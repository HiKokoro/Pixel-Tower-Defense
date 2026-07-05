extends Node
class_name WaveManager

signal wave_started(wave: int)
signal enemy_spawn_requested(type_id: String, health: int, speed: float, reward: int, route_index: int)
signal wave_spawn_finished(wave: int)

const BASE_ENEMY_COUNT: int = 10
const ENEMY_COUNT_PER_WAVE: int = 4
const ENEMY_COUNT_PER_LEVEL_STEP: int = 2
const ROUTE_DENSITY_BONUS: int = 1
const BASE_SPAWN_INTERVAL: float = 0.50
const SPAWN_INTERVAL_WAVE_STEP: float = 0.024
const SPAWN_INTERVAL_LEVEL_STEP: float = 0.016
const SPAWN_INTERVAL_ROUTE_STEP: float = 0.012
const MIN_SPAWN_INTERVAL: float = 0.23
const BASE_ENEMY_REWARD: int = 4
const REWARD_WAVE_STEP_INTERVAL: int = 8
const SPAWN_REWARD_BONUS_INTERVAL: int = 32
const MAX_SPAWN_REWARD_BONUS: int = 0
const DEFAULT_HEALTH_MULTIPLIER: float = 1.0
const DEFAULT_SPEED_MULTIPLIER: float = 1.0
const DEFAULT_REWARD_MULTIPLIER: float = 1.0
const DEFAULT_TOTAL_WAVES: int = 10
const MAX_TOTAL_WAVES: int = 20
const DEFAULT_ROUTE_COUNT: int = 1
const MAX_ROUTE_COUNT: int = 8
const MAX_HEALTH_MULTIPLIER: float = 10.0
const MAX_SPEED_MULTIPLIER: float = 4.0
const MAX_REWARD_MULTIPLIER: float = 5.0

var game: Main
var total_waves: int = 10
var current_wave: int = 0
var is_spawning: bool = false
var spawn_interval: float = 0.75
var enemy_types: Array[String] = ["grunt"]
var route_count: int = 1

var _enemy_count: int = 0
var _spawned_count: int = 0
var _spawn_timer: float = 0.0
var _enemy_stat_multipliers: Dictionary = {}
var _enemy_wave_stat_cache: Dictionary = {}


func setup(game_ref: Main, wave_total: int, available_enemy_types: Array = ["grunt"], available_route_count: int = 1) -> void:
	game = game_ref
	total_waves = _sanitize_total_waves(wave_total)
	current_wave = 0
	enemy_types = _normalize_enemy_types(available_enemy_types)
	route_count = _sanitize_route_count(available_route_count)
	is_spawning = false
	_enemy_stat_multipliers.clear()
	_enemy_wave_stat_cache.clear()
	set_process(false)


func _sanitize_total_waves(raw_wave_total: Variant) -> int:
	if raw_wave_total is int or raw_wave_total is float:
		var wave_total := int(round(float(raw_wave_total)))
		if wave_total > 0 and wave_total <= MAX_TOTAL_WAVES:
			return wave_total
	return DEFAULT_TOTAL_WAVES


func _sanitize_route_count(raw_route_count: Variant) -> int:
	if raw_route_count is int or raw_route_count is float:
		var count := int(round(float(raw_route_count)))
		if count > 0 and count <= MAX_ROUTE_COUNT:
			return count
	return DEFAULT_ROUTE_COUNT


func start_next_wave() -> bool:
	if game == null or game.is_game_over or is_spawning or current_wave >= total_waves:
		return false

	current_wave += 1
	var wave_index := current_wave - 1
	var level_index: int = game.current_level_index if game != null else 0
	_enemy_count = _get_wave_enemy_count(wave_index, level_index)
	spawn_interval = _get_wave_spawn_interval(wave_index, level_index)
	_spawned_count = 0
	_spawn_timer = 0.0
	is_spawning = true
	set_process(true)
	wave_started.emit(current_wave)
	return true


