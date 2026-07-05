extends Node2D
class_name Enemy

const ParticleBurst := preload("res://scripts/ParticleBurst.gd")

signal died(enemy: Enemy)
signal reached_end(enemy: Enemy)

var game: Main
var path_points: Array[Vector2] = []
var path_index: int = 1
var max_health: int = 50
var health: int = 50
var speed: float = 70.0
var reward: int = 10
var base_damage: int = 1
var enemy_type_id: String = "grunt"
var enemy_name: String = _get_default_enemy_display_name()
var body_color: Color = Color(0.82, 0.18, 0.15)
var outline_color: Color = Color(0.25, 0.05, 0.04)
var body_radius: float = 13.0
var shape: String = "circle"
var is_taunt: bool = false
var is_dead: bool = false
var has_reached_end: bool = false
var is_attacking_base: bool = false
var speed_multiplier: float = 1.0
var slow_time: float = 0.0
var attraction_position: Vector2 = Vector2.ZERO
var attraction_time: float = 0.0
var attraction_strength: float = 0.0

var _traveled_distance: float = 0.0
var _total_path_length: float = 1.0
var _path_progress: float = 0.0
var _attack_timer: float = 0.0
var _sprite: AnimatedSprite2D
var _move_direction: Vector2 = Vector2.RIGHT
var _step_particle_timer: float = 0.0
static var _enemy1_sprite_frames_cache: SpriteFrames

const ENEMY1_WALK_FRAMES: Array[String] = [
	"res://enemy1/walk1.png",
	"res://enemy1/walk2.png",
	"res://enemy1/walk3.png",
	"res://enemy1/walk4.png",
]
const ENEMY1_TARGET_SIZE: float = 34.0
const STEP_PARTICLE_INTERVAL: float = 0.28
const DEFAULT_ENEMY_DISPLAY_NAME := "步兵"
const DEFAULT_HEALTH: int = 50
const DEFAULT_SPEED: float = 70.0
const DEFAULT_REWARD: int = 10
const DEFAULT_BODY_RADIUS: float = 13.0
const DEFAULT_BASE_DAMAGE: int = 1
const MAX_HEALTH: int = 100000
const MAX_SPEED: float = 2000.0
const MAX_REWARD: int = 5000
const MAX_BODY_RADIUS: float = 128.0
const MAX_BASE_DAMAGE: int = 100


func setup(points: Array[Vector2], enemy_health: int, move_speed: float, kill_reward: int, type_config: Dictionary = {}, cached_path_length: float = -1.0) -> void:
	var route_points: Array[Vector2] = points.duplicate()
	path_points = route_points
	max_health = _sanitize_positive_int(enemy_health, DEFAULT_HEALTH, MAX_HEALTH)
	health = max_health
	speed = _sanitize_positive_float(move_speed, DEFAULT_SPEED, MAX_SPEED)
	reward = _sanitize_non_negative_int(kill_reward, DEFAULT_REWARD, MAX_REWARD)
	enemy_type_id = str(type_config.get("id", "grunt"))
	enemy_name = _get_enemy_display_name(type_config)
	body_color = type_config.get("color", Color(0.82, 0.18, 0.15))
	outline_color = type_config.get("outline", Color(0.25, 0.05, 0.04))
	body_radius = _sanitize_positive_float(type_config.get("radius", DEFAULT_BODY_RADIUS), DEFAULT_BODY_RADIUS, MAX_BODY_RADIUS)
	shape = str(type_config.get("shape", "circle"))
	is_taunt = bool(type_config.get("taunt", false))
	base_damage = _sanitize_positive_int(type_config.get("base_damage", DEFAULT_BASE_DAMAGE), DEFAULT_BASE_DAMAGE, MAX_BASE_DAMAGE)
	path_index = 1
	_traveled_distance = 0.0
	_total_path_length = maxf(cached_path_length, 1.0) if cached_path_length > 0.0 else _calculate_path_length()
	_path_progress = 0.0

	if not path_points.is_empty():
		position = path_points[0]


func _sanitize_positive_int(raw_value: Variant, default_value: int, max_value: int) -> int:
	if raw_value is int or raw_value is float:
		var value := int(round(float(raw_value)))
		if value > 0 and value <= max_value:
			return value
	return default_value


