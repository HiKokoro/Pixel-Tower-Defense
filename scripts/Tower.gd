extends Node2D
class_name Tower

const ImpactEffect := preload("res://scripts/ImpactEffect.gd")
const BASE_DAMAGE: int = 15
const LEGACY_GRID_SIZE: float = 32.0
const CURRENT_GRID_SIZE: float = 64.0
const WORLD_RANGE_SCALE: float = CURRENT_GRID_SIZE / LEGACY_GRID_SIZE
const LEGACY_BASE_RANGE: float = 130.0
const BASE_RANGE: float = LEGACY_BASE_RANGE * WORLD_RANGE_SCALE
const MAX_LEVEL: int = 3
const TARGET_SCAN_INTERVAL: float = 0.08
const TARGET_SCAN_JITTER_STEPS: int = 7
const RECOIL_DURATION_RATIO: float = 0.34
const RECOIL_MIN_DURATION: float = 0.07
const RECOIL_MAX_DURATION: float = 0.32
const PROJECTILE_EFFECTIVE_RANGE_MULTIPLIER: float = 1.35
const CONFIG_DEFAULT_COST: int = 50
const CONFIG_MAX_COST: int = 100000
const CONFIG_MAX_DAMAGE: int = 100000
const CONFIG_DEFAULT_INTERVAL: float = 0.8
const CONFIG_MAX_INTERVAL: float = 30.0
const CONFIG_DEFAULT_PROJECTILE_SPEED: float = 360.0
const CONFIG_MAX_PROJECTILE_SPEED: float = 4000.0
const CONFIG_MAX_RAW_RANGE: float = 2000.0
const CONFIG_MAX_SHOTS: int = 16
const CONFIG_MAX_SPREAD: float = 180.0
const CONFIG_MAX_SPLASH_RATIO: float = 10.0
const CONFIG_MAX_PIERCE: int = 64
const CONFIG_MAX_MULTIPLIER: float = 5.0
const AUGMENTATION_MAX_LEVEL: int = 3
const AUGMENTATION_UPGRADE_COSTS: Array[int] = [320, 560]
const AUGMENTATION_LEVEL_TWO_DAMAGE_MULTIPLIER: float = 1.16
const AUGMENTATION_LEVEL_TWO_RANGE_MULTIPLIER: float = 1.08
const AUGMENTATION_LEVEL_THREE_DAMAGE_MULTIPLIER: float = 1.14
const AUGMENTATION_LEVEL_THREE_RANGE_MULTIPLIER: float = 1.06
const DEFAULT_TOWER_DISPLAY_NAME := "基础塔"
const DEFAULT_AUGMENTATION_DISPLAY_NAME := "增幅塔"
const DEFAULT_TRAIT_TEXT := "标准弹道"
const MAX_LEVEL_PREVIEW_TEXT := "已达到最终形态"
const AUGMENTATION_LEVEL_TWO_TRAIT_NAME := "稳定谐振"
const AUGMENTATION_LEVEL_THREE_TRAIT_NAME := "矩阵过载"
const BASIC_LEVEL_TWO_TRAIT_NAME := "强化核心"
const BASIC_LEVEL_THREE_TRAIT_NAME := "元素分支"
const BASIC_FIRE_BRANCH_ID := "fire"
const BASIC_ICE_BRANCH_ID := "ice"
const BASIC_FIRE_BRANCH_DISPLAY_NAME := "火塔"
const BASIC_ICE_BRANCH_DISPLAY_NAME := "冰塔"
const BASIC_BRANCH_PREVIEW_TEXT := "等级3：选择火塔或冰塔"
const RAPID_LEVEL_TWO_TRAIT_NAME := "双联枪管"
const RAPID_LEVEL_THREE_TRAIT_NAME := "三联齐射"
const SHOTGUN_LEVEL_TWO_TRAIT_NAME := "扩容弹仓"
const SHOTGUN_LEVEL_THREE_TRAIT_NAME := "碎星齐射"
const CANNON_LEVEL_TWO_TRAIT_NAME := "爆破弹头"
const CANNON_LEVEL_THREE_TRAIT_NAME := "震荡核心"
const SNIPER_LEVEL_TWO_TRAIT_NAME := "校准透镜"
const SNIPER_LEVEL_THREE_TRAIT_NAME := "处决射击"
const CLUSTER_LEVEL_TWO_TRAIT_NAME := "蜂群装填"
const CLUSTER_LEVEL_THREE_TRAIT_NAME := "裂爆弹头"
const RAPID_BASE_TRAIT_TEXT := "单管高速射击"
const CANNON_BASE_TRAIT_TEXT := "重弹单体打击"
const SNIPER_BASE_TRAIT_TEXT := "超远距离点杀"
const CLUSTER_BASE_TRAIT_TEXT := "多枚跟踪弹头齐射"
const BASIC_BASE_TRAIT_TEXT := "均衡防御火力"
const UPGRADE_PREVIEW_TEMPLATE := "等级%d：%s"
const AUGMENTATION_TRAIT_LINE_TEMPLATE := "\n增幅：%s"
const AUGMENTATION_TRAIT_TEMPLATE := "\n增幅：%s 等级%d（伤害+%d%%，射程+%d%%）"
const BASIC_LEVEL_TWO_TRAIT_TEMPLATE := "%s：射程扩大，装填加快"
const BASIC_LEVEL_THREE_TRAIT_TEMPLATE := "%s：可分支为持续灼烧或寒霜减速"
const BASIC_FIRE_TRAIT_TEXT := "火塔：命中后造成持续烧伤"
const BASIC_ICE_TRAIT_TEXT := "冰塔：命中后降低敌人移动速度"
const RAPID_LEVEL_TWO_TRAIT_TEMPLATE := "%s：每次攻击发射两枚弹丸"
const RAPID_LEVEL_THREE_TRAIT_TEMPLATE := "%s：三枚弹丸形成高速弹幕"
const SHOTGUN_LEVEL_TWO_TRAIT_TEMPLATE := "%s：更宽扇形和更多弹丸"
const SHOTGUN_LEVEL_THREE_TRAIT_TEMPLATE := "%s：高密度近距覆盖"
const CANNON_LEVEL_TWO_TRAIT_TEMPLATE := "%s：爆破半径扩大，溅射伤害提高"
const CANNON_LEVEL_THREE_TRAIT_TEMPLATE := "%s：大范围高强度溅射炮击"
const SNIPER_LEVEL_TWO_TRAIT_TEMPLATE := "%s：极大提高单发伤害和射程"
const SNIPER_LEVEL_THREE_TRAIT_TEMPLATE := "%s：对低生命敌人造成致命伤害"
const CLUSTER_LEVEL_TWO_TRAIT_TEMPLATE := "%s：增加弹头数量和单枚伤害"
const CLUSTER_LEVEL_THREE_TRAIT_TEMPLATE := "%s：弹头伤害继续提高，并解锁小范围爆炸"

var game: Main
var grid_position: Vector2i = Vector2i.ZERO
var tower_type_id: String = "basic"
var display_name: String = _get_default_tower_display_name()
var attack_range: float = BASE_RANGE
var damage: int = BASE_DAMAGE
var attack_interval: float = 0.8
var projectile_speed: float = 360.0
var tower_color: Color = Color(0.23, 0.48, 0.78)
var barrel_color: Color = Color(0.08, 0.13, 0.18)
var projectile_color: Color = Color(1.0, 0.83, 0.2)
var level: int = 1
var total_invested: int = 50
var selected: bool = false
var damage_multiplier: float = 1.0
var damage_boost_time: float = 0.0
var range_multiplier: float = 1.0
var range_boost_time: float = 0.0
var fire_rate_multiplier: float = 1.0
var fire_rate_boost_time: float = 0.0
var augmentation_damage_multiplier: float = 1.0
var augmentation_range_multiplier: float = 1.0
var shots_per_attack: int = 1
var splash_radius: float = 0.0
var splash_damage_ratio: float = 0.0
var spread_angle: float = 0.0
var pierce_count: int = 0
var execute_threshold: float = 0.0
var execute_multiplier: float = 1.0
var level_trait: String = _get_default_trait_text()
var basic_branch: String = ""
var burn_damage_per_tick: int = 0
var burn_tick_interval: float = 0.5
var burn_duration: float = 0.0
var ice_slow_multiplier: float = 1.0
var ice_slow_duration: float = 0.0

var augmentation_id: String = ""
var augmentation_name: String = ""
var augmentation_level: int = 0
var stun_time: float = 0.0

var _cooldown: float = 0.0
var _current_target: Enemy
var _barrel_direction: Vector2 = Vector2.UP
var forced_fire_time: float = 0.0
var forced_fire_target_position: Vector2 = Vector2.ZERO
var _forced_fire_direction: Vector2 = Vector2.ZERO
var _target_scan_timer: float = 0.0
var _target_scan_interval: float = TARGET_SCAN_INTERVAL
var _effective_range: float = BASE_RANGE
var _effective_range_sq: float = BASE_RANGE * BASE_RANGE
var _effective_damage: int = BASE_DAMAGE
var _effective_splash_damage: int = 0
var _upgrade_costs: Array[int] = []
var _recoil_timer: float = 0.0
var _recoil_duration: float = 0.0
var _recoil_distance: float = 0.0
var _recoil_direction: Vector2 = Vector2.ZERO


