extends Node2D
class_name MapRenderer

const GRID_SIZE: int = 64
const PLAY_TOP: int = 64
const MAP_HEIGHT: int = 640
const COL_BG := Color(0.045, 0.055, 0.060)
const COL_FIELD_A := Color(0.085, 0.125, 0.112)
const COL_FIELD_B := Color(0.070, 0.105, 0.096)
const COL_GRID := Color(0.56, 0.76, 0.70, 0.055)
const COL_ROAD_DARK := Color(0.255, 0.225, 0.180)
const COL_ROAD := Color(0.385, 0.335, 0.250)
const COL_ROAD_LIGHT := Color(0.620, 0.530, 0.360)
const COL_ROAD_EDGE := Color(0.145, 0.125, 0.100)
const COL_WATER := Color(0.055, 0.120, 0.155, 0.42)
const MAP_ASSET_ROOT := "res://assets/maps"
const MAP_THEME_ASSET_SLUGS: Array[String] = [
	"theme_01_green_bay",
	"theme_02_double_bend",
	"theme_03_split_fortress",
	"theme_04_river_teeth",
	"theme_05_iron_clover",
	"theme_06_fractured_delta",
	"theme_07_ash_spiral",
	"theme_08_frost_glass",
	"theme_09_obsidian_fan",
	"theme_10_final_fortress",
]
const ROAD_DIR_UP := Vector2i(0, -1)
const ROAD_DIR_RIGHT := Vector2i(1, 0)
const ROAD_DIR_DOWN := Vector2i(0, 1)
const ROAD_DIR_LEFT := Vector2i(-1, 0)
const ROAD_MASK_UP := 1
const ROAD_MASK_RIGHT := 2
const ROAD_MASK_DOWN := 4
const ROAD_MASK_LEFT := 8
const DECOR_ANIMATION_STEP_SECONDS := 0.36
const DECOR_DENSITY := 0.035
const DECOR_MIN_COUNT := 8
const DECOR_MAX_COUNT := 32

var game: Main
var _cached_road_cells: Array[Vector2i] = []
var _cached_road_cell_lookup: Dictionary = {}
var _cached_road_connection_masks: Dictionary = {}
var _cached_decorations: Array[Dictionary] = []
var _destroyed_decoration_cells: Dictionary = {}
var _cached_decoration_level_index: int = -1
var _decor_animation_time: float = 0.0
var _cached_route_paths: Array[PackedVector2Array] = []
var _cached_ground_rects: Array[Rect2] = []
var _cached_ground_colors: Array[Color] = []
var _cached_pebble_rects: Array[Rect2] = []
var _cached_pebble_color: Color = COL_WATER
var _cached_grid_lines: PackedVector2Array = PackedVector2Array()
var _cached_road_edge_rects: Array[Rect2] = []
var _cached_road_inner_rects: Array[Rect2] = []
var _cached_road_light_rects: Array[Rect2] = []
var _cached_road_dark_rects: Array[Rect2] = []
var _map_theme_asset_slug: String = ""
var _map_background_texture: Texture2D = null
var _road_straight_texture: Texture2D = null
var _road_cross_texture: Texture2D = null
var _road_corner_texture: Texture2D = null
var _road_t_texture: Texture2D = null
var _spawn_gate_texture: Texture2D = null
var _decoration_texture_sets: Array = []


func setup(game_ref: Main) -> void:
	game = game_ref
	process_mode = Node.PROCESS_MODE_PAUSABLE
	texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	set_process(true)
	_cache_level_geometry()


func redraw_map() -> void:
	_cache_level_geometry()
	queue_redraw()


func _process(delta: float) -> void:
	if _cached_decorations.is_empty():
		return
	_decor_animation_time += delta
	if _decor_animation_time >= DECOR_ANIMATION_STEP_SECONDS:
		_decor_animation_time = fmod(_decor_animation_time, DECOR_ANIMATION_STEP_SECONDS)
		queue_redraw()


func _draw() -> void:
	if game == null:
		return

	var map_width := float(game.get_map_pixel_width())
	var map_height := float(maxi(game.get_map_pixel_height(), MAP_HEIGHT))
	draw_rect(Rect2(Vector2.ZERO, Vector2(map_width, map_height)), _theme_color("bg", COL_BG))
	if _map_background_texture != null:
		draw_texture_rect(_map_background_texture, Rect2(Vector2.ZERO, Vector2(map_width, map_height)), false)
	else:
		draw_rect(Rect2(Vector2(0.0, PLAY_TOP), Vector2(map_width, float(game.get_map_pixel_height() - PLAY_TOP))), _theme_color("field_a", COL_FIELD_A))
		_draw_ground_tiles()
	_draw_decorations()
	_draw_grid()
	_draw_path()
	_draw_spawn_gates()


