extends Node2D
class_name Tower

const ImpactEffect := preload("res://scripts/ImpactEffect.gd")
const BASE_DAMAGE: int = 15
const BASE_RANGE: float = 130.0
const MAX_LEVEL: int = 3
const TARGET_SCAN_INTERVAL: float = 0.08
const TARGET_SCAN_JITTER_STEPS: int = 7
const RECOIL_DURATION_RATIO: float = 0.34
const RECOIL_MIN_DURATION: float = 0.07
const RECOIL_MAX_DURATION: float = 0.32
const PROJECTILE_EFFECTIVE_RANGE_MULTIPLIER: float = 1.35
const DEFAULT_TOWER_DISPLAY_NAME := "基础塔"
const DEFAULT_AUGMENTATION_DISPLAY_NAME := "增幅塔"
const DEFAULT_TRAIT_TEXT := "标准弹道"
const MAX_LEVEL_PREVIEW_TEXT := "已达到最终形态"
const BASIC_LEVEL_TWO_TRAIT_NAME := "强化核心"
const BASIC_LEVEL_THREE_TRAIT_NAME := "过载中枢"
const RAPID_LEVEL_TWO_TRAIT_NAME := "双联枪管"
const RAPID_LEVEL_THREE_TRAIT_NAME := "三联齐射"
const SHOTGUN_LEVEL_TWO_TRAIT_NAME := "扩容弹仓"
const SHOTGUN_LEVEL_THREE_TRAIT_NAME := "碎星齐射"
const CANNON_LEVEL_TWO_TRAIT_NAME := "爆破弹头"
const CANNON_LEVEL_THREE_TRAIT_NAME := "震荡核心"
const SNIPER_LEVEL_TWO_TRAIT_NAME := "校准透镜"
const SNIPER_LEVEL_THREE_TRAIT_NAME := "处决射击"
const RAPID_BASE_TRAIT_TEXT := "单管高速射击"
const CANNON_BASE_TRAIT_TEXT := "重弹单体打击"
const SNIPER_BASE_TRAIT_TEXT := "超远距离点杀"
const BASIC_BASE_TRAIT_TEXT := "均衡防御火力"
const UPGRADE_PREVIEW_TEMPLATE := "等级%d：%s"
const AUGMENTATION_TRAIT_LINE_TEMPLATE := "\n增幅：%s"
const BASIC_LEVEL_TWO_TRAIT_TEMPLATE := "%s：射程扩大，装填加快"
const BASIC_LEVEL_THREE_TRAIT_TEMPLATE := "%s：高伤害高射程均衡压制"
const RAPID_LEVEL_TWO_TRAIT_TEMPLATE := "%s：每次攻击发射两枚弹丸"
const RAPID_LEVEL_THREE_TRAIT_TEMPLATE := "%s：三枚弹丸形成高速弹幕"
const SHOTGUN_LEVEL_TWO_TRAIT_TEMPLATE := "%s：更宽扇形和更多弹丸"
const SHOTGUN_LEVEL_THREE_TRAIT_TEMPLATE := "%s：高密度近距覆盖"
const CANNON_LEVEL_TWO_TRAIT_TEMPLATE := "%s：爆破半径扩大，溅射伤害提高"
const CANNON_LEVEL_THREE_TRAIT_TEMPLATE := "%s：大范围高强度溅射炮击"
const SNIPER_LEVEL_TWO_TRAIT_TEMPLATE := "%s：极大提高单发伤害和射程"
const SNIPER_LEVEL_THREE_TRAIT_TEMPLATE := "%s：对低生命敌人造成致命伤害"

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
var shots_per_attack: int = 1
var splash_radius: float = 0.0
var splash_damage_ratio: float = 0.0
var spread_angle: float = 0.0
var pierce_count: int = 0
var execute_threshold: float = 0.0
var execute_multiplier: float = 1.0
var level_trait: String = _get_default_trait_text()

var augmentation_id: String = ""
var augmentation_name: String = ""
var stun_time: float = 0.0