func setup(game_ref: Main, tower_grid_position: Vector2i, type_config: Dictionary) -> void:
	game = game_ref
	grid_position = tower_grid_position
	tower_type_id = _get_config_id(type_config, "id", "basic")
	display_name = _get_tower_display_name(type_config)
	total_invested = _get_config_int(type_config, "cost", CONFIG_DEFAULT_COST, 0, CONFIG_MAX_COST)
	damage = _get_config_int(type_config, "damage", BASE_DAMAGE, 1, CONFIG_MAX_DAMAGE)
	attack_range = scale_world_range(_get_config_float(type_config, "range", LEGACY_BASE_RANGE, 1.0, CONFIG_MAX_RAW_RANGE))
	attack_interval = _get_config_float(type_config, "interval", CONFIG_DEFAULT_INTERVAL, 0.01, CONFIG_MAX_INTERVAL)
	projectile_speed = _get_config_float(type_config, "projectile_speed", CONFIG_DEFAULT_PROJECTILE_SPEED, 1.0, CONFIG_MAX_PROJECTILE_SPEED)
	shots_per_attack = _get_config_int(type_config, "shots", 1, 1, CONFIG_MAX_SHOTS)
	spread_angle = _get_config_float(type_config, "spread", 0.0, 0.0, CONFIG_MAX_SPREAD)
	splash_radius = scale_world_range(_get_config_float(type_config, "splash_radius", 0.0, 0.0, CONFIG_MAX_RAW_RANGE))
	splash_damage_ratio = _get_config_float(type_config, "splash_ratio", 0.0, 0.0, CONFIG_MAX_SPLASH_RATIO)
	pierce_count = _get_config_int(type_config, "pierce", 0, 0, CONFIG_MAX_PIERCE)
	tower_color = _get_config_color(type_config, "color", Color(0.23, 0.48, 0.78))
	barrel_color = _get_config_color(type_config, "barrel_color", Color(0.08, 0.13, 0.18))
	projectile_color = _get_config_color(type_config, "projectile_color", Color(1.0, 0.83, 0.2))
	level_trait = _get_base_trait()
	basic_branch = ""
	burn_damage_per_tick = 0
	burn_tick_interval = 0.5
	burn_duration = 0.0
	ice_slow_multiplier = 1.0
	ice_slow_duration = 0.0
	augmentation_id = ""
	augmentation_name = ""
	augmentation_level = 0
	augmentation_damage_multiplier = 1.0
	augmentation_range_multiplier = 1.0
	_upgrade_costs = _get_upgrade_costs()
	_refresh_range_cache()
	_refresh_damage_cache()
	_refresh_target_scan_interval()


static func scale_world_range(raw_range: float) -> float:
	return raw_range * WORLD_RANGE_SCALE


func _get_config_int(config: Dictionary, key: String, default_value: int, min_value: int, max_value: int) -> int:
	var raw_value: Variant = config.get(key, default_value)
	if raw_value is int or raw_value is float:
		return clampi(int(round(float(raw_value))), min_value, max_value)
	return default_value


func _get_config_float(config: Dictionary, key: String, default_value: float, min_value: float, max_value: float) -> float:
	var raw_value: Variant = config.get(key, default_value)
	if raw_value is int or raw_value is float:
		return clampf(float(raw_value), min_value, max_value)
	return default_value


func _get_config_color(config: Dictionary, key: String, fallback: Color) -> Color:
	var raw_value: Variant = config.get(key, fallback)
	return raw_value if raw_value is Color else fallback


func _get_config_id(config: Dictionary, key: String, fallback: String) -> String:
	var id := str(config.get(key, fallback)).strip_edges()
	return id if not id.is_empty() else fallback


func _process(delta: float) -> void:
	if game == null or game.is_game_over:
		return

	var redraw_needed := false
	if _recoil_timer > 0.0:
		_recoil_timer = maxf(_recoil_timer - delta, 0.0)
		redraw_needed = true

	if stun_time > 0.0:
		stun_time = maxf(stun_time - delta, 0.0)
		queue_redraw()
		return

	if damage_boost_time > 0.0:
		damage_boost_time = maxf(damage_boost_time - delta, 0.0)
		if damage_boost_time <= 0.0:
			damage_multiplier = 1.0
			_refresh_damage_cache()
			redraw_needed = true
	if range_boost_time > 0.0:
		range_boost_time = maxf(range_boost_time - delta, 0.0)
		if range_boost_time <= 0.0:
			range_multiplier = 1.0
			_refresh_range_cache()
			redraw_needed = true
	if fire_rate_boost_time > 0.0:
		fire_rate_boost_time = maxf(fire_rate_boost_time - delta, 0.0)
		if fire_rate_boost_time <= 0.0:
			fire_rate_multiplier = 1.0
			redraw_needed = true

	_cooldown = maxf(_cooldown - delta, 0.0)
	if forced_fire_time > 0.0:
		forced_fire_time = maxf(forced_fire_time - delta, 0.0)
		if _forced_fire_direction != Vector2.ZERO and absf(_barrel_direction.angle_to(_forced_fire_direction)) > 0.025:
			_barrel_direction = _forced_fire_direction
			redraw_needed = true
		if _cooldown <= 0.0 and forced_fire_time > 0.0:
			_fire_projectiles(_forced_fire_direction)
			_cooldown = get_effective_attack_interval()
		if forced_fire_time <= 0.0:
			_forced_fire_direction = Vector2.ZERO
			redraw_needed = true
		if redraw_needed:
			queue_redraw()
		return

	_target_scan_timer -= delta
	var has_valid_target := _is_target_valid(_current_target)
	if _target_scan_timer <= 0.0 or not has_valid_target:
		_current_target = _find_target()
		_target_scan_timer = _get_next_target_scan_interval()
		has_valid_target = _is_target_valid(_current_target)

	if has_valid_target:
		var target_direction := (_current_target.global_position - global_position).normalized()
		if target_direction != Vector2.ZERO and absf(_barrel_direction.angle_to(target_direction)) > 0.025:
			_barrel_direction = target_direction
			redraw_needed = true

	if _cooldown <= 0.0 and has_valid_target:
		_fire_at(_current_target)
		_cooldown = get_effective_attack_interval()

	if redraw_needed:
		queue_redraw()


func set_selected(value: bool) -> void:
	selected = value
	queue_redraw()


func can_upgrade() -> bool:
	return level < MAX_LEVEL


func can_choose_basic_branch() -> bool:
	return tower_type_id == "basic" and level == 2 and basic_branch.is_empty()


func is_upgrade_choice_valid(branch_id: String = "") -> bool:
	if not can_upgrade():
		return false
	if not can_choose_basic_branch():
		return branch_id.is_empty()
	return branch_id.is_empty() or _is_basic_branch_id(branch_id)


func get_upgrade_cost() -> int:
	if level >= MAX_LEVEL:
		return 0

	return _upgrade_costs[level - 1]


func upgrade(branch_id: String = "") -> bool:
	if not can_upgrade():
		return false
	if not is_upgrade_choice_valid(branch_id):
		return false

	var cost := get_upgrade_cost()
	var selected_basic_branch := _get_basic_upgrade_branch_or_default(branch_id)
	total_invested += cost
	level += 1
	if not selected_basic_branch.is_empty():
		basic_branch = selected_basic_branch

	_apply_upgrade_stats()
	if has_augmentation():
		_update_augmentation_trait_line()
	_refresh_range_cache()
	_refresh_damage_cache()
	_refresh_target_scan_interval()
	_target_scan_timer = 0.0

	queue_redraw()
	return true


func get_trait_summary() -> String:
	return level_trait


func get_upgrade_preview() -> String:
	if not can_upgrade():
		return _get_max_level_preview_text()
	if can_choose_basic_branch():
		return _get_basic_branch_preview_text()

	return _format_upgrade_preview_text(level + 1, _get_upgrade_preview_trait_name(tower_type_id, level + 1))


func can_upgrade_augmentation() -> bool:
	return _has_pending_augmentation_upgrade()


func get_augmentation_upgrade_cost() -> int:
	return _get_augmentation_upgrade_cost() if can_upgrade_augmentation() else 0


func get_augmentation_upgrade_preview() -> String:
	if not has_augmentation():
		return ""
	if not can_upgrade_augmentation():
		return "已满级"
	return _format_upgrade_preview_text(augmentation_level + 1, _get_augmentation_upgrade_trait_name(augmentation_level + 1))


func upgrade_augmentation() -> bool:
	return _upgrade_augmentation()


func get_sell_value() -> int:
	return int(round(float(total_invested) * 0.6))


func apply_damage_boost(multiplier: float, duration: float) -> void:
	damage_multiplier = maxf(damage_multiplier, multiplier)
	damage_boost_time = maxf(damage_boost_time, duration)
	_refresh_damage_cache()
	if game != null:
		game.spawn_particle_burst(global_position, {
			"name": "DamageBoostParticles",
			"amount": 18,
			"lifetime": 0.46,
			"emission_radius": 12.0,
			"velocity_min": 24.0,
			"velocity_max": 96.0,
			"gravity": Vector2.ZERO,
			"color": Color(1.0, 0.78, 0.24),
		})
	queue_redraw()


func apply_range_boost(multiplier: float, duration: float) -> void:
	range_multiplier = maxf(range_multiplier, multiplier)
	range_boost_time = maxf(range_boost_time, duration)
	_refresh_range_cache()
	_target_scan_timer = 0.0
	if game != null:
		game.spawn_particle_burst(global_position, {
			"name": "RangeBoostParticles",
			"amount": 18,
			"lifetime": 0.52,
			"emission_radius": 18.0,
			"velocity_min": 20.0,
			"velocity_max": 110.0,
			"gravity": Vector2.ZERO,
			"color": Color(0.45, 0.76, 1.0),
		})
	queue_redraw()