func _draw_ground_tiles() -> void:
	var map_width: float = float(game.get_map_pixel_width())
	var play_bottom: float = float(game.get_map_pixel_height())
	for index in range(_cached_ground_rects.size()):
		draw_rect(_cached_ground_rects[index], _cached_ground_colors[index])

	for pebble_rect in _cached_pebble_rects:
		draw_rect(pebble_rect, _cached_pebble_color)

	draw_rect(Rect2(Vector2(0.0, PLAY_TOP), Vector2(map_width, 4.0)), Color(0.0, 0.0, 0.0, 0.22))
	draw_rect(Rect2(Vector2(0.0, play_bottom - 4.0), Vector2(map_width, 4.0)), Color(0.0, 0.0, 0.0, 0.22))
	draw_rect(Rect2(Vector2(0.0, PLAY_TOP), Vector2(5.0, play_bottom - float(PLAY_TOP))), Color(0.0, 0.0, 0.0, 0.16))
	draw_rect(Rect2(Vector2(map_width - 5.0, PLAY_TOP), Vector2(5.0, play_bottom - float(PLAY_TOP))), Color(0.0, 0.0, 0.0, 0.16))


func _draw_grid() -> void:
	var grid_color: Color = _theme_color("grid", COL_GRID)
	draw_multiline(_cached_grid_lines, grid_color, 1.0)


func _draw_path() -> void:
	if _has_road_textures():
		_draw_road_tiles()
		return

	var road_edge: Color = _theme_color("road_edge", COL_ROAD_EDGE)
	var road: Color = _theme_color("road", COL_ROAD)
	var road_light: Color = _theme_color("road_light", COL_ROAD_LIGHT)
	var road_dark: Color = _theme_color("road_dark", COL_ROAD_DARK)
	var route_line_color: Color = road_light.lightened(0.12)
	var road_light_shadow: Color = road_light.darkened(0.05)
	for rect in _cached_road_edge_rects:
		draw_rect(rect, road_edge)
	for rect in _cached_road_inner_rects:
		draw_rect(rect, road)
	for rect in _cached_road_light_rects:
		draw_rect(rect, road_light_shadow)
	for rect in _cached_road_dark_rects:
		draw_rect(rect, road_dark)

	for points in _cached_route_paths:
		if points.size() < 2:
			continue
		draw_polyline(points, Color(0.12, 0.10, 0.08, 0.40), 7.0, true)
		draw_polyline(points, route_line_color, 3.0, true)


func _has_road_textures() -> bool:
	return _road_straight_texture != null and _road_cross_texture != null and _road_corner_texture != null and _road_t_texture != null


func _draw_road_tiles() -> void:
	for cell in _cached_road_cells:
		var connections := _get_road_connections(cell)
		if connections.size() >= 4:
			_draw_road_texture_cell(_road_cross_texture, cell, 0)
		elif connections.size() == 3:
			_draw_road_texture_cell(_road_t_texture, cell, _get_t_road_quarter_turns(connections))
		elif _is_vertical_road(connections):
			_draw_road_texture_cell(_road_straight_texture, cell, 1)
		elif _is_horizontal_road(connections):
			_draw_road_texture_cell(_road_straight_texture, cell, 0)
		elif connections.size() == 2:
			_draw_road_texture_cell(_road_corner_texture, cell, _get_corner_quarter_turns(connections))
		elif connections.has(ROAD_DIR_UP) or connections.has(ROAD_DIR_DOWN):
			_draw_road_texture_cell(_road_straight_texture, cell, 1)
		else:
			_draw_road_texture_cell(_road_straight_texture, cell, 0)


func _get_road_connections(cell: Vector2i) -> Array[Vector2i]:
	var connections: Array[Vector2i] = []
	var mask := int(_cached_road_connection_masks.get(cell, 0))
	if (mask & ROAD_MASK_UP) != 0:
		connections.append(ROAD_DIR_UP)
	if (mask & ROAD_MASK_RIGHT) != 0:
		connections.append(ROAD_DIR_RIGHT)
	if (mask & ROAD_MASK_DOWN) != 0:
		connections.append(ROAD_DIR_DOWN)
	if (mask & ROAD_MASK_LEFT) != 0:
		connections.append(ROAD_DIR_LEFT)
	return connections