func _sanitize_non_negative_int(raw_value: Variant, default_value: int, max_value: int) -> int:
	if raw_value is int or raw_value is float:
		var value := int(round(float(raw_value)))
		if value >= 0 and value <= max_value:
			return value
	return default_value


func _sanitize_positive_float(raw_value: Variant, default_value: float, max_value: float) -> float:
	if raw_value is int or raw_value is float:
		var value := float(raw_value)
		if value > 0.0 and value <= max_value:
			return value
	return default_value


func _get_enemy_display_name(type_config: Dictionary) -> String:
	var display_name := str(type_config.get("name", "")).strip_edges()
	return display_name if not display_name.is_empty() else DEFAULT_ENEMY_DISPLAY_NAME


func _get_default_enemy_display_name() -> String:
	return DEFAULT_ENEMY_DISPLAY_NAME


func set_game(game_ref: Main) -> void:
	game = game_ref


func _ready() -> void:
	add_to_group("enemies")
	_setup_sprite_visual()


func _process(delta: float) -> void:
	if slow_time > 0.0:
		slow_time = maxf(slow_time - delta, 0.0)
		if slow_time <= 0.0:
			speed_multiplier = 1.0
			queue_redraw()
	if attraction_time > 0.0:
		attraction_time = maxf(attraction_time - delta, 0.0)
		if attraction_time <= 0.0:
			attraction_strength = 0.0
			queue_redraw()

	if is_attacking_base:
		_attack_timer -= delta
		queue_redraw()
		if _attack_timer <= 0.0:
			_reach_end()
		return

	if is_dead or has_reached_end or path_points.size() < 2:
		return

	var previous_position := position
	var remaining_distance := speed * speed_multiplier * delta
	while remaining_distance > 0.0 and path_index < path_points.size():
		var target_position := path_points[path_index]
		var to_target := target_position - position
		var distance_to_target_sq := to_target.length_squared()
		var remaining_distance_sq := remaining_distance * remaining_distance

		if distance_to_target_sq <= remaining_distance_sq:
			var distance_to_target := sqrt(distance_to_target_sq)
			if distance_to_target > 0.0:
				_set_move_direction(to_target / distance_to_target)
			position = target_position
			_traveled_distance += distance_to_target
			_update_path_progress()
			remaining_distance -= distance_to_target
			path_index += 1

			if path_index >= path_points.size():
				_path_progress = 1.0
				_start_base_attack()
				return
		else:
			var distance_to_target := sqrt(distance_to_target_sq)
			if distance_to_target > 0.0:
				_set_move_direction(to_target / distance_to_target)
			position += _move_direction * remaining_distance
			_traveled_distance += remaining_distance
			_update_path_progress()
			remaining_distance = 0.0

	if attraction_time > 0.0 and attraction_strength > 0.0:
		var to_attraction := attraction_position - position
		var attraction_distance := to_attraction.length()
		if attraction_distance > 1.0:
			var attraction_step := minf(speed * attraction_strength * delta, attraction_distance)
			position += to_attraction / attraction_distance * attraction_step
			_set_move_direction(to_attraction / attraction_distance)

	if position.distance_squared_to(previous_position) > 1.0:
		_step_particle_timer -= delta
		if _step_particle_timer <= 0.0:
			_spawn_step_particles()
			_step_particle_timer = STEP_PARTICLE_INTERVAL


func take_damage(amount: int) -> void:
	if is_dead or has_reached_end:
		return

	health -= amount
	if health <= 0:
		_die()
	else:
		queue_redraw()


func get_path_progress() -> float:
	return _path_progress


func apply_slow(multiplier: float, duration: float) -> void:
	speed_multiplier = minf(speed_multiplier, clampf(multiplier, 0.15, 1.0))
	slow_time = maxf(slow_time, duration)
	_update_sprite_direction()
	queue_redraw()


func apply_speed_effect(multiplier: float, duration: float) -> void:
	speed_multiplier = clampf(multiplier, 0.15, 2.0)
	slow_time = maxf(slow_time, duration)
	_update_sprite_direction()
	queue_redraw()


func apply_attraction(target_position: Vector2, duration: float, strength: float) -> void:
	attraction_position = target_position
	attraction_time = maxf(attraction_time, duration)
	attraction_strength = maxf(attraction_strength, strength)
	queue_redraw()


