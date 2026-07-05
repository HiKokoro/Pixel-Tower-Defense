extends Node2D
class_name ImpactEffect

const DEFAULT_EFFECT_NAME := "ImpactEffect"
const DEFAULT_PROFILE := "basic"
const DEFAULT_COLOR := Color(1.0, 0.82, 0.28)
const DEFAULT_DIRECTION := Vector2.RIGHT
const VALID_PROFILES: Array[String] = [
	"basic",
	"cannon",
	"shotgun",
	"sniper",
	"rapid",
	"muzzle",
	"card_attack",
	"card_freeze",
	"card_buff",
	"card_guard",
	"card_gold",
	"card_trap",
	"card_beacon",
	"card_warp",
	"card_release",
]
const MIN_RADIUS: float = 1.0
const MAX_RADIUS: float = 5000.0
const MIN_DURATION: float = 0.05
const MAX_DURATION: float = 10.0
const MIN_WIDTH: float = 0.0
const MAX_WIDTH: float = 256.0
const MIN_SPREAD_ANGLE: float = 0.0
const MAX_SPREAD_ANGLE: float = TAU
const MIN_Z_INDEX: int = -4096
const MAX_Z_INDEX: int = 4096

static var _effect_script: Script

var profile: String = DEFAULT_PROFILE
var effect_color: Color = DEFAULT_COLOR
var radius: float = 28.0
var direction: Vector2 = DEFAULT_DIRECTION
var duration: float = 0.32
var width: float = 0.0
var spread_angle: float = 0.0

var _age: float = 0.0


static func spawn(parent: Node, effect_position: Vector2, config: Dictionary = {}) -> Node2D:
	if parent == null:
		return null

	var effect: Node2D = _get_effect_script().new() as Node2D
	effect.name = _get_effect_node_name(config)
	effect.process_mode = _get_effect_process_mode(config.get("process_mode", Node.PROCESS_MODE_PAUSABLE))
	effect.profile = _get_effect_profile(config.get("profile", DEFAULT_PROFILE))
	effect.effect_color = _get_config_color(config, "color", DEFAULT_COLOR)
	effect.radius = _get_config_float(config, "radius", 28.0, MIN_RADIUS, MAX_RADIUS)
	effect.direction = _get_config_vector2(config, "direction", DEFAULT_DIRECTION)
	if effect.direction == Vector2.ZERO:
		effect.direction = DEFAULT_DIRECTION
	effect.direction = effect.direction.normalized()
	effect.duration = _get_config_float(config, "duration", 0.32, MIN_DURATION, MAX_DURATION)
	effect.width = _get_config_float(config, "width", 0.0, MIN_WIDTH, MAX_WIDTH)
	effect.spread_angle = _get_config_float(config, "spread_angle", 0.0, MIN_SPREAD_ANGLE, MAX_SPREAD_ANGLE)
	effect.z_index = _get_config_int(config, "z_index", 95, MIN_Z_INDEX, MAX_Z_INDEX)
	parent.add_child(effect)
	effect.global_position = effect_position
	return effect


static func _get_effect_script() -> Script:
	if _effect_script == null:
		_effect_script = load("res://scripts/ImpactEffect.gd") as Script
	return _effect_script


static func _get_effect_process_mode(raw_value: Variant) -> int:
	if raw_value is int:
		match raw_value:
			Node.PROCESS_MODE_INHERIT, Node.PROCESS_MODE_PAUSABLE, Node.PROCESS_MODE_WHEN_PAUSED, Node.PROCESS_MODE_ALWAYS, Node.PROCESS_MODE_DISABLED:
				return raw_value
	return Node.PROCESS_MODE_PAUSABLE


static func _get_effect_profile(raw_value: Variant) -> String:
	var profile_text := str(raw_value).strip_edges()
	if VALID_PROFILES.has(profile_text):
		return profile_text
	return DEFAULT_PROFILE