func _is_vertical_road(connections: Array[Vector2i]) -> bool:
	return connections.has(ROAD_DIR_UP) and connections.has(ROAD_DIR_DOWN) and not connections.has(ROAD_DIR_LEFT) and not connections.has(ROAD_DIR_RIGHT)


func _is_horizontal_road(connections: Array[Vector2i]) -> bool:
	return connections.has(ROAD_DIR_LEFT) and connections.has(ROAD_DIR_RIGHT) and not connections.has(ROAD_DIR_UP) and not connections.has(ROAD_DIR_DOWN)


func _get_corner_quarter_turns(connections: Array[Vector2i]) -> int:
	if connections.has(ROAD_DIR_LEFT) and connections.has(ROAD_DIR_DOWN):
		return 0
	if connections.has(ROAD_DIR_UP) and connections.has(ROAD_DIR_LEFT):
		return 1
	if connections.has(ROAD_DIR_RIGHT) and connections.has(ROAD_DIR_UP):
		return 2
	if connections.has(ROAD_DIR_DOWN) and connections.has(ROAD_DIR_RIGHT):
		return 3
	return 0


func _get_t_road_quarter_turns(connections: Array[Vector2i]) -> int:
	if not connections.has(ROAD_DIR_UP):
		return 0
	if not connections.has(ROAD_DIR_RIGHT):
		return 1
	if not connections.has(ROAD_DIR_DOWN):
		return 2
	if not connections.has(ROAD_DIR_LEFT):
		return 3
	return 0


func _draw_road_texture_cell(texture: Texture2D, cell: Vector2i, quarter_turns: int) -> void:
	if texture == null:
		return
	var cell_size := Vector2(float(GRID_SIZE), float(GRID_SIZE))
	var cell_position := Vector2(float(cell.x * GRID_SIZE), float(PLAY_TOP + cell.y * GRID_SIZE))
	var normalized_turns := posmod(quarter_turns, 4)
	if normalized_turns == 0:
		draw_texture_rect(texture, Rect2(cell_position, cell_size), false)
		return

	var cell_center := cell_position + cell_size * 0.5
	draw_set_transform(cell_center, float(normalized_turns) * PI * 0.5, Vector2.ONE)
	draw_texture_rect(texture, Rect2(-cell_size * 0.5, cell_size), false)
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)


func _draw_decorations() -> void:
	if _cached_decorations.is_empty():
		return
	var frame_tick := int(floor(Time.get_ticks_msec() / int(DECOR_ANIMATION_STEP_SECONDS * 1000.0)))
	for decoration in _cached_decorations:
		var frames: Array = decoration.get("frames", [])
		if frames.is_empty():
			continue
		var frame_index := posmod(frame_tick + int(decoration.get("frame_offset", 0)), frames.size())
		var texture := frames[frame_index] as Texture2D
		if texture == null:
			continue
		var cell: Vector2i = decoration.get("cell", Vector2i.ZERO)
		var texture_size := Vector2(float(texture.get_width()), float(texture.get_height()))
		var cell_center := Vector2(float(cell.x * GRID_SIZE) + float(GRID_SIZE) * 0.5, float(PLAY_TOP + cell.y * GRID_SIZE) + float(GRID_SIZE) * 0.5)
		var draw_position := (cell_center - texture_size * 0.5).snapped(Vector2.ONE)
		draw_texture(texture, draw_position)


func _draw_spawn_gates() -> void:
	for points in _cached_route_paths:
		if points.is_empty():
			continue
		var gate_position := points[0]
		_draw_gate_shadow(gate_position)
		if _spawn_gate_texture != null:
			var gate_size := Vector2(float(_spawn_gate_texture.get_width()), float(_spawn_gate_texture.get_height()))
			var gate_rect := Rect2((gate_position - Vector2(gate_size.x * 0.5, gate_size.y * 0.58)).snapped(Vector2.ONE), gate_size)
			draw_texture_rect(_spawn_gate_texture, gate_rect, false)
			continue
		draw_rect(Rect2(gate_position + Vector2(-18.0, -22.0), Vector2(36.0, 44.0)), Color(0.045, 0.035, 0.032))
		draw_rect(Rect2(gate_position + Vector2(-14.0, -18.0), Vector2(28.0, 36.0)), Color(0.20, 0.12, 0.08))
		draw_rect(Rect2(gate_position + Vector2(-8.0, -12.0), Vector2(16.0, 30.0)), Color(0.055, 0.035, 0.030))
		draw_arc(gate_position + Vector2(0.0, -11.0), 14.0, PI, TAU, 16, Color(0.60, 0.38, 0.18), 3.0, true)
		draw_rect(Rect2(gate_position + Vector2(-18.0, 18.0), Vector2(36.0, 5.0)), Color(0.60, 0.38, 0.18))
		draw_rect(Rect2(gate_position + Vector2(-14.0, -18.0), Vector2(28.0, 5.0)), Color(0.72, 0.46, 0.22, 0.65))


