extends Node2D
class_name Projectile

const ParticleBurst := preload("res://scripts/ParticleBurst.gd")
const ImpactEffect := preload("res://scripts/ImpactEffect.gd")
const TRAIL_INTERVAL_STANDARD: float = 0.10
const TRAIL_INTERVAL_SPLASH: float = 0.07
const VISUAL_BASIC := "basic"
const VISUAL_RAPID := "rapid"
const VISUAL_SHOTGUN := "shotgun"
const VISUAL_CANNON := "cannon"
const VISUAL_SNIPER := "sniper"
const SNIPER_DAMAGE_FALLOFF: float = 0.72
const SNIPER_SCREEN_EXIT_MARGIN: float = 80.0

var game: Main
var target: Enemy
var damage: int = 15
var speed: float = 360.0
var hit_radius: float = 8.0
var splash_radius: float = 0.0
var splash_damage: int = 0
var pierce_count: int = 0
var projectile_color: Color = Color(1.0, 0.83, 0.2)
var trail_color: Color = Color(1.0, 0.45, 0.1, 0.8)
var projectile_size: float = 5.0
var visual_profile: String = VISUAL_BASIC
var max_travel_distance: float = 0.0
var _trail_timer: float = 0.0
var _trail_interval: float = TRAIL_INTERVAL_STANDARD
var _hit_radius_sq: float = hit_radius * hit_radius
var _splash_radius_sq: float = splash_radius * splash_radius
var _travel_direction: Vector2 = Vector2.RIGHT
var _travel_distance: float = 0.0
var _hit_enemy_ids: Dictionary = {}


func setup(
	target_enemy: Enemy,
	projectile_damage: int,
	projectile_speed: float = 360.0,
	projectile_splash_radius: float = 0.0,
	projectile_splash_damage: int = 0,
	color: Color = Color(1.0, 0.83, 0.2),
	projectile_pierce_count: int = 0,
	initial_direction: Vector2 = Vector2.ZERO,
	projectile_max_distance: float = 0.0,
	projectile_visual_profile: String = VISUAL_BASIC
) -> void:
	target = target_enemy
	damage = projectile_damage
	speed = projectile_speed
	splash_radius = projectile_splash_radius
	splash_damage = projectile_splash_damage
	pierce_count = projectile_pierce_count
	max_travel_distance = projectile_max_distance
	projectile_color = color
	trail_color = color.darkened(0.25)
	visual_profile = projectile_visual_profile
	hit_radius = _get_projectile_hit_radius()
	projectile_size = _get_projectile_size()
	_trail_interval = TRAIL_INTERVAL_SPLASH if splash_radius > 0.0 else TRAIL_INTERVAL_STANDARD
	if initial_direction != Vector2.ZERO:
		_travel_direction = initial_direction.normalized()
	elif is_instance_valid(target_enemy):
		var target_direction := target_enemy.global_position - global_position
		if target_direction != Vector2.ZERO:
			_travel_direction = target_direction.normalized()
	_refresh_radius_cache()


func set_game(game_ref: Main) -> void:
	game = game_ref


func _process(delta: float) -> void:
	_process_linear_motion(delta)


func _process_linear_motion(delta: float) -> void:
	var step := speed * delta
	var previous_position := global_position
	var next_position := global_position + _travel_direction * step
	global_position = next_position
	_travel_distance += step
	rotation = _travel_direction.angle()

	var hit_enemy := _find_linear_motion_hit(previous_position, next_position)
	if hit_enemy != null:
		target = hit_enemy
		var impact_position := _closest_point_on_segment(hit_enemy.global_position, previous_position, next_position)
		global_position = impact_position
		if _apply_impact_damage(impact_position):
			queue_free()
			return

	if _should_free_after_travel():
		queue_free()
		return

	_trail_timer -= delta
	if _trail_timer <= 0.0:
		_spawn_trail_particles()
		_trail_timer = _trail_interval