static func _get_config_int(config: Dictionary, key: String, default_value: int, min_value: int, max_value: int) -> int:
	var raw_value: Variant = config.get(key, default_value)
	if raw_value is int or raw_value is float:
		var value := int(round(float(raw_value)))
		if value >= min_value and value <= max_value:
			return value
	return default_value


static func _get_config_float(config: Dictionary, key: String, default_value: float, min_value: float, max_value: float) -> float:
	var raw_value: Variant = config.get(key, default_value)
	if raw_value is int or raw_value is float:
		var value := float(raw_value)
		if value >= min_value and value <= max_value:
			return value
	return default_value


static func _get_config_vector2(config: Dictionary, key: String, default_value: Vector2) -> Vector2:
	var raw_value: Variant = config.get(key, default_value)
	if raw_value is Vector2:
		return raw_value
	if raw_value is Vector2i:
		return Vector2(raw_value)
	return default_value


static func _get_config_color(config: Dictionary, key: String, default_value: Color) -> Color:
	var raw_value: Variant = config.get(key, default_value)
	if raw_value is Color:
		return raw_value
	return default_value


static func _get_effect_node_name(config: Dictionary) -> String:
	var configured_name := str(config.get("name", DEFAULT_EFFECT_NAME)).strip_edges()
	if configured_name.is_empty() or not _is_ascii_identifier_text(configured_name):
		return DEFAULT_EFFECT_NAME
	return configured_name


static func _is_ascii_identifier_text(text: String) -> bool:
	for index in range(text.length()):
		var code := text.unicode_at(index)
		var is_upper := code >= 65 and code <= 90
		var is_lower := code >= 97 and code <= 122
		var is_digit := code >= 48 and code <= 57
		var is_underscore := code == 95
		if not (is_upper or is_lower or is_digit or is_underscore):
			return false
	return true


func _process(delta: float) -> void:
	_age += delta
	if _age >= duration:
		queue_free()
		return
	queue_redraw()


func _draw() -> void:
	var t := clampf(_age / duration, 0.0, 1.0)
	match profile:
		"cannon":
			_draw_cannon_impact(t)
		"shotgun":
			_draw_shotgun_cone(t)
		"sniper":
			_draw_sniper_trace(t)
		"rapid":
			_draw_rapid_flash(t)
		"muzzle":
			_draw_muzzle_flash(t)
		"card_attack":
			_draw_card_attack(t)
		"card_freeze":
			_draw_card_freeze(t)
		"card_buff":
			_draw_card_buff(t)
		"card_guard":
			_draw_card_guard(t)
		"card_gold":
			_draw_card_gold(t)
		"card_trap":
			_draw_card_trap(t)
		"card_beacon":
			_draw_card_beacon(t)
		"card_warp":
			_draw_card_warp(t)
		"card_release":
			_draw_card_release(t)
		_:
			_draw_basic_impact(t)


func _draw_cannon_impact(t: float) -> void:
	var alpha := 1.0 - t
	var current_radius := lerpf(radius * 0.35, radius, t)
	var ring_color := Color(effect_color.r, effect_color.g, effect_color.b, 0.42 * alpha)
	var core_color := Color(1.0, 0.92, 0.55, 0.30 * alpha)
	draw_circle(Vector2.ZERO, current_radius, Color(effect_color.r, effect_color.g * 0.55, effect_color.b * 0.35, 0.11 * alpha))
	draw_arc(Vector2.ZERO, current_radius, 0.0, TAU, 48, ring_color, 4.0, false)
	draw_arc(Vector2.ZERO, current_radius * 0.58, 0.0, TAU, 40, core_color, 3.0, false)
	for index in range(8):
		var angle := TAU * float(index) / 8.0
		var ray := Vector2.RIGHT.rotated(angle)
		draw_line(ray * current_radius * 0.22, ray * current_radius * 0.72, Color(1.0, 0.68, 0.30, 0.46 * alpha), 3.0, false)


