extends Node2D
class_name BuildManager

const GRID_SIZE: int = 32
const TOWER_COST: int = 50
const PLAY_TOP: int = 64
const CONFIG_MAX_TOWER_COST: int = 10000
const CONFIG_MAX_TOWER_RANGE: float = 2000.0
const TOWER_CATEGORY_SUPPORT := "support"
const TOWER_CATEGORY_WEAPON := "weapon"
const DEFAULT_TOWER_DISPLAY_NAME := "防御塔"
const BUILD_MODE_ENTERED_MESSAGE_TEMPLATE := "选择一个有效格子建造%s。"
const BUILD_CANCELLED_MESSAGE_TEXT := "已取消建造。"
const SUPPORT_LAYER_FULL_MESSAGE_TEXT := "这座塔已经有增益层。"
const SUPPORT_LAYER_APPLIED_MESSAGE_TEMPLATE := "已为%s叠加%s。"
const TOWER_BUILT_MESSAGE_TEMPLATE := "已建造%s。"
const NO_TOWER_SELECTED_MESSAGE_TEXT := "请先选择一座防御塔。"
const TOWER_MAX_LEVEL_MESSAGE_TEXT := "防御塔已达到最高等级。"
const UPGRADE_INSUFFICIENT_GOLD_MESSAGE_TEXT := "金币不足，无法升级。"
const TOWER_UPGRADED_MESSAGE_TEXT := "防御塔已升级。"
const TOWER_SOLD_MESSAGE_TEXT := "防御塔已出售。"
const BUILD_INSUFFICIENT_GOLD_ERROR_TEXT := "金币不足。"
const BUILD_OUTSIDE_MAP_ERROR_TEXT := "请在地图内建造。"
const SUPPORT_REQUIRES_EXISTING_TOWER_ERROR_TEXT := "增益塔必须叠加在已有塔上。"
const SUPPORT_LAYER_FULL_ERROR_TEXT := "每座塔只能叠加一层增益塔。"
const BUILD_OCCUPIED_TILE_ERROR_TEXT := "该格子已被占用。"
const BUILD_ROAD_TILE_ERROR_TEXT := "不能建在道路上。"

var game: Main
var tower_layer: Node2D
var road_cells: Dictionary = {}
var _road_cell_lookup: Dictionary = {}
var is_building: bool = false
var selected_tower: Tower
var selected_tower_type_id: String = "basic"

var _occupied_tiles: Dictionary = {}
var _preview_position: Vector2 = Vector2.ZERO
var _preview_valid: bool = false
var _preview_grid_position: Vector2i = Vector2i(-9999, -9999)
var _preview_gold: int = -1
var _preview_tower_type_id: String = ""
var _selected_tower_config: Dictionary = {}
var _selected_tower_cost: int = TOWER_COST
var _selected_tower_range: float = Tower.BASE_RANGE
var _selected_tower_name: String = _get_default_tower_display_name()
var _selected_tower_category: String = TOWER_CATEGORY_WEAPON


func setup(game_ref: Main, tower_layer_ref: Node2D, roads: Dictionary = {}) -> void:
	game = game_ref
	tower_layer = tower_layer_ref
	_set_road_cache(roads)
	set_process(false)


func set_road_cells(roads: Dictionary) -> void:
	_set_road_cache(roads)
	queue_redraw()


func reset_occupied_tiles() -> void:
	_occupied_tiles.clear()
	selected_tower = null
	queue_redraw()


func enter_build_mode(tower_type_id: String = "basic") -> void:
	if game.is_game_over:
		return

	selected_tower_type_id = game._sanitize_tower_type_id(tower_type_id)
	_cache_selected_tower_config()
	clear_selection()
	is_building = true
	_reset_preview_cache()
	set_process(true)
	_update_build_preview()
	game.set_message(_format_build_mode_entered_message_text(_selected_tower_name))
	queue_redraw()


func cancel_build_mode() -> void:
	if not is_building:
		return

	is_building = false
	set_process(false)
	game.set_message(_get_build_cancelled_message_text())
	queue_redraw()