func _get_wave_enemy_count(wave_index: int, level_index: int) -> int:
	var route_bonus := maxi(route_count - 1, 0) * ROUTE_DENSITY_BONUS
	var level_bonus := int(level_index / 2) * ENEMY_COUNT_PER_LEVEL_STEP
	var per_route_count := BASE_ENEMY_COUNT + wave_index * ENEMY_COUNT_PER_WAVE + level_bonus + route_bonus
	return per_route_count * maxi(route_count, 1)


func _get_wave_spawn_interval(wave_index: int, level_index: int) -> float:
	var route_pressure := float(maxi(route_count - 1, 0)) * SPAWN_INTERVAL_ROUTE_STEP
	var interval := BASE_SPAWN_INTERVAL - float(wave_index) * SPAWN_INTERVAL_WAVE_STEP - float(level_index) * SPAWN_INTERVAL_LEVEL_STEP - route_pressure
	return maxf(MIN_SPAWN_INTERVAL, interval)


func stop() -> void:
	is_spawning = false
	set_process(false)


func can_start_wave() -> bool:
	return not is_spawning and current_wave < total_waves


func is_all_waves_finished() -> bool:
	return current_wave >= total_waves and not is_spawning


func _process(delta: float) -> void:
	if not is_spawning:
		set_process(false)
		return

	_spawn_timer -= delta
	if _spawn_timer > 0.0:
		return

	var spawn_batch_size := _get_spawn_batch_size()
	for batch_index in range(spawn_batch_size):
		if _spawned_count >= _enemy_count:
			break
		_spawn_enemy_for_current_wave(batch_index)
		_spawned_count += 1
	_spawn_timer = spawn_interval

	if _spawned_count >= _enemy_count:
		is_spawning = false
		wave_spawn_finished.emit(current_wave)


func _get_spawn_batch_size() -> int:
	return maxi(route_count, 1)


func _spawn_enemy_for_current_wave(batch_index: int = 0) -> void:
	var wave_index := current_wave - 1
	var safe_type_id := _sanitize_enemy_type_id(_pick_enemy_type(wave_index, _spawned_count))
	var base_stats: Dictionary = _get_enemy_wave_base_stats(safe_type_id, wave_index)
	var route_index := _pick_route_index(wave_index, _spawned_count, batch_index)
	var reward := int(base_stats["reward"]) + _get_spawn_reward_bonus(_spawned_count)
	enemy_spawn_requested.emit(safe_type_id, int(base_stats["health"]), float(base_stats["speed"]), reward, route_index)


func get_enemy_stats(type_id: String, wave_index: int, spawn_index: int = 0) -> Dictionary:
	var safe_type_id := _sanitize_enemy_type_id(type_id)
	var base_stats: Dictionary = _get_enemy_wave_base_stats(safe_type_id, wave_index)
	return {
		"health": int(base_stats["health"]),
		"speed": float(base_stats["speed"]),
		"reward": int(base_stats["reward"]) + _get_spawn_reward_bonus(spawn_index),
	}


func _get_enemy_wave_base_stats(type_id: String, wave_index: int) -> Dictionary:
	var safe_type_id := _sanitize_enemy_type_id(type_id)
	var cache_key := "%s:%d" % [safe_type_id, wave_index]
	if _enemy_wave_stat_cache.has(cache_key):
		var cached_stats: Dictionary = _enemy_wave_stat_cache[cache_key] as Dictionary
		return cached_stats

	var multipliers: Dictionary = _get_enemy_stat_multipliers(safe_type_id)
	var base_health := 50 + wave_index * 16
	var base_speed := 70.0 + float(wave_index * 3)
	var base_reward := BASE_ENEMY_REWARD + int(wave_index / REWARD_WAVE_STEP_INTERVAL)
	var base_stats: Dictionary = {
		"health": int(round(float(base_health) * float(multipliers["health"]))),
		"speed": base_speed * float(multipliers["speed"]),
		"reward": int(round(float(base_reward) * float(multipliers["reward"]))),
	}
	_enemy_wave_stat_cache[cache_key] = base_stats
	return base_stats