func _draw_shotgun_cone(t: float) -> void:
	var alpha := 1.0 - t
	var half_angle := maxf(spread_angle * 0.5, 0.18)
	var current_radius := lerpf(radius * 0.55, radius, t)
	var left := direction.rotated(-half_angle)
	var right := direction.rotated(half_angle)
	var cone_points := PackedVector2Array([
		Vector2.ZERO,
		left * current_radius,
		direction * current_radius * 1.08,
		right * current_radius,
	])
	draw_colored_polygon(cone_points, Color(effect_color.r, effect_color.g, effect_color.b, 0.10 * alpha))
	draw_line(Vector2.ZERO, left * current_radius, Color(effect_color.r, effect_color.g, effect_color.b, 0.38 * alpha), 3.0, false)
	draw_line(Vector2.ZERO, right * current_radius, Color(effect_color.r, effect_color.g, effect_color.b, 0.38 * alpha), 3.0, false)
	for pellet_index in range(5):
		var lane_t := float(pellet_index) / 4.0
		var angle := lerpf(-half_angle, half_angle, lane_t)
		var pellet_dir := direction.rotated(angle)
		draw_line(pellet_dir * 10.0, pellet_dir * current_radius * 0.74, Color(1.0, 0.84, 0.42, 0.48 * alpha), 2.0, false)


func _draw_sniper_trace(t: float) -> void:
	var alpha := 1.0 - t
	var trace_width := maxf(width, 2.0)
	draw_line(Vector2.ZERO, direction * radius, Color(effect_color.r, effect_color.g, effect_color.b, 0.55 * alpha), trace_width, false)
	draw_line(direction * 8.0, direction * radius * 0.72, Color(1.0, 1.0, 1.0, 0.32 * alpha), 1.0, false)
	var cross_center := direction * minf(radius, 26.0)
	var side := direction.orthogonal()
	draw_line(cross_center - side * 5.0, cross_center + side * 5.0, Color(effect_color.r, effect_color.g, effect_color.b, 0.62 * alpha), 2.0, false)


func _draw_rapid_flash(t: float) -> void:
	var alpha := 1.0 - t
	var current_radius := lerpf(radius * 0.45, radius, t)
	draw_line(Vector2.ZERO, direction * current_radius, Color(effect_color.r, effect_color.g, effect_color.b, 0.58 * alpha), 3.0, false)
	draw_line(direction.rotated(0.16) * 4.0, direction.rotated(0.16) * current_radius * 0.62, Color(0.74, 1.0, 0.82, 0.28 * alpha), 2.0, false)
	draw_line(direction.rotated(-0.16) * 4.0, direction.rotated(-0.16) * current_radius * 0.62, Color(0.74, 1.0, 0.82, 0.28 * alpha), 2.0, false)


func _draw_muzzle_flash(t: float) -> void:
	var alpha := 1.0 - t
	var side := direction.orthogonal()
	var current_radius := lerpf(radius * 0.65, radius, t)
	var points := PackedVector2Array([
		direction * current_radius,
		side * 7.0,
		direction * -4.0,
		side * -7.0,
	])
	draw_colored_polygon(points, Color(effect_color.r, effect_color.g, effect_color.b, 0.22 * alpha))
	draw_line(Vector2.ZERO, direction * current_radius, Color(1.0, 0.92, 0.54, 0.50 * alpha), 3.0, false)


func _draw_basic_impact(t: float) -> void:
	var alpha := 1.0 - t
	var current_radius := lerpf(radius * 0.40, radius, t)
	draw_arc(Vector2.ZERO, current_radius, 0.0, TAU, 24, Color(effect_color.r, effect_color.g, effect_color.b, 0.36 * alpha), 2.0, false)
	for index in range(4):
		var ray := Vector2.RIGHT.rotated(TAU * float(index) / 4.0)
		draw_line(ray * 3.0, ray * current_radius * 0.65, Color(effect_color.r, effect_color.g, effect_color.b, 0.30 * alpha), 2.0, false)