var _cooldown: float = 0.0
var _current_target: Enemy
var _barrel_direction: Vector2 = Vector2.UP
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
	tower_type_id = str(type_config.get("id", "basic"))
	display_name = _get_tower_display_name(type_config)
	total_invested = int(type_config.get("cost", 50))
	damage = int(type_config.get("damage", BASE_DAMAGE))
	attack_range = float(type_config.get("range", BASE_RANGE))
	attack_interval = float(type_config.get("interval", 0.8))
	projectile_speed = float(type_config.get("projectile_speed", 360.0))
	shots_per_attack = int(type_config.get("shots", 1))
	spread_angle = float(type_config.get("spread", 0.0))
	splash_radius = float(type_config.get("splash_radius", 0.0))
	splash_damage_ratio = float(type_config.get("splash_ratio", 0.0))
	pierce_count = int(type_config.get("pierce", 0))
	tower_color = type_config.get("color", Color(0.23, 0.48, 0.78))
	barrel_color = type_config.get("barrel_color", Color(0.08, 0.13, 0.18))
	projectile_color = type_config.get("projectile_color", Color(1.0, 0.83, 0.2))
	level_trait = _get_base_trait()
	_upgrade_costs = _get_upgrade_costs()
	_refresh_range_cache()
	_refresh_damage_cache()
	_refresh_target_scan_interval()


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


func get_upgrade_cost() -> int:
	if level >= MAX_LEVEL:
		return 0

	return _upgrade_costs[level - 1]


func upgrade() -> bool:
	if not can_upgrade():
		return false

	var cost := get_upgrade_cost()
	total_invested += cost
	level += 1

	_apply_upgrade_stats()
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

	return _format_upgrade_preview_text(level + 1, _get_upgrade_preview_trait_name(tower_type_id, level + 1))


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
	augmentation_id = str(type_config.get("id", "amplifier"))
	augmentation_name = _get_augmentation_display_name(type_config)
	damage_multiplier *= float(type_config.get("damage_multiplier", 1.0))
	range_multiplier *= float(type_config.get("range_multiplier", 1.0))
	total_invested += int(type_config.get("cost", 0))
	level_trait += _format_augmentation_trait_line_text(augmentation_name)
	_refresh_range_cache()
	_refresh_damage_cache()
	_refresh_target_scan_interval()
	queue_redraw()
	return true


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


func _format_upgrade_preview_text(next_level: int, trait_name: String) -> String:
	return UPGRADE_PREVIEW_TEMPLATE % [next_level, trait_name]


func _get_upgrade_preview_trait_name(type_id: String, next_level: int) -> String:
	match type_id:
		"rapid":
			return _get_rapid_upgrade_trait_name(next_level)
		"cannon":
			return _get_cannon_upgrade_trait_name(next_level)
		"sniper":
			return _get_sniper_upgrade_trait_name(next_level)
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


func _format_augmentation_trait_line_text(augmentation_display_name: String) -> String:
	return AUGMENTATION_TRAIT_LINE_TEMPLATE % augmentation_display_name


func _get_base_trait_text(type_id: String) -> String:
	match type_id:
		"rapid":
			return _get_rapid_base_trait_text()
		"cannon":
			return _get_cannon_base_trait_text()
		"sniper":
			return _get_sniper_base_trait_text()
		_:
			return _get_basic_base_trait_text()


func _get_rapid_base_trait_text() -> String:
	return RAPID_BASE_TRAIT_TEXT


func _get_cannon_base_trait_text() -> String:
	return CANNON_BASE_TRAIT_TEXT


func _get_sniper_base_trait_text() -> String:
	return SNIPER_BASE_TRAIT_TEXT


func _get_basic_base_trait_text() -> String:
	return BASIC_BASE_TRAIT_TEXT


func _format_basic_level_two_trait_text() -> String:
	return BASIC_LEVEL_TWO_TRAIT_TEMPLATE % _get_basic_upgrade_trait_name(2)


func _format_basic_level_three_trait_text() -> String:
	return BASIC_LEVEL_THREE_TRAIT_TEMPLATE % _get_basic_upgrade_trait_name(3)


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


func apply_stun(duration: float) -> void:
	stun_time = maxf(stun_time, duration)
	queue_redraw()


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
	_effective_range = attack_range * range_multiplier
	_effective_range_sq = _effective_range * _effective_range


func _refresh_damage_cache() -> void:
	_effective_damage = int(round(float(damage) * damage_multiplier))
	_effective_splash_damage = int(round(float(damage) * splash_damage_ratio * damage_multiplier))


func _is_target_valid(enemy) -> bool:
	if not is_instance_valid(enemy):
		return false

	var target_enemy := enemy as Enemy
	return (
		target_enemy != null
		and not target_enemy.is_dead
		and not target_enemy.has_reached_end
		and global_position.distance_squared_to(target_enemy.global_position) <= _effective_range_sq
	)