func _get_spawn_reward_bonus(spawn_index: int) -> int:
	return mini(int(maxi(spawn_index, 0) / SPAWN_REWARD_BONUS_INTERVAL), MAX_SPAWN_REWARD_BONUS)


func _get_enemy_stat_multipliers(type_id: String) -> Dictionary:
	var safe_type_id := _sanitize_enemy_type_id(type_id)
	if _enemy_stat_multipliers.has(safe_type_id):
		var cached_multipliers: Dictionary = _enemy_stat_multipliers[safe_type_id] as Dictionary
		return cached_multipliers

	var type_config := _get_enemy_type_config(safe_type_id)
	var multipliers: Dictionary = {
		"health": _sanitize_positive_multiplier(type_config.get("health_mul", DEFAULT_HEALTH_MULTIPLIER), DEFAULT_HEALTH_MULTIPLIER, MAX_HEALTH_MULTIPLIER),
		"speed": _sanitize_positive_multiplier(type_config.get("speed_mul", DEFAULT_SPEED_MULTIPLIER), DEFAULT_SPEED_MULTIPLIER, MAX_SPEED_MULTIPLIER),
		"reward": _sanitize_positive_multiplier(type_config.get("reward_mul", DEFAULT_REWARD_MULTIPLIER), DEFAULT_REWARD_MULTIPLIER, MAX_REWARD_MULTIPLIER),
	}
	_enemy_stat_multipliers[safe_type_id] = multipliers
	return multipliers


func _get_enemy_type_config(type_id: String) -> Dictionary:
	if game == null or game.enemy_type_configs.is_empty():
		return {}
	var safe_type_id := _sanitize_enemy_type_id(type_id)
	var fallback: Dictionary = {}
	var raw_fallback: Variant = game.enemy_type_configs.get("grunt", {})
	if raw_fallback is Dictionary:
		fallback = (raw_fallback as Dictionary).duplicate(true)
	var raw_config: Variant = game.enemy_type_configs.get(safe_type_id, fallback)
	if raw_config is Dictionary:
		return (raw_config as Dictionary).duplicate(true)
	return fallback


func _sanitize_positive_multiplier(raw_value: Variant, default_value: float, max_value: float) -> float:
	if raw_value is int or raw_value is float:
		var value := float(raw_value)
		if value > 0.0 and value <= max_value:
			return value
	return default_value


func _pick_enemy_type(wave_index: int, spawn_index: int) -> String:
	if enemy_types.has("elite") and wave_index >= 2 and spawn_index > 0 and spawn_index % 10 == 0:
		return "elite"
	if enemy_types.has("taunt") and wave_index >= 3 and spawn_index > 0 and spawn_index % 14 == 7:
		return "taunt"

	var max_index := mini(enemy_types.size() - 1, int(wave_index / 2))
	if spawn_index % 5 == 4:
		return str(enemy_types[max_index])
	return str(enemy_types[(spawn_index + wave_index) % (max_index + 1)])


func _pick_route_index(wave_index: int, _spawn_index: int, batch_index: int = 0) -> int:
	if route_count <= 1:
		return 0
	return (batch_index + wave_index) % route_count


func _normalize_enemy_types(available_enemy_types: Array) -> Array[String]:
	var normalized_types: Array[String] = []
	for type_value in available_enemy_types:
		var type_id := str(type_value).strip_edges()
		if type_id.is_empty():
			continue
		if normalized_types.has(type_id):
			continue
		normalized_types.append(type_id)
	if normalized_types.is_empty():
		normalized_types.append("grunt")
	return normalized_types


func _sanitize_enemy_type_id(raw_type: Variant) -> String:
	if game != null:
		return game._sanitize_enemy_type_id(raw_type)
	var type_id := str(raw_type).strip_edges()
	return type_id if not type_id.is_empty() else "grunt"