func _draw_card_attack(t: float) -> void:
	var alpha := 1.0 - t
	var strike_length := lerpf(radius * 0.35, radius * 0.92, t)
	var side := direction.orthogonal()
	draw_line(direction * -radius * 0.42, direction * strike_length, Color(1.0, 0.82, 0.34, 0.72 * alpha), 5.0, false)
	draw_line(side * -radius * 0.20, side * radius * 0.20, Color(effect_color.r, effect_color.g, effect_color.b, 0.52 * alpha), 4.0, false)
	draw_circle(Vector2.ZERO, lerpf(radius * 0.18, radius * 0.58, t), Color(effect_color.r, effect_color.g * 0.55, effect_color.b * 0.35, 0.14 * alpha))
	draw_arc(Vector2.ZERO, lerpf(radius * 0.22, radius * 0.76, t), 0.0, TAU, 42, Color(effect_color.r, effect_color.g, effect_color.b, 0.46 * alpha), 4.0, false)


func _draw_card_freeze(t: float) -> void:
	var alpha := 1.0 - t
	var current_radius := lerpf(radius * 0.28, radius, t)
	draw_circle(Vector2.ZERO, current_radius, Color(effect_color.r, effect_color.g, effect_color.b, 0.08 * alpha))
	for index in range(6):
		var ray := Vector2.RIGHT.rotated(TAU * float(index) / 6.0)
		draw_line(ray * current_radius * 0.20, ray * current_radius * 0.82, Color(0.84, 1.0, 1.0, 0.55 * alpha), 2.0, false)
	draw_arc(Vector2.ZERO, current_radius, 0.0, TAU, 48, Color(effect_color.r, effect_color.g, effect_color.b, 0.52 * alpha), 3.0, false)
	draw_arc(Vector2.ZERO, current_radius * 0.62, 0.0, TAU, 36, Color(0.92, 1.0, 1.0, 0.38 * alpha), 2.0, false)


func _draw_card_buff(t: float) -> void:
	var alpha := 1.0 - t
	var current_radius := lerpf(radius * 0.30, radius * 0.82, t)
	for ring_index in range(3):
		var ring_radius := current_radius - float(ring_index) * 12.0
		if ring_radius > 4.0:
			draw_arc(Vector2.ZERO, ring_radius, 0.0, TAU, 32, Color(effect_color.r, effect_color.g, effect_color.b, (0.42 - float(ring_index) * 0.10) * alpha), 2.0, false)
	for index in range(4):
		var arm := Vector2.RIGHT.rotated(TAU * float(index) / 4.0)
		draw_line(arm * 6.0, arm * current_radius * 0.64, Color(effect_color.r, effect_color.g, effect_color.b, 0.38 * alpha), 3.0, false)


func _draw_card_guard(t: float) -> void:
	var alpha := 1.0 - t
	var current_radius := lerpf(radius * 0.24, radius * 0.70, t)
	var points := PackedVector2Array([
		Vector2(0.0, -current_radius),
		Vector2(current_radius * 0.76, -current_radius * 0.22),
		Vector2(current_radius * 0.58, current_radius * 0.72),
		Vector2(0.0, current_radius),
		Vector2(-current_radius * 0.58, current_radius * 0.72),
		Vector2(-current_radius * 0.76, -current_radius * 0.22),
	])
	draw_colored_polygon(points, Color(effect_color.r, effect_color.g, effect_color.b, 0.09 * alpha))
	for index in range(points.size()):
		draw_line(points[index], points[(index + 1) % points.size()], Color(effect_color.r, effect_color.g, effect_color.b, 0.52 * alpha), 3.0, false)
	draw_line(Vector2(-current_radius * 0.34, 0.0), Vector2(current_radius * 0.34, 0.0), Color(1.0, 1.0, 1.0, 0.34 * alpha), 2.0, false)