func _draw() -> void:
	_draw_contact_shadow()
	match visual_profile:
		VISUAL_CANNON:
			draw_circle(Vector2.ZERO, projectile_size, projectile_color.darkened(0.05))
			draw_rect(Rect2(Vector2(-5.0, -5.0), Vector2(10.0, 10.0)), projectile_color.lightened(0.20))
			draw_line(Vector2(-12.0, 0.0), Vector2(-4.0, 0.0), trail_color, 4.0)
		VISUAL_SNIPER:
			draw_line(Vector2(-10.0, 0.0), Vector2(9.0, 0.0), projectile_color, 2.0, false)
			draw_circle(Vector2(7.0, 0.0), 2.5, Color(1.0, 1.0, 1.0, 0.90))
			draw_line(Vector2(-18.0, 0.0), Vector2(-8.0, 0.0), Color(trail_color.r, trail_color.g, trail_color.b, 0.55), 1.0)
		VISUAL_SHOTGUN:
			draw_circle(Vector2.ZERO, projectile_size, projectile_color)
			draw_line(Vector2(-5.0, 0.0), Vector2(-2.0, 0.0), Color(trail_color.r, trail_color.g, trail_color.b, 0.58), 1.5)
		VISUAL_RAPID:
			draw_circle(Vector2.ZERO, projectile_size, projectile_color)
			draw_line(Vector2(-9.0, 0.0), Vector2(-3.0, 0.0), trail_color, 2.0)
		_:
			draw_circle(Vector2.ZERO, projectile_size, projectile_color)
			draw_line(Vector2(-7.0, 0.0), Vector2(-2.0, 0.0), trail_color, 2.0)


func _draw_contact_shadow() -> void:
	if visual_profile == VISUAL_SNIPER:
		draw_line(Vector2(-7.0, 3.0), Vector2(8.0, 3.0), Color(0.0, 0.0, 0.0, 0.20), 1.0, false)
	else:
		draw_circle(Vector2(0.0, 4.0), maxf(projectile_size * 0.72, 2.0), Color(0.0, 0.0, 0.0, 0.22))


func _apply_impact_damage(impact_position: Vector2) -> bool:
	var game_node := _get_game()
	if game_node != null:
		_spawn_impact_visuals(game_node, impact_position)

	if is_instance_valid(target) and not target.is_dead and not target.has_reached_end and not _hit_enemy_ids.has(target.get_instance_id()):
		_hit_enemy_ids[target.get_instance_id()] = true
		target.take_damage(damage)

	if splash_radius <= 0.0 or splash_damage <= 0:
		return _try_continue_pierce(impact_position)

	if game_node != null:
		for enemy in game_node.get_active_enemies():
			if enemy == target:
				continue
			_apply_splash_to_enemy(enemy, impact_position)
		return _try_continue_pierce(impact_position)

	for node in get_tree().get_nodes_in_group("enemies"):
		var enemy := node as Enemy
		_apply_splash_to_enemy(enemy, impact_position)
	return _try_continue_pierce(impact_position)


func _apply_splash_to_enemy(enemy: Enemy, impact_position: Vector2) -> void:
	if enemy == null or enemy == target or not is_instance_valid(enemy) or enemy.is_dead or enemy.has_reached_end:
		return
	if impact_position.distance_squared_to(enemy.global_position) <= _splash_radius_sq:
		enemy.take_damage(splash_damage)


func _try_continue_pierce(impact_position: Vector2) -> bool:
	if visual_profile == VISUAL_SNIPER:
		target = null
		damage = maxi(1, int(round(float(damage) * SNIPER_DAMAGE_FALLOFF)))
		global_position = impact_position + _travel_direction * maxf(hit_radius, 4.0)
		return false

	if pierce_count <= 0:
		return true
	pierce_count -= 1
	target = null
	global_position = impact_position + _travel_direction * maxf(hit_radius, 4.0)
	if max_travel_distance <= 0.0:
		max_travel_distance = 280.0
	return false