func _draw_gate_shadow(gate_position: Vector2) -> void:
	var points := PackedVector2Array()
	for index in range(20):
		var angle := TAU * float(index) / 20.0
		points.append((gate_position + Vector2(cos(angle) * 27.0, 20.0 + sin(angle) * 9.0)).snapped(Vector2.ONE))
	draw_colored_polygon(points, Color(0.0, 0.0, 0.0, 0.26))


func _theme_color(key: String, fallback: Color) -> Color:
	if game != null and game.scene_theme.has(key):
		return _get_valid_theme_color(game.scene_theme.get(key), fallback)
	return fallback


func _get_valid_theme_color(raw_color: Variant, fallback: Color) -> Color:
	if raw_color is Color:
		return raw_color
	return fallback


func _cache_level_geometry() -> void:
	_cached_road_cells.clear()
	_cached_road_cell_lookup.clear()
	_cached_road_connection_masks.clear()
	_cached_decorations.clear()
	_cached_route_paths.clear()
	_cached_ground_rects.clear()
	_cached_ground_colors.clear()
	_cached_pebble_rects.clear()
	_cached_grid_lines.clear()
	_cached_road_edge_rects.clear()
	_cached_road_inner_rects.clear()
	_cached_road_light_rects.clear()
	_cached_road_dark_rects.clear()
	if game == null:
		return
	if _cached_decoration_level_index != game.current_level_index:
		_destroyed_decoration_cells.clear()
		_cached_decoration_level_index = game.current_level_index
	_load_current_map_theme_textures()

	for cell in _get_sanitized_road_cells(game.road_cells):
		_cached_road_cells.append(cell)
		_cached_road_cell_lookup[cell] = true
		_cache_road_cell_rects(cell)

	for packed_path in _get_sanitized_route_paths(game.spawn_paths):
		_cached_route_paths.append(packed_path)

	_cache_road_connection_masks()
	_cache_grid_lines()
	_cache_ground_tiles()
	_cache_decorations()


func _load_current_map_theme_textures() -> void:
	var next_slug := _get_current_map_theme_asset_slug()
	if next_slug == _map_theme_asset_slug:
		return

	_map_theme_asset_slug = next_slug
	_map_background_texture = null
	_road_straight_texture = null
	_road_cross_texture = null
	_road_corner_texture = null
	_road_t_texture = null
	_spawn_gate_texture = null
	_decoration_texture_sets.clear()
	if next_slug.is_empty():
		return

	var asset_dir := "%s/%s" % [MAP_ASSET_ROOT, next_slug]
	_map_background_texture = _load_texture_asset("%s/background.png" % asset_dir)
	_road_straight_texture = _load_texture_asset("%s/road_straight.png" % asset_dir)
	_road_cross_texture = _load_texture_asset("%s/road_cross.png" % asset_dir)
	_road_corner_texture = _load_texture_asset("%s/road_corner.png" % asset_dir)
	_road_t_texture = _load_texture_asset("%s/road_t.png" % asset_dir)
	_spawn_gate_texture = _load_texture_asset("%s/spawn_gate.png" % asset_dir)
	_decoration_texture_sets = _load_decoration_texture_sets(asset_dir)


func _get_current_map_theme_asset_slug() -> String:
	if game == null:
		return ""
	var level_index := clampi(game.current_level_index, 0, MAP_THEME_ASSET_SLUGS.size() - 1)
	if level_index < MAP_THEME_ASSET_SLUGS.size():
		return MAP_THEME_ASSET_SLUGS[level_index]
	return ""


func _load_texture_asset(asset_path: String) -> Texture2D:
	if not FileAccess.file_exists(asset_path):
		return null
	var image := Image.new()
	var load_error := image.load(asset_path)
	if load_error != OK or image.is_empty():
		return null
	return ImageTexture.create_from_image(image)