func _draw_card_gold(t: float) -> void:
	var alpha := 1.0 - t
	var current_radius := lerpf(radius * 0.18, radius * 0.68, t)
	draw_arc(Vector2.ZERO, current_radius, 0.0, TAU, 28, Color(effect_color.r, effect_color.g, effect_color.b, 0.58 * alpha), 3.0, false)
	for index in range(5):
		var offset := Vector2((float(index) - 2.0) * 9.0, -current_radius * (0.18 + float(index % 2) * 0.08))
		var coin_center := offset + Vector2.UP * t * radius * 0.38
		draw_circle(coin_center, 4.0, Color(effect_color.r, effect_color.g, effect_color.b, 0.55 * alpha))
		draw_line(coin_center + Vector2(-2.0, 0.0), coin_center + Vector2(2.0, 0.0), Color(1.0, 0.95, 0.56, 0.62 * alpha), 1.0, false)


func _draw_card_trap(t: float) -> void:
	var alpha := 1.0 - t
	var current_radius := lerpf(radius * 0.42, radius * 0.86, t)
	draw_line(Vector2(-current_radius, 0.0), Vector2(current_radius, 0.0), Color(effect_color.r, effect_color.g, effect_color.b, 0.42 * alpha), 3.0, false)
	for index in range(7):
		var x := lerpf(-current_radius * 0.82, current_radius * 0.82, float(index) / 6.0)
		draw_line(Vector2(x, 0.0), Vector2(x, -14.0 - float(index % 2) * 5.0), Color(1.0, 0.72, 0.38, 0.62 * alpha), 3.0, false)


func _draw_card_beacon(t: float) -> void:
	var alpha := 1.0 - t
	var current_radius := lerpf(radius * 0.20, radius * 0.74, t)
	draw_circle(Vector2.ZERO, 6.0, Color(effect_color.r, effect_color.g, effect_color.b, 0.64 * alpha))
	for index in range(3):
		var ring_radius := current_radius - float(index) * 18.0
		if ring_radius > 8.0:
			draw_arc(Vector2.ZERO, ring_radius, 0.0, TAU, 40, Color(effect_color.r, effect_color.g, effect_color.b, (0.36 - float(index) * 0.08) * alpha), 2.0, false)
	for index in range(4):
		var ray := Vector2.RIGHT.rotated(TAU * float(index) / 4.0 + t * 0.55)
		draw_line(ray * current_radius * 0.22, ray * current_radius * 0.54, Color(1.0, 0.92, 0.46, 0.42 * alpha), 2.0, false)


func _draw_card_warp(t: float) -> void:
	var alpha := 1.0 - t
	var current_radius := lerpf(radius * 0.24, radius * 0.86, t)
	for index in range(3):
		var arc_start := t * TAU + float(index) * TAU / 3.0
		draw_arc(Vector2.ZERO, current_radius - float(index) * 13.0, arc_start, arc_start + PI * 1.18, 36, Color(effect_color.r, effect_color.g, effect_color.b, (0.52 - float(index) * 0.10) * alpha), 3.0, false)
	draw_circle(Vector2.ZERO, current_radius * 0.16, Color(effect_color.r, effect_color.g, effect_color.b, 0.22 * alpha))


func _draw_card_release(t: float) -> void:
	var alpha := 1.0 - t
	var current_radius := lerpf(radius * 0.25, radius * 0.70, t)
	draw_arc(Vector2.ZERO, current_radius, 0.0, TAU, 32, Color(effect_color.r, effect_color.g, effect_color.b, 0.42 * alpha), 3.0, false)
	draw_circle(Vector2.ZERO, current_radius * 0.22, Color(effect_color.r, effect_color.g, effect_color.b, 0.16 * alpha))