func apply_fire_rate_boost(multiplier: float, duration: float) -> void:
	fire_rate_multiplier = maxf(fire_rate_multiplier, multiplier)
	fire_rate_boost_time = maxf(fire_rate_boost_time, duration)
	if game != null:
		game.spawn_particle_burst(global_position, {
			"name": "FireRateBoostParticles",
			"amount": 18,
			"lifetime": 0.42,
			"emission_radius": 12.0,
			"velocity_min": 42.0,
			"velocity_max": 150.0,
			"gravity": Vector2.ZERO,
			"color": Color(0.58, 1.0, 0.70),
		})
	queue_redraw()


func can_apply_augmentation() -> bool:
	return augmentation_id.is_empty()


func apply_augmentation(type_config: Dictionary) -> bool:
	if not can_apply_augmentation():
		return false
	augmentation_id = _get_config_id(type_config, "id", "amplifier")
	augmentation_name = _get_augmentation_display_name(type_config)
	augmentation_level = 1
	augmentation_damage_multiplier = _get_config_float(type_config, "damage_multiplier", 1.0, 0.0, CONFIG_MAX_MULTIPLIER)
	augmentation_range_multiplier = _get_config_float(type_config, "range_multiplier", 1.0, 0.0, CONFIG_MAX_MULTIPLIER)
	total_invested += _get_config_int(type_config, "cost", 0, 0, CONFIG_MAX_COST)
	_update_augmentation_trait_line()
	_refresh_range_cache()
	_refresh_damage_cache()
	_refresh_target_scan_interval()
	queue_redraw()
	return true


func has_augmentation() -> bool:
	return not augmentation_id.is_empty()


func get_augmentation_display_name() -> String:
	return augmentation_name if not augmentation_name.strip_edges().is_empty() else _get_default_augmentation_display_name()


func get_augmentation_level() -> int:
	return augmentation_level


func get_augmentation_damage_bonus_percent() -> int:
	return int(round((augmentation_damage_multiplier - 1.0) * 100.0))


func get_augmentation_range_bonus_percent() -> int:
	return int(round((augmentation_range_multiplier - 1.0) * 100.0))


func is_upgrading_augmentation() -> bool:
	return _has_pending_augmentation_upgrade()


func _get_tower_display_name(type_config: Dictionary) -> String:
	var config_name := str(type_config.get("name", "")).strip_edges()
	return config_name if not config_name.is_empty() else _get_default_tower_display_name()


func _get_augmentation_display_name(type_config: Dictionary) -> String:
	var config_name := str(type_config.get("name", "")).strip_edges()
	return config_name if not config_name.is_empty() else _get_default_augmentation_display_name()


func _get_default_tower_display_name() -> String:
	return DEFAULT_TOWER_DISPLAY_NAME


func _get_default_augmentation_display_name() -> String:
	return DEFAULT_AUGMENTATION_DISPLAY_NAME


func _get_default_trait_text() -> String:
	return DEFAULT_TRAIT_TEXT


func _get_max_level_preview_text() -> String:
	return MAX_LEVEL_PREVIEW_TEXT


func _get_basic_branch_preview_text() -> String:
	return BASIC_BRANCH_PREVIEW_TEXT


func _format_upgrade_preview_text(next_level: int, trait_name: String) -> String:
	return UPGRADE_PREVIEW_TEMPLATE % [next_level, trait_name]


func _get_upgrade_preview_trait_name(type_id: String, next_level: int) -> String:
	match type_id:
		"rapid":
			return _get_rapid_upgrade_trait_name(next_level)
		"shotgun":
			return _get_shotgun_upgrade_trait_name(next_level)
		"cannon":
			return _get_cannon_upgrade_trait_name(next_level)
		"sniper":
			return _get_sniper_upgrade_trait_name(next_level)
		"cluster":
			return _get_cluster_upgrade_trait_name(next_level)
		_:
			return _get_basic_upgrade_trait_name(next_level)


func _get_basic_upgrade_trait_name(next_level: int) -> String:
	if next_level <= 2:
		return BASIC_LEVEL_TWO_TRAIT_NAME
	return BASIC_LEVEL_THREE_TRAIT_NAME


func _get_rapid_upgrade_trait_name(next_level: int) -> String:
	if next_level <= 2:
		return RAPID_LEVEL_TWO_TRAIT_NAME
	return RAPID_LEVEL_THREE_TRAIT_NAME


func _get_shotgun_upgrade_trait_name(next_level: int) -> String:
	if next_level <= 2:
		return SHOTGUN_LEVEL_TWO_TRAIT_NAME
	return SHOTGUN_LEVEL_THREE_TRAIT_NAME


func _get_cannon_upgrade_trait_name(next_level: int) -> String:
	if next_level <= 2:
		return CANNON_LEVEL_TWO_TRAIT_NAME
	return CANNON_LEVEL_THREE_TRAIT_NAME


func _get_sniper_upgrade_trait_name(next_level: int) -> String:
	if next_level <= 2:
		return SNIPER_LEVEL_TWO_TRAIT_NAME
	return SNIPER_LEVEL_THREE_TRAIT_NAME


func _get_cluster_upgrade_trait_name(next_level: int) -> String:
	if next_level <= 2:
		return CLUSTER_LEVEL_TWO_TRAIT_NAME
	return CLUSTER_LEVEL_THREE_TRAIT_NAME


func _format_augmentation_trait_line_text(augmentation_display_name: String) -> String:
	return AUGMENTATION_TRAIT_LINE_TEMPLATE % augmentation_display_name


func _format_augmentation_trait_text() -> String:
	return AUGMENTATION_TRAIT_TEMPLATE % [
		get_augmentation_display_name(),
		maxi(augmentation_level, 1),
		get_augmentation_damage_bonus_percent(),
		get_augmentation_range_bonus_percent(),
	]


func _get_augmentation_upgrade_trait_name(next_level: int) -> String:
	return AUGMENTATION_LEVEL_TWO_TRAIT_NAME if next_level <= 2 else AUGMENTATION_LEVEL_THREE_TRAIT_NAME


func _has_pending_augmentation_upgrade() -> bool:
	return has_augmentation() and augmentation_level > 0 and augmentation_level < AUGMENTATION_MAX_LEVEL


func _get_augmentation_upgrade_cost() -> int:
	var cost_index := clampi(augmentation_level - 1, 0, AUGMENTATION_UPGRADE_COSTS.size() - 1)
	return AUGMENTATION_UPGRADE_COSTS[cost_index]


func _upgrade_augmentation() -> bool:
	if not _has_pending_augmentation_upgrade():
		return false

	var cost := _get_augmentation_upgrade_cost()
	total_invested += cost
	augmentation_level += 1
	match augmentation_level:
		2:
			augmentation_damage_multiplier *= AUGMENTATION_LEVEL_TWO_DAMAGE_MULTIPLIER
			augmentation_range_multiplier *= AUGMENTATION_LEVEL_TWO_RANGE_MULTIPLIER
		3:
			augmentation_damage_multiplier *= AUGMENTATION_LEVEL_THREE_DAMAGE_MULTIPLIER
			augmentation_range_multiplier *= AUGMENTATION_LEVEL_THREE_RANGE_MULTIPLIER
	_update_augmentation_trait_line()
	_refresh_range_cache()
	_refresh_damage_cache()
	_refresh_target_scan_interval()
	_target_scan_timer = 0.0
	queue_redraw()
	return true


func _update_augmentation_trait_line() -> void:
	var base_trait := level_trait
	var split_index := base_trait.find("\n增幅：")
	if split_index >= 0:
		base_trait = base_trait.substr(0, split_index)
	level_trait = "%s%s" % [base_trait, _format_augmentation_trait_text()]


func _get_base_trait_text(type_id: String) -> String:
	match type_id:
		"rapid":
			return _get_rapid_base_trait_text()
		"cannon":
			return _get_cannon_base_trait_text()
		"sniper":
			return _get_sniper_base_trait_text()
		"cluster":
			return _get_cluster_base_trait_text()
		_:
			return _get_basic_base_trait_text()


func _get_rapid_base_trait_text() -> String:
	return RAPID_BASE_TRAIT_TEXT


func _get_cannon_base_trait_text() -> String:
	return CANNON_BASE_TRAIT_TEXT


func _get_sniper_base_trait_text() -> String:
	return SNIPER_BASE_TRAIT_TEXT


func _get_cluster_base_trait_text() -> String:
	return CLUSTER_BASE_TRAIT_TEXT


func _get_basic_base_trait_text() -> String:
	return BASIC_BASE_TRAIT_TEXT


func _format_basic_level_two_trait_text() -> String:
	return BASIC_LEVEL_TWO_TRAIT_TEMPLATE % _get_basic_upgrade_trait_name(2)


func _format_basic_level_three_trait_text() -> String:
	return BASIC_LEVEL_THREE_TRAIT_TEMPLATE % _get_basic_upgrade_trait_name(3)


func _format_basic_fire_trait_text() -> String:
	return BASIC_FIRE_TRAIT_TEXT


func _format_basic_ice_trait_text() -> String:
	return BASIC_ICE_TRAIT_TEXT


func _is_basic_branch_id(branch_id: String) -> bool:
	return branch_id == BASIC_FIRE_BRANCH_ID or branch_id == BASIC_ICE_BRANCH_ID


func _get_basic_upgrade_branch_or_default(branch_id: String) -> String:
	if not can_choose_basic_branch():
		return ""
	if branch_id.is_empty():
		return BASIC_FIRE_BRANCH_ID
	return branch_id if _is_basic_branch_id(branch_id) else ""