func _load_decoration_texture_sets(asset_dir: String) -> Array:
	var texture_sets: Array = []
	for decor_index in range(1, 3):
		var frames: Array = []
		for frame_index in range(3):
			var texture := _load_texture_asset("%s/decor_%02d_%d.png" % [asset_dir, decor_index, frame_index])
			if texture != null:
				frames.append(texture)
		if not frames.is_empty():
			texture_sets.append(frames)
	return texture_sets


func _cache_decorations() -> void:
	if _decoration_texture_sets.is_empty() or game == null:
		return
	var target_count := clampi(int(round(float(game.map_cols * game.map_rows) * DECOR_DENSITY)), DECOR_MIN_COUNT, DECOR_MAX_COUNT)
	var rng := RandomNumberGenerator.new()
	rng.seed = int(0xC0DEC0DE + game.current_level_index * 7919 + game.map_cols * 131 + game.map_rows * 977)
	var used_cells: Dictionary = {}
	var attempts := 0
	while _cached_decorations.size() < target_count and attempts < target_count * 18:
		attempts += 1
		var cell := Vector2i(rng.randi_range(0, game.map_cols - 1), rng.randi_range(0, game.map_rows - 1))
		if used_cells.has(cell) or _cached_road_cell_lookup.has(cell) or _destroyed_decoration_cells.has(cell):
			continue
		used_cells[cell] = true
		var texture_set_index := _cached_decorations.size() % _decoration_texture_sets.size()
		_cached_decorations.append({
			"cell": cell,
			"frames": _decoration_texture_sets[texture_set_index],
			"frame_offset": rng.randi_range(0, 7),
		})


func has_decoration_at(cell: Vector2i) -> bool:
	for decoration in _cached_decorations:
		if decoration.get("cell", Vector2i.ZERO) == cell:
			return true
	return false


func destroy_decoration_at(cell: Vector2i) -> bool:
	var destroyed := false
	for index in range(_cached_decorations.size() - 1, -1, -1):
		if _cached_decorations[index].get("cell", Vector2i.ZERO) != cell:
			continue
		_cached_decorations.remove_at(index)
		destroyed = true
	if destroyed:
		_destroyed_decoration_cells[cell] = true
		queue_redraw()
	return destroyed


func _get_sanitized_road_cells(source_road_cells: Dictionary) -> Array[Vector2i]:
	var sanitized_lookup: Dictionary = {}
	var sanitized_cells: Array[Vector2i] = []
	for cell_value in source_road_cells.values():
		var cell = _get_valid_road_cell(cell_value)
		if cell == null or sanitized_lookup.has(cell):
			continue
		sanitized_lookup[cell] = true
		sanitized_cells.append(cell)
	return sanitized_cells


func _get_valid_road_cell(raw_cell: Variant):
	if raw_cell is Vector2i:
		return raw_cell
	if raw_cell is Vector2:
		return Vector2i(roundi(raw_cell.x), roundi(raw_cell.y))
	return null


func _get_sanitized_route_paths(source_paths: Array) -> Array[PackedVector2Array]:
	var sanitized_paths: Array[PackedVector2Array] = []
	for route_value in source_paths:
		if not route_value is Array:
			continue
		var packed_path := _get_sanitized_route_path(route_value as Array)
		if packed_path.size() >= 2:
			sanitized_paths.append(packed_path)
	return sanitized_paths


func _get_sanitized_route_path(route_path: Array) -> PackedVector2Array:
	var packed_path := PackedVector2Array()
	for point_value in route_path:
		var point = _get_valid_route_point(point_value)
		if point == null:
			continue
		packed_path.append(point)
	return packed_path


func _get_valid_route_point(raw_point: Variant):
	if raw_point is Vector2:
		return raw_point
	if raw_point is Vector2i:
		return Vector2(float(raw_point.x), float(raw_point.y))
	return null


func _cache_road_connection_masks() -> void:
	# 道路贴图连接只来自真实 spawn_paths，不从 road_cells 的邻接关系猜测，避免并排道路被画成假路口。
	for route_path in _cached_route_paths:
		_cache_road_connection_mask_for_route(route_path)


func _cache_road_connection_mask_for_route(route_path: PackedVector2Array) -> void:
	if route_path.size() < 2:
		return

	var previous_cell := _world_point_to_grid_cell(route_path[0])
	for point_index in range(1, route_path.size()):
		var next_cell := _world_point_to_grid_cell(route_path[point_index])
		_cache_road_connection_between_cells(previous_cell, next_cell)
		previous_cell = next_cell