func _die() -> void:
	if is_dead or has_reached_end:
		return

	is_dead = true
	_spawn_enemy_particles(global_position, {
		"name": "EnemyDeathParticles",
		"amount": 26,
		"lifetime": 0.52,
		"emission_radius": body_radius * 0.45,
		"velocity_min": 34.0,
		"velocity_max": 140.0,
		"scale_min": 0.9,
		"scale_max": 2.6,
		"gravity": Vector2(0.0, 210.0),
		"color": body_color.lightened(0.10),
	})
	died.emit(self)
	queue_free()


func _start_base_attack() -> void:
	if is_dead or has_reached_end or is_attacking_base:
		return

	is_attacking_base = true
	_attack_timer = 0.45
	_spawn_enemy_particles(global_position + _move_direction * 12.0, {
		"name": "EnemyAttackParticles",
		"amount": 12,
		"lifetime": 0.28,
		"emission_radius": 5.0,
		"velocity_min": 24.0,
		"velocity_max": 90.0,
		"scale_min": 0.8,
		"scale_max": 1.8,
		"gravity": Vector2.ZERO,
		"color": Color(1.0, 0.58, 0.16),
	})
	queue_redraw()


func _reach_end() -> void:
	if is_dead or has_reached_end:
		return

	has_reached_end = true
	reached_end.emit(self)
	queue_free()


func _calculate_path_length() -> float:
	if path_points.size() < 2:
		return 1.0

	var length := 0.0
	for index in range(path_points.size() - 1):
		length += path_points[index].distance_to(path_points[index + 1])
	return maxf(length, 1.0)


func _update_path_progress() -> void:
	_path_progress = clampf(_traveled_distance / _total_path_length, 0.0, 1.0)


func _draw() -> void:
	var health_ratio := clampf(float(health) / float(max_health), 0.0, 1.0)
	var attack_pulse := 0.0
	if is_attacking_base:
		attack_pulse = 1.0 - clampf(_attack_timer / 0.45, 0.0, 1.0)

	var radius := body_radius + 3.0 * sin(attack_pulse * PI)
	_draw_contact_shadow(radius)
	if not _uses_sprite_visual():
		_draw_body(radius)
		_draw_type_details(radius)
	if slow_time > 0.0:
		draw_circle(Vector2.ZERO, radius + 7.0, Color(0.45, 0.82, 1.0, 0.15))
		draw_arc(Vector2.ZERO, radius + 8.0, 0.0, TAU, 24, Color(0.55, 0.92, 1.0, 0.85), 2.0, true)
	if attraction_time > 0.0:
		draw_arc(Vector2.ZERO, radius + 12.0, -0.75, 0.75, 18, Color(1.0, 0.82, 0.24, 0.85), 2.0, true)
	if is_attacking_base:
		draw_line(Vector2(10.0, -4.0), Vector2(30.0, -16.0), Color(1.0, 0.66, 0.12), 3.5, true)
		draw_line(Vector2(10.0, 4.0), Vector2(30.0, 16.0), Color(1.0, 0.66, 0.12), 3.5, true)
		draw_circle(Vector2(30.0, 0.0), 4.0, Color(1.0, 0.35, 0.12, 0.8))
	if not _uses_sprite_visual():
		_draw_outline(radius)

	var bar_position := Vector2(-16.0, -25.0)
	draw_rect(Rect2(bar_position, Vector2(32.0, 6.0)), Color(0.05, 0.06, 0.06))
	draw_rect(Rect2(bar_position + Vector2(1.0, 1.0), Vector2(30.0 * health_ratio, 4.0)), Color(0.25, 0.9, 0.35))


func _draw_contact_shadow(radius: float) -> void:
	var shadow_points := PackedVector2Array()
	var width := maxf(radius * 1.18, 12.0)
	var height := maxf(radius * 0.34, 4.0)
	for index in range(18):
		var angle := TAU * float(index) / 18.0
		shadow_points.append((Vector2(cos(angle) * width, radius * 0.62 + sin(angle) * height)).snapped(Vector2.ONE))
	draw_colored_polygon(shadow_points, Color(0.0, 0.0, 0.0, 0.28))