func _format_rapid_level_two_trait_text() -> String:
	return RAPID_LEVEL_TWO_TRAIT_TEMPLATE % _get_rapid_upgrade_trait_name(2)


func _format_rapid_level_three_trait_text() -> String:
	return RAPID_LEVEL_THREE_TRAIT_TEMPLATE % _get_rapid_upgrade_trait_name(3)


func _format_shotgun_level_two_trait_text() -> String:
	return SHOTGUN_LEVEL_TWO_TRAIT_TEMPLATE % _get_shotgun_upgrade_trait_name(2)


func _format_shotgun_level_three_trait_text() -> String:
	return SHOTGUN_LEVEL_THREE_TRAIT_TEMPLATE % _get_shotgun_upgrade_trait_name(3)


func _format_cannon_level_two_trait_text() -> String:
	return CANNON_LEVEL_TWO_TRAIT_TEMPLATE % _get_cannon_upgrade_trait_name(2)


func _format_cannon_level_three_trait_text() -> String:
	return CANNON_LEVEL_THREE_TRAIT_TEMPLATE % _get_cannon_upgrade_trait_name(3)


func _format_sniper_level_two_trait_text() -> String:
	return SNIPER_LEVEL_TWO_TRAIT_TEMPLATE % _get_sniper_upgrade_trait_name(2)


func _format_sniper_level_three_trait_text() -> String:
	return SNIPER_LEVEL_THREE_TRAIT_TEMPLATE % _get_sniper_upgrade_trait_name(3)


func _format_cluster_level_two_trait_text() -> String:
	return CLUSTER_LEVEL_TWO_TRAIT_TEMPLATE % _get_cluster_upgrade_trait_name(2)


func _format_cluster_level_three_trait_text() -> String:
	return CLUSTER_LEVEL_THREE_TRAIT_TEMPLATE % _get_cluster_upgrade_trait_name(3)


func apply_stun(duration: float) -> void:
	stun_time = maxf(stun_time, duration)
	queue_redraw()


func can_receive_forced_fire_command() -> bool:
	return tower_type_id != "amplifier" and damage > 0 and attack_interval > 0.0


func apply_forced_fire_direction(target_position: Vector2, duration: float) -> void:
	if not can_receive_forced_fire_command() or duration <= 0.0:
		return

	update_forced_fire_target_position(target_position)
	forced_fire_time = maxf(forced_fire_time, duration)
	_current_target = null
	_target_scan_timer = 0.0
	queue_redraw()


func update_forced_fire_target_position(target_position: Vector2) -> void:
	forced_fire_target_position = target_position
	var next_direction := (target_position - global_position).normalized()
	if next_direction == Vector2.ZERO:
		next_direction = _forced_fire_direction if _forced_fire_direction != Vector2.ZERO else _barrel_direction
	if next_direction == Vector2.ZERO:
		next_direction = Vector2.UP
	if _forced_fire_direction == Vector2.ZERO or absf(_forced_fire_direction.angle_to(next_direction)) > 0.001:
		_forced_fire_direction = next_direction
		queue_redraw()
	else:
		_forced_fire_direction = next_direction


func get_effective_range() -> float:
	return _effective_range


func get_effective_damage() -> int:
	return _effective_damage


func get_effective_attack_interval() -> float:
	return attack_interval / maxf(fire_rate_multiplier, 0.1)


func _trigger_recoil(direction: Vector2, shot_count: int) -> void:
	if direction == Vector2.ZERO:
		return

	_recoil_direction = -direction.normalized()
	_recoil_duration = _get_recoil_duration()
	_recoil_timer = _recoil_duration
	_recoil_distance = _get_recoil_distance(shot_count)
	queue_redraw()


func _get_recoil_duration() -> float:
	var duration_multiplier := 1.0
	match tower_type_id:
		"cannon":
			duration_multiplier = 1.75
		"sniper":
			duration_multiplier = 1.50
		"cluster":
			duration_multiplier = 1.20
		"rapid":
			duration_multiplier = 0.82
		_:
			duration_multiplier = 1.0
	return clampf(get_effective_attack_interval() * RECOIL_DURATION_RATIO * duration_multiplier, RECOIL_MIN_DURATION, RECOIL_MAX_DURATION)


func _get_recoil_distance(shot_count: int) -> float:
	var base_distance := 4.0
	match tower_type_id:
		"rapid":
			base_distance = 2.6
		"shotgun":
			base_distance = 6.0
		"cannon":
			base_distance = 9.2
		"sniper":
			base_distance = 6.2
		"cluster":
			base_distance = 7.4
		_:
			base_distance = 4.0

	var level_bonus := float(maxi(level - 1, 0)) * 0.45
	var volley_bonus := minf(float(maxi(shot_count, 1) - 1) * 0.32, 2.0)
	return clampf(base_distance + level_bonus + volley_bonus, 2.0, 11.0)


func _get_recoil_offset() -> Vector2:
	if _recoil_timer <= 0.0 or _recoil_duration <= 0.0 or _recoil_direction == Vector2.ZERO:
		return Vector2.ZERO

	var remaining_ratio := clampf(_recoil_timer / _recoil_duration, 0.0, 1.0)
	var strength := remaining_ratio * remaining_ratio
	return _recoil_direction * _recoil_distance * strength


func _get_projectile_max_distance() -> float:
	if tower_type_id == "sniper":
		return 0.0
	return get_effective_range() * PROJECTILE_EFFECTIVE_RANGE_MULTIPLIER


func _get_next_target_scan_interval() -> float:
	return _target_scan_interval


func _refresh_target_scan_interval() -> void:
	var hash: int = absi(grid_position.x * 31 + grid_position.y * 17 + level * 13)
	var jitter: float = float(hash % TARGET_SCAN_JITTER_STEPS) / float(TARGET_SCAN_JITTER_STEPS)
	_target_scan_interval = TARGET_SCAN_INTERVAL + jitter * TARGET_SCAN_INTERVAL


func _refresh_range_cache() -> void:
	_effective_range = attack_range * augmentation_range_multiplier * range_multiplier
	_effective_range_sq = _effective_range * _effective_range


func _refresh_damage_cache() -> void:
	var permanent_damage := float(damage) * augmentation_damage_multiplier
	_effective_damage = int(round(permanent_damage * damage_multiplier))
	_effective_splash_damage = int(round(permanent_damage * splash_damage_ratio * damage_multiplier))


func _is_target_valid(enemy) -> bool:
	return _get_valid_enemy_target(enemy) != null


func _get_valid_enemy_target(enemy) -> Enemy:
	if not is_instance_valid(enemy):
		return null
	var target_enemy := enemy as Enemy
	if target_enemy == null:
		return null
	if target_enemy.is_dead:
		return null
	if target_enemy.has_reached_end:
		return null
	if global_position.distance_squared_to(target_enemy.global_position) > _effective_range_sq:
		return null
	return target_enemy


func _find_target() -> Enemy:
	var best_taunt_enemy: Enemy = null
	var best_taunt_progress := -1.0
	var best_enemy: Enemy = null
	var best_progress := -1.0

	for enemy in game.get_active_enemies():
		var valid_enemy := _get_valid_enemy_target(enemy)
		if valid_enemy == null:
			continue

		var progress: float = valid_enemy.get_path_progress()
		if valid_enemy.is_taunt:
			if progress > best_taunt_progress:
				best_taunt_progress = progress
				best_taunt_enemy = valid_enemy
			continue
		if progress > best_progress:
			best_progress = progress
			best_enemy = valid_enemy

	if best_taunt_enemy != null:
		return best_taunt_enemy
	return best_enemy


func _fire_at(enemy: Enemy) -> void:
	var direction := (enemy.global_position - global_position).normalized()
	if direction == Vector2.ZERO:
		direction = Vector2.UP
	_fire_projectiles(direction, enemy)


func _fire_projectiles(direction: Vector2, target_enemy: Enemy = null) -> void:
	var shot_count := maxi(shots_per_attack, 1)
	if direction == Vector2.ZERO:
		direction = Vector2.UP
	var side := direction.orthogonal()
	_trigger_recoil(direction, shot_count)
	_spawn_fire_visuals(direction, shot_count)

	for index in range(shot_count):
		var projectile := Projectile.new()
		var offset := (float(index) - float(shot_count - 1) * 0.5) * 7.0
		var shot_direction := direction
		if spread_angle > 0.0 and shot_count > 1:
			var spread_offset := (float(index) - float(shot_count - 1) * 0.5) / float(shot_count - 1)
			shot_direction = direction.rotated(spread_offset * spread_angle).normalized()
		projectile.global_position = global_position + side * offset
		var projectile_target := target_enemy if tower_type_id == "cluster" and is_instance_valid(target_enemy) else null
		projectile.setup(
			projectile_target,
			_get_attack_damage(target_enemy),
			projectile_speed,
			splash_radius,
			_effective_splash_damage,
			projectile_color,
			pierce_count,
			shot_direction,
			_get_projectile_max_distance(),
			_get_projectile_visual_profile()
		)
		if tower_type_id == "cluster" and projectile_target != null:
			projectile.setup_homing(true)
		projectile.setup_status_effect(_get_projectile_status_effect())
		game.add_projectile(projectile)
		game.spawn_muzzle_particles(global_position + shot_direction * 25.0 + side * offset, shot_direction, projectile_color)