func try_build_at(world_position: Vector2) -> bool:
	if not is_building or game.is_game_over:
		return false

	var grid_position := world_to_grid(world_position)
	var reason := get_build_error(grid_position)
	if not reason.is_empty():
		game.set_message(reason)
		queue_redraw()
		return false

	if _is_support_build_selected():
		var target_tower := _get_occupied_tower(grid_position)
		if not is_instance_valid(target_tower) or not target_tower.apply_augmentation(_selected_tower_config):
			game.set_message(_get_support_layer_full_message_text())
			queue_redraw()
			return false
		game.spend_gold(_selected_tower_cost)
		game.spawn_particle_burst(target_tower.global_position, {
			"name": "SupportTowerParticles",
			"amount": 28,
			"lifetime": 0.66,
			"emission_radius": 22.0,
			"direction": Vector2.UP,
			"spread": 96.0,
			"velocity_min": 18.0,
			"velocity_max": 92.0,
			"scale_min": 0.8,
			"scale_max": 2.2,
			"gravity": Vector2.ZERO,
			"color": _selected_tower_config.get("color", Color(0.52, 1.0, 0.78)),
		})
		game.set_message(_format_support_layer_applied_message_text(target_tower.display_name, _selected_tower_name))
		select_tower(target_tower)
		is_building = false
		set_process(false)
		queue_redraw()
		return true

	var tower := Tower.new()
	tower.position = grid_to_center(grid_position)
	tower.setup(game, grid_position, _selected_tower_config)
	tower_layer.add_child(tower)
	game.register_tower(tower)
	_occupied_tiles[grid_position] = tower

	game.spend_gold(_selected_tower_cost)
	game.spawn_particle_burst(tower.global_position, {
		"name": "BuildParticles",
		"amount": 28,
		"lifetime": 0.50,
		"emission_radius": 12.0,
		"direction": Vector2.DOWN,
		"spread": 72.0,
		"velocity_min": 36.0,
		"velocity_max": 132.0,
		"scale_min": 1.0,
		"scale_max": 2.8,
		"gravity": Vector2(0.0, 160.0),
		"color": tower.tower_color.lightened(0.18),
	})
	game.set_message(_format_tower_built_message_text(_selected_tower_name))
	select_tower(tower)
	is_building = false
	set_process(false)
	queue_redraw()
	return true


func try_select_at(world_position: Vector2) -> void:
	if game.is_game_over:
		return

	var grid_position := world_to_grid(world_position)
	var tower := _get_occupied_tower(grid_position)

	if is_instance_valid(tower):
		select_tower(tower)
	else:
		clear_selection()


func select_tower(tower: Tower) -> void:
	if selected_tower == tower:
		return

	clear_selection()
	selected_tower = tower
	if is_instance_valid(selected_tower):
		selected_tower.set_selected(true)
		game.show_selected_tower(selected_tower)


func clear_selection() -> void:
	if is_instance_valid(selected_tower):
		selected_tower.set_selected(false)

	selected_tower = null
	if game != null:
		game.show_selected_tower(null)


func upgrade_selected() -> void:
	if not is_instance_valid(selected_tower):
		game.set_message(_get_no_tower_selected_message_text())
		return

	if not selected_tower.can_upgrade():
		game.set_message(_get_tower_max_level_message_text())
		return

	var cost := selected_tower.get_upgrade_cost()
	if game.gold < cost:
		game.set_message(_get_upgrade_insufficient_gold_message_text())
		return

	game.spend_gold(cost)
	selected_tower.upgrade()
	game.spawn_particle_burst(selected_tower.global_position, {
		"name": "UpgradeParticles",
		"amount": 42,
		"lifetime": 0.72,
		"emission_radius": 18.0,
		"direction": Vector2.UP,
		"spread": 82.0,
		"velocity_min": 54.0,
		"velocity_max": 190.0,
		"scale_min": 1.1,
		"scale_max": 3.4,
		"gravity": Vector2(0.0, -70.0),
		"color": Color(1.0, 0.86, 0.30),
		"important": true,
	})
	game.set_message(_get_tower_upgraded_message_text())
	game.show_selected_tower(selected_tower)


func sell_selected() -> void:
	if not is_instance_valid(selected_tower):
		game.set_message(_get_no_tower_selected_message_text())
		return

	var sold_tower := selected_tower
	var refund := sold_tower.get_sell_value()
	_occupied_tiles.erase(sold_tower.grid_position)
	clear_selection()
	game.unregister_tower(sold_tower)
	game.add_gold(refund)
	game.spawn_particle_burst(sold_tower.global_position, {
		"name": "SellParticles",
		"amount": 24,
		"lifetime": 0.58,
		"emission_radius": 14.0,
		"direction": Vector2.UP,
		"spread": 48.0,
		"velocity_min": 34.0,
		"velocity_max": 136.0,
		"scale_min": 0.9,
		"scale_max": 2.3,
		"gravity": Vector2(0.0, -150.0),
		"color": Color(0.95, 0.68, 0.28),
	})
	game.set_message(_get_tower_sold_message_text())
	sold_tower.queue_free()


