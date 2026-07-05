extends SceneTree

const TARGET_LEVEL_INDEX: int = 9
const TARGET_TOWERS: int = 48
const TARGET_ENEMIES: int = 180
const WARMUP_FRAMES: int = 60
const SAMPLE_FRAMES: int = 240

var _failures: Array[String] = []


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var main_scene := load("res://scenes/Main.tscn") as PackedScene
	_assert(main_scene != null, "Main scene should load for benchmark.")

	var game := main_scene.instantiate() as Main
	_assert(game != null, "Main scene should instantiate for benchmark.")
	root.add_child(game)
	await process_frame
	await process_frame

	var setup_start := Time.get_ticks_usec()
	game.highest_unlocked_level_index = TARGET_LEVEL_INDEX
	game.ui.set_highest_unlocked_level(game.highest_unlocked_level_index)
	game._on_level_selected(TARGET_LEVEL_INDEX)
	await process_frame
	game.gold = 999999

	var towers_built := _build_towers(game, TARGET_TOWERS)
	var enemies_spawned := _spawn_enemies(game, TARGET_ENEMIES)
	await process_frame
	var setup_ms := float(Time.get_ticks_usec() - setup_start) / 1000.0

	for frame_index in range(WARMUP_FRAMES):
		await process_frame

	var frame_times: Array[float] = []
	var sample_start := Time.get_ticks_usec()
	for frame_index in range(SAMPLE_FRAMES):
		var frame_start := Time.get_ticks_usec()
		await process_frame
		frame_times.append(float(Time.get_ticks_usec() - frame_start) / 1000.0)
	var sample_ms := float(Time.get_ticks_usec() - sample_start) / 1000.0

	var summary := _summarize_frame_times(frame_times)
	var active_enemies := game.get_active_enemies().size()
	var active_projectiles := game.get_active_projectiles().size()
	var active_particles := game.get_world_particle_count()
	var active_towers := game.get_active_towers().size()

	print("[PERF] level=%d towers=%d enemies_spawned=%d active_enemies=%d projectiles=%d particles=%d" % [
		TARGET_LEVEL_INDEX + 1,
		active_towers,
		enemies_spawned,
		active_enemies,
		active_projectiles,
		active_particles,
	])
	print("[PERF] setup_ms=%.2f sample_ms=%.2f frames=%d" % [setup_ms, sample_ms, SAMPLE_FRAMES])
	print("[PERF] avg_frame_ms=%.3f p95_frame_ms=%.3f max_frame_ms=%.3f estimated_fps=%.1f" % [
		float(summary["avg_ms"]),
		float(summary["p95_ms"]),
		float(summary["max_ms"]),
		1000.0 / maxf(float(summary["avg_ms"]), 0.001),
	])
	print("[PERF] result=%s" % ("PASS" if _failures.is_empty() else "FAIL"))

	game.queue_free()
	await process_frame
	quit(0 if _failures.is_empty() else 1)


func _build_towers(game: Main, target_count: int) -> int:
	var built := 0
	var tower_types: Array[String] = ["basic", "rapid", "cannon", "sniper"]

	for y in range(game.map_rows):
		for x in range(game.map_cols):
			if built >= target_count:
				return built
			if (x + y) % 3 != 0:
				continue

			var type_id := tower_types[built % tower_types.size()]
			game.build_manager.enter_build_mode(type_id)
			var grid_position := Vector2i(x, y)
			if not game.build_manager.get_build_error(grid_position).is_empty():
				continue

			if game.build_manager.try_build_at(game.build_manager.grid_to_center(grid_position)):
				built += 1

	_assert(built >= mini(target_count, 1), "Benchmark should build at least one tower.")
	return built


func _spawn_enemies(game: Main, target_count: int) -> int:
	var spawned := 0
	var enemy_types: Array[String] = ["grunt", "runner", "brute", "shield"]
	var route_count := maxi(game.spawn_paths.size(), 1)

	for index in range(target_count):
		var type_id := enemy_types[index % enemy_types.size()]
		var stats: Dictionary = game.wave_manager.get_enemy_stats(type_id, 9, index)
		var route_index := index % route_count
		var enemy := game._spawn_enemy(
			type_id,
			int(stats["health"]),
			float(stats["speed"]),
			int(stats["reward"]),
			float(index % 12) * -20.0,
			route_index
		)
		if enemy != null and is_instance_valid(enemy):
			spawned += 1

	_assert(spawned == target_count, "Benchmark should spawn requested enemies.")
	return spawned


func _summarize_frame_times(frame_times: Array[float]) -> Dictionary:
	if frame_times.is_empty():
		return {"avg_ms": 0.0, "p95_ms": 0.0, "max_ms": 0.0}

	var total := 0.0
	var max_value := 0.0
	for value in frame_times:
		total += value
		max_value = maxf(max_value, value)

	var sorted_times := frame_times.duplicate()
	sorted_times.sort()
	var p95_index := clampi(int(ceil(float(sorted_times.size()) * 0.95)) - 1, 0, sorted_times.size() - 1)
	return {
		"avg_ms": total / float(frame_times.size()),
		"p95_ms": sorted_times[p95_index],
		"max_ms": max_value,
	}


func _assert(condition: bool, message: String) -> void:
	if condition:
		print("[PASS] ", message)
	else:
		push_error("[FAIL] " + message)
		_failures.append(message)