func _spawn_fire_visuals(direction: Vector2, shot_count: int) -> void:
	if game == null:
		return
	var effect_parent := game.impact_layer if game.impact_layer != null else game.particle_layer
	if effect_parent == null:
		return

	var effect_position := global_position + direction * 24.0
	var profile := "muzzle"
	var effect_name := "TowerMuzzleEffect"
	var effect_radius := 30.0
	var effect_duration := 0.14
	var effect_width := 0.0
	var effect_spread := 0.0

	match tower_type_id:
		"rapid":
			profile = "rapid"
			effect_name = "RapidMuzzleEffect"
			effect_radius = 34.0
			effect_duration = 0.12
		"shotgun":
			profile = "shotgun"
			effect_name = "ShotgunConeEffect"
			effect_radius = get_effective_range() * 0.34
			effect_duration = 0.18
			effect_spread = spread_angle
		"cannon":
			effect_name = "CannonMuzzleEffect"
			effect_radius = 42.0
			effect_duration = 0.18
			effect_width = 4.0
		"cluster":
			profile = "rapid"
			effect_name = "ClusterMuzzleVolley"
			effect_radius = 44.0
			effect_duration = 0.16
		"sniper":
			profile = "sniper"
			effect_name = "SniperMuzzleTrace"
			effect_radius = minf(get_effective_range() * 0.26, 90.0)
			effect_duration = 0.12
			effect_width = 1.8

	ImpactEffect.spawn(effect_parent, effect_position, {
		"name": effect_name,
		"profile": profile,
		"radius": effect_radius,
		"direction": direction,
		"duration": effect_duration,
		"width": effect_width,
		"spread_angle": effect_spread,
		"color": projectile_color.lightened(0.08),
		"z_index": 94,
	})

	if tower_type_id == "shotgun":
		game.spawn_particle_burst(effect_position + direction * 12.0, {
			"name": "ShotgunMuzzleParticles",
			"amount": 3 + shot_count,
			"lifetime": 0.20,
			"emission_radius": 5.0,
			"direction": direction,
			"spread": rad_to_deg(maxf(spread_angle, 0.24)),
			"velocity_min": 36.0,
			"velocity_max": 128.0,
			"scale_min": 0.7,
			"scale_max": 1.6,
			"gravity": Vector2.ZERO,
			"color": projectile_color,
		})


func _get_projectile_visual_profile() -> String:
	match tower_type_id:
		"rapid":
			return Projectile.VISUAL_RAPID
		"shotgun":
			return Projectile.VISUAL_SHOTGUN
		"cannon":
			return Projectile.VISUAL_CANNON
		"sniper":
			return Projectile.VISUAL_SNIPER
		"cluster":
			return Projectile.VISUAL_CLUSTER
		_:
			return Projectile.VISUAL_BASIC


func _get_attack_damage(enemy: Enemy) -> int:
	var result := _effective_damage
	if execute_threshold > 0.0 and is_instance_valid(enemy):
		var health_ratio := float(enemy.health) / maxf(float(enemy.max_health), 1.0)
		if health_ratio <= execute_threshold:
			result = int(round(float(result) * execute_multiplier))
	return result


func _get_projectile_status_effect() -> Dictionary:
	if tower_type_id != "basic" or level < 3:
		return {}
	match basic_branch:
		BASIC_FIRE_BRANCH_ID:
			return {
				"id": BASIC_FIRE_BRANCH_ID,
				"burn_damage_per_tick": burn_damage_per_tick,
				"burn_tick_interval": burn_tick_interval,
				"burn_duration": burn_duration,
			}
		BASIC_ICE_BRANCH_ID:
			return {
				"id": BASIC_ICE_BRANCH_ID,
				"slow_multiplier": ice_slow_multiplier,
				"slow_duration": ice_slow_duration,
			}
	return {}


func _get_upgrade_costs() -> Array[int]:
	match tower_type_id:
		"rapid":
			return [90, 155]
		"shotgun":
			return [105, 175]
		"cannon":
			return [120, 205]
		"sniper":
			return [130, 220]
		"cluster":
			return [145, 245]
		_:
			return [80, 145]


func _get_base_trait() -> String:
	return _get_base_trait_text(tower_type_id)


func _apply_upgrade_stats() -> void:
	match tower_type_id:
		"rapid":
			_apply_rapid_upgrade()
		"shotgun":
			_apply_shotgun_upgrade()
		"cannon":
			_apply_cannon_upgrade()
		"sniper":
			_apply_sniper_upgrade()
		"cluster":
			_apply_cluster_upgrade()
		_:
			_apply_basic_upgrade()


func _apply_basic_upgrade() -> void:
	match level:
		2:
			damage += 8
			attack_range += scale_world_range(28.0)
			attack_interval *= 0.88
			projectile_speed += 55.0
			level_trait = _format_basic_level_two_trait_text()
		3:
			match basic_branch:
				BASIC_ICE_BRANCH_ID:
					display_name = BASIC_ICE_BRANCH_DISPLAY_NAME
					damage += 6
					attack_range += scale_world_range(38.0)
					attack_interval *= 0.86
					projectile_speed += 60.0
					tower_color = Color(0.24, 0.58, 0.88)
					barrel_color = Color(0.05, 0.13, 0.20)
					projectile_color = Color(0.56, 0.92, 1.0)
					ice_slow_multiplier = 0.52
					ice_slow_duration = 3.0
					level_trait = _format_basic_ice_trait_text()
				_:
					basic_branch = BASIC_FIRE_BRANCH_ID
					display_name = BASIC_FIRE_BRANCH_DISPLAY_NAME
					damage += 11
					attack_range += scale_world_range(28.0)
					attack_interval *= 0.82
					projectile_speed += 75.0
					tower_color = Color(0.88, 0.34, 0.17)
					barrel_color = Color(0.16, 0.08, 0.05)
					projectile_color = Color(1.0, 0.46, 0.10)
					burn_damage_per_tick = 6
					burn_tick_interval = 0.5
					burn_duration = 3.0
					level_trait = _format_basic_fire_trait_text()


func _apply_rapid_upgrade() -> void:
	match level:
		2:
			damage += 2
			attack_range += scale_world_range(18.0)
			attack_interval *= 0.84
			shots_per_attack = 2
			level_trait = _format_rapid_level_two_trait_text()
		3:
			attack_range += scale_world_range(22.0)
			attack_interval *= 0.66
			shots_per_attack = 3
			level_trait = _format_rapid_level_three_trait_text()


func _apply_shotgun_upgrade() -> void:
	match level:
		2:
			damage += 4
			attack_range += scale_world_range(14.0)
			shots_per_attack = 6
			spread_angle = 1.10
			level_trait = _format_shotgun_level_two_trait_text()
		3:
			damage += 7
			attack_interval *= 0.82
			shots_per_attack = 8
			spread_angle = 1.25
			level_trait = _format_shotgun_level_three_trait_text()


func _apply_cannon_upgrade() -> void:
	match level:
		2:
			damage += 18
			attack_range += scale_world_range(20.0)
			splash_radius = scale_world_range(74.0)
			splash_damage_ratio = 0.62
			projectile_speed += 35.0
			level_trait = _format_cannon_level_two_trait_text()
		3:
			damage += 30
			attack_range += scale_world_range(30.0)
			attack_interval *= 0.86
			splash_radius = scale_world_range(96.0)
			splash_damage_ratio = 0.78
			projectile_speed += 45.0
			level_trait = _format_cannon_level_three_trait_text()


func _apply_sniper_upgrade() -> void:
	match level:
		2:
			damage += 34
			attack_range += scale_world_range(48.0)
			projectile_speed += 180.0
			attack_interval *= 0.98
			level_trait = _format_sniper_level_two_trait_text()
		3:
			damage += 58
			attack_range += scale_world_range(62.0)
			projectile_speed += 220.0
			execute_threshold = 0.35
			execute_multiplier = 1.9
			level_trait = _format_sniper_level_three_trait_text()


func _apply_cluster_upgrade() -> void:
	match level:
		2:
			damage += 3
			attack_range += scale_world_range(24.0)
			attack_interval *= 0.90
			projectile_speed += 28.0
			shots_per_attack = 8
			spread_angle = 0.46
			level_trait = _format_cluster_level_two_trait_text()
		3:
			damage += 1
			attack_range += scale_world_range(26.0)
			attack_interval *= 0.88
			projectile_speed += 22.0
			shots_per_attack = 10
			spread_angle = 0.56
			splash_radius = scale_world_range(46.0)
			splash_damage_ratio = 0.50
			level_trait = _format_cluster_level_three_trait_text()