func _setup_sprite_visual() -> void:
	if enemy_type_id != "grunt" or _sprite != null:
		return

	var frames := _get_enemy1_sprite_frames()
	if frames == null or frames.get_frame_count("walk") == 0:
		return

	_sprite = AnimatedSprite2D.new()
	_sprite.name = "Enemy1AnimatedSprite"
	_sprite.sprite_frames = frames
	_sprite.animation = "walk"
	_sprite.centered = true
	_sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	var first_texture := frames.get_frame_texture("walk", 0)
	if first_texture != null:
		var max_dimension := maxf(float(first_texture.get_width()), float(first_texture.get_height()))
		if max_dimension > 0.0:
			_sprite.scale = Vector2.ONE * (ENEMY1_TARGET_SIZE / max_dimension)
	_sprite.play("walk")
	add_child(_sprite)
	_update_sprite_direction()


func _get_enemy1_sprite_frames() -> SpriteFrames:
	if _enemy1_sprite_frames_cache != null:
		return _copy_enemy1_sprite_frames(_enemy1_sprite_frames_cache)

	var frames := SpriteFrames.new()
	frames.add_animation("walk")
	frames.set_animation_loop("walk", true)
	frames.set_animation_speed("walk", 8.0)

	for frame_path in ENEMY1_WALK_FRAMES:
		var texture := _load_png_texture(frame_path)
		if texture == null:
			push_warning("Enemy frame missing: " + frame_path)
			continue
		frames.add_frame("walk", texture)

	_enemy1_sprite_frames_cache = frames
	return _copy_enemy1_sprite_frames(_enemy1_sprite_frames_cache)


func _copy_enemy1_sprite_frames(frames: SpriteFrames) -> SpriteFrames:
	if frames == null:
		return null
	var frames_snapshot := frames.duplicate(true) as SpriteFrames
	return frames_snapshot


func _uses_sprite_visual() -> bool:
	return _sprite != null and is_instance_valid(_sprite)