func world_to_grid(world_position: Vector2) -> Vector2i:
	return Vector2i(
		floori(world_position.x / float(GRID_SIZE)),
		floori((world_position.y - float(PLAY_TOP)) / float(GRID_SIZE))
	)


func grid_to_center(grid_position: Vector2i) -> Vector2:
	return Vector2(
		float(grid_position.x * GRID_SIZE) + float(GRID_SIZE) * 0.5,
		float(PLAY_TOP + grid_position.y * GRID_SIZE) + float(GRID_SIZE) * 0.5
	)


func get_build_error(grid_position: Vector2i) -> String:
	if game.gold < _selected_tower_cost:
		return _get_build_insufficient_gold_error_text()

	if not _is_inside_map(grid_position):
		return _get_build_outside_map_error_text()

	if _is_support_build_selected():
		var target_tower := _get_occupied_tower(grid_position)
		if not is_instance_valid(target_tower):
			return _get_support_requires_existing_tower_error_text()
		if not target_tower.can_apply_augmentation():
			return _get_support_layer_full_error_text()
		return ""

	if _get_occupied_tower(grid_position) != null:
		return _get_build_occupied_tile_error_text()

	if _is_road_cell(grid_position):
		return _get_build_road_tile_error_text()

	return ""


func _cache_selected_tower_config() -> void:
	_selected_tower_config = game.get_tower_config(selected_tower_type_id)
	_selected_tower_cost = _get_selected_tower_cost(_selected_tower_config)
	_selected_tower_range = _get_selected_tower_range(_selected_tower_config)
	_selected_tower_category = _get_selected_tower_category(_selected_tower_config)
	_selected_tower_name = _get_tower_display_name(_selected_tower_config)


func _get_selected_tower_cost(config: Dictionary) -> int:
	return _get_positive_int_config(config, "cost", TOWER_COST, CONFIG_MAX_TOWER_COST)


func _get_selected_tower_range(config: Dictionary) -> float:
	return _get_non_negative_float_config(config, "range", Tower.BASE_RANGE, CONFIG_MAX_TOWER_RANGE)


func _get_selected_tower_category(config: Dictionary) -> String:
	var category := str(config.get("category", TOWER_CATEGORY_WEAPON)).strip_edges()
	if category == TOWER_CATEGORY_SUPPORT:
		return TOWER_CATEGORY_SUPPORT
	return TOWER_CATEGORY_WEAPON


func _get_positive_int_config(config: Dictionary, key: String, default_value: int, max_value: int) -> int:
	var raw_value: Variant = config.get(key, default_value)
	if raw_value is int or raw_value is float:
		var value := int(round(float(raw_value)))
		if value > 0 and value <= max_value:
			return value
	return default_value


func _get_non_negative_float_config(config: Dictionary, key: String, default_value: float, max_value: float) -> float:
	var raw_value: Variant = config.get(key, default_value)
	if raw_value is int or raw_value is float:
		var value := float(raw_value)
		if value >= 0.0 and value <= max_value:
			return value
	return default_value


func _get_tower_display_name(config: Dictionary) -> String:
	var display_name := str(config.get("name", "")).strip_edges()
	return display_name if not display_name.is_empty() else _get_default_tower_display_name()


func _get_default_tower_display_name() -> String:
	return DEFAULT_TOWER_DISPLAY_NAME


func _format_build_mode_entered_message_text(tower_name: String) -> String:
	return BUILD_MODE_ENTERED_MESSAGE_TEMPLATE % tower_name


func _get_build_cancelled_message_text() -> String:
	return BUILD_CANCELLED_MESSAGE_TEXT


func _get_support_layer_full_message_text() -> String:
	return SUPPORT_LAYER_FULL_MESSAGE_TEXT


func _format_support_layer_applied_message_text(target_tower_name: String, support_tower_name: String) -> String:
	return SUPPORT_LAYER_APPLIED_MESSAGE_TEMPLATE % [target_tower_name, support_tower_name]


func _format_tower_built_message_text(tower_name: String) -> String:
	return TOWER_BUILT_MESSAGE_TEMPLATE % tower_name


func _get_no_tower_selected_message_text() -> String:
	return NO_TOWER_SELECTED_MESSAGE_TEXT


func _get_tower_max_level_message_text() -> String:
	return TOWER_MAX_LEVEL_MESSAGE_TEXT


func _get_upgrade_insufficient_gold_message_text() -> String:
	return UPGRADE_INSUFFICIENT_GOLD_MESSAGE_TEXT


func _get_tower_upgraded_message_text() -> String:
	return TOWER_UPGRADED_MESSAGE_TEXT