func _draw() -> void:
	if selected:
		var effective_range := get_effective_range()
		draw_circle(Vector2.ZERO, effective_range, Color(0.2, 0.55, 1.0, 0.07))
		draw_arc(Vector2.ZERO, effective_range, 0.0, TAU, 96, Color(0.35, 0.75, 1.0, 0.55), 2.0, true)

	_draw_contact_shadow()

	var recoil_offset := _get_recoil_offset()
	draw_set_transform(recoil_offset, 0.0, Vector2.ONE)

	if damage_boost_time > 0.0:
		draw_circle(Vector2.ZERO, 34.0, Color(1.0, 0.30, 0.18, 0.10))
		for marker in [Vector2(-28.0, -28.0), Vector2(20.0, -28.0), Vector2(-28.0, 20.0), Vector2(20.0, 20.0)]:
			draw_rect(Rect2(marker, Vector2(8.0, 8.0)), Color(1.0, 0.38, 0.20, 0.82))
	if range_boost_time > 0.0:
		draw_circle(Vector2.ZERO, 38.0, Color(0.35, 0.70, 1.0, 0.08))
		draw_arc(Vector2.ZERO, 38.0, 0.0, TAU, 40, Color(0.45, 0.75, 1.0, 0.72), 2.0, true)
	if fire_rate_boost_time > 0.0:
		draw_rect(Rect2(Vector2(-25.0, -35.0), Vector2(50.0, 4.0)), Color(0.60, 1.0, 0.72, 0.80))
		draw_rect(Rect2(Vector2(-18.0, 31.0), Vector2(36.0, 4.0)), Color(0.60, 1.0, 0.72, 0.52))
	if stun_time > 0.0:
		draw_circle(Vector2.ZERO, 36.0, Color(0.75, 0.85, 1.0, 0.16))
		draw_arc(Vector2.ZERO, 32.0, 0.0, TAU, 28, Color(0.80, 0.92, 1.0, 0.85), 3.0, true)

	var barrel_direction := _barrel_direction

	match tower_type_id:
		"amplifier":
			_draw_amplifier_tower(barrel_direction)
		"rapid":
			_draw_rapid_tower(barrel_direction)
		"shotgun":
			_draw_shotgun_tower(barrel_direction)
		"cannon":
			_draw_cannon_tower(barrel_direction)
		"sniper":
			_draw_sniper_tower(barrel_direction)
		"cluster":
			_draw_cluster_tower(barrel_direction)
		_:
			_draw_basic_tower(barrel_direction)

	_draw_upgrade_details()
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)


func _draw_contact_shadow() -> void:
	var shadow_points := PackedVector2Array()
	for index in range(20):
		var angle := TAU * float(index) / 20.0
		shadow_points.append((Vector2(cos(angle) * 25.0, 11.0 + sin(angle) * 8.0)).snapped(Vector2.ONE))
	draw_colored_polygon(shadow_points, Color(0.0, 0.0, 0.0, 0.26))


func _draw_basic_tower(direction: Vector2) -> void:
	var side := direction.orthogonal()
	_draw_64px_chassis(tower_color, tower_color.lightened(0.22), Color(0.08, 0.13, 0.18))
	if level >= 2:
		_draw_rect_center(Vector2(-18.0, -18.0), Vector2(14.0, 8.0), tower_color.lightened(0.18))
		_draw_rect_center(Vector2(18.0, -18.0), Vector2(14.0, 8.0), tower_color.lightened(0.18))
		_draw_rect_center(side * -19.0 + direction * -4.0, Vector2(6.0, 22.0), projectile_color.lightened(0.04))
		_draw_rect_center(side * 19.0 + direction * -4.0, Vector2(6.0, 22.0), projectile_color.lightened(0.04))
	_draw_directional_barrel(direction, 33.0 if level < 3 else 37.0, 8.0 if level < 3 else 10.0, barrel_color, tower_color.lightened(0.28), 8.0 if level < 3 else 10.0)
	if level >= 2:
		draw_line((side * -6.0 + direction * 7.0).snapped(Vector2.ONE), (side * -6.0 + direction * 26.0).snapped(Vector2.ONE), projectile_color.lightened(0.12), 2.0, false)
		draw_line((side * 6.0 + direction * 7.0).snapped(Vector2.ONE), (side * 6.0 + direction * 26.0).snapped(Vector2.ONE), projectile_color.lightened(0.12), 2.0, false)
	_draw_rect_center(Vector2.ZERO, Vector2(18.0 if level < 3 else 22.0, 18.0 if level < 3 else 22.0), tower_color.lightened(0.12))
	_draw_rect_center(Vector2.ZERO, Vector2(10.0 if level < 3 else 13.0, 10.0 if level < 3 else 13.0), Color(0.88, 0.95, 1.0))
	_draw_rect_center(Vector2.ZERO, Vector2(4.0 if level < 3 else 7.0, 4.0 if level < 3 else 7.0), projectile_color)
	_draw_corner_bolts(Color(0.78, 0.94, 1.0, 0.82), 23.0, 4.0)
	if level >= 3:
		if basic_branch == BASIC_ICE_BRANCH_ID:
			_draw_rect_center(Vector2(0.0, -22.0), Vector2(28.0, 5.0), Color(0.66, 0.94, 1.0, 0.88))
			_draw_rect_center(Vector2(0.0, 22.0), Vector2(28.0, 5.0), Color(0.38, 0.74, 1.0, 0.70))
			for marker in [Vector2(-23.0, 13.0), Vector2(23.0, 13.0), Vector2(-16.0, -24.0), Vector2(16.0, -24.0)]:
				_draw_rect_center(marker, Vector2(7.0, 13.0), Color(0.78, 0.97, 1.0, 0.82))
			draw_arc(Vector2.ZERO, 28.0, -0.15, TAU - 0.15, 28, Color(0.62, 0.94, 1.0, 0.55), 2.0, false)
		else:
			_draw_rect_center(Vector2(0.0, -22.0), Vector2(28.0, 5.0), Color(1.0, 0.64, 0.22, 0.92))
			_draw_rect_center(Vector2(0.0, 22.0), Vector2(28.0, 5.0), Color(0.95, 0.26, 0.12, 0.78))
			_draw_rect_center(Vector2(-23.0, 15.0), Vector2(7.0, 13.0), Color(1.0, 0.74, 0.24, 0.82))
			_draw_rect_center(Vector2(23.0, 15.0), Vector2(7.0, 13.0), Color(1.0, 0.74, 0.24, 0.82))
			for flame_tip in [side * -10.0 + direction * 31.0, side * 10.0 + direction * 31.0, direction * 36.0]:
				draw_circle(flame_tip.snapped(Vector2.ONE), 3.0, Color(1.0, 0.82, 0.22, 0.82))


func _draw_rapid_tower(direction: Vector2) -> void:
	var side := direction.orthogonal()
	_draw_64px_chassis(tower_color, Color(0.66, 1.0, 0.78), Color(0.05, 0.13, 0.11))
	_draw_rect_center(Vector2(-15.0, 11.0), Vector2(12.0, 12.0), tower_color.darkened(0.16))
	_draw_rect_center(Vector2(15.0, 11.0), Vector2(12.0, 12.0), tower_color.darkened(0.16))
	if level >= 2:
		_draw_rect_center(Vector2(-22.0, 9.0), Vector2(8.0, 22.0), Color(0.50, 0.92, 0.62))
		_draw_rect_center(Vector2(22.0, 9.0), Vector2(8.0, 22.0), Color(0.50, 0.92, 0.62))
		for marker in [Vector2(-18.0, -17.0), Vector2(-6.0, -17.0), Vector2(6.0, -17.0), Vector2(18.0, -17.0)]:
			_draw_rect_center(marker, Vector2(5.0, 6.0), Color(0.66, 1.0, 0.78, 0.86))
	_draw_rect_center(Vector2(0.0, -15.0), Vector2(24.0 if level < 3 else 32.0, 6.0), Color(0.62, 1.0, 0.78, 0.72))
	var barrel_offsets := [-6.0, 6.0] if level < 3 else [-9.0, 0.0, 9.0]
	for offset in barrel_offsets:
		var center := side * float(offset) + direction * 14.0
		_draw_directional_barrel_at(center, direction, 34.0, 4.0, barrel_color, Color(0.72, 1.0, 0.84), 5.0)
		_draw_rect_center(side * float(offset) + direction * -5.0, Vector2(5.0, 8.0), barrel_color.lightened(0.12))
	if level >= 3:
		for offset in [-15.0, 15.0]:
			draw_line((side * float(offset) + direction * -13.0).snapped(Vector2.ONE), (side * float(offset) + direction * 24.0).snapped(Vector2.ONE), Color(0.72, 1.0, 0.84, 0.62), 2.0, false)
		_draw_rect_center(direction * -16.0, Vector2(24.0, 8.0), Color(0.42, 0.86, 0.58))
	_draw_rect_center(Vector2.ZERO, Vector2(14.0 if level < 3 else 18.0, 14.0 if level < 3 else 18.0), Color(0.90, 1.0, 0.88))
	_draw_rect_center(Vector2.ZERO, Vector2(6.0 if level < 3 else 9.0, 6.0 if level < 3 else 9.0), tower_color.darkened(0.18))


func _draw_shotgun_tower(direction: Vector2) -> void:
	var side := direction.orthogonal()
	_draw_64px_chassis(tower_color, Color(1.0, 0.82, 0.36), Color(0.15, 0.11, 0.06))
	_draw_rect_center(Vector2(0.0, 13.0), Vector2(34.0, 10.0), tower_color.darkened(0.18))
	if level >= 2:
		_draw_rect_center(Vector2(-23.0, 0.0), Vector2(7.0, 26.0), Color(1.0, 0.78, 0.34, 0.82))
		_draw_rect_center(Vector2(23.0, 0.0), Vector2(7.0, 26.0), Color(1.0, 0.78, 0.34, 0.82))
		for marker in [Vector2(-14.0, 20.0), Vector2(-5.0, 20.0), Vector2(5.0, 20.0), Vector2(14.0, 20.0)]:
			_draw_rect_center(marker, Vector2(6.0, 9.0), Color(1.0, 0.66, 0.26, 0.86))
	var barrel_offsets := [-9.0, 0.0, 9.0] if level < 3 else [-13.0, -4.5, 4.5, 13.0]
	for offset in barrel_offsets:
		var center := side * float(offset) + direction * 13.0
		_draw_directional_barrel_at(center, direction, 30.0 if level < 3 else 33.0, 5.0, barrel_color, Color(1.0, 0.82, 0.36), 6.0)
		_draw_rect_center(side * float(offset) + direction * -6.0, Vector2(5.0, 7.0), Color(1.0, 0.70, 0.28, 0.75))
	_draw_rect_center(Vector2.ZERO, Vector2(18.0 if level < 3 else 22.0, 18.0 if level < 3 else 22.0), Color(1.0, 0.92, 0.62))
	_draw_rect_center(Vector2.ZERO, Vector2(8.0 if level < 3 else 11.0, 8.0 if level < 3 else 11.0), tower_color.darkened(0.22))
	if level >= 2:
		var cone_left := direction.rotated(-maxf(spread_angle, 0.34) * 0.5)
		var cone_right := direction.rotated(maxf(spread_angle, 0.34) * 0.5)
		draw_line(Vector2.ZERO, cone_left * 31.0, Color(1.0, 0.76, 0.34, 0.50), 2.0, false)
		draw_line(Vector2.ZERO, cone_right * 31.0, Color(1.0, 0.76, 0.34, 0.50), 2.0, false)
	if level >= 3:
		_draw_rect_center(side * -18.0 + direction * 23.0, Vector2(5.0, 14.0), Color(1.0, 0.92, 0.62, 0.70))
		_draw_rect_center(side * 18.0 + direction * 23.0, Vector2(5.0, 14.0), Color(1.0, 0.92, 0.62, 0.70))


