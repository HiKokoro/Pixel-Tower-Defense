extends Node2D
class_name MapRenderer

const GRID_SIZE: int = 32
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

var game: Main
var _cached_road_cells: Array[Vector2i] = []
var _cached_road_cell_lookup: Dictionary = {}
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


func setup(game_ref: Main) -> void:
	game = game_ref
	process_mode = Node.PROCESS_MODE_PAUSABLE
	_cache_level_geometry()


func redraw_map() -> void:
	_cache_level_geometry()
	queue_redraw()


func _draw() -> void:
	if game == null:
		return

	var map_width := float(game.get_map_pixel_width())
	var map_height := float(maxi(game.get_map_pixel_height(), MAP_HEIGHT))
	draw_rect(Rect2(Vector2.ZERO, Vector2(map_width, map_height)), _theme_color("bg", COL_BG))
	draw_rect(Rect2(Vector2(0.0, PLAY_TOP), Vector2(map_width, float(game.get_map_pixel_height() - PLAY_TOP))), _theme_color("field_a", COL_FIELD_A))
	_draw_ground_tiles()
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


func _draw_spawn_gates() -> void:
	for points in _cached_route_paths:
		if points.is_empty():
			continue
		var gate_position := points[0]
		_draw_gate_shadow(gate_position)
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

	for cell in _get_sanitized_road_cells(game.road_cells):
		_cached_road_cells.append(cell)
		_cached_road_cell_lookup[cell] = true
		_cache_road_cell_rects(cell)

	for packed_path in _get_sanitized_route_paths(game.spawn_paths):
		_cached_route_paths.append(packed_path)

	_cache_grid_lines()
	_cache_ground_tiles()


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
