extends CPUParticles2D

const DEFAULT_COLOR := Color(1.0, 0.82, 0.28)
const DEFAULT_DIRECTION := Vector2.UP
const DEFAULT_GRAVITY := Vector2(0.0, 260.0)
const DEFAULT_PARTICLE_NODE_NAME := "ParticleBurst"
const MIN_AMOUNT: int = 1
const MAX_AMOUNT: int = 512
const MIN_LIFETIME: float = 0.01
const MAX_LIFETIME: float = 10.0
const MIN_UNIT_RATIO: float = 0.0
const MAX_UNIT_RATIO: float = 1.0
const MIN_RADIUS: float = 0.0
const MAX_RADIUS: float = 2048.0
const MIN_SPREAD: float = 0.0
const MAX_SPREAD: float = 360.0
const MIN_SIGNED_SPEED: float = -5000.0
const MAX_SIGNED_SPEED: float = 5000.0
const MIN_UNSIGNED_SPEED: float = 0.0
const MAX_UNSIGNED_SPEED: float = 5000.0
const MIN_SCALE: float = 0.01
const MAX_SCALE: float = 64.0
const MIN_Z_INDEX: int = -4096
const MAX_Z_INDEX: int = 4096

static var _pixel_texture: Texture2D


static func spawn(parent: Node, burst_position: Vector2, config: Dictionary = {}) -> CPUParticles2D:
	if parent == null:
		return null

	var burst := CPUParticles2D.new()
	burst.name = _get_particle_node_name(config)
	burst.process_mode = _get_particle_process_mode(config.get("process_mode", Node.PROCESS_MODE_PAUSABLE))
	burst.texture = _get_pixel_texture()
	burst.one_shot = true
	burst.emitting = false
	burst.amount = _get_config_int(config, "amount", 18, MIN_AMOUNT, MAX_AMOUNT)
	burst.lifetime = _get_config_float(config, "lifetime", 0.42, MIN_LIFETIME, MAX_LIFETIME)
	burst.explosiveness = _get_config_float(config, "explosiveness", 0.88, MIN_UNIT_RATIO, MAX_UNIT_RATIO)
	burst.randomness = _get_config_float(config, "randomness", 0.48, MIN_UNIT_RATIO, MAX_UNIT_RATIO)
	burst.local_coords = false
	burst.emission_shape = CPUParticles2D.EMISSION_SHAPE_SPHERE
	burst.emission_sphere_radius = _get_config_float(config, "emission_radius", 2.0, MIN_RADIUS, MAX_RADIUS)
	burst.direction = _get_config_vector2(config, "direction", DEFAULT_DIRECTION)
	burst.spread = _get_config_float(config, "spread", 180.0, MIN_SPREAD, MAX_SPREAD)
	burst.gravity = _get_config_vector2(config, "gravity", DEFAULT_GRAVITY)
	burst.initial_velocity_min = _get_config_float(config, "velocity_min", 24.0, MIN_UNSIGNED_SPEED, MAX_UNSIGNED_SPEED)
	burst.initial_velocity_max = _get_config_float(config, "velocity_max", 110.0, MIN_UNSIGNED_SPEED, MAX_UNSIGNED_SPEED)
	burst.angular_velocity_min = _get_config_float(config, "angular_velocity_min", -120.0, MIN_SIGNED_SPEED, MAX_SIGNED_SPEED)
	burst.angular_velocity_max = _get_config_float(config, "angular_velocity_max", 120.0, MIN_SIGNED_SPEED, MAX_SIGNED_SPEED)
	burst.damping_min = _get_config_float(config, "damping_min", 18.0, MIN_UNSIGNED_SPEED, MAX_UNSIGNED_SPEED)
	burst.damping_max = _get_config_float(config, "damping_max", 70.0, MIN_UNSIGNED_SPEED, MAX_UNSIGNED_SPEED)
	burst.scale_amount_min = _get_config_float(config, "scale_min", 1.0, MIN_SCALE, MAX_SCALE)
	burst.scale_amount_max = _get_config_float(config, "scale_max", 2.4, MIN_SCALE, MAX_SCALE)
	burst.color = _get_config_color(config, "color", DEFAULT_COLOR)
	burst.z_index = _get_config_int(config, "z_index", 80, MIN_Z_INDEX, MAX_Z_INDEX)

	parent.add_child(burst)
	burst.global_position = burst_position
	burst.finished.connect(burst.queue_free, CONNECT_ONE_SHOT)
	burst.restart()
	burst.emitting = true

	return burst


static func _get_particle_process_mode(raw_value: Variant) -> int:
	if raw_value is int:
		match raw_value:
			Node.PROCESS_MODE_INHERIT, Node.PROCESS_MODE_PAUSABLE, Node.PROCESS_MODE_WHEN_PAUSED, Node.PROCESS_MODE_ALWAYS, Node.PROCESS_MODE_DISABLED:
				return raw_value
	return Node.PROCESS_MODE_PAUSABLE


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


static func _get_particle_node_name(config: Dictionary) -> String:
	var configured_name := str(config.get("name", "")).strip_edges()
	if configured_name.is_empty() or not _is_ascii_identifier_text(configured_name):
		return DEFAULT_PARTICLE_NODE_NAME
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


static func _get_pixel_texture() -> Texture2D:
	if _pixel_texture != null:
		return _pixel_texture

	var image := Image.create(4, 4, false, Image.FORMAT_RGBA8)
	image.fill(Color.WHITE)
	_pixel_texture = ImageTexture.create_from_image(image)
	return _pixel_texture
