extends Node2D
class_name WorldOverlayRenderer

var game: Main


func setup(game_ref: Main) -> void:
	game = game_ref
	process_mode = Node.PROCESS_MODE_PAUSABLE
	queue_redraw()


func _draw() -> void:
	if game == null:
		return
	_draw_area_effect()


func _draw_area_effect() -> void:
	if game._missile_effect_timer <= 0.0:
		return

	var ratio := clampf(game._missile_effect_timer / 0.45, 0.0, 1.0)
	var alpha := ratio * 0.78
	var center := game._missile_effect_position
	var radius := game._missile_effect_radius
	var effect_color := game._world_effect_color
	var accent_color := game._world_effect_accent_color
	var pulse_radius := radius * (1.0 - ratio * 0.18)

	draw_circle(center, pulse_radius, Color(effect_color.r, effect_color.g, effect_color.b, 0.15 * alpha))
	draw_arc(center, radius, 0.0, TAU, 72, Color(effect_color.r, effect_color.g, effect_color.b, alpha), 4.0, true)
	draw_arc(center, radius * 0.72, -PI * ratio, TAU - PI * ratio, 64, Color(accent_color.r, accent_color.g, accent_color.b, 0.42 * alpha), 2.0, true)
	draw_line(center + Vector2(-18.0, 0.0), center + Vector2(18.0, 0.0), Color(accent_color.r, accent_color.g, accent_color.b, alpha), 3.0, true)
	draw_line(center + Vector2(0.0, -18.0), center + Vector2(0.0, 18.0), Color(accent_color.r, accent_color.g, accent_color.b, alpha), 3.0, true)

	for index in range(8):
		var direction := Vector2.RIGHT.rotated(TAU * float(index) / 8.0 + ratio * 0.35)
		var inner := center + direction * radius * 0.18
		var outer := center + direction * radius * (0.34 + 0.10 * (1.0 - ratio))
		draw_line(inner, outer, Color(accent_color.r, accent_color.g, accent_color.b, 0.34 * alpha), 2.0, true)