func _find_linear_motion_hit(from_position: Vector2, to_position: Vector2) -> Enemy:
	var game_node := _get_game()
	if game_node == null:
		return null
	var segment := to_position - from_position
	var segment_length_sq := segment.length_squared()
	var segment_direction := segment.normalized() if segment_length_sq > 0.001 else _travel_direction
	var best_enemy: Enemy = null
	var best_forward := INF
	for enemy in game_node.get_active_enemies():
		if enemy == null or not is_instance_valid(enemy) or enemy.is_dead or enemy.has_reached_end:
			continue
		if _hit_enemy_ids.has(enemy.get_instance_id()):
			continue
		var collision_radius := hit_radius + maxf(enemy.body_radius, 1.0)
		var closest_point := _closest_point_on_segment(enemy.global_position, from_position, to_position)
		if closest_point.distance_squared_to(enemy.global_position) > collision_radius * collision_radius:
			continue
		if segment_length_sq <= 0.001:
			return enemy
		var forward_distance := (closest_point - from_position).dot(segment_direction)
		if forward_distance < -0.01:
			continue
		if forward_distance < best_forward:
			best_forward = forward_distance
			best_enemy = enemy
	return best_enemy


func _closest_point_on_segment(point: Vector2, from_position: Vector2, to_position: Vector2) -> Vector2:
	var segment := to_position - from_position
	var segment_length_sq := segment.length_squared()
	if segment_length_sq <= 0.001:
		return from_position
	var t := clampf((point - from_position).dot(segment) / segment_length_sq, 0.0, 1.0)
	return from_position + segment * t


func _refresh_radius_cache() -> void:
	_hit_radius_sq = hit_radius * hit_radius
	_splash_radius_sq = splash_radius * splash_radius


func _spawn_trail_particles() -> void:
	var game_node := _get_game()
	if game_node == null:
		return

	game_node.spawn_particle_burst(global_position - _travel_direction * 6.0, {
		"name": "ProjectileTrailParticles",
		"amount": _get_trail_particle_amount(),
		"lifetime": 0.16 if visual_profile != VISUAL_CANNON else 0.22,
		"emission_radius": 1.0,
		"velocity_min": 4.0,
		"velocity_max": 34.0 if visual_profile == VISUAL_CANNON else 22.0,
		"scale_min": 0.5,
		"scale_max": 1.6 if visual_profile == VISUAL_CANNON else 1.2,
		"gravity": Vector2.ZERO,
		"color": Color(projectile_color.r, projectile_color.g, projectile_color.b, 0.72),
		"z_index": 70,
	})


func _spawn_impact_visuals(game_node: Main, impact_position: Vector2) -> void:
	game_node.spawn_particle_burst(impact_position, _get_impact_particle_config())
	var effect_parent := game_node.impact_layer if game_node.impact_layer != null else game_node.particle_layer
	if effect_parent == null:
		return

	ImpactEffect.spawn(effect_parent, impact_position, {
		"name": _get_impact_effect_name(),
		"profile": _get_impact_effect_profile(),
		"radius": _get_impact_effect_radius(),
		"direction": _travel_direction,
		"duration": _get_impact_effect_duration(),
		"width": _get_impact_effect_width(),
		"color": projectile_color,
		"z_index": 92,
	})


func _get_projectile_size() -> float:
	match visual_profile:
		VISUAL_CANNON:
			return 8.5
		VISUAL_SNIPER:
			return 3.0
		VISUAL_SHOTGUN:
			return 3.5
		VISUAL_RAPID:
			return 4.0
		_:
			return 5.0


func _get_projectile_hit_radius() -> float:
	match visual_profile:
		VISUAL_CANNON:
			return 9.0
		VISUAL_SNIPER:
			return 5.0
		VISUAL_SHOTGUN:
			return 4.0
		VISUAL_RAPID:
			return 6.0
		_:
			return 8.0


func _get_trail_particle_amount() -> int:
	match visual_profile:
		VISUAL_SNIPER:
			return 1
		VISUAL_SHOTGUN:
			return 1
		VISUAL_CANNON:
			return 4
		_:
			return 3