func _draw_cannon_tower(direction: Vector2) -> void:
	var side := direction.orthogonal()
	_draw_64px_heavy_chassis(tower_color, Color(1.0, 0.62, 0.22), Color(0.12, 0.10, 0.08))
	if level >= 2:
		_draw_rect_center(Vector2(-23.0, -16.0), Vector2(12.0, 7.0), Color(1.0, 0.62, 0.22, 0.80))
		_draw_rect_center(Vector2(23.0, -16.0), Vector2(12.0, 7.0), Color(1.0, 0.62, 0.22, 0.80))
		_draw_rect_center(side * -18.0 + direction * 7.0, Vector2(5.0, 24.0), barrel_color.darkened(0.04))
		_draw_rect_center(side * 18.0 + direction * 7.0, Vector2(5.0, 24.0), barrel_color.darkened(0.04))
	_draw_directional_barrel(direction, 37.0 if level < 3 else 41.0, 13.0 if level < 3 else 15.0, barrel_color, Color(1.0, 0.58, 0.22), 15.0 if level < 3 else 17.0)
	_draw_rect_center(Vector2.ZERO, Vector2(25.0 if level < 3 else 29.0, 25.0 if level < 3 else 29.0), tower_color.lightened(0.10))
	_draw_rect_center(Vector2.ZERO, Vector2(14.0 if level < 3 else 17.0, 14.0 if level < 3 else 17.0), Color(1.0, 0.77, 0.36))
	_draw_rect_center(direction * 21.0, Vector2(11.0, 17.0), barrel_color.darkened(0.08))
	if splash_radius > 0.0:
		draw_arc(Vector2.ZERO, 30.0, 0.0, TAU, 40, Color(1.0, 0.62, 0.22, 0.55), 3.0, false)
	if level >= 3:
		for marker in [Vector2(-24.0, -6.0), Vector2(18.0, -6.0), Vector2(-6.0, -24.0), Vector2(-6.0, 18.0)]:
			draw_rect(Rect2(marker, Vector2(12.0, 12.0)), Color(1.0, 0.45, 0.18, 0.58))
		for offset in [-10.0, 10.0]:
			draw_line((side * float(offset) + direction * -18.0).snapped(Vector2.ONE), (side * float(offset) + direction * 27.0).snapped(Vector2.ONE), Color(1.0, 0.82, 0.42, 0.58), 2.0, false)


func _draw_sniper_tower(direction: Vector2) -> void:
	var side := direction.orthogonal()
	_draw_64px_diamond_chassis(tower_color, Color(0.86, 0.82, 1.0), Color(0.11, 0.10, 0.18))
	if level >= 2:
		_draw_rect_center(Vector2(-18.0, 16.0), Vector2(6.0, 18.0), Color(0.72, 0.70, 1.0, 0.78))
		_draw_rect_center(Vector2(18.0, 16.0), Vector2(6.0, 18.0), Color(0.72, 0.70, 1.0, 0.78))
	_draw_directional_barrel(direction, 46.0 if level < 3 else 50.0, 4.0 if level < 3 else 5.0, barrel_color, Color(0.86, 0.82, 1.0), 6.0 if level < 3 else 8.0)
	_draw_directional_barrel_at(direction * 15.0, direction, 20.0 if level < 3 else 25.0, 2.0, Color(0.86, 0.82, 1.0), Color(0.94, 0.90, 1.0), 3.0)
	draw_line((side * -11.0 + direction * 11.0).snapped(Vector2.ONE), (side * 11.0 + direction * 11.0).snapped(Vector2.ONE), Color(0.92, 0.90, 1.0, 0.72), 2.0, false)
	draw_line((side * -7.0 + direction * 26.0).snapped(Vector2.ONE), (side * 7.0 + direction * 26.0).snapped(Vector2.ONE), Color(0.86, 0.82, 1.0, 0.55), 2.0, false)
	if level >= 2:
		_draw_rect_center(side * 9.0 + direction * 2.0, Vector2(10.0, 6.0), Color(0.94, 0.90, 1.0, 0.86))
		_draw_rect_center(side * 9.0 + direction * 8.0, Vector2(6.0, 6.0), Color(0.56, 0.72, 1.0, 0.90))
	_draw_rect_center(Vector2.ZERO, Vector2(13.0 if level < 3 else 17.0, 13.0 if level < 3 else 17.0), Color(0.94, 0.90, 1.0))
	_draw_rect_center(Vector2.ZERO, Vector2(5.0 if level < 3 else 8.0, 5.0 if level < 3 else 8.0), tower_color.darkened(0.18))
	if level >= 3:
		draw_colored_polygon(PackedVector2Array([Vector2(0.0, -14.0), Vector2(9.0, 0.0), Vector2(0.0, 14.0), Vector2(-9.0, 0.0)]), Color(0.86, 0.82, 1.0, 0.36))
		_draw_rect_center(side * -20.0 + direction * -6.0, Vector2(5.0, 16.0), Color(0.94, 0.90, 1.0, 0.72))
		_draw_rect_center(side * 20.0 + direction * -6.0, Vector2(5.0, 16.0), Color(0.94, 0.90, 1.0, 0.72))


func _draw_cluster_tower(direction: Vector2) -> void:
	var side := direction.orthogonal()
	var accent := Color(1.0, 0.76, 0.28)
	_draw_64px_heavy_chassis(tower_color, accent, Color(0.11, 0.09, 0.055))
	_draw_rect_center(Vector2(0.0, 14.0), Vector2(40.0, 8.0), tower_color.darkened(0.22))
	_draw_rect_center(Vector2(-24.0, -8.0), Vector2(7.0, 25.0), accent.darkened(0.10))
	_draw_rect_center(Vector2(24.0, -8.0), Vector2(7.0, 25.0), accent.darkened(0.10))
	_draw_rect_center(-direction * 17.0, Vector2(30.0, 10.0), barrel_color.lightened(0.08))
	_draw_rect_center(direction * 3.0, Vector2(32.0, 22.0), tower_color.lightened(0.08))

	var cell_centers := _get_cluster_launcher_cell_centers()
	for local_center in cell_centers:
		var cell_center := side * float(local_center.x) + direction * float(local_center.y)
		_draw_cluster_launcher_cell(cell_center, direction, side, 5.6 if level < 3 else 5.2, barrel_color, accent)

	if level >= 2:
		for marker in [Vector2(-14.0, -23.0), Vector2(0.0, -25.0), Vector2(14.0, -23.0)]:
			_draw_rect_center(marker, Vector2(7.0, 7.0), projectile_color.lightened(0.12))
	if splash_radius > 0.0:
		draw_arc(Vector2.ZERO, 28.0, 0.0, TAU, 36, Color(1.0, 0.56, 0.18, 0.56), 3.0, false)
		_draw_rect_center(Vector2.ZERO, Vector2(22.0, 22.0), tower_color.lightened(0.16))
		_draw_rect_center(direction * 24.0, Vector2(12.0, 6.0), projectile_color.lightened(0.10))
	else:
		_draw_rect_center(Vector2.ZERO, Vector2(18.0, 18.0), tower_color.lightened(0.10))
	_draw_rect_center(Vector2.ZERO, Vector2(9.0 if level < 3 else 12.0, 9.0 if level < 3 else 12.0), projectile_color)


func _get_cluster_launcher_cell_centers() -> Array[Vector2]:
	if level >= 3:
		return [
			Vector2(-18.0, 15.0), Vector2(-6.0, 15.0), Vector2(6.0, 15.0), Vector2(18.0, 15.0),
			Vector2(-12.0, 5.0), Vector2(0.0, 5.0), Vector2(12.0, 5.0),
			Vector2(-18.0, -5.0), Vector2(0.0, -5.0), Vector2(18.0, -5.0),
		]
	if level >= 2:
		return [
			Vector2(-18.0, 11.0), Vector2(-6.0, 11.0), Vector2(6.0, 11.0), Vector2(18.0, 11.0),
			Vector2(-12.0, 0.0), Vector2(0.0, 0.0), Vector2(12.0, 0.0), Vector2(0.0, -11.0),
		]
	return [
		Vector2(-12.0, 10.0), Vector2(0.0, 10.0), Vector2(12.0, 10.0),
		Vector2(-12.0, -1.0), Vector2(0.0, -1.0), Vector2(12.0, -1.0),
	]