func _world_point_to_grid_cell(world_point: Vector2) -> Vector2i:
	return Vector2i(
		floori(world_point.x / float(GRID_SIZE)),
		floori((world_point.y - float(PLAY_TOP)) / float(GRID_SIZE))
	)


func _cache_road_connection_between_cells(start_cell: Vector2i, end_cell: Vector2i) -> void:
	if start_cell == end_cell:
		return

	var current_cell := start_cell
	while current_cell != end_cell:
		var step := Vector2i.ZERO
		if current_cell.x != end_cell.x:
			step.x = signi(end_cell.x - current_cell.x)
		elif current_cell.y != end_cell.y:
			step.y = signi(end_cell.y - current_cell.y)

		if step == Vector2i.ZERO:
			return

		var next_cell := current_cell + step
		_add_road_connection(current_cell, step)
		_add_road_connection(next_cell, -step)
		current_cell = next_cell


func _add_road_connection(cell: Vector2i, direction: Vector2i) -> void:
	if not _cached_road_cell_lookup.has(cell):
		return
	var current_mask := int(_cached_road_connection_masks.get(cell, 0))
	_cached_road_connection_masks[cell] = current_mask | _get_road_direction_mask(direction)


func _get_road_direction_mask(direction: Vector2i) -> int:
	if direction == ROAD_DIR_UP:
		return ROAD_MASK_UP
	if direction == ROAD_DIR_RIGHT:
		return ROAD_MASK_RIGHT
	if direction == ROAD_DIR_DOWN:
		return ROAD_MASK_DOWN
	if direction == ROAD_DIR_LEFT:
		return ROAD_MASK_LEFT
	return 0


func _cache_grid_lines() -> void:
	var map_width: float = float(game.get_map_pixel_width())
	var play_bottom: float = float(game.get_map_pixel_height())
	for x in range(0, game.map_cols + 1):
		var px: float = float(x * GRID_SIZE)
		_cached_grid_lines.append(Vector2(px, PLAY_TOP))
		_cached_grid_lines.append(Vector2(px, play_bottom))

	for y in range(0, game.map_rows + 1):
		var py: float = float(PLAY_TOP + y * GRID_SIZE)
		_cached_grid_lines.append(Vector2(0.0, py))
		_cached_grid_lines.append(Vector2(map_width, py))


func _cache_road_cell_rects(cell: Vector2i) -> void:
	var rect := Rect2(Vector2(float(cell.x * GRID_SIZE), float(PLAY_TOP + cell.y * GRID_SIZE)), Vector2(GRID_SIZE, GRID_SIZE))
	_cached_road_edge_rects.append(rect)
	_cached_road_inner_rects.append(Rect2(rect.position + Vector2(2.0, 2.0), rect.size - Vector2(4.0, 4.0)))
	_cached_road_light_rects.append(Rect2(rect.position + Vector2(4.0, 4.0), Vector2(rect.size.x - 8.0, 5.0)))
	_cached_road_dark_rects.append(Rect2(rect.position + Vector2(4.0, rect.size.y - 7.0), Vector2(rect.size.x - 8.0, 3.0)))


func _cache_ground_tiles() -> void:
	var field_a: Color = _theme_color("field_a", COL_FIELD_A)
	var field_b: Color = _theme_color("field_b", COL_FIELD_B)
	var field_highlight: Color = field_a.lightened(0.035)
	_cached_pebble_color = _theme_color("water", COL_WATER).lightened(0.35)

	for x in range(game.map_cols):
		for y in range(game.map_rows):
			var cell := Vector2i(x, y)
			var rect := Rect2(Vector2(float(x * GRID_SIZE), float(PLAY_TOP + y * GRID_SIZE)), Vector2(GRID_SIZE, GRID_SIZE))
			var value: int = (x * 17 + y * 31 + game.current_level_index * 13) % 9
			var color: Color = field_a
			if value == 1 or value == 5:
				color = field_b
			elif value == 7:
				color = field_highlight

			_cached_ground_rects.append(rect)
			_cached_ground_colors.append(color)

			if value == 3 and not _cached_road_cell_lookup.has(cell):
				var pebble_position: Vector2 = rect.position + Vector2(10.0 + float((x * 3) % 9), 9.0 + float((y * 5) % 11))
				_cached_pebble_rects.append(Rect2(pebble_position.snapped(Vector2.ONE), Vector2(3.0, 3.0)))
