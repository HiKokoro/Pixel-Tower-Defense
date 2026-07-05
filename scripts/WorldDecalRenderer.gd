extends Node2D
class_name WorldDecalRenderer

var game: Main


func setup(game_ref: Main) -> void:
	game = game_ref
	process_mode = Node.PROCESS_MODE_PAUSABLE
	queue_redraw()


func _draw() -> void:
	if game == null:
		return
	_draw_base()
	_draw_road_spike_traps()


func _draw_base() -> void:
	if game.path_points.is_empty():
		return

	var base_position := game.get_base_position()
	var flash_ratio := clampf(game._base_hit_flash / 0.35, 0.0, 1.0)
	var body_color := _theme_color("base_body", Color(0.22, 0.39, 0.48)).lerp(Color(1.0, 0.25, 0.14), flash_ratio)
	var plate_color := _theme_color("base_plate", Color(0.58, 0.68, 0.64)).lerp(Color(1.0, 0.84, 0.30), flash_ratio)
	var glow_color := _theme_color("base_glow", Color(0.22, 0.86, 0.78)).lerp(Color(1.0, 0.30, 0.14), flash_ratio)

	_draw_pixel_ellipse(base_position + Vector2(0.0, 18.0), Vector2(45.0, 15.0), Color(0.0, 0.0, 0.0, 0.30))
	draw_circle(base_position, 30.0 + 12.0 * flash_ratio, Color(glow_color.r, glow_color.g, glow_color.b, 0.10 + 0.16 * flash_ratio))
	draw_rect(Rect2(base_position + Vector2(-34.0, -24.0), Vector2(68.0, 50.0)), Color(0.015, 0.022, 0.026, 0.95))
	draw_rect(Rect2(base_position + Vector2(-28.0, -18.0), Vector2(56.0, 38.0)), body_color.darkened(0.14))
	draw_rect(Rect2(base_position + Vector2(-23.0, -15.0), Vector2(46.0, 31.0)), body_color)
	draw_rect(Rect2(base_position + Vector2(-31.0, -30.0), Vector2(62.0, 10.0)), plate_color.darkened(0.10))
	draw_rect(Rect2(base_position + Vector2(-26.0, -34.0), Vector2(10.0, 16.0)), plate_color.darkened(0.22))
	draw_rect(Rect2(base_position + Vector2(16.0, -34.0), Vector2(10.0, 16.0)), plate_color.darkened(0.22))
	draw_rect(Rect2(base_position + Vector2(-7.0, 2.0), Vector2(14.0, 19.0)), Color(0.035, 0.048, 0.056))
	draw_rect(Rect2(base_position + Vector2(-16.0, -9.0), Vector2(9.0, 8.0)), glow_color)
	draw_rect(Rect2(base_position + Vector2(7.0, -9.0), Vector2(9.0, 8.0)), glow_color)
	draw_rect(Rect2(base_position + Vector2(-23.0, -15.0), Vector2(46.0, 5.0)), body_color.lightened(0.16))
	draw_arc(base_position, 34.0, 0.0, TAU, 48, Color(0.010, 0.015, 0.018), 2.0, true)
	if flash_ratio > 0.0:
		draw_arc(base_position, 40.0 + flash_ratio * 10.0, 0.0, TAU, 52, Color(1.0, 0.30, 0.12, 0.62 * flash_ratio), 4.0, true)
		for index in range(6):
			var ray := Vector2.RIGHT.rotated(TAU * float(index) / 6.0)
			draw_line(base_position + ray * 23.0, base_position + ray * (40.0 + 8.0 * flash_ratio), Color(1.0, 0.46, 0.18, 0.44 * flash_ratio), 3.0, true)


func _draw_road_spike_traps() -> void:
	for trap in game._road_spike_traps:
		var center := _get_road_spike_trap_draw_position(trap)
		var radius := _get_road_spike_trap_draw_radius(trap)
		var charges := _get_road_spike_trap_draw_charges(trap)
		if charges <= 0:
			continue
		_draw_pixel_ellipse(center + Vector2(0.0, 7.0), Vector2(radius * 0.78, radius * 0.26), Color(0.0, 0.0, 0.0, 0.20))
		draw_circle(center, radius, Color(0.95, 0.55, 0.22, 0.10))
		draw_arc(center, radius, 0.0, TAU, 32, Color(0.95, 0.62, 0.28, 0.80), 2.0, true)
		for index in range(charges):
			var angle := TAU * float(index) / float(maxi(charges, 1))
			var direction := Vector2.RIGHT.rotated(angle)
			draw_line(center + direction * 9.0, center + direction * 22.0, Color(1.0, 0.82, 0.36, 0.92), 3.0, true)
			draw_rect(Rect2((center + direction * 23.0).snapped(Vector2.ONE) - Vector2(2.0, 2.0), Vector2(4.0, 4.0)), Color(0.20, 0.10, 0.04, 0.78))


func _get_road_spike_trap_draw_position(trap: Dictionary) -> Vector2:
	var raw_position: Variant = trap.get("position", Vector2.ZERO)
	if raw_position is Vector2:
		return raw_position
	if raw_position is Vector2i:
		return Vector2(raw_position)
	return Vector2.ZERO


func _get_road_spike_trap_draw_radius(trap: Dictionary) -> float:
	var raw_radius: Variant = trap.get("radius", Main.ROAD_SPIKE_DEFAULT_RADIUS)
	if raw_radius is int or raw_radius is float:
		var radius := float(raw_radius)
		if radius > 0.0 and radius <= Main.ROAD_SPIKE_MAX_RADIUS:
			return radius
	return Main.ROAD_SPIKE_DEFAULT_RADIUS


func _get_road_spike_trap_draw_charges(trap: Dictionary) -> int:
	var raw_charges: Variant = trap.get("charges", 0)
	if raw_charges is int or raw_charges is float:
		var charges := int(round(float(raw_charges)))
		if charges > 0 and charges <= Main.ROAD_SPIKE_MAX_CHARGES:
			return charges
	return 0


func _draw_pixel_ellipse(center: Vector2, radii: Vector2, color: Color) -> void:
	var points := PackedVector2Array()
	for index in range(24):
		var angle := TAU * float(index) / 24.0
		points.append((center + Vector2(cos(angle) * radii.x, sin(angle) * radii.y)).snapped(Vector2.ONE))
	draw_colored_polygon(points, color)


func _theme_color(key: String, fallback: Color) -> Color:
	if game != null and game.scene_theme.has(key):
		return _get_valid_theme_color(game.scene_theme.get(key), fallback)
	return fallback


func _get_valid_theme_color(raw_color: Variant, fallback: Color) -> Color:
	if raw_color is Color:
		return raw_color
	return fallback