func _get_impact_particle_config() -> Dictionary:
	match visual_profile:
		VISUAL_CANNON:
			return {
				"name": "CannonImpactParticles",
				"amount": 36,
				"lifetime": 0.52,
				"emission_radius": maxf(8.0, splash_radius * 0.22),
				"velocity_min": 48.0,
				"velocity_max": 190.0,
				"scale_min": 1.2,
				"scale_max": 3.4,
				"gravity": Vector2(0.0, 150.0),
				"color": projectile_color,
				"important": true,
			}
		VISUAL_SHOTGUN:
			return {
				"name": "ShotgunImpactParticles",
				"amount": 7,
				"lifetime": 0.18,
				"emission_radius": 2.0,
				"velocity_min": 18.0,
				"velocity_max": 70.0,
				"scale_min": 0.55,
				"scale_max": 1.3,
				"gravity": Vector2.ZERO,
				"color": projectile_color,
			}
		VISUAL_SNIPER:
			return {
				"name": "SniperImpactParticles",
				"amount": 9,
				"lifetime": 0.22,
				"emission_radius": 1.0,
				"velocity_min": 34.0,
				"velocity_max": 118.0,
				"scale_min": 0.45,
				"scale_max": 1.4,
				"gravity": Vector2.ZERO,
				"color": projectile_color.lightened(0.12),
			}
		VISUAL_RAPID:
			return {
				"name": "RapidImpactParticles",
				"amount": 6,
				"lifetime": 0.16,
				"emission_radius": 1.0,
				"velocity_min": 20.0,
				"velocity_max": 82.0,
				"scale_min": 0.5,
				"scale_max": 1.2,
				"gravity": Vector2.ZERO,
				"color": projectile_color,
			}
		_:
			return {
				"name": "BasicImpactParticles",
				"amount": 12,
				"lifetime": 0.28,
				"emission_radius": 2.0,
				"velocity_min": 26.0,
				"velocity_max": 92.0,
				"scale_min": 0.8,
				"scale_max": 1.8,
				"gravity": Vector2(0.0, 130.0),
				"color": projectile_color,
			}


func _get_impact_effect_name() -> String:
	match visual_profile:
		VISUAL_CANNON:
			return "CannonImpactEffect"
		VISUAL_SHOTGUN:
			return "ShotgunImpactEffect"
		VISUAL_SNIPER:
			return "SniperImpactEffect"
		VISUAL_RAPID:
			return "RapidImpactEffect"
		_:
			return "BasicImpactEffect"


func _get_impact_effect_profile() -> String:
	if visual_profile == VISUAL_CANNON:
		return VISUAL_CANNON
	if visual_profile == VISUAL_SNIPER:
		return VISUAL_SNIPER
	if visual_profile == VISUAL_RAPID:
		return VISUAL_RAPID
	return VISUAL_BASIC


func _get_impact_effect_radius() -> float:
	match visual_profile:
		VISUAL_CANNON:
			return maxf(splash_radius, 34.0)
		VISUAL_SNIPER:
			return 34.0
		VISUAL_RAPID:
			return 22.0
		VISUAL_SHOTGUN:
			return 18.0
		_:
			return 26.0


func _get_impact_effect_duration() -> float:
	return 0.44 if visual_profile == VISUAL_CANNON else 0.24


func _get_impact_effect_width() -> float:
	return 2.4 if visual_profile == VISUAL_SNIPER else 0.0


func _should_free_after_travel() -> bool:
	if visual_profile == VISUAL_SNIPER:
		return _has_exited_visible_screen()
	return max_travel_distance > 0.0 and _travel_distance >= max_travel_distance


func _has_exited_visible_screen() -> bool:
	var game_node := _get_game()
	if game_node == null or game_node.camera == null or not is_instance_valid(game_node.camera):
		return false

	var viewport_size := get_viewport_rect().size
	var zoom := game_node.camera.zoom
	if zoom.x <= 0.0 or zoom.y <= 0.0:
		return false

	var map_rect := Rect2(Vector2.ZERO, game_node.get_map_pixel_size()).grow(SNIPER_SCREEN_EXIT_MARGIN)
	if map_rect.has_point(global_position):
		return false

	var world_size := Vector2(viewport_size.x / zoom.x, viewport_size.y / zoom.y)
	var visible_rect := Rect2(game_node.camera.global_position - world_size * 0.5, world_size)
	return not visible_rect.grow(SNIPER_SCREEN_EXIT_MARGIN).has_point(global_position)


func _get_game() -> Main:
	if game != null and is_instance_valid(game):
		return game
	var parent := get_parent()
	if parent == null:
		return null
	game = parent.get_parent() as Main
	return game