func _set_move_direction(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		return
	var previous_direction := _move_direction
	_move_direction = direction
	if not _uses_sprite_visual():
		return
	if previous_direction.dot(direction) < 0.999:
		_update_sprite_direction()


func _update_sprite_direction() -> void:
	if not _uses_sprite_visual():
		return

	if absf(_move_direction.x) > 0.05:
		var should_flip := _move_direction.x < 0.0
		if _sprite.flip_h != should_flip:
			_sprite.flip_h = should_flip
	var desired_speed_scale := clampf((speed * speed_multiplier) / 70.0, 0.35, 1.8)
	if not is_equal_approx(_sprite.speed_scale, desired_speed_scale):
		_sprite.speed_scale = desired_speed_scale


func _load_png_texture(resource_path: String) -> Texture2D:
	var image := Image.load_from_file(resource_path)
	if image == null:
		image = Image.load_from_file(ProjectSettings.globalize_path(resource_path))
	if image == null:
		return null
	return ImageTexture.create_from_image(image)


func _draw_body(radius: float) -> void:
	match shape:
		"square":
			draw_rect(Rect2(Vector2(-radius, -radius), Vector2(radius * 2.0, radius * 2.0)), body_color)
			draw_rect(Rect2(Vector2(-radius + 3.0, -radius + 3.0), Vector2(radius * 2.0 - 6.0, 5.0)), body_color.lightened(0.15))
		"diamond":
			draw_colored_polygon(PackedVector2Array([
				Vector2(0.0, -radius * 1.15),
				Vector2(radius * 1.15, 0.0),
				Vector2(0.0, radius * 1.15),
				Vector2(-radius * 1.15, 0.0),
			]), body_color)
		"triangle":
			draw_colored_polygon(PackedVector2Array([
				Vector2(0.0, -radius * 1.2),
				Vector2(radius * 1.1, radius),
				Vector2(-radius * 1.1, radius),
			]), body_color)
		"hex":
			draw_colored_polygon(_make_hex_points(radius), body_color)
			draw_colored_polygon(_make_hex_points(radius * 0.58), body_color.lightened(0.18))
		_:
			draw_rect(Rect2(Vector2(-radius, -radius), Vector2(radius * 2.0, radius * 2.0)), body_color)
			draw_rect(Rect2(Vector2(-radius + 3.0, -radius + 3.0), Vector2(radius * 2.0 - 6.0, 4.0)), body_color.lightened(0.18))


func _draw_outline(radius: float) -> void:
	match shape:
		"square":
			draw_rect(Rect2(Vector2(-radius, -radius), Vector2(radius * 2.0, radius * 2.0)), outline_color, false, 2.0)
		"diamond":
			draw_polyline(PackedVector2Array([
				Vector2(0.0, -radius * 1.15),
				Vector2(radius * 1.15, 0.0),
				Vector2(0.0, radius * 1.15),
				Vector2(-radius * 1.15, 0.0),
				Vector2(0.0, -radius * 1.15),
			]), outline_color, 2.0, true)
		"triangle":
			draw_polyline(PackedVector2Array([
				Vector2(0.0, -radius * 1.2),
				Vector2(radius * 1.1, radius),
				Vector2(-radius * 1.1, radius),
				Vector2(0.0, -radius * 1.2),
			]), outline_color, 2.0, true)
		"hex":
			var points := _make_hex_points(radius)
			points.append(points[0])
			draw_polyline(points, outline_color, 2.0, true)
		_:
			draw_rect(Rect2(Vector2(-radius, -radius), Vector2(radius * 2.0, radius * 2.0)), outline_color, false, 2.0)


func _draw_type_details(radius: float) -> void:
	match enemy_type_id:
		"runner":
			_draw_runner_details(radius)
		"brute":
			_draw_brute_details(radius)
		"shield":
			_draw_shield_details(radius)
		"elite":
			_draw_elite_details(radius)
		"taunt":
			_draw_taunt_details(radius)
		_:
			_draw_grunt_details(radius)


func _make_hex_points(radius: float) -> PackedVector2Array:
	var points := PackedVector2Array()
	for index in range(6):
		var angle := TAU * float(index) / 6.0 + PI / 6.0
		points.append(Vector2(cos(angle), sin(angle)) * radius)
	return points


func _spawn_step_particles() -> void:
	_spawn_enemy_particles(global_position - _move_direction * body_radius * 0.4 + Vector2(0.0, body_radius * 0.55), {
		"name": "EnemyStepParticles",
		"amount": 4,
		"lifetime": 0.22,
		"emission_radius": 2.0,
		"velocity_min": 4.0,
		"velocity_max": 28.0,
		"scale_min": 0.5,
		"scale_max": 1.3,
		"gravity": Vector2(0.0, 80.0),
		"color": Color(0.58, 0.48, 0.34, 0.62),
		"z_index": 45,
	})


func _spawn_enemy_particles(world_position: Vector2, config: Dictionary) -> void:
	var game_node := _get_game()
	if game_node != null:
		game_node.spawn_particle_burst(world_position, config)
		return

	var parent := _get_particle_parent()
	if parent != null:
		ParticleBurst.spawn(parent, world_position, config)


func _get_game() -> Main:
	if game != null and is_instance_valid(game):
		return game
	var parent := get_parent()
	if parent == null:
		return null
	game = parent.get_parent() as Main
	return game


func _get_particle_parent() -> Node:
	var game_node := _get_game()
	if game_node != null and game_node.particle_layer != null:
		return game_node.particle_layer

	var parent := get_parent()
	return parent


func _draw_grunt_details(radius: float) -> void:
	draw_rect(Rect2(Vector2(-7.0, -6.0), Vector2(4.0, 4.0)), Color(1.0, 0.86, 0.72))
	draw_rect(Rect2(Vector2(3.0, -6.0), Vector2(4.0, 4.0)), Color(1.0, 0.86, 0.72))
	draw_line(Vector2(-6.0, 6.0), Vector2(6.0, 6.0), outline_color.darkened(0.1), 2.0, true)
	draw_line(Vector2(-radius * 0.65, radius * 0.15), Vector2(radius * 0.65, radius * 0.15), body_color.lightened(0.18), 2.0, true)


func _draw_runner_details(radius: float) -> void:
	draw_line(Vector2(-radius * 1.25, -4.0), Vector2(-radius * 1.85, -8.0), Color(1.0, 0.92, 0.32, 0.75), 2.5, true)
	draw_line(Vector2(-radius * 1.25, 4.0), Vector2(-radius * 1.85, 8.0), Color(1.0, 0.92, 0.32, 0.75), 2.5, true)
	draw_rect(Rect2(Vector2(-3.0, -7.0), Vector2(6.0, 5.0)), Color(0.22, 0.12, 0.02))
	draw_line(Vector2(-radius * 0.45, 0.0), Vector2(radius * 0.45, 0.0), Color(1.0, 0.92, 0.45), 2.0, true)
	draw_line(Vector2(-radius * 0.20, 5.0), Vector2(radius * 0.20, 5.0), Color(1.0, 0.92, 0.45), 2.0, true)


func _draw_brute_details(radius: float) -> void:
	var plate_color := body_color.darkened(0.22)
	draw_rect(Rect2(Vector2(-radius * 0.62, -radius * 0.72), Vector2(radius * 1.24, radius * 0.42)), plate_color)
	draw_rect(Rect2(Vector2(-radius * 0.75, radius * 0.18), Vector2(radius * 1.5, radius * 0.36)), plate_color)
	draw_rect(Rect2(Vector2(-radius * 0.55, -radius * 0.20), Vector2(5.0, 5.0)), Color(1.0, 0.42, 0.32))
	draw_rect(Rect2(Vector2(radius * 0.30, -radius * 0.20), Vector2(5.0, 5.0)), Color(1.0, 0.42, 0.32))
	draw_line(Vector2(-radius, -radius), Vector2(-radius * 1.32, -radius * 1.3), outline_color, 3.0, true)
	draw_line(Vector2(radius, -radius), Vector2(radius * 1.32, -radius * 1.3), outline_color, 3.0, true)


func _draw_shield_details(radius: float) -> void:
	var shield_color := Color(0.78, 0.96, 1.0, 0.35)
	draw_polyline(PackedVector2Array([
		Vector2(0.0, -radius * 1.45),
		Vector2(radius * 1.25, -radius * 0.2),
		Vector2(radius * 0.70, radius * 1.25),
		Vector2(-radius * 0.70, radius * 1.25),
		Vector2(-radius * 1.25, -radius * 0.2),
		Vector2(0.0, -radius * 1.45),
	]), shield_color, 3.0, true)
	draw_line(Vector2(0.0, -radius * 0.72), Vector2(0.0, radius * 0.62), Color(0.86, 1.0, 1.0), 2.0, true)
	draw_line(Vector2(-radius * 0.52, 0.0), Vector2(radius * 0.52, 0.0), Color(0.86, 1.0, 1.0), 2.0, true)
	draw_rect(Rect2(Vector2(-4.0, -4.0), Vector2(8.0, 8.0)), Color(0.86, 1.0, 1.0))


func _draw_elite_details(radius: float) -> void:
	var core_color := Color(1.0, 0.82, 0.28)
	draw_circle(Vector2.ZERO, radius * 0.30, Color(core_color.r, core_color.g, core_color.b, 0.92))
	for index in range(6):
		var direction := Vector2.RIGHT.rotated(TAU * float(index) / 6.0)
		draw_line(direction * radius * 0.20, direction * radius * 0.78, core_color, 2.5, true)
	draw_arc(Vector2.ZERO, radius * 0.92, -PI * 0.2, PI * 1.15, 24, Color(1.0, 0.58, 0.28, 0.86), 2.0, true)


func _draw_taunt_details(radius: float) -> void:
	var signal_color := Color(1.0, 0.92, 0.36)
	draw_circle(Vector2.ZERO, radius * 0.54, Color(0.08, 0.10, 0.11, 0.86))
	draw_arc(Vector2.ZERO, radius * 0.78, -PI * 0.85, PI * 0.85, 28, signal_color, 3.0, true)
	draw_arc(Vector2.ZERO, radius * 1.10, PI * 0.15, PI * 1.85, 28, Color(signal_color.r, signal_color.g, signal_color.b, 0.62), 2.0, true)
	draw_line(Vector2(-radius * 0.36, -radius * 0.12), Vector2(radius * 0.36, -radius * 0.12), signal_color, 3.0, true)
	draw_line(Vector2(-radius * 0.36, radius * 0.18), Vector2(radius * 0.36, radius * 0.18), signal_color, 3.0, true)