func _draw_cluster_launcher_cell(center: Vector2, direction: Vector2, side: Vector2, radius: float, fill: Color, accent: Color) -> void:
	_draw_oriented_hex(center, direction, side, radius + 1.8, accent.darkened(0.24))
	_draw_oriented_hex(center, direction, side, radius, fill.lightened(0.08))
	_draw_oriented_hex(center + direction * 1.2, direction, side, radius * 0.48, Color(0.03, 0.025, 0.018))
	_draw_rect_center(center + direction * 1.4, Vector2(3.0, 3.0), projectile_color)


func _draw_oriented_hex(center: Vector2, direction: Vector2, side: Vector2, radius: float, color: Color) -> void:
	var points := PackedVector2Array([
		center + direction * radius,
		center + direction * radius * 0.5 + side * radius * 0.86,
		center - direction * radius * 0.5 + side * radius * 0.86,
		center - direction * radius,
		center - direction * radius * 0.5 - side * radius * 0.86,
		center + direction * radius * 0.5 - side * radius * 0.86,
	])
	draw_colored_polygon(points, color)


func _draw_amplifier_tower(_direction: Vector2) -> void:
	_draw_64px_chassis(tower_color, Color(0.52, 1.0, 0.78), Color(0.05, 0.13, 0.10))
	draw_arc(Vector2.ZERO, 24.0, 0.0, TAU, 40, Color(0.52, 1.0, 0.78, 0.55), 3.0, false)
	draw_arc(Vector2.ZERO, 15.0, 0.0, TAU, 32, Color(0.90, 1.0, 0.88, 0.65), 2.0, false)
	if level >= 2:
		for marker in [Vector2(-18.0, -18.0), Vector2(18.0, -18.0), Vector2(-18.0, 18.0), Vector2(18.0, 18.0)]:
			_draw_rect_center(marker, Vector2(8.0, 8.0), Color(0.62, 1.0, 0.82, 0.76))
	_draw_rect_center(Vector2.ZERO, Vector2(16.0 if level < 3 else 21.0, 16.0 if level < 3 else 21.0), Color(0.78, 1.0, 0.88))
	_draw_rect_center(Vector2.ZERO, Vector2(7.0 if level < 3 else 10.0, 7.0 if level < 3 else 10.0), tower_color.darkened(0.18))
	for marker in [Vector2(0.0, -25.0), Vector2(25.0, 0.0), Vector2(0.0, 25.0), Vector2(-25.0, 0.0)]:
		_draw_rect_center(marker, Vector2(6.0 if level < 3 else 8.0, 10.0), Color(0.52, 1.0, 0.78, 0.82))
	if level >= 3:
		for marker in [Vector2(0.0, -16.0), Vector2(16.0, 0.0), Vector2(0.0, 16.0), Vector2(-16.0, 0.0)]:
			_draw_rect_center(marker, Vector2(5.0, 5.0), Color(0.90, 1.0, 0.88, 0.88))


func _draw_upgrade_details() -> void:
	if not augmentation_id.is_empty():
		var glow_alpha := 0.14 + float(augmentation_level) * 0.045
		var border_width := 1.5 + float(augmentation_level) * 0.7
		draw_rect(Rect2(Vector2(-32.0, -32.0), Vector2(64.0, 64.0)), Color(0.42, 1.0, 0.62, glow_alpha))
		draw_rect(Rect2(Vector2(-31.0, -31.0), Vector2(62.0, 62.0)), Color(0.42, 1.0, 0.62, 0.82), false, border_width)
		draw_rect(Rect2(Vector2(-5.0, -36.0), Vector2(10.0, 8.0)), Color(0.42, 1.0, 0.62))
		if augmentation_level >= 2:
			draw_line(Vector2(-32.0, -24.0), Vector2(32.0, -24.0), Color(0.74, 1.0, 0.82, 0.78), 2.0, false)
			draw_line(Vector2(-32.0, 24.0), Vector2(32.0, 24.0), Color(0.74, 1.0, 0.82, 0.78), 2.0, false)
		if augmentation_level >= 3:
			draw_line(Vector2(-24.0, -32.0), Vector2(-24.0, 32.0), Color(0.90, 1.0, 0.88, 0.86), 2.0, false)
			draw_line(Vector2(24.0, -32.0), Vector2(24.0, 32.0), Color(0.90, 1.0, 0.88, 0.86), 2.0, false)


func _draw_64px_chassis(fill: Color, accent: Color, shadow: Color) -> void:
	_draw_rect_center(Vector2(0.0, 10.0), Vector2(48.0, 18.0), Color(0.0, 0.0, 0.0, 0.18))
	_draw_rect_center(Vector2.ZERO, Vector2(56.0, 48.0), shadow)
	_draw_rect_center(Vector2.ZERO, Vector2(46.0, 38.0), fill.darkened(0.12))
	_draw_rect_center(Vector2(0.0, -10.0), Vector2(38.0, 10.0), fill.lightened(0.24))
	_draw_rect_center(Vector2(0.0, 12.0), Vector2(38.0, 8.0), fill.darkened(0.18))
	_draw_rect_center(Vector2(-24.0, 0.0), Vector2(6.0, 24.0), accent.darkened(0.10))
	_draw_rect_center(Vector2(24.0, 0.0), Vector2(6.0, 24.0), accent.darkened(0.10))
	_draw_rect_center(Vector2.ZERO, Vector2(30.0, 26.0), fill)
	_draw_corner_bolts(accent, 20.0, 4.0)


func _draw_64px_heavy_chassis(fill: Color, accent: Color, shadow: Color) -> void:
	var outline := PackedVector2Array([
		Vector2(-22.0, -30.0), Vector2(22.0, -30.0), Vector2(30.0, -22.0), Vector2(30.0, 22.0),
		Vector2(22.0, 30.0), Vector2(-22.0, 30.0), Vector2(-30.0, 22.0), Vector2(-30.0, -22.0),
	])
	draw_colored_polygon(outline, shadow)
	var body := PackedVector2Array([
		Vector2(-18.0, -24.0), Vector2(18.0, -24.0), Vector2(24.0, -18.0), Vector2(24.0, 18.0),
		Vector2(18.0, 24.0), Vector2(-18.0, 24.0), Vector2(-24.0, 18.0), Vector2(-24.0, -18.0),
	])
	draw_colored_polygon(body, fill)
	_draw_rect_center(Vector2(0.0, -12.0), Vector2(28.0, 8.0), fill.lightened(0.20))
	_draw_rect_center(Vector2(0.0, 13.0), Vector2(30.0, 8.0), fill.darkened(0.18))
	_draw_corner_bolts(accent, 22.0, 5.0)


func _draw_64px_diamond_chassis(fill: Color, accent: Color, shadow: Color) -> void:
	draw_colored_polygon(PackedVector2Array([
		Vector2(0.0, -31.0), Vector2(31.0, 0.0), Vector2(0.0, 31.0), Vector2(-31.0, 0.0),
	]), shadow)
	draw_colored_polygon(PackedVector2Array([
		Vector2(0.0, -23.0), Vector2(23.0, 0.0), Vector2(0.0, 23.0), Vector2(-23.0, 0.0),
	]), fill)
	draw_colored_polygon(PackedVector2Array([
		Vector2(0.0, -16.0), Vector2(16.0, 0.0), Vector2(0.0, 16.0), Vector2(-16.0, 0.0),
	]), fill.lightened(0.12))
	draw_line(Vector2(-17.0, 0.0), Vector2(17.0, 0.0), accent, 2.0, false)
	draw_line(Vector2(0.0, -17.0), Vector2(0.0, 17.0), accent, 2.0, false)
	_draw_corner_bolts(accent, 18.0, 3.5)


func _draw_corner_bolts(color: Color, offset: float, size: float) -> void:
	for marker in [Vector2(-offset, -offset), Vector2(offset, -offset), Vector2(-offset, offset), Vector2(offset, offset)]:
		_draw_rect_center(marker, Vector2(size, size), color)


func _draw_rect_center(center: Vector2, rect_size: Vector2, color: Color) -> void:
	var top_left := (center - rect_size * 0.5).snapped(Vector2.ONE)
	draw_rect(Rect2(top_left, rect_size.snapped(Vector2.ONE)), color)


func _draw_directional_barrel(direction: Vector2, length: float, width: float, body_color: Color, muzzle_color: Color, muzzle_size: float) -> void:
	_draw_directional_barrel_at(direction * (length * 0.5 - 3.0), direction, length, width, body_color, muzzle_color, muzzle_size)


func _draw_directional_barrel_at(center: Vector2, direction: Vector2, length: float, width: float, body_color: Color, muzzle_color: Color, muzzle_size: float) -> void:
	var safe_direction := direction.normalized()
	if safe_direction == Vector2.ZERO:
		safe_direction = Vector2.RIGHT
	var side := safe_direction.orthogonal()
	var half_length := length * 0.5
	var half_width := width * 0.5
	var start := center - safe_direction * half_length
	var end := center + safe_direction * half_length
	var points := PackedVector2Array([
		(start - side * half_width).snapped(Vector2.ONE),
		(end - side * half_width).snapped(Vector2.ONE),
		(end + side * half_width).snapped(Vector2.ONE),
		(start + side * half_width).snapped(Vector2.ONE),
	])
	draw_colored_polygon(points, body_color)
	draw_line((start + side * (half_width - 1.0)).snapped(Vector2.ONE), (end + side * (half_width - 1.0)).snapped(Vector2.ONE), body_color.lightened(0.18), 1.0, false)
	_draw_rect_center(end, Vector2(muzzle_size, muzzle_size), muzzle_color)