func _find_target() -> Enemy:
	var best_taunt_enemy: Enemy = null
	var best_taunt_progress := -1.0
	var best_enemy: Enemy = null
	var best_progress := -1.0

	for enemy in game.get_active_enemies():
		if enemy == null or not is_instance_valid(enemy) or enemy.is_dead or enemy.has_reached_end:
			continue

		if global_position.distance_squared_to(enemy.global_position) > _effective_range_sq:
			continue

		var progress: float = enemy.get_path_progress()
		if enemy.is_taunt:
			if progress > best_taunt_progress:
				best_taunt_progress = progress
				best_taunt_enemy = enemy
			continue
		if progress > best_progress:
			best_progress = progress
			best_enemy = enemy

	if best_taunt_enemy != null:
		return best_taunt_enemy
	return best_enemy


func _fire_at(enemy: Enemy) -> void:
	var shot_count := maxi(shots_per_attack, 1)
	var direction := (enemy.global_position - global_position).normalized()
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
		projectile.setup(
			null,
			_get_attack_damage(enemy),
			projectile_speed,
			splash_radius,
			_effective_splash_damage,
			projectile_color,
			pierce_count,
			shot_direction,
			_get_projectile_max_distance(),
			_get_projectile_visual_profile()
		)
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
		_:
			return Projectile.VISUAL_BASIC


func _get_attack_damage(enemy: Enemy) -> int:
	var result := _effective_damage
	if execute_threshold > 0.0 and is_instance_valid(enemy):
		var health_ratio := float(enemy.health) / maxf(float(enemy.max_health), 1.0)
		if health_ratio <= execute_threshold:
			result = int(round(float(result) * execute_multiplier))
	return result


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
		_:
			_apply_basic_upgrade()


func _apply_basic_upgrade() -> void:
	match level:
		2:
			damage += 8
			attack_range += 28.0
			attack_interval *= 0.88
			projectile_speed += 55.0
			level_trait = _format_basic_level_two_trait_text()
		3:
			damage += 14
			attack_range += 34.0
			attack_interval *= 0.78
			projectile_speed += 75.0
			level_trait = _format_basic_level_three_trait_text()


func _apply_rapid_upgrade() -> void:
	match level:
		2:
			damage += 2
			attack_range += 18.0
			attack_interval *= 0.90
			shots_per_attack = 2
			level_trait = _format_rapid_level_two_trait_text()
		3:
			damage += 3
			attack_range += 22.0
			attack_interval *= 0.78
			shots_per_attack = 3
			level_trait = _format_rapid_level_three_trait_text()


func _apply_shotgun_upgrade() -> void:
	match level:
		2:
			damage += 4
			attack_range += 14.0
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
			attack_range += 20.0
			splash_radius = 74.0
			splash_damage_ratio = 0.62
			projectile_speed += 35.0
			level_trait = _format_cannon_level_two_trait_text()
		3:
			damage += 30
			attack_range += 30.0
			attack_interval *= 0.86
			splash_radius = 96.0
			splash_damage_ratio = 0.78
			projectile_speed += 45.0
			level_trait = _format_cannon_level_three_trait_text()


func _apply_sniper_upgrade() -> void:
	match level:
		2:
			damage += 34
			attack_range += 48.0
			projectile_speed += 180.0
			attack_interval *= 0.94
			level_trait = _format_sniper_level_two_trait_text()
		3:
			damage += 58
			attack_range += 62.0
			projectile_speed += 220.0
			execute_threshold = 0.35
			execute_multiplier = 1.9
			level_trait = _format_sniper_level_three_trait_text()


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
		_draw_rect_center(Vector2(0.0, -22.0), Vector2(24.0, 5.0), projectile_color.lightened(0.16))
		_draw_rect_center(Vector2(0.0, 22.0), Vector2(24.0, 5.0), projectile_color.lightened(0.04))
		_draw_rect_center(Vector2(-23.0, 15.0), Vector2(6.0, 12.0), Color(0.88, 0.95, 1.0, 0.72))
		_draw_rect_center(Vector2(23.0, 15.0), Vector2(6.0, 12.0), Color(0.88, 0.95, 1.0, 0.72))


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
		draw_rect(Rect2(Vector2(-32.0, -32.0), Vector2(64.0, 64.0)), Color(0.42, 1.0, 0.62, 0.18))
		draw_rect(Rect2(Vector2(-31.0, -31.0), Vector2(62.0, 62.0)), Color(0.42, 1.0, 0.62, 0.82), false, 2.0)
		draw_rect(Rect2(Vector2(-5.0, -36.0), Vector2(10.0, 8.0)), Color(0.42, 1.0, 0.62))


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