func _get_tower_sold_message_text() -> String:
	return TOWER_SOLD_MESSAGE_TEXT


func _get_build_insufficient_gold_error_text() -> String:
	return BUILD_INSUFFICIENT_GOLD_ERROR_TEXT


func _get_build_outside_map_error_text() -> String:
	return BUILD_OUTSIDE_MAP_ERROR_TEXT


func _get_support_requires_existing_tower_error_text() -> String:
	return SUPPORT_REQUIRES_EXISTING_TOWER_ERROR_TEXT


func _get_support_layer_full_error_text() -> String:
	return SUPPORT_LAYER_FULL_ERROR_TEXT


func _get_build_occupied_tile_error_text() -> String:
	return BUILD_OCCUPIED_TILE_ERROR_TEXT


func _get_build_road_tile_error_text() -> String:
	return BUILD_ROAD_TILE_ERROR_TEXT


func _is_support_build_selected() -> bool:
	return _selected_tower_category == TOWER_CATEGORY_SUPPORT


func _get_occupied_tower(grid_position: Vector2i) -> Tower:
	var occupied_value = _occupied_tiles.get(grid_position)
	var tower := occupied_value as Tower
	if is_instance_valid(tower):
		return tower
	if _occupied_tiles.has(grid_position):
		_occupied_tiles.erase(grid_position)
	return null


func _process(_delta: float) -> void:
	if not is_building:
		return

	_update_build_preview()


func _update_build_preview() -> void:
	var mouse_position: Vector2 = game.screen_to_world(get_viewport().get_mouse_position()) if game != null else get_viewport().get_mouse_position()
	var grid_position := world_to_grid(mouse_position)
	var preview_position := grid_to_center(grid_position)
	var preview_valid := get_build_error(grid_position).is_empty()
	var current_gold: int = game.gold if game != null else 0
	if (
		grid_position == _preview_grid_position
		and preview_position == _preview_position
		and preview_valid == _preview_valid
		and current_gold == _preview_gold
		and selected_tower_type_id == _preview_tower_type_id
	):
		return

	_preview_grid_position = grid_position
	_preview_position = preview_position
	_preview_valid = preview_valid
	_preview_gold = current_gold
	_preview_tower_type_id = selected_tower_type_id
	queue_redraw()


func _reset_preview_cache() -> void:
	_preview_grid_position = Vector2i(-9999, -9999)
	_preview_gold = -1
	_preview_tower_type_id = ""


func _draw() -> void:
	if not is_building:
		return

	var color := Color(0.25, 0.9, 0.45, 0.32) if _preview_valid else Color(1.0, 0.18, 0.12, 0.32)
	var rect := Rect2(_preview_position - Vector2(GRID_SIZE, GRID_SIZE) * 0.5, Vector2(GRID_SIZE, GRID_SIZE))
	draw_rect(rect, color)
	draw_rect(rect, Color(color.r, color.g, color.b, 0.88), false, 2.0)
	if _is_support_build_selected():
		draw_rect(Rect2(_preview_position - Vector2(24.0, 24.0), Vector2(48.0, 48.0)), Color(0.50, 1.0, 0.72, 0.22), false, 3.0)
	else:
		draw_circle(_preview_position, _selected_tower_range, Color(color.r, color.g, color.b, 0.12))


func _is_inside_map(grid_position: Vector2i) -> bool:
	var center := grid_to_center(grid_position)
	return (
		grid_position.x >= 0
		and grid_position.x < game.map_cols
		and grid_position.y >= 0
		and grid_position.y < game.map_rows
		and center.x >= 0.0
		and center.x <= game.get_map_pixel_width()
		and center.y >= PLAY_TOP
		and center.y <= game.get_map_pixel_height()
	)


func _is_road_cell(grid_position: Vector2i) -> bool:
	return _road_cell_lookup.has(grid_position)


func _set_road_cache(roads: Dictionary) -> void:
	road_cells = _sanitize_road_cells(roads)
	_road_cell_lookup.clear()
	for cell in road_cells.keys():
		_road_cell_lookup[cell] = true


func _sanitize_road_cells(roads: Dictionary) -> Dictionary:
	var sanitized_cells: Dictionary = {}
	for cell_value in roads.values():
		var cell = _get_valid_road_cell(cell_value)
		if cell == null:
			continue
		sanitized_cells[cell] = cell
	return sanitized_cells


func _get_valid_road_cell(raw_cell: Variant):
	if raw_cell is Vector2i:
		return raw_cell
	if raw_cell is Vector2:
		return Vector2i(roundi(raw_cell.x), roundi(raw_cell.y))
	return null
