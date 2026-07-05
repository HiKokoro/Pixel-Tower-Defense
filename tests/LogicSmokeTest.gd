extends SceneTree

const UpdateAnnouncements := preload("res://scripts/UpdateAnnouncements.gd")
const LEVEL_START_SAVE_PATH := "user://level_start_save.cfg"
const LEVEL_START_SAVE_SECTION := "level_start"
const TEST_TIMEOUT_SECONDS := 150.0

var _failures: Array[String] = []
var _elapsed_seconds := 0.0
var _finished := false
var _last_checkpoint := "初始化"
var _level_start_save_snapshot: Dictionary = {}
var _has_level_start_save_snapshot := false


func _initialize() -> void:
	print("逻辑冒烟测试开始。")
	call_deferred("_run")


func _process(delta: float) -> bool:
	if _finished:
		return false
	_elapsed_seconds += delta
	if _elapsed_seconds >= TEST_TIMEOUT_SECONDS:
		_failures.append("逻辑冒烟测试超时，最后检查点：" + _last_checkpoint)
		push_error("[FAIL] 逻辑冒烟测试超时，最后检查点：" + _last_checkpoint)
		_finish()
	return false


func _run() -> void:
	_last_checkpoint = "读取并清理关卡存档"
	_level_start_save_snapshot = _read_level_start_save_for_test()
	_has_level_start_save_snapshot = true
	_clear_level_start_save_for_test()

	var main_scene := load("res://scenes/Main.tscn") as PackedScene
	_assert(main_scene != null, "Main scene should load.")

	var ui_init_probe := GameUI.new()
	root.add_child(ui_init_probe)
	ui_init_probe.setup([{
		"id": "basic",
		"name": "基础塔",
		"cost": 50,
		"damage": 15,
		"range": 130.0,
		"interval": 0.8,
		"category_label": "武器塔",
		"icon": "基",
	}], [])
	_assert(ui_init_probe.start_wave_button.disabled, "Standalone UI setup should initialize the start-wave button as disabled.")
	_assert(ui_init_probe.start_wave_button.mouse_default_cursor_shape == Control.CURSOR_ARROW, "Standalone UI setup should initialize the start-wave button with the default cursor.")
	_assert(ui_init_probe.build_tower_button.disabled, "Standalone UI setup should initialize the build menu button as disabled.")
	_assert(ui_init_probe.build_tower_button.mouse_default_cursor_shape == Control.CURSOR_ARROW, "Standalone UI setup should initialize the build menu button with the default cursor.")
	_assert(ui_init_probe._build_option_buttons.size() == 1 and ui_init_probe._build_option_buttons[0].disabled, "Standalone UI setup should initialize detailed tower options as disabled.")
	_assert(ui_init_probe._compact_build_option_buttons.size() == 1 and ui_init_probe._compact_build_option_buttons[0].disabled, "Standalone UI setup should initialize compact tower options as disabled.")
	_assert(ui_init_probe.level_clear_next_button.disabled, "Standalone UI setup should initialize the level-clear next button as disabled.")
	_assert(ui_init_probe.level_clear_next_button.mouse_default_cursor_shape == Control.CURSOR_ARROW, "Standalone UI setup should initialize the level-clear next button with the default cursor.")
	_assert(not ui_init_probe.has_signal("reward_card_used"), "Card UI should not expose the removed click-to-use reward-card signal.")
	_assert(not ui_init_probe.has_method("_on_reward_card_use_pressed"), "Card UI should not keep the removed click-to-use reward-card callback.")
	_assert(not ui_init_probe.has_method("animate_card_consumed"), "Card UI should not expose the removed standalone card-consume animation entry.")
	_assert(not ui_init_probe.has_method("_play_card_used_animation"), "Card UI should not keep the removed standalone card-used animation callback.")
	ui_init_probe.queue_free()
	await process_frame

	var main_init_probe := Main.new()
	_assert(main_init_probe._message == main_init_probe._get_start_screen_message_text(), "Main initial message should use the start-screen message helper.")
	_assert(Main.GRID_SIZE == 64, "主逻辑网格必须是64px，才能容纳64px炮塔。")
	_assert(BuildManager.GRID_SIZE == 64, "建造逻辑网格必须是64px，避免炮塔溢出格子。")
	_assert(MapRenderer.GRID_SIZE == 64, "地图渲染网格必须是64px，保证视觉格子和建造格一致。")
	var build_grid_probe := BuildManager.new()
	_assert(build_grid_probe.grid_to_center(Vector2i(0, 0)) == Vector2(32.0, 96.0), "64px格子的第一格中心应位于炮塔模型中心。")
	_assert(build_grid_probe.world_to_grid(Vector2(63.0, 127.0)) == Vector2i(0, 0), "64px格子边界内的坐标应仍属于第一格。")
	build_grid_probe.queue_free()
	main_init_probe.queue_free()
	var tower_text_probe := Tower.new()
	_assert(tower_text_probe._format_upgrade_preview_text(2, "强化核心") == "等级2：强化核心", "Tower upgrade preview formatter should use localized text.")
	_assert(tower_text_probe._format_augmentation_trait_line_text("增幅塔") == "\n增幅：增幅塔", "Tower augmentation formatter should use localized text.")
	_assert(tower_text_probe._format_basic_level_two_trait_text() == "强化核心：射程扩大，装填加快", "Basic tower level-2 trait helper should use localized text.")
	_assert(tower_text_probe._format_basic_level_three_trait_text() == "过载中枢：高伤害高射程均衡压制", "Basic tower level-3 trait helper should use localized text.")
	_assert(tower_text_probe._format_rapid_level_two_trait_text() == "双联枪管：每次攻击发射两枚弹丸", "Rapid tower level-2 trait helper should use localized text.")
	_assert(tower_text_probe._format_rapid_level_three_trait_text() == "三联齐射：三枚弹丸形成高速弹幕", "Rapid tower level-3 trait helper should use localized text.")
	_assert(tower_text_probe._format_shotgun_level_two_trait_text() == "扩容弹仓：更宽扇形和更多弹丸", "Shotgun tower level-2 trait helper should use localized text.")
	_assert(tower_text_probe._format_shotgun_level_three_trait_text() == "碎星齐射：高密度近距覆盖", "Shotgun tower level-3 trait helper should use localized text.")
	_assert(tower_text_probe._format_cannon_level_two_trait_text() == "爆破弹头：爆破半径扩大，溅射伤害提高", "Cannon tower level-2 trait helper should use localized text.")
	_assert(tower_text_probe._format_cannon_level_three_trait_text() == "震荡核心：大范围高强度溅射炮击", "Cannon tower level-3 trait helper should use localized text.")
	_assert(tower_text_probe._format_sniper_level_two_trait_text() == "校准透镜：极大提高单发伤害和射程", "Sniper tower level-2 trait helper should use localized text.")
	_assert(tower_text_probe._format_sniper_level_three_trait_text() == "处决射击：对低生命敌人造成致命伤害", "Sniper tower level-3 trait helper should use localized text.")
	tower_text_probe.queue_free()

	var game := main_scene.instantiate() as Main
	_assert(game != null, "Main scene should instantiate as Main.")
	root.add_child(game)
	await process_frame
	await process_frame

	_assert(not game.has_method("_on_reward_card_used"), "Main should not keep the removed click-to-use reward-card callback.")
	_assert(game.level_configs.size() >= 10, "Game should define at least ten levels.")
	_assert(int(game.level_configs[9].get("cols", 0)) > int(game.level_configs[0].get("cols", 0)), "Later levels should use wider maps.")
	_assert(int(game.level_configs[9].get("rows", 0)) > int(game.level_configs[0].get("rows", 0)), "Later levels should use taller maps.")
	_assert(int(game.level_configs[9].get("start_gold", 0)) > int(game.level_configs[0].get("start_gold", 0)), "Later levels should define a higher starting gold baseline.")
	_assert((game.level_configs[9].get("theme", {}) as Dictionary) != (game.level_configs[0].get("theme", {}) as Dictionary), "Later levels should use different scene themes.")
	_assert(str(game.level_configs[9].get("description", "")).contains("48x24"), "Level descriptions should be localized and mention large map size.")
	_assert(game._get_level_display_name({"name": "  测试关卡  "}) == "测试关卡", "Main should trim level display names through a shared helper.")
	_assert(game._get_level_display_name({"name": ""}) == "未命名关卡", "Main should provide a localized fallback level display name.")
	_assert(game._get_default_level_display_name() == "未命名关卡", "Main default level display-name helper should use localized text.")
	_assert(game._get_tower_type_display_name("basic") == "基础塔", "Main should expose localized tower display names through a shared helper.")
	game.tower_configs["display_probe"] = {"id": "display_probe", "name": "  "}
	_assert(game._get_tower_type_display_name("display_probe") == "防御塔", "Main should provide a localized fallback tower display name.")
	_assert(game._get_default_tower_display_name() == "防御塔", "Main default tower display-name helper should use localized text.")
	game.tower_configs.erase("display_probe")
	_assert(game._format_current_level_message_text(2, "双折道") == "第2关：双折道", "Main level message formatter should use localized level text.")
	_assert(game._format_locked_level_message_text(4) == "第4关尚未解锁，请先通关前置关卡。", "Main locked-level message formatter should use localized text.")
	_assert(game._format_wave_started_message_text(3, 2) == "第3关第2波已开始。", "Main wave-start message formatter should use localized text.")
	_assert(game._get_wave_start_blocked_message_text() == "暂时不能开始新一波。", "Main wave-start blocked message helper should use localized text.")
	_assert(game._format_tower_locked_message_text("狙击塔", 4) == "狙击塔 将在第4关解锁。", "Main tower-locked message formatter should use localized text.")
	_assert(game._get_pause_message_text() == "游戏已暂停。" and game._get_resume_message_text() == "游戏继续。", "Main pause/resume message helpers should use localized text.")
	_assert(game._format_level_restart_message_text(5) == "第5关已重新开始。", "Main restart message formatter should use localized text.")
	_assert(game._get_start_screen_message_text() == "建造防御塔，然后开始第一波进攻。", "Main start-screen message helper should use localized text.")
	_assert(game._format_wave_spawn_finished_message_text(2) == "第2波敌人已出动，清空敌人可获得卡牌。", "Main wave-spawn-finished formatter should use localized text.")
	_assert(game._get_final_wave_spawn_finished_message_text() == "最终波已出动，清空所有敌人。", "Main final-wave message helper should use localized text.")
	_assert(game._format_gold_reward_message_text(12) == "金币+12。", "Main gold reward message formatter should use localized text.")
	_assert(game._format_base_damage_message_text(3) == "基地受到3点伤害。", "Main base-damage message formatter should use localized text.")
	_assert(game._format_elite_stun_message_text(2) == "精英怪爆炸，眩晕2座炮塔。", "Main elite-stun message formatter should use localized text.")
	_assert(game._format_level_complete_message_text(6) == "第6关已完成，可以进入下一关。", "Main level-complete message formatter should use localized text.")
	_assert(game._format_intermission_message_text(3, 4.75) == "第3波已清空，下一波将在4.8秒后开始。", "Main intermission message formatter should use localized text.")
	_assert(game._format_auto_wave_started_message_text(4, 5) == "第4关第5波自动开始。", "Main auto-wave message formatter should use localized text.")
	_assert(game._get_auto_wave_blocked_message_text() == "自动波次暂时无法开始。", "Main auto-wave blocked message helper should use localized text.")
	_assert(game._format_reward_card_console_text("超频核心") == "获得奖励卡牌：超频核心", "Main reward-card console formatter should use localized text.")
	_assert(game._format_reward_card_stored_message_text("超频核心") == "已存入奖励卡牌：超频核心。", "Main stored-card message formatter should use localized text.")
	_assert(game._format_reward_card_hand_full_message_text("超频核心") == "手牌已满，请丢弃一张来保留超频核心。", "Main full-hand message formatter should use localized text.")
	_assert(game._get_pending_card_blocks_play_message_text().contains("不能先使用旧卡"), "Main pending-card play-block helper should use localized text.")
	_assert(game._format_reward_card_replaced_message_text("战地维修", "超频核心") == "已丢弃战地维修，并保留超频核心。", "Main card replacement message formatter should use localized text.")
	_assert(game._get_pending_card_rejected_message_text() == "已放弃新卡牌。", "Main pending-card reject helper should use localized text.")
	_assert(game._get_pending_card_timeout_message_text() == "新卡牌超时，已自动丢弃。", "Main pending-card timeout helper should use localized text.")
	_assert(game._get_pending_card_blocks_sell_message_text().contains("不能先出售旧卡"), "Main pending-card sell-block helper should use localized text.")
	_assert(game._format_reward_card_sold_message_text(28) == "已出售卡牌，金币+28。", "Main card-sold message formatter should use localized text.")
	_assert(game._format_damage_boost_card_message_text(2, 10.0) == "卡牌生效：2座塔在10秒内伤害提高。", "Main damage-boost card message formatter should use localized text.")
	_assert(game._format_range_boost_card_message_text(2, 12.0) == "卡牌生效：2座塔在12秒内射程提高。", "Main range-boost card message formatter should use localized text.")
	_assert(game._format_fire_rate_boost_card_message_text(2, 8.0) == "卡牌生效：2座塔在8秒内攻速提高。", "Main fire-rate card message formatter should use localized text.")
	_assert(game._format_heal_card_message_text(6) == "卡牌生效：基地修复6点生命。", "Main heal-card message formatter should use localized text.")
	_assert(game._get_missile_card_empty_message_text() == "导弹目标区域内没有敌人。", "Main missile-empty message helper should use localized text.")
	_assert(game._format_missile_card_hit_message_text(3) == "卡牌生效：导弹命中3个敌人。", "Main missile-hit message formatter should use localized text.")
	_assert(game._get_cryo_card_empty_message_text() == "冷冻地雷目标区域内没有敌人。", "Main cryo-empty message helper should use localized text.")
	_assert(game._format_cryo_card_hit_message_text(4) == "卡牌生效：冷冻地雷影响4个敌人。", "Main cryo-hit message formatter should use localized text.")
	_assert(game._get_firestorm_card_empty_message_text() == "全屏火焰没有可攻击的敌人。", "Main firestorm-empty message helper should use localized text.")
	_assert(game._format_firestorm_card_hit_message_text(5) == "卡牌生效：全屏火焰灼烧5个敌人。", "Main firestorm-hit message formatter should use localized text.")
	_assert(game._get_global_freeze_card_empty_message_text() == "冻结全屏没有可影响的敌人。", "Main freeze-empty message helper should use localized text.")
	_assert(game._format_global_freeze_card_hit_message_text(6) == "卡牌生效：冻结全屏影响6个敌人。", "Main freeze-hit message formatter should use localized text.")
	_assert(game._format_gold_card_message_text(85) == "卡牌生效：金币+85。", "Main gold-card message formatter should use localized text.")
	_assert(game._format_risky_cache_success_message_text(180) == "不稳定补给成功：金币+180。", "Main risky-cache success formatter should use localized text.")
	_assert(game._format_risky_cache_failure_message_text(35, 1) == "不稳定补给失稳：金币+35，基地受1点伤害。", "Main risky-cache failure formatter should use localized text.")
	_assert(game._format_fortify_card_message_text(2, 4) == "卡牌生效：基地生命上限+2，并修复4点。", "Main fortify-card message formatter should use localized text.")
	_assert(game._get_bait_beacon_card_empty_message_text() == "诱饵信标附近没有敌人。", "Main bait beacon empty helper should use localized text.")
	_assert(game._format_bait_beacon_card_hit_message_text(3) == "卡牌生效：诱饵信标牵引3个敌人。", "Main bait beacon hit formatter should use localized text.")
	_assert(game._get_road_spikes_card_message_text() == "卡牌生效：尖刺路障已部署。", "Main road spikes helper should use localized text.")
	_assert(game._format_coin_magnet_card_message_text(12.0, 45) == "卡牌生效：12秒内击杀金币提高45%。", "Main coin magnet formatter should use localized text.")
	_assert(game._get_time_warp_card_empty_message_text() == "时间裂隙没有影响到敌人。", "Main time warp empty helper should use localized text.")
	_assert(game._format_time_warp_card_hit_message_text(4) == "卡牌生效：时间裂隙扭曲4个敌人。", "Main time warp hit formatter should use localized text.")
	_assert(game._get_tower_swap_card_empty_message_text() == "塔位调度需要释放在防御塔附近。", "Main tower swap empty helper should use localized text.")
	_assert(game._get_tower_swap_card_hit_message_text() == "卡牌生效：目标防御塔进入调度状态。", "Main tower swap hit helper should use localized text.")
	_assert(game._format_overload_debt_card_message_text(5.0) == "卡牌生效：全塔透支超频5秒，之后会短暂降速。", "Main overload debt formatter should use localized text.")
	_assert(game._get_panic_button_card_message_text() == "紧急按钮启动：基地获得战场缓冲。", "Main panic button helper should use localized text.")
	_assert(game._get_bounty_mark_card_empty_message_text() == "悬赏标记范围内没有敌人。", "Main bounty empty helper should use localized text.")
	_assert(game._format_bounty_mark_card_hit_message_text("重甲兵", 120) == "卡牌生效：已悬赏重甲兵，击杀额外+120金币。", "Main bounty formatter should use localized text.")
	_assert(game._get_reroll_cache_card_empty_message_text() == "战术改签需要至少一张旧手牌。", "Main reroll empty helper should use localized text.")
	_assert(game._get_reroll_cache_card_message_text() == "卡牌生效：已改签最左侧手牌。", "Main reroll helper should use localized text.")
	_assert(game._get_unknown_reward_card_message_text() == "未知卡牌。", "Main unknown-card message helper should use localized text.")
	_assert(game._get_victory_message_text() == "胜利！所有关卡已清空。", "Main victory message helper should use localized text.")
	_assert(game._get_victory_title_text() == "胜利" and game._get_victory_subtitle_text().contains("所有关卡已完成"), "Main victory overlay text helpers should use localized text.")
	_assert(game._get_defeat_message_text() == "失败，基地已被摧毁。", "Main defeat message helper should use localized text.")
	_assert(game._get_defeat_title_text() == "失败" and game._get_defeat_subtitle_text().contains("基地已经失守"), "Main defeat overlay text helpers should use localized text.")
	_assert(game._get_console_game_started_response_text() == "游戏已开始。", "Main console start helper should use localized text.")
	_assert(game._get_console_game_already_started_response_text() == "游戏已经开始。", "Main console already-started helper should use localized text.")
	_assert(game._get_console_wave_requested_response_text() == "已请求开始波次。", "Main console wave helper should use localized text.")
	_assert(game._format_console_level_loaded_response_text(7) == "已载入第7关。", "Main console level-load formatter should use localized text.")
	_assert(game._get_console_next_level_requested_response_text() == "已请求进入下一关。", "Main console next-level helper should use localized text.")
	_assert(game._format_console_gold_added_message_text(25) == "调试：增加25金币。", "Main console gold-added message formatter should use localized text.")
	_assert(game._format_console_gold_added_response_text(25, 175) == "金币增加25，当前175。", "Main console gold-added response formatter should use localized text.")
	_assert(game._format_console_gold_set_message_text(90) == "调试：金币设置为90。", "Main console gold-set message formatter should use localized text.")
	_assert(game._format_console_gold_set_response_text(90) == "金币已设置为90。", "Main console gold-set response formatter should use localized text.")
	_assert(game._format_console_base_health_response_text(12, 20) == "基地生命：12/20", "Main console base-health formatter should use localized text.")
	_assert(game._format_console_base_healed_message_text(4) == "调试：基地修复4点。", "Main console heal message formatter should use localized text.")
	_assert(game._get_console_base_health_set_message_text() == "调试：基地生命已设置。", "Main console base-health set helper should use localized text.")
	_assert(game._format_console_enemy_spawned_message_text(3, "疾行者") == "调试：生成3个疾行者。", "Main console spawn message formatter should use localized text.")
	_assert(game._format_console_enemy_spawned_response_text(3, "疾行者") == "已生成3个疾行者。", "Main console spawn response formatter should use localized text.")
	_assert(game._get_console_enemies_cleared_message_text() == "调试：敌人已清空。", "Main console clear message helper should use localized text.")
	_assert(game._get_console_clear_response_text() == "敌人和子弹已清空。", "Main console clear response helper should use localized text.")
	_assert(game._format_console_reward_card_created_response_text("超频核心") == "已创建奖励卡牌：超频核心", "Main console card-create formatter should use localized text.")
	_assert(game._get_console_no_stored_card_response_text() == "没有已存储的卡牌。", "Main console empty-card helper should use localized text.")
	_assert(game._get_console_card_used_response_text() == "卡牌已使用。", "Main console card-used helper should use localized text.")
	_assert(game._get_console_card_unavailable_response_text() == "卡牌暂时无法使用。", "Main console card-unavailable helper should use localized text.")
	_assert(game._get_console_victory_triggered_response_text() == "胜利动画已触发。", "Main console victory helper should use localized text.")
	_assert(game._get_console_defeat_triggered_response_text() == "失败动画已触发。", "Main console defeat helper should use localized text.")
	_assert(game._get_console_reload_response_text() == "正在重载场景。", "Main console reload helper should use localized text.")
	_assert(game._format_console_status_response_text(2, 10, 160, 18, 20, 3, 5, 4, true, 1.24, false) == "当前状态：第2/10关，金币160，基地生命18/20，波次3/5，敌人4个，自动波次是，间隔1.2秒，游戏结束否。", "Main console status formatter should use localized sentence text.")
	_assert(game._format_console_unknown_command_response_text("bad") == "未知命令：bad。输入 help 查看可用命令。", "Main console unknown-command formatter should use localized text.")
	_assert(game._format_console_base_damaged_message_text(2) == "调试：基地受到2点伤害。", "Main console damage message formatter should use localized text.")
	_assert(game._get_reward_card_display_name({"name": "  测试卡  "}) == "测试卡", "Main should trim reward-card display names through a shared helper.")
	_assert(game._get_reward_card_display_name({"id": "heal"}) == "战地维修", "Main should resolve default reward-card names from card ids.")
	_assert(game._get_reward_card_display_name({"name": ""}) == "卡牌", "Main should provide a localized fallback reward-card display name.")
	_assert(game._get_default_reward_card_display_name() == "卡牌", "Main default reward-card display-name helper should use localized text.")
	_assert(game._get_level_map_size({"cols": 1, "rows": -4}) == Vector2i(30, 15), "Main should clamp invalid level map sizes to the base grid.")
	_assert(game._get_level_map_size({"cols": 48, "rows": 24}) == Vector2i(48, 24), "Main should preserve valid large level map sizes.")
	var sanitized_level_theme := game._get_level_theme({
		"theme": {
			"field_a": Color(0.1, 0.2, 0.3),
			"road": "invalid",
			"unused": Color(1.0, 0.0, 0.0),
		}
	})
	_assert(sanitized_level_theme.has("field_a") and sanitized_level_theme["field_a"] is Color, "Main should preserve valid level theme colors.")
	_assert(not sanitized_level_theme.has("road") and not sanitized_level_theme.has("unused"), "Main should discard invalid or unknown level theme entries.")
	_assert(game._get_level_theme({"theme": "invalid"}).is_empty(), "Main should ignore non-dictionary level theme configs.")
	var normalized_level_resources: Dictionary = game._get_level_resources({
		"start_gold": 260,
		"base_health": 24,
		"level_bonus_gold": 90,
		"repair": 5,
	})
	_assert(int(normalized_level_resources["start_gold"]) == 260 and int(normalized_level_resources["base_health"]) == 24, "Main should preserve valid level starting resources.")
	_assert(int(normalized_level_resources["level_bonus_gold"]) == 90 and int(normalized_level_resources["repair"]) == 5, "Main should preserve valid carry-over level resources.")
	var fallback_level_resources: Dictionary = game._get_level_resources({
		"start_gold": -10,
		"base_health": 0,
		"level_bonus_gold": -3,
		"repair": -2,
	})
	_assert(int(fallback_level_resources["start_gold"]) == 0, "Main should clamp invalid level starting gold to zero.")
	_assert(int(fallback_level_resources["base_health"]) == 1, "Main should keep level base health at least one.")
	_assert(int(fallback_level_resources["level_bonus_gold"]) == 0 and int(fallback_level_resources["repair"]) == 0, "Main should clamp invalid carry-over resources to zero.")
	_assert(game._get_level_wave_count({"waves": 9}) == 9, "Main should preserve valid level wave counts.")
	_assert(game._get_level_wave_count({"waves": 0}) == 1, "Main should keep level wave counts at least one.")
	var normalized_level_enemy_types := game._get_level_enemy_types({"enemy_types": ["runner", "", 42, "runner", "brute"]})
	_assert(normalized_level_enemy_types == ["runner", "42", "brute"], "Main should normalize level enemy type ids before wave setup.")
	var fallback_level_enemy_types := game._get_level_enemy_types({"enemy_types": []})
	_assert(fallback_level_enemy_types == ["grunt"], "Main should fallback empty level enemy type lists to grunt.")
	var normalized_routes := game._get_level_routes({
		"routes": [
			[Vector2i(0, 0), Vector2i(2, 0)],
			[],
			"invalid",
			[Vector2i(1, 1)],
			[Vector2(3.0, 2.0), Vector2(5.0, 2.0)],
		]
	})
	_assert(normalized_routes.size() == 2, "Main should discard invalid or incomplete route configs.")
	_assert(normalized_routes[0] == [Vector2i(0, 0), Vector2i(2, 0)], "Main should keep valid Vector2i route configs.")
	_assert(normalized_routes[1] == [Vector2i(3, 2), Vector2i(5, 2)], "Main should convert Vector2 route points to grid cells.")
	_assert(game._get_reward_card_pool().size() == 20, "Reward card pool should contain exactly twenty card types.")
	_assert(_reward_card_ids_are_unique(game), "Reward card ids should be unique across the twenty-card pool.")
	_assert(_reward_card_rarities_are_valid(game), "Every reward card should declare one of the five effect rarity tiers.")
	_assert(_reward_card_icons_are_localized(game), "Reward card icons should not use English abbreviations or currency symbols.")
	_assert(game._reward_card_uses_strength_roll(game._get_reward_card_definition("tower_boost")), "Multiplier-based reward cards should roll strength when drawn.")
	_assert(game._reward_card_uses_strength_roll(game._get_reward_card_definition("cryo")), "Slow multiplier reward cards should roll strength when drawn.")
	_assert(not game._reward_card_uses_strength_roll(game._get_reward_card_definition("missile")), "Fixed-effect attack cards should keep one strength class.")
	_assert(not game._reward_card_uses_strength_roll(game._get_reward_card_definition("heal")), "Fixed-effect utility cards should keep one strength class.")
	var rolled_boost_card := game._roll_reward_card_strength(game._get_reward_card_definition("tower_boost").duplicate(true), 1)
	_assert(float(rolled_boost_card.get("strength_multiplier", 0.0)) >= 1.0, "Rolled strength cards should store their strength multiplier.")
	_assert(_is_valid_reward_card_rarity(str(rolled_boost_card.get("rarity", ""))), "Rolled strength cards should use a valid rarity color tier.")
	var rolled_missile_card := game._roll_reward_card_strength(game._get_reward_card_definition("missile").duplicate(true), 1)
	_assert(not rolled_missile_card.has("strength_multiplier"), "Fixed-effect cards should not receive a draw-time strength multiplier.")
	_assert(str(rolled_missile_card.get("rarity", "")) == "purple", "Fixed-effect cards should keep their authored strength color.")
	var base_missile_card := game._get_reward_card_definition("missile")
	var scaled_missile_card := game._normalize_reward_card(base_missile_card)
	_assert(int(scaled_missile_card.get("damage", 0)) > int(base_missile_card.get("damage", 0)), "Higher rarity attack cards should scale damage above their base values.")
	_assert(int(base_missile_card.get("damage", 0)) >= 270, "Missile cards should have the strengthened base damage.")
	_assert(int(game._get_reward_card_definition("firestorm").get("damage", 0)) >= 135, "Firestorm cards should have the strengthened base damage.")
	var base_freeze_card := game._get_reward_card_definition("global_freeze")
	var scaled_freeze_card := game._normalize_reward_card(base_freeze_card)
	_assert(float(scaled_freeze_card.get("slow_multiplier", 1.0)) < float(base_freeze_card.get("slow_multiplier", 1.0)), "Higher rarity control cards should strengthen slow effects.")
	_assert(game.current_level_index == 0, "Game should start on level 1.")
	_assert(game.path_points.size() > 2, "Level should generate a pathfinding path.")
	_assert(game.spawn_paths.size() == 1, "Level 1 should have one spawn route.")
	_assert(game.spawn_path_lengths.size() == game.spawn_paths.size(), "Level should cache one length per spawn route.")
	_assert(game.road_cells.size() >= game.path_points.size(), "Level should expose road cells for build blocking.")
	game.gold = Main.MAX_GOLD - 5
	game.add_gold(1000)
	_assert(game.gold == Main.MAX_GOLD, "Gold should be capped at the maximum bank size.")
	game.gold = Main.INITIAL_GOLD
	_assert(game.map_layer != null, "Game should create a dedicated static map layer.")
	_assert(game.world_decal_layer != null, "Game should create a dedicated world decal layer.")
	_assert(game.impact_layer != null, "Game should create a dedicated impact effect layer.")
	_assert(game.world_overlay_layer != null, "Game should create a dedicated world overlay layer.")
	_assert(game.map_layer.z_index == Main.WORLD_LAYER_MAP, "Static map layer should use the shared world layer constant.")
	_assert(game.map_layer.z_index < game.world_decal_layer.z_index, "Static map layer should render behind base decals.")
	_assert(game.world_decal_layer.z_index < game.tower_layer.z_index and game.tower_layer.z_index < game.enemy_layer.z_index, "Base decals, towers, and enemies should have deterministic depth order.")
	_assert(game.enemy_layer.z_index < game.projectile_layer.z_index and game.projectile_layer.z_index < game.impact_layer.z_index, "Enemies, projectiles, and impacts should have deterministic depth order.")
	_assert(game.impact_layer.z_index < game.particle_layer.z_index and game.particle_layer.z_index < game.world_overlay_layer.z_index, "Impact, particle, and world overlay layers should have deterministic depth order.")
	_assert(game.build_manager.z_index > game.world_overlay_layer.z_index, "Build preview should render above world skill overlays.")
	_assert(not game.has_method("_draw_ground_tiles"), "Main should not keep the old static ground drawing method.")
	_assert(not game.has_method("_draw_grid"), "Main should not keep the old static grid drawing method.")
	_assert(not game.has_method("_draw_path"), "Main should not keep the old static path drawing method.")
	_assert(not game.has_method("_draw_base"), "Main should not keep the old base drawing method after moving decals into WorldDecalRenderer.")
	_assert(not game.has_method("_draw_road_spike_traps"), "Main should not keep the old road-spike drawing method after moving decals into WorldDecalRenderer.")
	_assert(not game.has_method("_draw_missile_effect"), "Main should not keep the old card-area drawing method after moving overlays into WorldOverlayRenderer.")
	_assert(not game.has_method("_parse_grid_key"), "Main should not keep the old draw-only grid key parser.")
	var cached_road_cells: Array = game.map_layer.get("_cached_road_cells")
	var cached_route_paths: Array = game.map_layer.get("_cached_route_paths")
	var cached_ground_rects: Array = game.map_layer.get("_cached_ground_rects")
	var cached_ground_colors: Array = game.map_layer.get("_cached_ground_colors")
	var cached_pebble_rects: Array = game.map_layer.get("_cached_pebble_rects")
	var cached_grid_lines: PackedVector2Array = game.map_layer.get("_cached_grid_lines")
	var cached_road_edge_rects: Array = game.map_layer.get("_cached_road_edge_rects")
	_assert(cached_road_cells.size() == game.road_cells.size(), "Map renderer should cache road cells for static drawing.")
	_assert(cached_route_paths.size() == game.spawn_paths.size(), "Map renderer should cache route polylines for static drawing.")
	_assert(cached_ground_rects.size() == game.map_cols * game.map_rows, "Map renderer should cache one ground rect per map tile.")
	_assert(cached_ground_colors.size() == cached_ground_rects.size(), "Map renderer should cache ground tile colors alongside rects.")
	_assert(not cached_pebble_rects.is_empty(), "Map renderer should cache decorative ground pebble rects.")
	_assert(cached_grid_lines.size() == (game.map_cols + 1 + game.map_rows + 1) * 2, "Map renderer should cache grid line point pairs.")
	_assert(cached_road_edge_rects.size() == game.road_cells.size(), "Map renderer should cache road rects for static drawing.")
	_assert(game.particle_layer != null, "Game should create a world particle layer.")
	var cleanup_probe := game.spawn_particle_burst(Vector2.ZERO, {
		"name": "ParticleCleanupProbe",
		"amount": 1,
		"lifetime": 0.05,
	})
	_assert(cleanup_probe != null, "Particle burst helper should return the spawned particle node.")
	_assert(game.get_world_particle_count() == 1, "World particle count should cache spawned particle nodes.")
	await create_timer(0.35).timeout
	_assert(not is_instance_valid(cleanup_probe), "Particle burst nodes should self-clean after finishing.")
	_assert(game.get_world_particle_count() == 0, "World particle count should update when particles self-clean.")
	var default_particle := game.spawn_particle_burst(Vector2.ZERO)
	_assert(default_particle != null, "Default particle burst config should still spawn.")
	_assert(default_particle.direction == Vector2.UP, "Default particle burst direction should use the cached default direction.")
	_assert(default_particle.gravity == Vector2(0.0, 260.0), "Default particle burst gravity should use the cached default gravity.")
	default_particle.queue_free()
	await process_frame
	var named_particle := game.spawn_particle_burst(Vector2.ZERO, {
		"name": "  ParticleNameProbe_1  ",
		"amount": 1,
		"lifetime": 0.05,
	})
	_assert(named_particle.name == "ParticleNameProbe_1", "Particle burst node names should trim valid English logic names.")
	named_particle.queue_free()
	await process_frame
	var invalid_named_particle := game.spawn_particle_burst(Vector2.ZERO, {
		"name": "粒子节点",
		"amount": 1,
		"lifetime": 0.05,
	})
	_assert(invalid_named_particle.name == "ParticleBurst", "Particle burst node names should fall back when config names are not English logic names.")
	invalid_named_particle.queue_free()
	await process_frame
	var impact_effect_probe: Node = load("res://scripts/ImpactEffect.gd").spawn(game.particle_layer, Vector2.ZERO, {
		"name": "CannonImpactEffectProbe",
		"profile": "cannon",
		"radius": 64.0,
		"duration": 0.05,
		"color": Color(1.0, 0.58, 0.22),
	})
	_assert(impact_effect_probe != null and str(impact_effect_probe.get("profile")) == "cannon", "Impact effect helper should spawn typed tower combat effects.")
	_assert(is_equal_approx(float(impact_effect_probe.get("radius")), 64.0), "Impact effect helper should preserve the requested visual radius.")
	await create_timer(0.16).timeout
	_assert(not is_instance_valid(impact_effect_probe), "Impact effect nodes should self-clean after their duration.")
	var ui_particle_config: Dictionary = game.ui._ui_particle_config
	game.ui._spawn_ui_particles(Vector2(24.0, 24.0), Color(0.24, 0.76, 0.72), 5, 20.0, "UIParticleCacheProbe")
	_assert(is_same(ui_particle_config, game.ui._ui_particle_config), "UI particles should reuse a cached config dictionary.")
	_assert(str(game.ui._ui_particle_config.get("name", "")) == "UIParticleCacheProbe", "UI particle config should update the effect name.")
	_assert(int(game.ui._ui_particle_config.get("amount", 0)) == 5, "UI particle config should update the amount.")
	game.ui._spawn_ui_particles(Vector2(24.0, 24.0), Color(0.42, 1.0, 0.62), 42, 72.0, "LevelClearParticles")
	var level_clear_ui_lifetime := float(game.ui._ui_particle_config.get("lifetime", 0.0))
	var level_clear_ui_gravity: Vector2 = game.ui._ui_particle_config.get("gravity", Vector2.ZERO)
	_assert(game.ui._ui_particle_config.get("direction") == Vector2.UP, "Level clear UI particles should rise like a celebration.")
	_assert(level_clear_ui_gravity.y < 0.0, "Level clear UI particles should not use the default falling burst.")
	game.ui._spawn_ui_particles(Vector2(24.0, 24.0), Color(0.88, 0.22, 0.18), 18, 28.0, "CardDiscardParticles")
	var discard_ui_gravity: Vector2 = game.ui._ui_particle_config.get("gravity", Vector2.ZERO)
	_assert(game.ui._ui_particle_config.get("direction") == Vector2.DOWN, "Discard UI particles should fall away from the hand.")
	_assert(discard_ui_gravity.y > 0.0, "Discard UI particles should use downward gravity.")
	_assert(not is_equal_approx(float(game.ui._ui_particle_config.get("lifetime", 0.0)), level_clear_ui_lifetime), "Discard and level-clear particles should use different timing.")
	game.ui._spawn_ui_particles(Vector2(24.0, 24.0), Color(0.38, 0.95, 0.54), 86, 150.0, "VictoryOverlayParticles")
	_assert(game.ui._ui_particle_config.get("direction") == Vector2.UP, "Victory overlay particles should lift upward.")
	game.ui._spawn_ui_particles(Vector2(24.0, 24.0), Color(1.0, 0.28, 0.18), 86, 150.0, "DefeatOverlayParticles")
	_assert(game.ui._ui_particle_config.get("direction") == Vector2.DOWN, "Defeat overlay particles should collapse downward.")
	for ui_particle in game.ui.ui_root.get_children():
		if ui_particle is CPUParticles2D:
			ui_particle.queue_free()
	await process_frame
	var muzzle_config: Dictionary = game._muzzle_particle_config
	game.spawn_muzzle_particles(Vector2(12.0, 12.0), Vector2.RIGHT, Color(0.32, 0.60, 0.86))
	_assert(is_same(muzzle_config, game._muzzle_particle_config), "Muzzle particles should reuse a cached config dictionary.")
	_assert(game._muzzle_particle_config.get("direction") == Vector2.RIGHT, "Muzzle particle config should update per-shot direction.")
	for muzzle_particle in game.particle_layer.get_children():
		muzzle_particle.queue_free()
	await process_frame
	_assert(game.get_world_particle_count() == 0, "World particle count should update after clearing cached-config muzzle particles.")
	var level_clear_world_particle := game.spawn_level_clear_particles(Vector2(18.0, 18.0))
	_assert(level_clear_world_particle != null and level_clear_world_particle.name == "LevelClearWorldParticles", "Level-clear world feedback should use its own particle effect.")
	_assert(level_clear_world_particle.direction == Vector2.UP and level_clear_world_particle.gravity.y < 0.0, "Level-clear world particles should rise instead of matching enemy death bursts.")
	var victory_world_particle := game.spawn_screen_particles(true)
	var defeat_world_particle := game.spawn_screen_particles(false)
	_assert(victory_world_particle != null and victory_world_particle.name == "VictoryScreenParticles", "Victory should use a dedicated world particle effect.")
	_assert(defeat_world_particle != null and defeat_world_particle.name == "DefeatScreenParticles", "Defeat should use a dedicated world particle effect.")
	_assert(victory_world_particle.direction == Vector2.UP and defeat_world_particle.direction == Vector2.DOWN, "Victory and defeat world particles should move in different directions.")
	var missile_particle_config: Dictionary = game._get_area_particle_config("MissileCardParticles", 96.0, Color(1.0, 0.46, 0.14), 56)
	var cryo_particle_config: Dictionary = game._get_area_particle_config("CryoCardParticles", 96.0, Color(0.46, 0.86, 1.0), 56)
	var firestorm_particle_config: Dictionary = game._get_area_particle_config("FirestormParticles", 180.0, Color(1.0, 0.30, 0.12), 72)
	var road_spikes_particle_config: Dictionary = game._get_area_particle_config("RoadSpikesParticles", 52.0, Color(0.95, 0.62, 0.28), 18)
	var coin_particle_config: Dictionary = game._get_area_particle_config("CoinMagnetParticles", 88.0, Color(1.0, 0.86, 0.24), 44)
	var coin_particle_gravity: Vector2 = coin_particle_config.get("gravity", Vector2.ZERO)
	_assert(str(missile_particle_config.get("name", "")) == "MissileCardParticles", "Missile cards should use a named explosive particle profile.")
	_assert(float(missile_particle_config.get("velocity_max", 0.0)) > float(cryo_particle_config.get("velocity_max", 0.0)), "Missile particles should move faster than cryo particles.")
	_assert(firestorm_particle_config.get("direction") == Vector2.DOWN, "Firestorm particles should fall like a screen-wide strike.")
	_assert(road_spikes_particle_config.get("direction") == Vector2.DOWN and float(road_spikes_particle_config.get("lifetime", 0.0)) < 0.5, "Road spike particles should be short downward debris.")
	_assert(coin_particle_config.get("direction") == Vector2.UP and coin_particle_gravity.y < 0.0, "Coin particles should lift upward instead of using generic area bursts.")
	for world_particle in game.particle_layer.get_children():
		if world_particle is CPUParticles2D:
			world_particle.queue_free()
	await process_frame
	_assert(Projectile.TRAIL_INTERVAL_STANDARD >= 0.08, "Standard projectile trails should be throttled to reduce particle churn.")
	_assert(Enemy.STEP_PARTICLE_INTERVAL >= 0.25, "Enemy step particles should be throttled for crowded waves.")
	var cap_probe_enemy := Enemy.new()
	game.enemy_layer.add_child(cap_probe_enemy)
	for particle_index in range(Main.MAX_PARTICLE_NODES):
		game.spawn_particle_burst(Vector2.ZERO, {
			"name": "ParticleCapProbe",
			"amount": 1,
			"lifetime": 1.0,
		})
	var capped_particle_count := _count_particles(game.particle_layer)
	_assert(game.get_world_particle_count() == capped_particle_count, "World particle count cache should match live particle nodes before cap checks.")
	cap_probe_enemy._spawn_step_particles()
	_assert(_count_particles(game.particle_layer) == capped_particle_count, "Enemy ambient particles should respect the world particle cap.")
	_assert(game.get_world_particle_count() == capped_particle_count, "Rejected particle bursts should not change the particle count cache.")
	cap_probe_enemy.queue_free()
	for particle in game.particle_layer.get_children():
		particle.queue_free()
	await process_frame
	_assert(game.get_world_particle_count() == 0, "World particle count should clear after manually freeing particles.")
	_assert(not game.has_game_started, "Game should start behind the start screen.")
	_assert(game.ui.start_overlay.visible, "Start overlay should be visible on launch.")
	_assert(game.ui.start_overlay.get_node_or_null("TacticalBackground") != null, "Start overlay should render a tactical pixel background.")
	_assert(UpdateAnnouncements.get_recent_announcements().size() <= 5, "Player update announcements should keep only the latest five major entries.")
	_assert(not UpdateAnnouncements.get_latest_announcement_id().is_empty(), "Player update announcements should expose the latest announcement id.")
	_assert(game.ui.update_announcement_button != null, "Start overlay should expose a player-facing update announcement button.")
	_assert(game.ui.update_announcement_button.text == "更新公告", "Update announcement button should use localized player-facing text.")
	_assert(game.ui.continue_game_button != null, "Start overlay should expose a Continue Game button.")
	_assert(game.ui.continue_game_button.text == "继续游戏", "Continue Game button should use localized player-facing text.")
	_assert(game.ui.continue_game_button.disabled, "Continue Game should be disabled when no level-start save exists.")
	_assert(game.ui._update_announcements.size() == UpdateAnnouncements.get_recent_announcements().size(), "Game UI should receive recent player update announcements.")
	game.ui.show_latest_update_announcement(UpdateAnnouncements.get_recent_announcements()[0] as Dictionary)
	_assert(game.ui.is_update_announcement_popup_visible(), "Latest update announcement should open as a popup.")
	_assert(game.ui.update_announcement_popup_body.text.contains("首次打开"), "Latest update announcement popup should explain the visible player change.")
	game.ui.hide_update_announcement_popup(false)
	await create_timer(0.15).timeout
	_assert(not game.ui.is_update_announcement_popup_visible(), "Latest update announcement popup should close cleanly.")
	game.ui._on_update_announcement_pressed()
	_assert(game.ui.is_update_announcement_history_visible(), "Update announcement button should open the history panel.")
	_assert(game.ui.update_announcement_history_container.get_child_count() == UpdateAnnouncements.get_recent_announcements().size(), "Update announcement history should render recent major entries.")
	game.ui._on_update_announcement_history_close_pressed()
	await create_timer(0.15).timeout
	_assert(not game.ui.is_update_announcement_history_visible(), "Update announcement history should close cleanly.")
	_assert(game.ui.start_wave_button.disabled, "Start wave button should be disabled before Start Game.")
	_assert(game.ui.build_tower_button.disabled, "Tower menu should be disabled before Start Game.")
	_assert(game.ui.next_level_button.disabled, "Top next-level button should be disabled before clearing a level.")
	_assert(game.ui.level_clear_next_button.disabled, "Level-clear next button should be disabled before clearing a level.")
	_assert(game.ui.start_wave_button.mouse_default_cursor_shape == Control.CURSOR_ARROW, "Disabled start-wave button should use the default cursor.")
	_assert(game.ui.build_tower_button.mouse_default_cursor_shape == Control.CURSOR_ARROW, "Disabled build button should use the default cursor.")
	_assert(game.ui.next_level_button.mouse_default_cursor_shape == Control.CURSOR_ARROW, "Disabled top next-level button should use the default cursor.")
	_assert(game.ui.level_clear_next_button.mouse_default_cursor_shape == Control.CURSOR_ARROW, "Disabled level-clear next button should use the default cursor.")
	_assert(not game.ui.level_select_panel.visible, "Level select panel should be hidden on launch.")
	game.ui._on_level_select_pressed()
	_assert(game.ui.level_select_panel.visible, "Level select button should open level select panel.")
	_assert(game.ui.level_select_panel.get_node_or_null("TacticalBackground") != null, "Level select should render a tactical pixel background.")
	_assert(game.ui.level_select_scroll != null and game.ui.level_buttons_container.get_parent() == game.ui.level_select_scroll, "Level select cards should be inside a scroll container.")
	_assert(game.ui.level_select_scroll.vertical_scroll_mode == ScrollContainer.SCROLL_MODE_AUTO, "Level select should support vertical scrolling.")
	_assert(game.ui.level_buttons_container.get_child_count() == game.level_configs.size(), "Level select should show one button per level.")
	_assert((game.ui.level_buttons_container.get_child(0) as Button).mouse_default_cursor_shape == Control.CURSOR_POINTING_HAND, "Unlocked level select cards should use the pointing cursor.")
	_assert((game.ui.level_buttons_container.get_child(1) as Button).disabled, "Level select should lock uncleared levels.")
	_assert((game.ui.level_buttons_container.get_child(1) as Button).mouse_default_cursor_shape == Control.CURSOR_ARROW, "Locked level select cards should use the default cursor.")
	await create_timer(0.35).timeout
	_assert(game.ui.level_select_panel.position == Vector2.ZERO, "Level select open should settle on its final position.")
	_assert(is_equal_approx(game.ui.level_select_panel.modulate.a, 1.0), "Level select open should settle on full opacity.")
	_assert(game.ui.start_overlay.position == Vector2(-180.0, 0.0), "Level select open should settle the start overlay offset.")
	_assert(is_equal_approx(game.ui.start_overlay.modulate.a, 0.35), "Level select open should dim the start overlay.")
	game.ui._on_level_select_close_pressed()
	game.ui._on_level_select_pressed()
	game.ui._on_level_select_close_pressed()
	await create_timer(0.35).timeout
	_assert(game.ui.start_overlay.visible and not game.ui.level_select_panel.visible, "Rapid level select toggles should settle back on the start screen.")
	_assert(game.ui.start_overlay.position == Vector2.ZERO, "Rapid level select toggles should restore the start overlay position.")
	_assert(is_equal_approx(game.ui.start_overlay.modulate.a, 1.0), "Rapid level select toggles should restore the start overlay opacity.")
	_assert(game.ui.level_select_panel.position == Vector2(960.0, 0.0), "Rapid level select toggles should restore the level select offscreen position.")
	_assert(is_equal_approx(game.ui.level_select_panel.modulate.a, 0.0), "Rapid level select toggles should restore the level select opacity.")
	game.ui._on_level_select_pressed()
	game.ui.set_console_visible(true, false)
	_assert(game.ui.is_console_visible() and game.ui.console_panel.visible, "Start screen reset setup should leave the console open.")
	game.ui.show_start_screen()
	await create_timer(0.35).timeout
	_assert(game.ui.start_overlay.visible, "Start screen reset should keep the start overlay visible.")
	_assert(not game.ui.is_console_visible() and not game.ui.console_panel.visible, "Start screen reset should close the console.")
	_assert(game.ui.start_overlay.position == Vector2.ZERO, "Start screen reset should restore the start overlay position.")
	_assert(is_equal_approx(game.ui.start_overlay.modulate.a, 1.0), "Start screen reset should restore the start overlay opacity.")
	_assert(not game.ui.level_select_panel.visible, "Start screen reset should hide level select after interrupting its animation.")
	_assert(game.ui.level_select_panel.position == Vector2(960.0, 0.0), "Start screen reset should restore level select position.")
	_assert(is_equal_approx(game.ui.level_select_panel.modulate.a, 0.0), "Start screen reset should restore level select opacity.")
	game.ui._on_level_select_pressed()
	game.ui._on_level_select_close_pressed()
	await create_timer(0.35).timeout
	_assert(not game.ui.level_select_panel.visible, "Level select close should hide panel.")

	game.highest_unlocked_level_index = 2
	game.ui.set_highest_unlocked_level(game.highest_unlocked_level_index)
	game._on_level_selected(2)
	await create_timer(0.35).timeout
	_assert(game.has_game_started, "Selecting a level should enter gameplay.")
	_assert(not game.ui.start_overlay.visible, "Selecting a level should hide start overlay.")
	_assert(game.current_level_index == 2, "Selecting level 3 should load level 3.")
	_assert(game.gold == int(game.level_configs[2].get("start_gold", 0)), "Selected levels should use their own starting gold.")
	var selected_level_save := _read_level_start_save_for_test()
	_assert(bool(selected_level_save.get("has_save", false)) and int(selected_level_save.get("level_index", -1)) == 2, "Selecting a level should save that level's initial state for Continue Game.")
	_assert(int(selected_level_save.get("gold", -1)) == game.gold, "Level-start save should capture the selected level starting gold.")
	_assert(game.spawn_paths.size() == 3, "Selected level 3 should load its routes.")
	_assert(game.spawn_path_lengths.size() == game.spawn_paths.size(), "Selected levels should refresh cached route lengths.")
	_assert(game.ui.level_banner_panel.visible, "Selecting a level should show the level intro banner.")
	_assert(_count_particles(game.ui.ui_root) == 0, "Level intro animation should use rebound animation instead of UI particles.")
	_assert(game.ui.level_banner_title_label.text == "第03关 / 共10关", "Level intro banner should use localized level wording.")

	game.gold = 1
	game.base_health = 2
	game._return_to_start_screen()
	_assert(not game.ui.continue_game_button.disabled, "Returning to start should enable Continue Game when a level-start save exists.")
	game.ui._on_continue_game_pressed()
	await create_timer(0.35).timeout
	_assert(game.has_game_started and game.current_level_index == 2, "Continue Game should load the saved level-start snapshot.")
	_assert(game.gold == int(selected_level_save.get("gold", -1)), "Continue Game should restore saved starting gold instead of the abandoned run state.")
	_assert(game.base_health == int(selected_level_save.get("base_health", -1)), "Continue Game should restore saved starting base health.")

	game._return_to_start_screen()
	game._on_level_selected(0)
	_assert(game.ui.is_confirm_dialog_visible(), "Starting from an earlier unlocked level should warn that Continue Game will be overwritten.")
	_assert(not game.has_game_started, "Overwrite warning should wait for player confirmation before starting the earlier level.")
	game.ui._on_confirm_dialog_confirm_pressed()
	await create_timer(0.35).timeout
	var overwritten_level_save := _read_level_start_save_for_test()
	_assert(game.has_game_started and game.current_level_index == 0, "Confirming overwrite should start the earlier level.")
	_assert(int(overwritten_level_save.get("level_index", -1)) == 0, "Confirming overwrite should replace Continue Game with the earlier level start.")

	game.queue_free()
	await process_frame
	_clear_level_start_save_for_test()

	game = main_scene.instantiate() as Main
	root.add_child(game)
	await process_frame
	await process_frame

	game._on_game_start_pressed()
	await create_timer(0.35).timeout
	_assert(game.has_game_started, "Start Game should enter gameplay.")
	_assert(not game.ui.start_overlay.visible, "Start overlay should hide after Start Game.")
	_assert(not game.ui.start_wave_button.disabled, "Start wave button should enable after Start Game.")
	_assert(not game.ui.build_tower_button.disabled, "Tower menu should enable after Start Game.")
	var start_game_save := _read_level_start_save_for_test()
	_assert(bool(start_game_save.get("has_save", false)) and int(start_game_save.get("level_index", -1)) == 0, "Start Game should save level 1's initial state for Continue Game.")
	_assert(not game.ui.continue_game_button.disabled, "Creating a level-start save should enable Continue Game on the start overlay.")
	_assert(game.ui.start_wave_button.mouse_default_cursor_shape == Control.CURSOR_POINTING_HAND, "Enabled start-wave button should use the pointing cursor.")
	_assert(game.ui.build_tower_button.mouse_default_cursor_shape == Control.CURSOR_POINTING_HAND, "Enabled build button should use the pointing cursor.")
	_assert(game.ui._build_option_buttons.size() == game.get_tower_configs().size(), "Build UI should cache tower option buttons for enabled-state updates.")
	_assert(game.ui.build_options_scroll != null and game.ui.build_options_container.get_parent() == game.ui.build_options_scroll, "Expanded build options should be inside a horizontal scroll container.")
	_assert(game.ui.build_options_scroll.horizontal_scroll_mode == ScrollContainer.SCROLL_MODE_AUTO, "Expanded build options should support horizontal scrolling.")
	_assert(game.ui.compact_build_options_scroll != null and game.ui.compact_build_options_container.get_parent() == game.ui.compact_build_options_scroll, "Compact build options should be inside a horizontal scroll container.")
	_assert(game.ui.compact_build_options_scroll.horizontal_scroll_mode == ScrollContainer.SCROLL_MODE_AUTO, "Compact build options should support horizontal scrolling.")
	_assert(game.ui.build_tower_button.text == "收起建塔", "Build toggle should describe the current expanded action.")
	game.ui._on_build_menu_toggled()
	game.ui._on_build_menu_toggled()
	await create_timer(0.25).timeout
	_assert(game.ui._build_panel_expanded, "Rapid build menu toggles should keep the final expanded state.")
	_assert(game.ui.build_options_scroll.visible and not game.ui.compact_build_options_scroll.visible, "Rapid build menu toggles should settle on detailed options when expanded.")
	_assert(is_equal_approx(game.ui.build_panel.size.y, 132.0) and is_equal_approx(game.ui.build_panel.position.y, 508.0), "Expanded build menu should settle on its final geometry.")
	_assert(game.ui.build_options_scroll.size.y >= 118.0, "Expanded build menu should provide a more noticeable tower option area.")
	_assert(is_equal_approx(game.ui.build_options_scroll.modulate.a, 1.0) and is_equal_approx(game.ui.compact_build_options_scroll.modulate.a, 0.0), "Expanded build menu should settle on final option opacity.")
	game.ui._on_build_menu_toggled()
	game.ui._on_build_menu_toggled()
	game.ui._on_build_menu_toggled()
	await create_timer(0.25).timeout
	_assert(not game.ui._build_panel_expanded, "Rapid build menu toggles should keep the final collapsed state.")
	_assert(game.ui.compact_build_options_scroll.visible and not game.ui.build_options_scroll.visible, "Rapid build menu toggles should settle on compact options when collapsed.")
	_assert(is_equal_approx(game.ui.build_panel.size.y, 56.0) and is_equal_approx(game.ui.build_panel.position.y, 584.0), "Collapsed build menu should settle on its final geometry.")
	_assert(is_equal_approx(game.ui.build_options_scroll.modulate.a, 0.0) and is_equal_approx(game.ui.compact_build_options_scroll.modulate.a, 1.0), "Collapsed build menu should settle on final option opacity.")
	game.ui._on_build_menu_toggled()
	await create_timer(0.25).timeout
	game.ui._on_build_menu_toggled()
	await create_timer(0.25).timeout
	_assert(game.ui.build_tower_button.text == "展开建塔", "Collapsed build toggle should offer expanding the build menu.")
	_assert(game.ui.compact_build_options_scroll.visible and not game.ui.build_options_scroll.visible, "Collapsed build menu should show compact tower options.")
	game.ui._on_build_menu_toggled()
	await create_timer(0.25).timeout
	_assert(game.ui.build_tower_button.text == "收起建塔", "Expanded build toggle should offer collapsing the build menu.")
	_assert(game.ui.build_options_scroll.visible and not game.ui.compact_build_options_scroll.visible, "Expanded build menu should show detailed tower options.")
	_assert(game.ui._compact_build_option_buttons.all(func(button: Button) -> bool: return not _contains_ascii_letter(button.text)), "Compact tower icons should not use English letter labels.")
	_assert(game.ui._build_option_buttons.all(func(button: Button) -> bool: return not button.text.contains("$")), "Expanded tower buttons should use localized currency text.")
	_assert(game.ui._compact_build_option_buttons.all(func(button: Button) -> bool: return not button.tooltip_text.contains("$")), "Compact tower tooltips should use localized currency text.")
	_assert(game.ui._build_option_buttons[0].tooltip_text.contains("秒") and not game.ui._build_option_buttons[0].tooltip_text.contains("s"), "Tower tooltip should use localized seconds.")
	_assert(game.ui._compact_build_option_buttons[0].tooltip_text.contains("伤害") and game.ui._compact_build_option_buttons[0].tooltip_text.contains("射程"), "Compact tower tooltips should expose core tower stats.")
	_assert(game.ui._compact_build_option_buttons[0].tooltip_text.contains("秒") and not game.ui._compact_build_option_buttons[0].tooltip_text.contains("s"), "Compact tower tooltip should use localized seconds.")
	var support_build_button := game.ui._build_option_buttons[game.ui._build_option_buttons.size() - 1]
	var support_compact_button := game.ui._compact_build_option_buttons[game.ui._compact_build_option_buttons.size() - 1]
	_assert(not support_build_button.text.contains("伤0") and not support_build_button.text.contains("射0"), "Support tower build buttons should not present zero weapon stats.")
	_assert(support_build_button.text.contains("伤+") and support_build_button.text.contains("射+"), "Support tower build buttons should present augmentation bonuses.")
	_assert(support_compact_button.tooltip_text.contains("伤害增幅") and support_compact_button.tooltip_text.contains("射程增幅"), "Support tower compact tooltips should explain augmentation bonuses.")
	_assert(game.ui._get_tower_display_name({"name": "  测试塔  "}) == "测试塔", "Tower display helper should trim configured names.")
	_assert(game.ui._get_tower_display_name({"name": ""}) == "防御塔", "Tower display helper should use a localized fallback name.")
	_assert(game.ui._get_default_tower_display_name() == "防御塔", "Game UI default tower display-name helper should use localized text.")
	_assert(game.ui._get_tower_category_label({"category_label": "  增益塔  "}) == "增益塔", "Tower category helper should trim configured labels.")
	_assert(game.ui._get_tower_category_label({"category_label": ""}) == "武器塔", "Tower category helper should use a localized fallback label.")
	_assert(game.ui._get_default_tower_category_label() == "武器塔", "Game UI default tower category helper should use localized text.")
	_assert(game.ui._get_tower_icon_text({"icon": "  炮  ", "name": "重炮塔"}) == "炮", "Tower icon helper should trim configured icons.")
	_assert(game.ui._get_tower_icon_text({"icon": "", "name": "狙击塔"}) == "狙", "Tower icon helper should derive a localized fallback from tower names.")
	_assert(game.ui._get_tower_icon_text({"icon": "SN", "name": "Sniper"}) == "塔", "Tower icon helper should avoid English compact icons.")
	_assert(game.ui._get_default_tower_icon_text() == "塔", "Game UI default tower icon helper should use localized text.")
	_assert(game.ui._get_level_config_display_name({"name": "  分岔峡谷  "}) == "分岔峡谷", "Level-select display helper should trim configured names.")
	_assert(game.ui._get_level_config_display_name({"name": ""}) == "未知关卡", "Level-select display helper should use a localized fallback name.")
	_assert(game.ui._get_default_level_display_name() == "未知关卡", "Game UI default level display-name helper should use localized text.")
	_assert(game.ui._get_level_config_description({"description": "  多路线进攻  "}) == "多路线进攻", "Level-select description helper should trim descriptions.")
	var formatted_level_button := game.ui._format_level_select_button_text(2, {"name": "", "waves": 5, "routes": [[], []], "description": "  压力测试  "})
	_assert(formatted_level_button.contains("第03关") and formatted_level_button.contains("未知关卡") and formatted_level_button.contains("2条路线") and formatted_level_button.contains("压力测试"), "Level-select button formatter should compose localized card text.")
	_assert(game.ui._get_card_display_name({"name": "  测试卡  "}) == "测试卡", "Card display helper should trim configured names.")
	_assert(game.ui._get_card_display_name({"name": ""}) == "卡牌", "Card display helper should use a localized fallback name.")
	_assert(game.ui._get_default_card_display_name() == "卡牌", "Game UI default card display-name helper should use localized text.")
	_assert(game.ui._get_card_type_label({"type_label": "  攻击  "}) == "攻击", "Card type helper should trim configured labels.")
	_assert(game.ui._get_card_type_label({"type_label": ""}) == "卡牌", "Card type helper should use a localized fallback label.")
	_assert(game.ui._get_default_card_type_label() == "卡牌", "Game UI default card type helper should use localized text.")
	_assert(game.ui._get_card_rarity_label({"rarity": "white"}) == "白色", "Card rarity helper should expose white effect text.")
	_assert(game.ui._get_card_rarity_label({"rarity": "blue"}) == "蓝色", "Card rarity helper should expose blue effect text.")
	_assert(game.ui._get_card_rarity_label({"rarity": "purple"}) == "紫色", "Card rarity helper should expose purple effect text.")
	_assert(game.ui._get_card_rarity_label({"rarity": "gold"}) == "金色", "Card rarity helper should expose gold effect text.")
	_assert(game.ui._get_card_rarity_label({"rarity": "red"}) == "红色", "Card rarity helper should expose red effect text.")
	var red_rarity_color := game.ui._get_card_rarity_color({"rarity": "red"})
	_assert(red_rarity_color.r > red_rarity_color.g and red_rarity_color.r > red_rarity_color.b, "Card rarity color helper should return a red effect font color.")
	_assert(game.ui._get_card_rarity_face_detail_score({"rarity": "white"}) < game.ui._get_card_rarity_face_detail_score({"rarity": "blue"}), "Blue card faces should be more detailed than white card faces.")
	_assert(game.ui._get_card_rarity_face_detail_score({"rarity": "blue"}) < game.ui._get_card_rarity_face_detail_score({"rarity": "purple"}), "Purple card faces should be more detailed than blue card faces.")
	_assert(game.ui._get_card_rarity_face_detail_score({"rarity": "purple"}) < game.ui._get_card_rarity_face_detail_score({"rarity": "gold"}), "Gold card faces should be more detailed than purple card faces.")
	_assert(game.ui._get_card_rarity_face_detail_score({"rarity": "gold"}) < game.ui._get_card_rarity_face_detail_score({"rarity": "red"}), "Red card faces should be the most decorated card face tier.")
	var red_face_style := game.ui._get_card_rarity_face_style({"rarity": "red"})
	_assert(int(red_face_style.get("border_width", 0)) == 4 and int(red_face_style.get("pip_count", 0)) == 4, "Red card face style should expose premium border and pip configuration.")
	var red_face_probe := game.ui._make_card_control({"id": "risky_cache", "name": "测试红卡", "type_label": "概率", "rarity": "red", "description": "测试"}, 0)
	_assert(red_face_probe.get_node_or_null("RarityPip3") != null and red_face_probe.get_node_or_null("RarityRail4") != null and red_face_probe.get_node_or_null("RarityCorner3") != null, "Red card controls should directly apply the premium rarity face decorations.")
	red_face_probe.free()
	_assert(game.ui._get_card_description({"description": "  范围伤害  "}) == "范围伤害", "Card description helper should trim descriptions.")
	game.ui.set_build_enabled(false)
	_assert(game.ui._build_option_buttons.all(func(button: Button) -> bool: return button.disabled), "Cached tower option buttons should disable without scanning the container.")
	_assert(game.ui._build_option_buttons.all(func(button: Button) -> bool: return button.mouse_default_cursor_shape == Control.CURSOR_ARROW), "Disabled tower option buttons should use the default cursor.")
	game.ui.set_build_enabled(true)
	_assert(_tower_buttons_match_unlock_state(game.ui, game.current_level_index), "Build buttons should enable only tower types unlocked for the current level.")
	var unlocked_tower_button := game.ui._build_option_buttons[0]
	var locked_tower_button := game.ui._build_option_buttons[game.ui._build_option_buttons.size() - 1]
	_assert(unlocked_tower_button.mouse_default_cursor_shape == Control.CURSOR_POINTING_HAND, "Unlocked tower buttons should use the pointing cursor.")
	_assert(locked_tower_button.disabled and locked_tower_button.mouse_default_cursor_shape == Control.CURSOR_ARROW, "Locked tower buttons should use the default cursor.")
	_assert(game.ui._format_gold_status_text(123) == "金币：123", "Gold status formatter should use localized text.")
	_assert(game.ui._format_base_health_status_text(7, 20) == "基地：7/20", "Base-health status formatter should use localized text.")
	_assert(game.ui._format_level_status_text(3, 10) == "关卡：3/10", "Level status formatter should use localized text.")
	_assert(game.ui._format_wave_status_text(2, 6) == "波次：2/6", "Wave status formatter should use localized text.")
	_assert(game.ui._get_start_wave_button_text() == "开始波次", "Start-wave button helper should use localized action text.")
	_assert(game.ui._get_next_level_button_text() == "下一关", "Next-level button helper should use localized action text.")
	_assert(game.ui._get_tower_panel_close_button_text() == "关闭", "Tower-panel close helper should use localized action text.")
	_assert(game.ui._get_tower_upgrade_placeholder_text() == "升级", "Tower upgrade placeholder helper should use localized action text.")
	_assert(game.ui._get_tower_sell_placeholder_text() == "出售", "Tower sell placeholder helper should use localized action text.")
	_assert(game.ui._get_build_panel_title_text() == "建造", "Build panel title helper should use localized title text.")
	_assert(game.ui._get_build_panel_toggle_text(true) == "收起建塔" and game.ui._get_build_panel_toggle_text(false) == "展开建塔", "Build panel toggle formatter should use localized action text.")
	_assert(game.ui._get_card_hand_toggle_text(true) == "收起手牌" and game.ui._get_card_hand_toggle_text(false) == "展开手牌", "Card hand toggle formatter should use localized action text.")
	_assert(game.ui._format_card_hand_label_text(3, true, false) == "卡牌 3/5", "Expanded card hand label formatter should use one-line localized text.")
	_assert(game.ui._format_card_hand_label_text(3, false, false) == "卡牌\n3/5", "Collapsed card hand label formatter should use compact localized text.")
	_assert(game.ui._format_card_hand_label_text(5, true, true).contains("选择一张丢弃"), "Discard-mode card hand label formatter should expose replacement state.")
	_assert(game.ui._get_start_title_text() == "像素塔防", "Start title helper should use localized text.")
	_assert(game.ui._get_start_subtitle_text().contains("布置防线"), "Start subtitle helper should use localized text.")
	_assert(game.ui._get_start_game_button_text() == "开始游戏", "Start button helper should use localized text.")
	_assert(game.ui._get_level_select_button_text() == "选择关卡", "Level-select button helper should use localized text.")
	_assert(game.ui._get_level_select_title_text() == "选择关卡", "Level-select title helper should use localized text.")
	_assert(game.ui._get_level_select_subtitle_text().contains("更多路线"), "Level-select subtitle helper should use localized text.")
	_assert(game.ui._get_level_select_close_button_text() == "返回", "Level-select close helper should use localized text.")
	_assert(game.ui._get_end_restart_button_text() == "重新开始本关", "End restart helper should use localized text.")
	_assert(game.ui._get_end_main_menu_button_text() == "返回开始界面", "End main-menu helper should use localized text.")
	_assert(game.ui._get_pause_title_text() == "游戏暂停", "Pause title helper should use localized text.")
	_assert(game.ui._get_pause_hint_text().contains("Esc 键"), "Pause hint helper should use localized key text.")
	_assert(game.ui._get_pause_resume_button_text() == "继续游戏", "Pause resume helper should use localized text.")
	_assert(game.ui._get_console_title_text().contains("回车执行") and game.ui._get_console_title_text().contains("Tab键补全"), "Console title helper should use localized text.")
	_assert(game.ui._get_console_placeholder_text() == "输入命令", "Console placeholder helper should use localized text.")
	_assert(game.ui._get_console_initial_line_text().contains("自动补全"), "Console initial line helper should use localized text.")
	_assert(game.ui._format_locked_level_button_text("第02关  双折道") == "第02关  双折道\n未解锁", "Locked level formatter should use localized locked text.")
	_assert(game.ui._get_locked_level_tooltip_text() == "请先通关前置关卡。", "Locked level tooltip helper should use localized text.")
	_assert(game.ui._format_tower_unlock_tooltip_text("狙击塔 | 110金币", 3).ends_with("第4关解锁"), "Tower unlock tooltip formatter should use localized level text.")
	_assert(game.ui._format_support_tower_stats_text({"damage_multiplier": 1.35, "range_multiplier": 1.20}).contains("伤害增幅"), "Support tower stat formatter should use localized labels.")
	_assert(game.ui._format_weapon_tower_stats_text({"damage": 15, "range": 130.0, "interval": 0.8}) == "伤害 15 | 射程 130 | 间隔 0.80秒", "Weapon tower stat formatter should use localized labels.")
	_assert(game.ui._format_support_tower_button_text({"name": "增幅塔", "cost": 95, "damage_multiplier": 1.35, "range_multiplier": 1.20}).contains("伤+35%"), "Support tower button formatter should use compact localized stat labels.")
	_assert(game.ui._format_weapon_tower_button_text({"name": "基础塔", "cost": 50, "damage": 15, "range": 130.0}) == "基础塔\n50金  伤15  射130", "Weapon tower button formatter should use compact localized stat labels.")
	_assert(game.ui._format_compact_tower_tooltip_text({"name": "基础塔", "category_label": "武器塔", "cost": 50, "damage": 15, "range": 130.0, "interval": 0.8}).contains("金币"), "Compact tower tooltip formatter should use localized currency text.")
	_assert(game.ui._format_console_completion_missing_text("zz").contains("没有可补全项"), "Console completion miss formatter should use localized text.")
	_assert(game.ui._format_console_completion_options_text(["card", "clear"]).contains("可选补全"), "Console completion options formatter should use localized text.")
	_assert(game.ui._get_damage_boost_card_icon_text() == "攻", "Damage boost card icon helper should use localized text.")
	_assert(game.ui._get_range_boost_card_icon_text() == "射", "Range boost card icon helper should use localized text.")
	_assert(game.ui._get_fire_rate_boost_card_icon_text() == "速", "Fire-rate card icon helper should use localized text.")
	_assert(game.ui._get_heal_card_icon_text() == "疗", "Heal card icon helper should use localized text.")
	_assert(game.ui._get_missile_card_icon_text() == "爆", "Missile card icon helper should use localized text.")
	_assert(game.ui._get_cryo_card_icon_text() == "冻", "Cryo card icon helper should use localized text.")
	_assert(game.ui._get_firestorm_card_icon_text() == "火", "Firestorm card icon helper should use localized text.")
	_assert(game.ui._get_global_freeze_card_icon_text() == "冰", "Global-freeze card icon helper should use localized text.")
	_assert(game.ui._get_risky_cache_card_icon_text() == "赌", "Risky-cache card icon helper should use localized text.")
	_assert(game.ui._get_fortify_card_icon_text() == "盾", "Fortify card icon helper should use localized text.")
	_assert(game.ui._get_gold_card_icon_text() == "金", "Gold card icon helper should use localized text.")
	_assert(game.ui._get_default_card_icon_text() == "卡", "Game UI default card icon helper should use localized text.")
	_assert(game.ui._format_level_intro_title_text(3, 10) == "第03关 / 共10关", "Level intro title formatter should use localized padded level text.")
	_assert(game.ui._format_level_clear_console_text(3, "分裂堡垒") == "第3关完成：分裂堡垒", "Level clear console formatter should use localized completion text.")
	_assert(game.ui._get_level_clear_title_text() == "关卡完成", "Level clear title helper should use localized title text.")
	_assert(game.ui._format_level_clear_subtitle_text(3, "分裂堡垒") == "第03关  分裂堡垒", "Level clear subtitle formatter should use localized padded level text.")
	_assert(game.ui._get_level_clear_next_button_text() == "进入下一关", "Level clear next button helper should use localized action text.")
	_assert(game.ui._get_card_sell_zone_icon_text() == "金", "Card sell zone icon helper should use localized currency text.")
	_assert(game.ui._get_pending_card_keep_hint_text() == "点旧卡替换", "Pending card keep hint helper should use localized replacement text.")
	_assert(game.ui._get_pending_card_reject_button_text() == "放弃新卡", "Pending card reject helper should use localized action text.")
	_assert(game.ui._format_pending_card_title_text({"name": "  轨道导弹  "}) == "新卡牌：轨道导弹", "Pending card title formatter should use localized card names.")
	_assert(game.ui._get_pending_card_description_text().contains("手牌已满"), "Pending card description helper should explain the full-hand state.")
	_assert(game.ui._get_hand_card_hint_text(false) == "拖拽" and game.ui._get_hand_card_hint_text(true) == "丢弃", "Hand card hint helper should switch between drag and discard text.")
	_assert(game.ui._format_pending_card_timer_text(-2.0) == "自动放弃 0秒", "Pending card timer formatter should clamp negative time.")
	var status_writes_before := game.ui._status_text_write_count
	var gold_label_before := game.ui.gold_label.text
	game.ui.update_status(
		game.gold,
		game.base_health,
		game.max_base_health,
		game.current_level_index + 1,
		game.level_configs.size(),
		game.wave_manager.current_wave,
		game.wave_manager.total_waves,
		"仅提示变化"
	)
	_assert(game.ui._status_text_write_count == status_writes_before + 1, "Status UI should update only changed labels.")
	_assert(game.ui.gold_label.text == gold_label_before, "Message-only status updates should not rewrite the gold label text.")

	var pause_key := InputEventKey.new()
	pause_key.keycode = KEY_ESCAPE
	pause_key.pressed = true
	game._unhandled_input(pause_key)
	_assert(game.is_game_paused, "ESC should pause active gameplay.")
	_assert(game.get_tree().paused, "Pausing should pause the scene tree.")
	_assert(game.ui.pause_overlay.visible, "Pausing should show the pause menu.")
	_assert(game.ui.pause_hint_label.text.contains("Esc 键"), "Pause hint should use localized key wording.")
	game._unhandled_input(pause_key)
	_assert(not game.is_game_paused, "ESC should resume when the pause menu is open.")
	_assert(not game.get_tree().paused, "Resuming should unpause the scene tree.")
	_assert(game.ui.pause_overlay.visible, "Resuming should keep the pause menu visible during its fade-out.")
	await create_timer(0.15).timeout
	_assert(not game.ui.pause_overlay.visible, "Resuming should hide the pause menu after its fade-out.")
	_assert(is_equal_approx(game.ui.pause_overlay.modulate.a, 0.0), "Pause menu fade-out should leave the overlay transparent.")

	game._add_card_to_hand_or_pending(game._make_debug_reward_card("gold"))
	await process_frame
	var dragged_card := game.ui._card_controls[0]
	game.ui._start_card_drag(dragged_card, 0, Vector2(760.0, 480.0))
	game._pause_game()
	_assert(game.ui._drag_card_control == null, "Pausing should cancel an active card drag.")
	_assert(game.ui.pause_overlay.z_index > dragged_card.z_index, "Pause menu should render above card controls.")
	game.ui.card_area_preview.visible = true
	game.ui.cancel_card_drag()
	_assert(not game.ui.card_area_preview.visible, "Canceling a card drag should hide orphaned range previews.")
	var paused_card_count := game._card_hand.size()
	var paused_gold := game.gold
	game._on_reward_card_play_requested(0, Vector2(500.0, 300.0))
	_assert(game._card_hand.size() == paused_card_count, "Cards should not be playable while paused.")
	_assert(game.gold == paused_gold, "Paused card use should not apply effects.")
	game._resume_game()
	game._card_hand.clear()
	game.ui.update_card_hand(game._card_hand, {}, false)

	game._pause_game()
	game.ui._on_pause_restart_pressed()
	_assert(not game.is_game_paused, "Restart from pause should leave pause state.")
	_assert(not game.get_tree().paused, "Restart from pause should unpause the scene tree.")
	_assert(game.has_game_started, "Restart from pause should keep gameplay active.")
	_assert(game.current_level_index == 0, "Restart from pause should reload the current level.")

	game._pause_game()
	game.ui._on_pause_main_menu_pressed()
	_assert(game.is_game_paused, "Returning to start from pause should keep the game paused while the exit warning is open.")
	_assert(game.has_game_started, "Returning to start from pause should wait for warning confirmation before leaving gameplay.")
	_assert(game.ui.is_confirm_dialog_visible(), "Returning to start from pause should warn the player before leaving the level.")
	game.ui._on_confirm_dialog_confirm_pressed()
	await process_frame
	_assert(not game.is_game_paused, "Returning to start screen should leave pause state.")
	_assert(not game.has_game_started, "Returning to start screen should leave gameplay.")
	_assert(game.ui.start_overlay.visible, "Returning to start screen should show the start overlay.")
	_assert(not game.ui.pause_overlay.visible, "Returning to start screen should immediately hide the pause menu.")
	_assert(not game.ui.is_confirm_dialog_visible(), "Confirming return to start should close the exit warning.")
	_assert(not game.ui.level_banner_panel.visible, "Returning to start screen should hide the level intro banner.")
	_assert(game.ui.level_banner_panel.position == Vector2(300.0, -70.0), "Hidden level intro banner should reset to its offscreen position.")
	_assert(is_equal_approx(game.ui.level_banner_panel.modulate.a, 0.0), "Hidden level intro banner should reset its opacity.")
	game._on_game_start_pressed()
	await create_timer(0.35).timeout

	game.gold = 200
	game._on_tower_build_requested("basic")
	var auto_tower_built := game.build_manager.try_build_at(game.build_manager.grid_to_center(Vector2i(1, 1)))
	await process_frame
	_assert(auto_tower_built, "Auto-wave test should build a tower for card testing.")

	game._add_card_to_hand_or_pending(game._make_debug_reward_card("missile"))
	await process_frame
	var wave_drag_card := game.ui._card_controls[0]
	game.ui._start_card_drag(wave_drag_card, 0, Vector2(760.0, 480.0))
	_assert(game.ui.card_area_preview.visible, "Dragging an area card should show the card range preview.")
	game._on_start_wave_pressed()
	await process_frame
	_assert(game._auto_waves_enabled, "Clicking Start Wave should enable automatic waves.")
	_assert(game.ui._drag_card_control == null and not game.ui.card_area_preview.visible, "Starting a wave should cancel card drags and hide range previews.")
	_assert(game.ui.start_wave_button.disabled, "Start Wave button should disable after auto waves begin.")
	game._card_hand.clear()
	game._pending_reward_card.clear()
	game._pending_reward_timeout = 0.0
	game.ui.update_card_hand(game._card_hand, game._pending_reward_card, false)
	game.wave_manager.stop()
	game._clear_enemies_and_projectiles()
	game._check_level_complete()
	await process_frame
	_assert(game._intermission_active, "Clearing a non-final auto wave should start the five second intermission.")
	_assert(game._card_hand.size() == 1, "Wave clear should store a reward card in hand.")
	_assert(game.ui._card_controls.size() == 1, "Stored card should render as a hand card.")
	_assert(str(game._card_hand[0].get("id", "")) == "tower_boost", "Wave one reward should be a tower boost card.")
	var boosted_tower := game.tower_layer.get_child(0) as Tower
	game._on_reward_card_play_requested(0, Vector2(500.0, 300.0))
	await create_timer(0.25).timeout
	_assert(boosted_tower.damage_multiplier > 1.0, "Tower boost card should increase tower damage temporarily.")
	_assert(game._card_hand.is_empty(), "Using a reward card should consume it from hand.")
	_assert(game.ui._card_controls.is_empty(), "Using a reward card should refresh hand display.")
	game._process(5.1)
	await process_frame
	_assert(game.wave_manager.current_wave == 2, "Auto waves should start the next wave after five seconds.")
	_assert(not game._intermission_active, "Intermission should end when the automatic wave starts.")
	game.wave_manager.stop()
	game._clear_enemies_and_projectiles()

	game.base_health = game.max_base_health - 5
	game._add_card_to_hand_or_pending(game._make_debug_reward_card("heal"))
	game._on_reward_card_play_requested(game._card_hand.size() - 1, Vector2(500.0, 300.0))
	await create_timer(0.25).timeout
	_assert(game.base_health == game.max_base_health, "Heal card should restore base health up to max.")

	var before_card_gold := game.gold
	game._add_card_to_hand_or_pending(game._make_debug_reward_card("gold"))
	game._on_reward_card_play_requested(game._card_hand.size() - 1, Vector2(500.0, 300.0))
	await create_timer(0.25).timeout
	_assert(game.gold == before_card_gold + 85, "Gold card should add its configured gold amount.")

	game._add_card_to_hand_or_pending(game._make_debug_reward_card("range"))
	game._on_reward_card_play_requested(game._card_hand.size() - 1, Vector2(500.0, 300.0))
	await create_timer(0.25).timeout
	_assert(boosted_tower.range_multiplier > 1.0, "Range card should increase tower range temporarily.")

	game._add_card_to_hand_or_pending(game._make_debug_reward_card("rate"))
	game._on_reward_card_play_requested(game._card_hand.size() - 1, Vector2(500.0, 300.0))
	await create_timer(0.25).timeout
	_assert(boosted_tower.fire_rate_multiplier > 1.0, "Fire-rate card should increase tower fire rate temporarily.")

	var before_max_hp := game.max_base_health
	game._add_card_to_hand_or_pending(game._make_debug_reward_card("fortify"))
	game._on_reward_card_play_requested(game._card_hand.size() - 1, Vector2(500.0, 300.0))
	await create_timer(0.25).timeout
	var fortify_card := game._normalize_reward_card(game._make_debug_reward_card("fortify"))
	_assert(game.max_base_health == before_max_hp + int(fortify_card.get("max_hp", 0)), "Fortify card should increase max base health by its rarity-scaled value.")

	for card_id in ["boost", "heal", "gold", "boost", "heal"]:
		game._add_card_to_hand_or_pending(game._make_debug_reward_card(card_id))
	_assert(game._card_hand.size() == 5, "Hand should store up to five cards.")
	game._add_card_to_hand_or_pending({"id": "boost", "name": "Alias Boost"})
	_assert(game._card_hand.size() == 5, "Full hand should not immediately add a sixth card.")
	_assert(not game._pending_reward_card.is_empty(), "Full hand should keep the new card pending.")
	_assert(game.ui.card_pending_panel.visible, "Full hand should ask the player to discard one card.")
	_assert(game.ui.card_pending_keep_hint_label != null and game.ui.card_pending_keep_hint_label.text.contains("旧卡"), "Pending card panel should explain that keeping the new card requires replacing an old card.")
	_assert(game.ui.card_pending_reject_button.text == "放弃新卡" and not game.ui.card_pending_reject_button.disabled, "Pending card panel should expose a clear reject-new-card action.")
	_assert(game.ui.card_pending_timer_label.text.contains("秒") and not game.ui.card_pending_timer_label.text.contains("s"), "Pending card timer should use localized seconds.")
	var pending_before_use := game._pending_reward_card.duplicate(true)
	game._on_reward_card_play_requested(0, Vector2(500.0, 300.0))
	_assert(game._card_hand.size() == 5, "Pending cards should block using an old card to make space.")
	_assert(str(game._pending_reward_card.get("id", "")) == str(pending_before_use.get("id", "")), "Using an old card should not replace or clear the pending card.")
	var pending_card_id := str(game._pending_reward_card.get("id", ""))
	var pending_card_name := str(game._pending_reward_card.get("name", ""))
	game._on_reward_card_discard_requested(0)
	await process_frame
	_assert(game._card_hand.size() == 5, "Discarding should keep hand at five cards.")
	_assert(game._pending_reward_card.is_empty(), "Discarding should move the pending card into hand.")
	_assert(str(game._card_hand[game._card_hand.size() - 1].get("id", "")) == pending_card_id, "Discarding should preserve the pending card id.")
	_assert(str(game._card_hand[game._card_hand.size() - 1].get("name", "")) == pending_card_name, "Discarding should preserve the pending card name.")
	_assert(str(game._card_hand[game._card_hand.size() - 1].get("type_label", "")) != "", "Discarding should keep normalized card metadata.")
	_assert(game.ui._card_icon(game._card_hand[game._card_hand.size() - 1]) != "卡", "Discarding should not turn the kept card into a fallback card icon.")
	_assert(_hand_card_has_icon_text(game.ui, game._card_hand.size() - 1, game.ui._card_icon(game._card_hand[game._card_hand.size() - 1])), "Discarding should render the kept card with its resolved icon text.")
	_assert(game.ui._card_icon({"card_id": "boost"}) == "攻", "Card UI should recognize pending card aliases that use card_id.")
	_assert(game.ui._card_icon({"id": "unknown_debug_card"}) == "卡", "Unknown card icons should use a localized fallback instead of a question mark.")
	var before_alias_gold := game.gold
	_assert(game._apply_reward_card({"card_id": "gold"}), "Card effects should accept card_id aliases after normalization.")
	_assert(game.gold == before_alias_gold + 85, "Normalized card_id aliases should apply the default card values.")
	_assert(not game.ui.card_pending_panel.visible, "Discard mode should close after choosing a card.")
	_assert(game.ui.card_hand_toggle_button.text == "收起手牌", "Expanded card hand toggle should offer collapsing the hand.")
	var hovered_card := game.ui._card_controls[0]
	game.ui._on_card_mouse_entered(hovered_card, 0)
	_assert(game.ui.card_detail_panel.visible, "Hovering a hand card should show its detail panel.")
	_assert(game.ui.card_detail_description_label.text.contains("效果"), "Card detail panel should include the effect rarity label.")
	game.ui._on_card_hand_toggle_pressed()
	_assert(not game.ui._card_hand_expanded, "Card hand should collapse when toggled.")
	_assert(game.ui.card_hand_toggle_button.text == "展开手牌", "Collapsed card hand toggle should offer expanding the hand.")
	_assert(game.ui.card_hand_zone.size.x >= 76.0, "Collapsed card hand should leave enough width for its toggle label.")
	_assert(game.ui._card_controls.is_empty(), "Collapsed card hand should hide card controls so it does not block tower placement.")
	_assert(not game.ui.card_detail_panel.visible, "Collapsed card hand should hide stale card detail panels.")
	game.ui._on_card_hand_toggle_pressed()
	_assert(game.ui._card_hand_expanded, "Card hand should expand when toggled again.")
	_assert(game.ui.card_hand_toggle_button.text == "收起手牌", "Expanded card hand should restore the collapse label.")
	game.ui._on_card_hand_toggle_pressed()
	game.ui._on_card_hand_toggle_pressed()
	await create_timer(0.25).timeout
	_assert(game.ui._card_hand_expanded, "Rapid card hand toggles should keep the final expanded state.")
	_assert(game.ui.card_hand_zone.position == Vector2(592.0, 388.0), "Rapid card hand toggles should restore expanded hand position.")
	_assert(game.ui.card_hand_zone.size == Vector2(354.0, 146.0), "Rapid card hand toggles should restore expanded hand size.")
	game.ui._on_card_hand_toggle_pressed()
	game.ui._on_card_hand_toggle_pressed()
	game.ui._on_card_hand_toggle_pressed()
	await create_timer(0.25).timeout
	_assert(not game.ui._card_hand_expanded, "Rapid card hand toggles should keep the final collapsed state.")
	_assert(game.ui.card_hand_zone.position == Vector2(884.0, 410.0), "Rapid card hand toggles should restore collapsed hand position.")
	_assert(game.ui.card_hand_zone.size == Vector2(76.0, 112.0), "Rapid card hand toggles should restore collapsed hand size.")
	game.ui._on_card_hand_toggle_pressed()
	await create_timer(0.25).timeout
	var disable_drag_card := game.ui._card_controls[0]
	game.ui._start_card_drag(disable_drag_card, 0, Vector2(760.0, 480.0))
	game.ui._card_hand_expanded = false
	game.ui._update_card_hand_zone_layout(true)
	_assert(game.ui._card_hand_tween != null and game.ui._card_hand_tween.is_valid(), "Card hand disable setup should leave a layout tween running.")
	game.ui.set_card_hand_available(false)
	_assert(game.ui._card_hand_tween == null or not game.ui._card_hand_tween.is_valid(), "Disabling the card hand should stop hand layout tweens.")
	_assert(game.ui._drag_card_control == null, "Disabling the card hand should clear active card drags.")
	_assert(game.ui._card_controls.is_empty(), "Disabling the card hand should clear rendered card controls.")
	_assert(not game.ui.card_hand_zone.visible, "Disabling the card hand should hide the hand zone.")
	_assert(game.ui.card_hand_zone.position == Vector2(884.0, 410.0), "Disabling the card hand should restore collapsed hand position.")
	_assert(game.ui.card_hand_zone.size == Vector2(76.0, 112.0), "Disabling the card hand should restore collapsed hand size.")
	_assert(not game.ui.card_area_preview.visible, "Disabling the card hand should hide area previews.")
	game.ui.set_card_hand_available(true)
	game._card_hand.clear()
	game.ui.update_card_hand(game._card_hand, {}, false)

	game._add_card_to_hand_or_pending(game._make_debug_reward_card("gold"))
	var before_sell_card_gold := game.gold
	game._on_reward_card_sell_requested(0)
	await process_frame
	_assert(game._card_hand.is_empty(), "Selling a card should remove it from hand.")
	_assert(game.gold > before_sell_card_gold, "Selling a card should convert it into gold.")

	for card_id in ["boost", "heal", "gold", "boost", "heal"]:
		game._add_card_to_hand_or_pending(game._make_debug_reward_card(card_id))
	game._add_card_to_hand_or_pending(game._make_debug_reward_card("firestorm"))
	_assert(not game._pending_reward_card.is_empty(), "Full hand should show a pending new card.")
	game._on_reward_card_reject_requested()
	_assert(game._pending_reward_card.is_empty(), "Rejecting should discard the pending new card.")
	_assert(game._card_hand.size() == 5, "Rejecting a pending card should keep the old hand unchanged.")
	game._card_hand.clear()
	game.ui.update_card_hand(game._card_hand, {}, false)

	var missile_enemy := game._spawn_enemy("grunt", 200, 0.0, 0, 0.0, 0)
	await process_frame
	_assert(missile_enemy.game == game, "Spawned enemies should cache their Main reference.")
	game._add_card_to_hand_or_pending(game._make_debug_reward_card("missile"))
	var missile_card_control := game.ui._card_controls[game.ui._card_controls.size() - 1]
	game.ui._start_card_drag(missile_card_control, game._card_hand.size() - 1, Vector2(760.0, 480.0))
	_assert(not missile_card_control.visible, "Area attack cards should hide the card while dragging.")
	_assert(game.ui.card_area_preview.visible, "Area attack cards should show a circular range preview while dragging.")
	_assert(not game.ui.card_detail_panel.visible, "Dragging an area attack card should hide card detail panels.")
	game.ui.reject_dragged_card()
	_assert(missile_card_control.visible, "Rejected area card drags should restore the card.")
	_assert(not game.ui.card_area_preview.visible, "Rejected area card drags should hide the range preview.")
	_assert(not game.ui.card_detail_panel.visible, "Rejected area card drags should keep card detail panels hidden.")
	var particles_before_missile := _count_particles(game.particle_layer)
	game._on_reward_card_play_requested(game._card_hand.size() - 1, game.world_to_screen(missile_enemy.global_position))
	_assert(_count_particles(game.particle_layer) > particles_before_missile, "Missile card should spawn area particles.")
	await create_timer(0.25).timeout
	_assert(not is_instance_valid(missile_enemy) or missile_enemy.health < 200, "Missile card should damage or defeat enemies in its target area.")
	_assert(game._missile_effect_timer > 0.0, "Missile card should trigger a visible strike effect.")
	game._clear_enemies_and_projectiles()

	var cryo_enemy := game._spawn_enemy("runner", 100, 120.0, 0, 0.0, 0)
	await process_frame
	game._add_card_to_hand_or_pending(game._make_debug_reward_card("cryo"))
	game._on_reward_card_play_requested(game._card_hand.size() - 1, game.world_to_screen(cryo_enemy.global_position))
	await create_timer(0.25).timeout
	_assert(not is_instance_valid(cryo_enemy) or cryo_enemy.health <= 75, "Cryo card should damage or defeat enemies in its target area.")
	_assert(not is_instance_valid(cryo_enemy) or cryo_enemy.speed_multiplier < 1.0, "Cryo card should slow or defeat enemies in its area.")
	game._clear_enemies_and_projectiles()

	var fire_enemy := game._spawn_enemy("grunt", 100, 0.0, 0, 0.0, 0)
	await process_frame
	game._add_card_to_hand_or_pending(game._make_debug_reward_card("firestorm"))
	game._on_reward_card_play_requested(game._card_hand.size() - 1, game.world_to_screen(fire_enemy.global_position))
	await create_timer(0.25).timeout
	_assert(not is_instance_valid(fire_enemy) or fire_enemy.health <= 55, "Firestorm card should damage or defeat enemies across the map.")
	game._clear_enemies_and_projectiles()

	var freeze_enemy := game._spawn_enemy("runner", 100, 120.0, 0, 0.0, 0)
	await process_frame
	game._add_card_to_hand_or_pending(game._make_debug_reward_card("freeze"))
	game._on_reward_card_play_requested(game._card_hand.size() - 1, game.world_to_screen(freeze_enemy.global_position))
	await create_timer(0.25).timeout
	_assert(not is_instance_valid(freeze_enemy) or freeze_enemy.speed_multiplier <= 0.20, "Global freeze card should strongly slow or defeat all enemies.")
	game._clear_enemies_and_projectiles()

	var new_card_ids := ["bait_beacon", "road_spikes", "coin_magnet", "time_warp", "tower_swap", "overload_debt", "panic_button", "bounty_mark", "reroll_cache"]
	for card_id in new_card_ids:
		var card_definition := game._get_reward_card_definition(card_id)
		_assert(not card_definition.is_empty(), "New fun card should exist in the reward card pool: %s" % card_id)
		_assert(game.ui._card_icon(card_definition) != "卡", "New fun cards should have dedicated localized icons: %s" % card_id)
		_assert(str(game._make_debug_reward_card(card_id).get("id", "")) == card_id, "Debug card creation should support new fun card: %s" % card_id)

	var bait_enemy := game._spawn_enemy("grunt", 100, 80.0, 0, 0.0, 0)
	await process_frame
	bait_enemy.global_position = Vector2(240.0, 220.0)
	_assert(game._apply_reward_card(game._make_debug_reward_card("bait"), Vector2(300.0, 220.0)), "Bait beacon card should apply near enemies.")
	_assert(bait_enemy.attraction_time > 0.0 and bait_enemy.attraction_position == Vector2(300.0, 220.0), "Bait beacon should mark enemies with an attraction target.")
	game._clear_enemies_and_projectiles()

	var spike_enemy := game._spawn_enemy("grunt", 100, 0.0, 0, 0.0, 0)
	await process_frame
	spike_enemy.global_position = Vector2(260.0, 240.0)
	_assert(game._apply_reward_card(game._make_debug_reward_card("spikes"), spike_enemy.global_position), "Road spikes should deploy as a trap.")
	game._update_road_spike_traps(0.1)
	_assert(not is_instance_valid(spike_enemy) or spike_enemy.health < 100, "Road spikes should damage or defeat enemies that enter the trap.")
	_assert(not is_instance_valid(spike_enemy) or spike_enemy.speed_multiplier < 1.0, "Road spikes should slow or defeat enemies that enter the trap.")
	game._clear_enemies_and_projectiles()

	_assert(game._apply_reward_card(game._make_debug_reward_card("magnet"), Vector2.ZERO), "Coin magnet should activate without a target.")
	var magnet_gold_before := game.gold
	var magnet_enemy := game._spawn_enemy("grunt", 1, 0.0, 20, 0.0, 0)
	await process_frame
	magnet_enemy.take_damage(5)
	await process_frame
	_assert(game.gold > magnet_gold_before + 20, "Coin magnet should increase kill reward while active.")
	game._clear_enemies_and_projectiles()

	var warp_inside_enemy := game._spawn_enemy("runner", 100, 120.0, 0, 0.0, 0)
	var warp_outside_enemy := game._spawn_enemy("runner", 100, 120.0, 0, 0.0, 0)
	await process_frame
	warp_inside_enemy.global_position = Vector2(280.0, 260.0)
	warp_outside_enemy.global_position = Vector2(620.0, 260.0)
	_assert(game._apply_reward_card(game._make_debug_reward_card("warp"), warp_inside_enemy.global_position), "Time warp should affect active enemies.")
	_assert(not is_instance_valid(warp_inside_enemy) or warp_inside_enemy.speed_multiplier < 1.0, "Time warp should slow or defeat enemies inside the target area.")
	_assert(not is_instance_valid(warp_outside_enemy) or warp_outside_enemy.speed_multiplier > 1.0, "Time warp should haste or spare enemies outside the target area as a tradeoff.")
	game._clear_enemies_and_projectiles()

	var tower_for_fun_cards := game.get_active_towers()[0] as Tower
	tower_for_fun_cards.damage_multiplier = 1.0
	tower_for_fun_cards.fire_rate_multiplier = 1.0
	tower_for_fun_cards.damage_boost_time = 0.0
	tower_for_fun_cards.fire_rate_boost_time = 0.0
	var tower_damage_multiplier_before := tower_for_fun_cards.damage_multiplier
	var tower_fire_rate_multiplier_before := tower_for_fun_cards.fire_rate_multiplier
	_assert(game._apply_reward_card(game._make_debug_reward_card("swap"), tower_for_fun_cards.global_position), "Tower swap should apply to a nearby tower.")
	_assert(tower_for_fun_cards.damage_multiplier > tower_damage_multiplier_before, "Tower swap should boost the target tower damage.")
	_assert(tower_for_fun_cards.fire_rate_multiplier > tower_fire_rate_multiplier_before, "Tower swap should boost the target tower fire rate.")
	_assert(game._apply_reward_card(game._make_debug_reward_card("overload"), Vector2.ZERO), "Overload debt should apply to all active towers.")
	_assert(game._overload_debt_timer > 0.0, "Overload debt should schedule a negative phase.")
	game._update_reward_card_timers(game._overload_debt_timer + 0.1)
	_assert(tower_for_fun_cards.fire_rate_multiplier < 1.0, "Overload debt should reduce tower fire rate after the burst phase.")

	game.base_health = 3
	var panic_enemy := game._spawn_enemy("runner", 100, 120.0, 0, 0.0, 0)
	await process_frame
	_assert(game._apply_reward_card(game._make_debug_reward_card("panic"), Vector2.ZERO), "Panic button should always be usable.")
	_assert(game.base_health > 3, "Panic button should repair the base.")
	_assert(not is_instance_valid(panic_enemy) or panic_enemy.speed_multiplier <= 0.18, "Low-health panic button should strongly slow or defeat enemies.")
	game._clear_enemies_and_projectiles()

	var bounty_enemy := game._spawn_enemy("brute", 20, 0.0, 10, 0.0, 0)
	await process_frame
	bounty_enemy.global_position = Vector2(300.0, 260.0)
	_assert(game._apply_reward_card(game._make_debug_reward_card("bounty"), bounty_enemy.global_position), "Bounty mark should select an enemy in range.")
	var bounty_gold_before := game.gold
	bounty_enemy.take_damage(25)
	await process_frame
	_assert(game.gold >= bounty_gold_before + 130, "Bounty mark should add bonus gold when the marked enemy dies.")
	game._clear_enemies_and_projectiles()

	game._card_hand.clear()
	game._add_card_to_hand_or_pending(game._make_debug_reward_card("gold"))
	game._add_card_to_hand_or_pending(game._make_debug_reward_card("heal"))
	game._add_card_to_hand_or_pending(game._make_debug_reward_card("reroll"))
	var reroll_size_before := game._card_hand.size()
	game._on_reward_card_play_requested(game._card_hand.size() - 1, Vector2(500.0, 300.0))
	await process_frame
	_assert(game._card_hand.size() == reroll_size_before - 1, "Reroll cache should consume itself and replace one old card.")
	_assert(str(game._card_hand[game._card_hand.size() - 1].get("id", "")) != "reroll_cache", "Reroll cache should add a fresh reward card.")
	game._card_hand.clear()
	game.ui.update_card_hand(game._card_hand, {}, false)
	game.queue_free()
	await process_frame
	_clear_level_start_save_for_test()

	game = main_scene.instantiate() as Main
	root.add_child(game)
	await process_frame
	await process_frame
	game._on_game_start_pressed()
	await create_timer(0.35).timeout

	game.ui.toggle_console()
	_assert(game.ui.is_console_visible(), "Debug console should toggle open.")
	_assert(game.ui.console_panel.visible, "Console panel should be visible while opening.")
	await create_timer(0.15).timeout
	_assert(is_equal_approx(game.ui.console_panel.modulate.a, 1.0), "Console panel should fade in after opening.")
	_assert(game.ui.console_title_label.text.contains("回车执行") and not game.ui.console_title_label.text.contains("Enter"), "Console title should use localized enter-key wording.")
	_assert(game.ui.console_title_label.text.contains("Tab键补全"), "Console title should use localized tab-key wording.")
	game.ui.console_input.text = "gol"
	game.ui.console_input.caret_column = game.ui.console_input.text.length()
	game.ui._complete_console_input()
	_assert(game.ui.console_input.text == "gold ", "Console Tab completion should complete command names.")
	game.ui.console_input.text = "card cr"
	game.ui.console_input.caret_column = game.ui.console_input.text.length()
	game.ui._complete_console_input()
	_assert(game.ui.console_input.text == "card cryo ", "Console Tab completion should complete card arguments.")
	game.ui.console_input.text = "card bou"
	game.ui.console_input.caret_column = game.ui.console_input.text.length()
	game.ui._complete_console_input()
	_assert(game.ui.console_input.text == "card bounty ", "Console Tab completion should include new fun card arguments.")
	game.ui.console_input.text = "zzz"
	game.ui.console_input.caret_column = game.ui.console_input.text.length()
	game.ui._complete_console_input()
	_assert(game.ui.last_console_line.contains("没有可补全项"), "Console completion miss should use localized text.")
	game.ui.console_input.text = "c"
	game.ui.console_input.caret_column = game.ui.console_input.text.length()
	game.ui._complete_console_input()
	_assert(game.ui.last_console_line.contains("可选补全"), "Console multiple-match output should use localized text.")
	game.ui.toggle_console()
	_assert(not game.ui.is_console_visible(), "Debug console should toggle closed.")
	_assert(game.ui.console_panel.visible, "Console panel should stay visible during its close fade-out.")
	await create_timer(0.15).timeout
	_assert(not game.ui.console_panel.visible, "Console panel should hide after its close fade-out.")
	_assert(is_equal_approx(game.ui.console_panel.modulate.a, 0.0), "Console panel should be transparent after closing.")

	var console_gold_before := game.gold
	var gold_response := game._execute_console_command("gold 25")
	_assert(gold_response.contains("金币增加25，当前"), "Gold console command should return localized natural text.")
	_assert(not gold_response.contains("+=") and not gold_response.contains("->"), "Gold console command should not expose debug operators.")
	_assert(game.gold == console_gold_before + 25, "Gold console command should add gold.")
	var set_gold_response := game._execute_console_command("setgold %d" % game.gold)
	_assert(set_gold_response.contains("金币已设置为"), "Set-gold console command should return localized natural text.")
	_assert(not set_gold_response.contains(" = "), "Set-gold console command should not expose assignment formatting.")
	var damage_response := game._execute_console_command("damage 0")
	var heal_response := game._execute_console_command("heal 0")
	var basehp_response := game._execute_console_command("basehp %d" % game.base_health)
	_assert(damage_response.contains("基地生命：") and heal_response.contains("基地生命：") and basehp_response.contains("基地生命："), "Base-health console commands should use localized punctuation.")
	_assert(not damage_response.contains(" = ") and not heal_response.contains(" = ") and not basehp_response.contains(" = "), "Base-health console commands should not expose assignment formatting.")
	var help_response := game._execute_console_command("help")
	_assert(help_response.contains("可用命令") and help_response.contains("start：进入游戏"), "Console help should use localized command descriptions.")
	_assert(help_response.contains("boost（超频）") and help_response.contains("firestorm（火焰）"), "Console help should explain card arguments with localized names.")
	_assert(help_response.contains("bait（诱饵）") and help_response.contains("reroll（改签）"), "Console help should explain new fun card arguments with localized names.")
	_assert(not help_response.contains("boost, range, rate"), "Console help should not expose a bare English card-argument list.")
	var unknown_response := game._execute_console_command("unknown_command")
	_assert(unknown_response.contains("未知命令") and unknown_response.contains("可用命令"), "Unknown console command should point to localized help.")
	var status_response := game._execute_console_command("status")
	_assert(status_response.contains("当前状态：第") and status_response.contains("自动波次"), "Console status should use localized sentence text.")
	_assert(status_response.contains("自动波次是") or status_response.contains("自动波次否"), "Console status should use localized auto-wave booleans.")
	_assert(status_response.contains("游戏结束是") or status_response.contains("游戏结束否"), "Console status should use localized game-over booleans.")
	_assert(not status_response.contains("true") and not status_response.contains("false"), "Console status should not expose English boolean literals.")
	_assert(not status_response.contains("自动=") and not status_response.contains("游戏结束="), "Console status should not expose key-value debug formatting.")

	var build_manager := game.build_manager
	var invalid_road_tile := Vector2i(0, 7)
	var valid_tile := Vector2i(1, 1)
	_assert(build_manager._get_tower_display_name({"name": "  建造测试塔  "}) == "建造测试塔", "Build manager tower display helper should trim configured names.")
	_assert(build_manager._get_tower_display_name({"name": ""}) == "防御塔", "Build manager tower display helper should use a localized fallback name.")
	_assert(build_manager._get_default_tower_display_name() == "防御塔", "Build manager default tower display-name helper should use localized text.")
	_assert(build_manager._selected_tower_name == build_manager._get_default_tower_display_name(), "Build manager selected tower name should initialize through the default display-name helper.")
	_assert(build_manager._format_build_mode_entered_message_text("基础塔") == "选择一个有效格子建造基础塔。", "Build manager build-mode message formatter should use localized text.")
	_assert(build_manager._get_build_cancelled_message_text() == "已取消建造。", "Build manager cancel message helper should use localized text.")
	_assert(build_manager._get_support_layer_full_message_text() == "这座塔已经有增益层。", "Build manager support-layer message helper should use localized text.")
	_assert(build_manager._format_support_layer_applied_message_text("基础塔", "增幅塔") == "已为基础塔叠加增幅塔。", "Build manager support-layer formatter should use localized text.")
	_assert(build_manager._format_tower_built_message_text("基础塔") == "已建造基础塔。", "Build manager built message formatter should use localized text.")
	_assert(build_manager._get_no_tower_selected_message_text() == "请先选择一座防御塔。", "Build manager no-selection helper should use localized text.")
	_assert(build_manager._get_tower_max_level_message_text() == "防御塔已达到最高等级。", "Build manager max-level helper should use localized text.")
	_assert(build_manager._get_upgrade_insufficient_gold_message_text() == "金币不足，无法升级。", "Build manager upgrade gold helper should use localized text.")
	_assert(build_manager._get_tower_upgraded_message_text() == "防御塔已升级。", "Build manager upgraded helper should use localized text.")
	_assert(build_manager._get_tower_sold_message_text() == "防御塔已出售。", "Build manager sold helper should use localized text.")
	_assert(build_manager._get_build_insufficient_gold_error_text() == "金币不足。", "Build manager build-gold error helper should use localized text.")
	_assert(build_manager._get_build_outside_map_error_text() == "请在地图内建造。", "Build manager outside-map error helper should use localized text.")
	_assert(build_manager._get_support_requires_existing_tower_error_text() == "增益塔必须叠加在已有塔上。", "Build manager support target error helper should use localized text.")
	_assert(build_manager._get_support_layer_full_error_text() == "每座塔只能叠加一层增益塔。", "Build manager support full error helper should use localized text.")
	_assert(build_manager._get_build_occupied_tile_error_text() == "该格子已被占用。", "Build manager occupied-tile error helper should use localized text.")
	_assert(build_manager._get_build_road_tile_error_text() == "不能建在道路上。", "Build manager road-tile error helper should use localized text.")

	game._on_tower_build_requested("basic")
	_assert(build_manager.is_building, "Selecting a tower type should enter build mode.")
	_assert(build_manager.selected_tower_type_id == "basic", "Build mode should remember selected tower type.")
	_assert(build_manager._road_cell_lookup.size() == build_manager.road_cells.size(), "Build manager should cache road cells with Vector2i keys.")
	_assert(build_manager._road_cell_lookup.has(invalid_road_tile), "Build manager road cache should identify road tiles without string key allocation.")
	_assert(not build_manager.get_build_error(invalid_road_tile).is_empty(), "Road tile should be blocked.")
	_assert(build_manager.get_build_error(valid_tile).is_empty(), "Open tile should be buildable.")

	var built := build_manager.try_build_at(build_manager.grid_to_center(valid_tile))
	await process_frame
	_assert(built, "Basic tower should build on a valid tile.")
	_assert(_count_particles(game.particle_layer) > 0, "Building a tower should spawn build particles.")
	_assert(game.gold == console_gold_before + 25 - 50, "Building basic tower should spend its cost.")
	_assert(game.tower_layer.get_child_count() == 1, "Tower layer should contain one tower.")
	_assert(game.get_active_towers().size() == 1, "Built towers should be tracked in the active tower cache.")
	_assert(build_manager._occupied_tiles.has(valid_tile), "Built towers should occupy Vector2i grid keys.")
	_assert(not build_manager.is_building, "Successful build should leave build mode.")
	var basic_tower := game.tower_layer.get_child(0) as Tower
	_assert(basic_tower._get_tower_display_name({"name": "  面板测试塔  "}) == "面板测试塔", "Tower display helper should trim configured names.")
	_assert(basic_tower._get_tower_display_name({"name": ""}) == "基础塔", "Tower display helper should use a localized fallback name.")
	_assert(basic_tower.display_name == "基础塔", "Tower display name should initialize through the localized fallback helper.")
	_assert(basic_tower._get_default_tower_display_name() == "基础塔", "Tower default display-name helper should use localized text.")
	_assert(basic_tower._get_augmentation_display_name({"name": "  增幅测试塔  "}) == "增幅测试塔", "Tower augmentation display helper should trim configured names.")
	_assert(basic_tower._get_augmentation_display_name({"name": ""}) == "增幅塔", "Tower augmentation display helper should use a localized fallback name.")
	_assert(basic_tower._get_default_augmentation_display_name() == "增幅塔", "Tower default augmentation display-name helper should use localized text.")
	_assert(basic_tower._get_default_trait_text() == "标准弹道", "Tower default trait helper should use localized text.")
	_assert(basic_tower._get_max_level_preview_text() == "已达到最终形态", "Tower max-level preview helper should use localized text.")
	_assert(basic_tower._format_upgrade_preview_text(2, "强化核心") == "等级2：强化核心", "Tower upgrade preview formatter should use localized text.")
	_assert(basic_tower._get_upgrade_preview_trait_name("basic", 2) == "强化核心", "Tower basic level-2 preview trait helper should use localized text.")
	_assert(basic_tower._get_upgrade_preview_trait_name("basic", 3) == "过载中枢", "Tower basic level-3 preview trait helper should use localized text.")
	_assert(basic_tower._get_upgrade_preview_trait_name("rapid", 2) == "双联枪管", "Tower rapid level-2 preview trait helper should use localized text.")
	_assert(basic_tower._get_upgrade_preview_trait_name("rapid", 3) == "三联齐射", "Tower rapid level-3 preview trait helper should use localized text.")
	_assert(basic_tower._get_upgrade_preview_trait_name("cannon", 2) == "爆破弹头", "Tower cannon level-2 preview trait helper should use localized text.")
	_assert(basic_tower._get_upgrade_preview_trait_name("cannon", 3) == "震荡核心", "Tower cannon level-3 preview trait helper should use localized text.")
	_assert(basic_tower._get_upgrade_preview_trait_name("sniper", 2) == "校准透镜", "Tower sniper level-2 preview trait helper should use localized text.")
	_assert(basic_tower._get_upgrade_preview_trait_name("sniper", 3) == "处决射击", "Tower sniper level-3 preview trait helper should use localized text.")
	_assert(basic_tower._get_shotgun_upgrade_trait_name(2) == "扩容弹仓", "Tower shotgun level-2 trait helper should use localized text.")
	_assert(basic_tower._get_shotgun_upgrade_trait_name(3) == "碎星齐射", "Tower shotgun level-3 trait helper should use localized text.")
	_assert(basic_tower._format_augmentation_trait_line_text("增幅塔") == "\n增幅：增幅塔", "Tower augmentation trait formatter should use localized text.")
	_assert(basic_tower._get_base_trait_text("rapid") == "单管高速射击", "Tower rapid base trait helper should use localized text.")
	_assert(basic_tower._get_base_trait_text("cannon") == "重弹单体打击", "Tower cannon base trait helper should use localized text.")
	_assert(basic_tower._get_base_trait_text("sniper") == "超远距离点杀", "Tower sniper base trait helper should use localized text.")
	_assert(basic_tower._get_base_trait_text("basic") == "均衡防御火力", "Tower basic base trait helper should use localized text.")
	_assert(basic_tower._format_basic_level_two_trait_text() == "强化核心：射程扩大，装填加快", "Tower basic level-2 trait formatter should use localized text.")
	_assert(basic_tower._format_basic_level_three_trait_text() == "过载中枢：高伤害高射程均衡压制", "Tower basic level-3 trait formatter should use localized text.")
	_assert(basic_tower._format_rapid_level_two_trait_text() == "双联枪管：每次攻击发射两枚弹丸", "Tower rapid level-2 trait formatter should use localized text.")
	_assert(basic_tower._format_rapid_level_three_trait_text() == "三联齐射：三枚弹丸形成高速弹幕", "Tower rapid level-3 trait formatter should use localized text.")
	_assert(basic_tower._format_shotgun_level_two_trait_text() == "扩容弹仓：更宽扇形和更多弹丸", "Tower shotgun level-2 trait formatter should use localized text.")
	_assert(basic_tower._format_shotgun_level_three_trait_text() == "碎星齐射：高密度近距覆盖", "Tower shotgun level-3 trait formatter should use localized text.")
	_assert(basic_tower._format_cannon_level_two_trait_text() == "爆破弹头：爆破半径扩大，溅射伤害提高", "Tower cannon level-2 trait formatter should use localized text.")
	_assert(basic_tower._format_cannon_level_three_trait_text() == "震荡核心：大范围高强度溅射炮击", "Tower cannon level-3 trait formatter should use localized text.")
	_assert(basic_tower._format_sniper_level_two_trait_text() == "校准透镜：极大提高单发伤害和射程", "Tower sniper level-2 trait formatter should use localized text.")
	_assert(basic_tower._format_sniper_level_three_trait_text() == "处决射击：对低生命敌人造成致命伤害", "Tower sniper level-3 trait formatter should use localized text.")
	_assert(game.ui.tower_panel.visible, "Selecting a tower should show the tower panel.")
	_assert(game.ui.tower_panel_close_button.text == "关闭", "Tower panel should expose a localized close action.")
	game.ui._on_tower_panel_close_pressed()
	await process_frame
	_assert(game.ui.tower_panel.visible, "Tower panel close should keep the panel visible during its close animation.")
	await game.get_tree().create_timer(0.25).timeout
	_assert(not game.ui.tower_panel.visible, "Tower panel close should hide the tower panel.")
	_assert(is_equal_approx(game.ui.tower_panel.modulate.a, 0.0), "Tower panel close animation should fade the panel out.")
	_assert(build_manager.selected_tower == null, "Tower panel close should clear the selected tower.")
	_assert(str(game.get_tower_config("basic").get("category", "")) == "weapon", "Basic tower should be categorized as a weapon tower.")
	_assert(str(game.get_tower_config("amplifier").get("category", "")) == "support", "Amplifier should be categorized as a support tower.")
	build_manager.enter_build_mode("amplifier")
	_assert(build_manager.get_build_error(valid_tile).is_empty(), "Support tower should be buildable on an existing tower.")
	var support_built := build_manager.try_build_at(build_manager.grid_to_center(valid_tile))
	await process_frame
	_assert(support_built, "Support tower should apply to an existing tower.")
	_assert(game.tower_layer.get_child_count() == 1, "Support tower should stack instead of creating a second tower node.")
	_assert(not basic_tower.augmentation_id.is_empty(), "Support tower should mark the target tower as augmented.")
	build_manager.enter_build_mode("amplifier")
	_assert(not build_manager.get_build_error(valid_tile).is_empty(), "A tower should reject a second support layer.")
	var projectile_cache_probe := Projectile.new()
	projectile_cache_probe.setup(null, 10, 360.0, 48.0, 5)
	_assert(is_equal_approx(projectile_cache_probe._hit_radius_sq, projectile_cache_probe.hit_radius * projectile_cache_probe.hit_radius), "Projectiles should cache hit radius squared.")
	_assert(is_equal_approx(projectile_cache_probe._splash_radius_sq, projectile_cache_probe.splash_radius * projectile_cache_probe.splash_radius), "Projectiles should cache splash radius squared.")
	var cannon_visual_probe := Projectile.new()
	cannon_visual_probe.setup(null, 10, 360.0, 64.0, 5, Color(1.0, 0.58, 0.22), 0, Vector2.RIGHT, 200.0, Projectile.VISUAL_CANNON)
	cannon_visual_probe.set_game(game)
	_assert(cannon_visual_probe.visual_profile == Projectile.VISUAL_CANNON, "Cannon projectiles should carry a distinct visual profile.")
	_assert(cannon_visual_probe.projectile_size > projectile_cache_probe.projectile_size, "Cannon projectiles should draw heavier than standard shots.")
	var cannon_effects_before := _count_named_children(game.impact_layer, "CannonImpactEffect")
	cannon_visual_probe._apply_impact_damage(Vector2(120.0, 120.0))
	var cannon_impact_effect: Node = _find_impact_effect(game.impact_layer, "CannonImpactEffect")
	_assert(_count_named_children(game.impact_layer, "CannonImpactEffect") > cannon_effects_before, "Cannon impacts should spawn a dedicated range effect.")
	_assert(cannon_impact_effect != null and is_equal_approx(float(cannon_impact_effect.get("radius")), cannon_visual_probe.splash_radius), "Cannon impact visuals should match the real splash radius.")
	cannon_visual_probe.free()
	var projectile_direction_target := Enemy.new()
	projectile_direction_target.setup([Vector2.ZERO, Vector2(100.0, 0.0)], 100, 0.0, 0, game.enemy_type_configs["grunt"])
	projectile_direction_target.global_position = Vector2(100.0, 0.0)
	var projectile_direction_probe := Projectile.new()
	projectile_direction_probe.setup(projectile_direction_target, 1, 100.0, 0.0, 0, Color(1.0, 0.83, 0.2), 0, Vector2.ZERO, 250.0)
	_assert(is_equal_approx(projectile_direction_probe.max_travel_distance, 250.0), "Projectile setup should expose max travel distance without legacy motion flags.")
	projectile_direction_target.global_position = Vector2(0.0, 100.0)
	projectile_direction_probe._process(0.1)
	_assert(projectile_direction_probe._travel_direction.is_equal_approx(Vector2.RIGHT), "Projectiles should cache their travel direction for trail placement.")
	_assert(is_equal_approx(projectile_direction_probe.global_position.y, 0.0), "Projectiles should not track targets after firing.")
	projectile_direction_probe.free()
	projectile_direction_target.free()
	var sniper_screen_probe := Projectile.new()
	sniper_screen_probe.global_position = game.camera.global_position
	sniper_screen_probe.setup(null, 10, 1000.0, 0.0, 0, Color(0.86, 0.82, 1.0), 0, Vector2.RIGHT, 32.0, Projectile.VISUAL_SNIPER)
	game.add_projectile(sniper_screen_probe)
	sniper_screen_probe._process(0.05)
	_assert(not sniper_screen_probe.is_queued_for_deletion(), "Sniper projectiles should ignore range expiry while still on screen.")
	sniper_screen_probe.global_position = game.camera.global_position + Vector2(2000.0, 0.0)
	sniper_screen_probe._process(0.05)
	_assert(sniper_screen_probe.is_queued_for_deletion(), "Sniper projectiles should disappear after leaving the visible screen.")
	await process_frame
	game.add_projectile(projectile_cache_probe)
	_assert(projectile_cache_probe.game == game, "Projectiles should cache their Main reference when added.")
	_assert(game.get_active_projectiles().size() == 1, "Added projectiles should be tracked in the active projectile cache.")
	projectile_cache_probe.queue_free()
	await process_frame
	_assert(game.get_active_projectiles().is_empty(), "Freed projectiles should leave the active projectile cache.")

	game.gold = 0
	build_manager.enter_build_mode("sniper")
	var sniper_tile := Vector2i(2, 1)
	_assert(build_manager._selected_tower_cost == int(game.get_tower_config("sniper").get("cost", 0)), "Build manager should cache selected tower cost.")
	_assert(is_equal_approx(build_manager._selected_tower_range, float(game.get_tower_config("sniper").get("range", 0.0))), "Build manager should cache selected tower range.")
	var blocked_by_gold := build_manager.try_build_at(build_manager.grid_to_center(sniper_tile))
	await process_frame
	_assert(not blocked_by_gold, "Expensive tower should fail without enough gold.")
	_assert(game.tower_layer.get_child_count() == 1, "Failed build should not add a tower.")
	_assert(game.get_active_towers().size() == 1, "Failed builds should not change the active tower cache.")
	_assert(not build_manager._occupied_tiles.has(sniper_tile), "Failed builds should not reserve occupied grid keys.")
	game.gold = 400

	build_manager.enter_build_mode("sniper")
	var sniper_built := build_manager.try_build_at(build_manager.grid_to_center(sniper_tile))
	await process_frame
	_assert(sniper_built, "Sniper tower should build with enough gold.")
	var sniper := game.tower_layer.get_child(1) as Tower
	_assert(sniper.tower_type_id == "sniper", "Built tower should keep its tower type.")
	_assert(sniper.attack_range > 180.0, "Sniper tower should have long range.")
	_assert(sniper.projectile_speed >= 900.0, "Sniper tower should use high-speed rounds for long-range hits.")
	_assert(game.get_active_towers().size() == 2, "Tower cache should include every successfully built tower.")

	build_manager.select_tower(sniper)
	_assert(not game.ui.upgrade_button.text.contains("$") and game.ui.upgrade_button.text.contains("金币"), "Tower upgrade button should use localized currency text.")
	_assert(not game.ui.sell_button.text.contains("$") and game.ui.sell_button.text.contains("金币"), "Tower sell button should use localized currency text.")
	_assert(game.ui._format_tower_panel_info_text(sniper).contains("等级 %d" % sniper.level), "Tower panel info formatter should include localized level text.")
	_assert(game.ui._get_tower_upgrade_button_text(sniper) == "升级（%d金币）" % sniper.get_upgrade_cost(), "Tower upgrade button formatter should use localized currency text.")
	_assert(not game.ui._is_tower_upgrade_button_disabled(sniper), "Tower upgrade disabled helper should keep upgradeable towers interactive.")
	_assert(game.ui._format_tower_sell_button_text(sniper) == "出售（%d金币）" % sniper.get_sell_value(), "Tower sell button formatter should use localized currency text.")
	var sniper_base_damage := sniper.get_effective_damage()
	var sniper_base_range := int(sniper.get_effective_range())
	var sniper_base_interval := sniper.get_effective_attack_interval()
	sniper.apply_damage_boost(1.5, 0.05)
	sniper.apply_range_boost(1.25, 0.05)
	sniper.apply_fire_rate_boost(2.0, 0.05)
	game.ui.show_tower_panel(sniper)
	_assert(game.ui.tower_info_label.text.contains("伤害 %d" % sniper.get_effective_damage()), "Tower panel should display boosted effective damage.")
	_assert(game.ui.tower_info_label.text.contains("射程 %d" % int(sniper.get_effective_range())), "Tower panel should display boosted effective range.")
	_assert(game.ui.tower_info_label.text.contains("间隔 %.2f秒" % sniper.get_effective_attack_interval()), "Tower panel should display boosted effective attack interval.")
	await create_timer(0.12).timeout
	_assert(game.ui.tower_info_label.text.contains("伤害 %d" % sniper_base_damage), "Tower panel should refresh when temporary damage boosts expire.")
	_assert(game.ui.tower_info_label.text.contains("射程 %d" % sniper_base_range), "Tower panel should refresh when temporary range boosts expire.")
	_assert(game.ui.tower_info_label.text.contains("间隔 %.2f秒" % sniper_base_interval), "Tower panel should refresh when temporary fire-rate boosts expire.")
	var before_upgrade_gold := game.gold
	var sniper_upgrade_cost := sniper.get_upgrade_cost()
	var cached_sniper_upgrade_costs: Array[int] = sniper._upgrade_costs
	_assert(cached_sniper_upgrade_costs == [130, 220], "Sniper tower should cache its upgrade cost table.")
	_assert(is_same(cached_sniper_upgrade_costs, sniper._upgrade_costs), "Repeated upgrade cost reads should reuse the cached cost table.")
	_assert(sniper.get_upgrade_preview().begins_with("等级2"), "Tower upgrade preview should use localized level text.")
	build_manager.upgrade_selected()
	await process_frame
	_assert(sniper.level == 2, "Upgrade should raise tower level.")
	_assert(_count_named_children(game.particle_layer, "UpgradeParticles") > 0, "Upgrading a tower should spawn upgrade particles.")
	_assert(game.gold == before_upgrade_gold - sniper_upgrade_cost, "Upgrade should spend its tower-specific level 2 cost.")
	_assert(sniper.damage >= 76 and sniper.attack_range >= 250.0, "Sniper upgrade should feel like a major precision improvement.")
	_assert(sniper.get_trait_summary().contains("校准"), "Upgraded sniper should expose a distinctive upgrade trait.")
	_assert(not game.ui.upgrade_button.disabled and game.ui.upgrade_button.mouse_default_cursor_shape == Control.CURSOR_POINTING_HAND, "Upgradeable tower panels should keep an interactive upgrade cursor.")
	game.gold += sniper.get_upgrade_cost()
	build_manager.upgrade_selected()
	await process_frame
	_assert(sniper.level == 3, "Second upgrade should bring the sniper tower to max level.")
	_assert(game.ui.upgrade_button.disabled, "Max-level tower panels should disable the upgrade button.")
	_assert(game.ui.upgrade_button.mouse_default_cursor_shape == Control.CURSOR_ARROW, "Disabled max-level upgrade buttons should use the default cursor.")
	_assert(game.ui._get_tower_upgrade_button_text(sniper) == "已满级", "Tower upgrade button formatter should expose the max-level state.")
	_assert(game.ui._is_tower_upgrade_button_disabled(sniper), "Tower upgrade disabled helper should disable max-level towers.")

	var rapid_upgrade_test := Tower.new()
	rapid_upgrade_test.setup(game, Vector2i(0, 0), game.get_tower_config("rapid"))
	var rapid_base_damage := rapid_upgrade_test.damage
	_assert(rapid_upgrade_test._upgrade_costs == [90, 155], "Rapid tower should cache its tower-specific upgrade costs.")
	rapid_upgrade_test.upgrade()
	_assert(rapid_upgrade_test.damage == rapid_base_damage + 2, "Rapid tower level 2 should keep damage growth modest after the balance pass.")
	_assert(rapid_upgrade_test.shots_per_attack == 2, "Rapid tower level 2 should unlock double shots.")
	rapid_upgrade_test.upgrade()
	_assert(rapid_upgrade_test.damage == rapid_base_damage + 5, "Rapid tower max-level damage growth should stay lower than the old steep ramp.")
	_assert(rapid_upgrade_test.shots_per_attack == 3, "Rapid tower level 3 should unlock triple shots.")

	var shotgun_upgrade_test := Tower.new()
	shotgun_upgrade_test.setup(game, Vector2i(0, 0), game.get_tower_config("shotgun"))
	_assert(shotgun_upgrade_test.shots_per_attack >= 5, "Shotgun tower should start with multiple pellets.")
	_assert(shotgun_upgrade_test.spread_angle > 0.0, "Shotgun tower should fire in a spread.")
	_assert(shotgun_upgrade_test._get_projectile_visual_profile() == Projectile.VISUAL_SHOTGUN, "Shotgun towers should mark pellets with a shotgun visual profile.")
	var shotgun_cones_before := _count_named_children(game.impact_layer, "ShotgunConeEffect")
	shotgun_upgrade_test._spawn_fire_visuals(Vector2.RIGHT, shotgun_upgrade_test.shots_per_attack)
	var shotgun_cone_effect: Node = _find_impact_effect(game.impact_layer, "ShotgunConeEffect")
	_assert(_count_named_children(game.impact_layer, "ShotgunConeEffect") > shotgun_cones_before, "Shotgun fire should spawn a visible cone effect.")
	_assert(shotgun_cone_effect != null and is_equal_approx(float(shotgun_cone_effect.get("spread_angle")), shotgun_upgrade_test.spread_angle), "Shotgun cone visuals should use the real spread angle.")
	shotgun_upgrade_test.global_position = Vector2(128.0, 128.0)
	var shotgun_target_probe := Enemy.new()
	shotgun_target_probe.global_position = shotgun_upgrade_test.global_position + Vector2.RIGHT * 160.0
	var projectiles_before_shotgun_fire := game.get_active_projectiles().size()
	shotgun_upgrade_test._fire_at(shotgun_target_probe)
	var spawned_shotgun_projectiles: Array[Projectile] = []
	for projectile_index in range(projectiles_before_shotgun_fire, game.get_active_projectiles().size()):
		spawned_shotgun_projectiles.append(game.get_active_projectiles()[projectile_index])
	_assert(spawned_shotgun_projectiles.size() == shotgun_upgrade_test.shots_per_attack, "Shotgun fire should spawn one projectile per pellet.")
	_assert(spawned_shotgun_projectiles.all(func(projectile: Projectile) -> bool: return projectile.target == null), "Shotgun pellets should not carry the tower target after firing.")
	_assert(spawned_shotgun_projectiles.all(func(projectile: Projectile) -> bool: return projectile.max_travel_distance > shotgun_upgrade_test.get_effective_range()), "Non-sniper tower projectiles should travel beyond the tower targeting range.")
	_assert(shotgun_upgrade_test._recoil_timer > 0.0, "Tower fire should trigger a recoil animation timer.")
	_assert(shotgun_upgrade_test._recoil_duration > 0.0 and shotgun_upgrade_test._recoil_duration <= shotgun_upgrade_test.get_effective_attack_interval(), "Tower recoil duration should stay aligned to the active attack interval.")
	_assert(shotgun_upgrade_test._recoil_direction.dot(Vector2.RIGHT) < -0.90, "Tower recoil should move opposite the firing direction.")
	_assert(shotgun_upgrade_test._get_recoil_offset().x < 0.0, "Tower recoil offset should pull the tower body backward immediately after firing.")
	var shotgun_recoil_duration := shotgun_upgrade_test._recoil_duration
	shotgun_upgrade_test._process(shotgun_recoil_duration + 0.02)
	_assert(shotgun_upgrade_test._recoil_timer <= 0.0 and shotgun_upgrade_test._get_recoil_offset() == Vector2.ZERO, "Tower recoil should decay back to the base position after its animation window.")
	var shotgun_min_angle := INF
	var shotgun_max_angle := -INF
	for pellet in spawned_shotgun_projectiles:
		var pellet_angle := Vector2.RIGHT.angle_to(pellet._travel_direction)
		shotgun_min_angle = minf(shotgun_min_angle, pellet_angle)
		shotgun_max_angle = maxf(shotgun_max_angle, pellet_angle)
	_assert(shotgun_min_angle < -0.08 and shotgun_max_angle > 0.08, "Shotgun pellets should fan out to both sides of the tower aim direction.")
	_assert(shotgun_max_angle - shotgun_min_angle >= shotgun_upgrade_test.spread_angle * 0.90, "Shotgun pellet directions should cover the configured spread angle.")
	shotgun_target_probe.free()
	game._clear_enemies_and_projectiles()
	await process_frame
	shotgun_upgrade_test.upgrade()
	_assert(shotgun_upgrade_test.shots_per_attack >= 6, "Shotgun upgrades should increase pellet count.")

	var cannon_upgrade_test := Tower.new()
	cannon_upgrade_test.setup(game, Vector2i(0, 0), game.get_tower_config("cannon"))
	_assert(cannon_upgrade_test._upgrade_costs == [120, 205], "Cannon tower should cache its tower-specific upgrade costs.")
	_assert(cannon_upgrade_test.splash_radius >= 56.0 and cannon_upgrade_test.splash_damage_ratio >= 0.52, "Cannon tower should have a larger baseline area damage profile.")
	_assert(cannon_upgrade_test._get_projectile_visual_profile() == Projectile.VISUAL_CANNON, "Cannon towers should mark shells with a cannon visual profile.")
	cannon_upgrade_test.upgrade()
	_assert(cannon_upgrade_test.splash_radius >= 74.0 and cannon_upgrade_test.splash_damage_ratio >= 0.62, "Cannon tower level 2 should expand splash radius and reduce splash damage falloff.")
	cannon_upgrade_test.upgrade()
	_assert(cannon_upgrade_test.splash_radius >= 96.0 and cannon_upgrade_test.splash_damage_ratio >= 0.78, "Cannon tower level 3 should deliver a substantially larger splash zone.")
	_assert(cannon_upgrade_test._effective_splash_damage == int(round(float(cannon_upgrade_test.damage) * cannon_upgrade_test.splash_damage_ratio * cannon_upgrade_test.damage_multiplier)), "Tower upgrades should refresh cached splash damage.")

	var basic_recoil_test := Tower.new()
	var rapid_recoil_test := Tower.new()
	var sniper_recoil_test := Tower.new()
	basic_recoil_test.setup(game, Vector2i(0, 0), game.get_tower_config("basic"))
	rapid_recoil_test.setup(game, Vector2i(0, 0), game.get_tower_config("rapid"))
	sniper_recoil_test.setup(game, Vector2i(0, 0), game.get_tower_config("sniper"))
	_assert(rapid_recoil_test._get_recoil_distance(rapid_recoil_test.shots_per_attack) < basic_recoil_test._get_recoil_distance(basic_recoil_test.shots_per_attack), "Rapid tower recoil should be shorter and snappier than a basic tower.")
	_assert(sniper_recoil_test._get_recoil_distance(sniper_recoil_test.shots_per_attack) > basic_recoil_test._get_recoil_distance(basic_recoil_test.shots_per_attack), "Sniper tower recoil should read heavier than a basic tower.")
	_assert(cannon_upgrade_test._get_recoil_distance(cannon_upgrade_test.shots_per_attack) > shotgun_upgrade_test._get_recoil_distance(shotgun_upgrade_test.shots_per_attack), "Cannon tower recoil should be the heaviest weapon-tower kick.")
	basic_recoil_test._trigger_recoil(Vector2.RIGHT, basic_recoil_test.shots_per_attack)
	cannon_upgrade_test._trigger_recoil(Vector2.RIGHT, cannon_upgrade_test.shots_per_attack)
	sniper_recoil_test._trigger_recoil(Vector2.RIGHT, sniper_recoil_test.shots_per_attack)
	_assert(cannon_upgrade_test._recoil_duration > basic_recoil_test._recoil_duration and sniper_recoil_test._recoil_duration > basic_recoil_test._recoil_duration, "Cannon and sniper recoil should return more slowly than basic tower recoil.")
	rapid_recoil_test.apply_fire_rate_boost(2.0, 1.0)
	rapid_recoil_test._trigger_recoil(Vector2.RIGHT, rapid_recoil_test.shots_per_attack)
	_assert(rapid_recoil_test._recoil_duration <= rapid_recoil_test.get_effective_attack_interval(), "Fire-rate boosted towers should use a recoil duration that still fits the boosted interval.")

	var scan_a := Tower.new()
	var scan_b := Tower.new()
	scan_a.setup(game, Vector2i(1, 1), game.get_tower_config("basic"))
	scan_b.setup(game, Vector2i(2, 1), game.get_tower_config("basic"))
	_assert(scan_a._get_next_target_scan_interval() >= Tower.TARGET_SCAN_INTERVAL, "Tower target scan interval should keep the base throttle.")
	_assert(not is_equal_approx(scan_a._get_next_target_scan_interval(), scan_b._get_next_target_scan_interval()), "Tower target scans should be staggered by grid position.")
	_assert(is_equal_approx(scan_a._effective_range, scan_a.get_effective_range()), "Tower effective range should be cached.")
	_assert(is_equal_approx(scan_a._effective_range_sq, scan_a.get_effective_range() * scan_a.get_effective_range()), "Tower effective range squared should be cached for target checks.")
	_assert(scan_a._effective_damage == scan_a.damage, "Tower attack damage should be cached for projectile creation.")
	scan_a.apply_range_boost(1.5, 0.05)
	_assert(is_equal_approx(scan_a._effective_range, scan_a.attack_range * 1.5), "Range boosts should refresh the cached tower range.")
	scan_a._process(0.10)
	_assert(is_equal_approx(scan_a._effective_range, scan_a.attack_range), "Expired range boosts should restore the cached tower range.")
	scan_a.apply_damage_boost(1.5, 0.05)
	_assert(scan_a._effective_damage == int(round(float(scan_a.damage) * 1.5)), "Damage boosts should refresh cached tower damage.")
	scan_a._process(0.10)
	_assert(scan_a._effective_damage == scan_a.damage, "Expired damage boosts should restore cached tower damage.")
	var cached_scan_interval_before_upgrade := scan_a._get_next_target_scan_interval()
	scan_a.upgrade()
	_assert(is_equal_approx(scan_a._effective_range, scan_a.attack_range), "Tower upgrades should refresh cached effective range.")
	_assert(scan_a._effective_damage == scan_a.damage, "Tower upgrades should refresh cached effective damage.")
	_assert(not is_equal_approx(scan_a._get_next_target_scan_interval(), cached_scan_interval_before_upgrade), "Tower upgrades should refresh cached scan staggering.")
	var freed_target_probe := Enemy.new()
	freed_target_probe.setup([Vector2.ZERO, Vector2(100.0, 0.0)], 100, 0.0, 0, game.enemy_type_configs["grunt"])
	scan_a._current_target = freed_target_probe
	freed_target_probe.free()
	_assert(not scan_a._is_target_valid(scan_a._current_target), "Tower target validation should tolerate previously freed enemies.")
	var progress_enemy := Enemy.new()
	progress_enemy.setup([Vector2.ZERO, Vector2(100.0, 0.0)], 100, 50.0, 0, game.enemy_type_configs["grunt"])
	progress_enemy._process(1.0)
	_assert(is_equal_approx(progress_enemy.get_path_progress(), 0.5), "Enemy path progress should be cached as enemies move.")
	_assert(is_equal_approx(progress_enemy._path_progress, progress_enemy.get_path_progress()), "Tower targeting should read the cached enemy path progress.")

	var sniper_upgrade_test := Tower.new()
	sniper_upgrade_test.setup(game, Vector2i(0, 0), game.get_tower_config("sniper"))
	_assert(sniper_upgrade_test.pierce_count > 0, "Sniper tower should fire piercing bullets.")
	_assert(sniper_upgrade_test.projectile_speed >= 900.0, "Sniper base projectile speed should support distant targets.")
	_assert(sniper_upgrade_test._get_projectile_visual_profile() == Projectile.VISUAL_SNIPER, "Sniper towers should mark rounds with a sniper visual profile.")
	_assert(is_equal_approx(sniper_upgrade_test._get_projectile_max_distance(), 0.0), "Sniper projectiles should still use screen-exit cleanup instead of tower range cleanup.")
	var sniper_pierce_first := game._spawn_enemy("brute", 200, 0.0, 0, 0.0, 0)
	var sniper_pierce_second := game._spawn_enemy("brute", 200, 0.0, 0, 0.0, 0)
	await process_frame
	sniper_pierce_first.global_position = Vector2(220.0, 180.0)
	sniper_pierce_second.global_position = Vector2(320.0, 180.0)
	sniper_pierce_first.health = 200
	sniper_pierce_second.health = 200
	var sniper_pierce_projectile := Projectile.new()
	sniper_pierce_projectile.global_position = Vector2(120.0, 180.0)
	sniper_pierce_projectile.setup(null, 100, 1000.0, 0.0, 0, Color(0.86, 0.82, 1.0), 0, Vector2.RIGHT, 0.0, Projectile.VISUAL_SNIPER)
	game.add_projectile(sniper_pierce_projectile)
	sniper_pierce_projectile._process(0.11)
	var first_sniper_hit_damage := 200 - sniper_pierce_first.health
	sniper_pierce_projectile._process(0.11)
	var second_sniper_hit_damage := 200 - sniper_pierce_second.health
	_assert(first_sniper_hit_damage == 100, "Sniper projectiles should apply full damage on the first hit.")
	_assert(second_sniper_hit_damage > 0 and second_sniper_hit_damage < first_sniper_hit_damage, "Sniper piercing damage should fall off after each hit.")
	_assert(not sniper_pierce_projectile.is_queued_for_deletion(), "Sniper projectiles should continue after piercing while still visible.")
	sniper_pierce_projectile.queue_free()
	sniper_pierce_first.queue_free()
	sniper_pierce_second.queue_free()
	await process_frame
	sniper_upgrade_test.upgrade()
	sniper_upgrade_test.upgrade()
	_assert(sniper_upgrade_test.projectile_speed >= 1300.0, "Max-level sniper rounds should be fast enough for full-range shots.")
	var execute_target := Enemy.new()
	execute_target.setup(game.path_points, 100, 0.0, 0, game.enemy_type_configs["brute"])
	execute_target.health = 30
	_assert(sniper_upgrade_test.execute_threshold > 0.0, "Sniper tower level 3 should unlock execute shots.")
	_assert(sniper_upgrade_test._get_attack_damage(execute_target) > sniper_upgrade_test.damage, "Sniper execute shot should boost damage against low health enemies.")
	rapid_upgrade_test.free()
	shotgun_upgrade_test.free()
	cannon_upgrade_test.free()
	basic_recoil_test.free()
	rapid_recoil_test.free()
	sniper_recoil_test.free()
	scan_a.free()
	scan_b.free()
	progress_enemy.free()
	sniper_upgrade_test.free()
	execute_target.free()

	var before_sell_gold := game.gold
	var expected_refund := sniper.get_sell_value()
	build_manager.sell_selected()
	await process_frame
	_assert(game.tower_layer.get_child_count() == 1, "Sell should remove selected tower.")
	_assert(game.get_active_towers().size() == 1, "Selling a tower should remove it from the active tower cache.")
	_assert(not build_manager._occupied_tiles.has(sniper_tile), "Selling a tower should release its occupied grid key.")
	_assert(game.gold == before_sell_gold + expected_refund, "Sell should refund based on investment.")

	var wave_type_probe := WaveManager.new()
	wave_type_probe.setup(game, 1, [], 0)
	_assert(wave_type_probe.enemy_types.size() == 1 and wave_type_probe.enemy_types[0] == "grunt", "Wave manager should normalize empty enemy type lists to grunt.")
	_assert(wave_type_probe.route_count == 1, "Wave manager should clamp route count to at least one.")
	wave_type_probe.setup(game, 1, ["runner", "", 42, "brute"], 2)
	_assert(wave_type_probe.enemy_types == ["runner", "42", "brute"], "Wave manager should normalize enemy types into clean string ids.")
	_assert(wave_type_probe._get_wave_enemy_count(0, 0) >= 16, "Multi-route first waves should spawn denser enemy groups.")
	_assert(wave_type_probe._get_wave_enemy_count(4, 8) >= 48, "Later levels and waves should substantially increase enemy count.")
	_assert(wave_type_probe._get_wave_spawn_interval(4, 8) <= 0.27, "Later levels and waves should spawn enemies more densely.")
	_assert(wave_type_probe._get_spawn_batch_size() == 2, "Multi-route waves should spawn one enemy per gate on each spawn tick.")
	_assert(wave_type_probe._pick_route_index(0, 0, 0) != wave_type_probe._pick_route_index(0, 1, 1), "Spawn batches should distribute enemies across different gates.")
	_assert(wave_type_probe._get_spawn_reward_bonus(8) == 0, "Early spawn-index reward bonuses should no longer inflate dense waves.")
	_assert(wave_type_probe._get_spawn_reward_bonus(20) == 0, "Spawn-index reward bonuses should be delayed beyond the old threshold.")
	_assert(wave_type_probe._get_spawn_reward_bonus(32) == 0, "Spawn-index reward bonuses should stay disabled after the economy nerf.")
	_assert(wave_type_probe._get_spawn_reward_bonus(80) == WaveManager.MAX_SPAWN_REWARD_BONUS, "Spawn-index reward bonuses should be capped.")
	wave_type_probe.free()

	_assert(game._get_wave_clear_gold_bonus(1) == 17, "First-level wave clear gold should provide a modest stable bonus.")
	var saved_level_index := game.current_level_index
	var saved_spawn_paths: Array[Array] = game.spawn_paths
	var bonus_probe_paths: Array[Array] = [[], [], [], []]
	game.current_level_index = 9
	game.spawn_paths = bonus_probe_paths
	_assert(game._get_wave_clear_gold_bonus(10) == 80, "Late multi-route wave clear gold should stay controlled after the economy nerf.")
	game.current_level_index = saved_level_index
	game.spawn_paths = saved_spawn_paths

	var start_wave_ok := game.wave_manager.start_next_wave()
	await process_frame
	_assert(start_wave_ok, "Wave manager should start first wave.")
	_assert(game.wave_manager.current_wave == 1, "Current wave should increment.")
	_assert(game.enemy_layer.get_child_count() >= 1, "Wave should spawn an enemy on the first process frame.")
	_assert(game.wave_manager._enemy_wave_stat_cache.has("grunt:0"), "Automatic wave spawning should use cached base stats without building a per-spawn stats dictionary.")
	var grunt_multipliers: Dictionary = game.wave_manager._get_enemy_stat_multipliers("grunt")
	_assert(game.wave_manager._enemy_stat_multipliers.has("grunt"), "Wave manager should cache enemy stat multipliers by type.")
	_assert(is_same(grunt_multipliers, game.wave_manager._get_enemy_stat_multipliers("grunt")), "Repeated enemy stat multiplier reads should reuse the cached dictionary.")
	var runner_stats: Dictionary = game.wave_manager.get_enemy_stats("runner", 2, 32)
	_assert(runner_stats.speed > 100.0 and runner_stats.reward >= 4, "Cached enemy stat multipliers should preserve speed and controlled reward scaling.")
	var runner_base_stats: Dictionary = game.wave_manager._get_enemy_wave_base_stats("runner", 2)
	_assert(game.wave_manager._enemy_wave_stat_cache.has("runner:2"), "Wave manager should cache per-wave enemy base stats.")
	_assert(is_same(runner_base_stats, game.wave_manager._get_enemy_wave_base_stats("runner", 2)), "Repeated per-wave enemy stat reads should reuse the cached dictionary.")
	var runner_no_bonus_stats: Dictionary = game.wave_manager.get_enemy_stats("runner", 2, 0)
	var runner_early_spawn_stats: Dictionary = game.wave_manager.get_enemy_stats("runner", 2, 8)
	_assert(int(runner_early_spawn_stats.reward) == int(runner_no_bonus_stats.reward), "Early dense-wave spawn rewards should stay flat.")
	_assert(int(runner_stats.reward) == int(runner_no_bonus_stats.reward), "Spawn index reward bonuses should stay disabled after the economy nerf.")
	game._clear_enemies_and_projectiles()
	await process_frame
	var clear_projectile_probe := Projectile.new()
	game.add_projectile(clear_projectile_probe)
	_assert(game.get_active_projectiles().size() == 1, "Projectile cache should track probes before clearing combat nodes.")
	game._clear_enemies_and_projectiles()
	await process_frame
	_assert(game.get_active_projectiles().is_empty(), "Clearing combat nodes should clear the active projectile cache.")

	game._clear_enemies_and_projectiles()
	await process_frame
	var spawn_response := game._execute_console_command("spawn 3 runner")
	await process_frame
	_assert(game._get_enemy_type_config_display_name({"name": "  测试敌群  "}) == "测试敌群", "Main enemy-type display helper should trim configured names.")
	_assert(game._get_enemy_type_config_display_name({"name": ""}) == "敌人", "Main enemy-type display helper should use a localized fallback name.")
	_assert(game._get_default_enemy_type_display_name() == "敌人", "Main default enemy-type display-name helper should use localized text.")
	_assert(game._get_enemy_type_display_name("runner") == "疾行者", "Main enemy-type display helper should resolve localized enemy names by id.")
	_assert(spawn_response == "已生成3个疾行者。", "Spawn console command should report localized enemy type.")
	_assert(not spawn_response.contains("runner"), "Spawn console command should not expose internal enemy ids.")
	_assert(game.enemy_layer.get_child_count() == 3, "Spawn console command should create requested enemies.")
	_assert(game.get_active_enemies().size() == 3, "Active enemy cache should track spawned enemies.")
	var spawned_enemy := game.enemy_layer.get_child(0) as Enemy
	_assert(spawned_enemy.enemy_type_id == "runner", "Spawn command should create requested enemy type.")
	_assert(spawned_enemy.speed > 90.0, "Runner should be faster than basic enemies.")
	spawned_enemy.take_damage(9999)
	await process_frame
	_assert(game.get_active_enemies().size() == 2, "Active enemy cache should remove defeated enemies immediately.")
	var direct_free_enemy := game._spawn_enemy("grunt", 50, 0.0, 0, 0.0, 0)
	await process_frame
	_assert(game.get_active_enemies().has(direct_free_enemy), "Spawned enemies should be registered in the active enemy cache.")
	direct_free_enemy.queue_free()
	await process_frame
	_assert(game.get_active_enemies().size() == 2, "Freed enemies should leave the active enemy cache through tree exit.")
	game._clear_enemies_and_projectiles()
	await process_frame
	_assert(game.get_active_enemies().is_empty(), "Clearing combat nodes should clear the active enemy cache.")

	var grunt := Enemy.new()
	grunt.setup(game.path_points, 50, 70.0, 10, game.enemy_type_configs["grunt"])
	game.enemy_layer.add_child(grunt)
	await process_frame
	var grunt_sprite := grunt.get_node_or_null("Enemy1AnimatedSprite") as AnimatedSprite2D
	_assert(grunt_sprite != null, "Grunt enemy should use the enemy1 animated sprite.")
	_assert(grunt_sprite.sprite_frames.get_frame_count("walk") == 4, "Enemy1 sprite should have four walk frames.")
	_assert(grunt_sprite.is_playing(), "Enemy1 walk animation should play while active.")
	grunt.queue_free()
	await process_frame
	var fallback_enemy := Enemy.new()
	fallback_enemy.setup(game.path_points, 50, 70.0, 10, {})
	_assert(fallback_enemy.enemy_name == "步兵", "Enemy display-name fallback should be localized.")
	_assert(fallback_enemy._get_default_enemy_display_name() == "步兵", "Enemy default display-name helper should use localized text.")
	_assert(fallback_enemy._get_enemy_display_name({"name": "  测试敌人  "}) == "测试敌人", "Enemy display helper should trim configured names.")
	_assert(fallback_enemy._get_enemy_display_name({"name": ""}) == "步兵", "Enemy display helper should use a localized fallback name.")
	fallback_enemy.free()

	_assert(game.enemy_type_configs.has("taunt"), "Later levels should define a taunt enemy type.")
	var taunt_enemy := Enemy.new()
	taunt_enemy.setup(game.path_points, 240, 30.0, 8, game.enemy_type_configs["taunt"])
	_assert(taunt_enemy.is_taunt and taunt_enemy.speed < 60.0, "Taunt enemies should be slow forced-target units.")
	var taunt_target_tower := Tower.new()
	taunt_target_tower.setup(game, Vector2i(4, 4), game.get_tower_configs()[0])
	taunt_target_tower.global_position = Vector2(128.0, 128.0)
	var normal_target_enemy := Enemy.new()
	normal_target_enemy.setup(game.path_points, 100, 70.0, 5, game.enemy_type_configs["runner"])
	normal_target_enemy.global_position = Vector2(132.0, 128.0)
	normal_target_enemy.set("_path_progress", 0.90)
	taunt_enemy.global_position = Vector2(140.0, 128.0)
	taunt_enemy.set("_path_progress", 0.20)
	game.enemy_layer.add_child(normal_target_enemy)
	game.enemy_layer.add_child(taunt_enemy)
	game.register_enemy(normal_target_enemy)
	game.register_enemy(taunt_enemy)
	_assert(taunt_target_tower._find_target() == taunt_enemy, "Towers should prioritize taunt enemies over higher-progress targets in range.")
	taunt_target_tower.free()
	game._clear_enemies_and_projectiles()
	await process_frame

	var health_before_hit := game.base_health
	var enemy := Enemy.new()
	enemy.setup(game.path_points, 50, 70.0, 10, game.enemy_type_configs["brute"])
	enemy.reached_end.connect(game._on_enemy_reached_end)
	game.enemy_layer.add_child(enemy)
	game.register_enemy(enemy)
	enemy._reach_end()
	await process_frame
	_assert(game.base_health == health_before_hit - 2, "Brute should deal higher base damage through its signal.")
	_assert(game.get_active_enemy_count() == game.get_active_enemies().size(), "Active enemy count should be derived from the cache.")

	game._clear_enemies_and_projectiles()
	game.wave_manager.current_wave = game.wave_manager.total_waves
	game.wave_manager.is_spawning = false
	game._check_level_complete()
	game._refresh_ui()
	await process_frame
	_assert(game.is_level_complete, "Finishing non-final level should mark level complete.")
	_assert(not game.is_game_over, "Non-final level clear should not end the full game.")
	_assert(not game.ui.next_level_button.disabled, "Next Level button should enable after level clear.")
	_assert(game.ui.level_clear_panel.visible, "Level clear should show an animated clear banner.")
	_assert(game.ui.level_clear_next_button.text == "进入下一关", "Level clear panel should expose a clear next-level action.")
	_assert(not game.ui.level_clear_next_button.disabled, "Level clear next action should enable when the next level is available.")
	_assert(game.ui.level_clear_next_button.mouse_default_cursor_shape == Control.CURSOR_POINTING_HAND, "Enabled level-clear next action should use the pointing cursor.")
	await create_timer(0.35).timeout
	_assert(game.ui.level_clear_panel.position == Vector2(304.0, 92.0), "Level clear panel should settle on its final position.")
	_assert(is_equal_approx(game.ui.level_clear_panel.modulate.a, 1.0), "Level clear panel should settle on full opacity.")

	game.ui._on_next_level_pressed()
	await process_frame
	_assert(game.current_level_index == 1, "Next Level should load level 2.")
	var next_level_save := _read_level_start_save_for_test()
	_assert(int(next_level_save.get("level_index", -1)) == 1, "Next Level should save the newly entered level's initial state for Continue Game.")
	_assert(int(next_level_save.get("gold", -1)) == game.gold, "Next Level save should capture carried starting gold for the new level.")
	_assert(not game.ui.level_clear_panel.visible, "Entering the next level should hide the level-clear panel.")
	_assert(game.ui.level_clear_panel.position == Vector2(304.0, -142.0), "Hidden level-clear panel should reset to its offscreen position.")
	_assert(is_equal_approx(game.ui.level_clear_panel.modulate.a, 0.0), "Hidden level-clear panel should reset its opacity.")
	_assert(game.ui.level_clear_next_button.disabled, "Level-clear next action should disable after entering the next level.")
	_assert(game.ui.level_clear_next_button.mouse_default_cursor_shape == Control.CURSOR_ARROW, "Disabled level-clear next action should restore the default cursor.")
	_assert(game.get_active_towers().is_empty(), "Changing levels should clear the active tower cache.")
	_assert(game.build_manager._road_cell_lookup.size() == game.road_cells.size(), "Changing levels should refresh the build manager road cache.")
	_assert(game.wave_manager.enemy_types.has("runner"), "Level 2 should unlock runner enemies.")
	_assert(game.spawn_paths.size() == 2, "Level 2 should have two spawn routes.")
	_assert(game.wave_manager.route_count == 2, "Wave manager should know level 2 route count.")
	_assert(game.path_points.size() > 8, "Level 2 should have a more complex path.")
	_assert(game.spawn_paths[0][0] != game.spawn_paths[1][0], "Level 2 routes should start from different spawn points.")
	_assert(game.spawn_paths[0][1] != game.spawn_paths[1][1], "Level 2 routes should preserve distinct branch paths.")

	game._execute_console_command("level 3")
	await process_frame
	_assert(game.current_level_index == 2, "Console should load level 3.")
	_assert(game.wave_manager._enemy_stat_multipliers.is_empty(), "Changing levels should clear cached enemy stat multipliers.")
	_assert(game.wave_manager._enemy_wave_stat_cache.is_empty(), "Changing levels should clear cached per-wave enemy stats.")
	_assert(game.wave_manager.enemy_types.has("brute"), "Level 3 should unlock brute enemies.")
	_assert(game.wave_manager.enemy_types.has("shield"), "Level 3 should unlock shield enemies.")
	_assert(game.wave_manager.enemy_types.has("elite"), "Level 3 should add elite enemies.")
	_assert(game.spawn_paths.size() == 3, "Level 3 should have three spawn routes.")
	_assert(game.spawn_path_lengths.size() == game.spawn_paths.size(), "Console level changes should rebuild cached route lengths.")
	_assert(game.wave_manager.route_count == 3, "Wave manager should know level 3 route count.")
	_assert(game.spawn_paths[0][0] != game.spawn_paths[1][0], "Level 3 route 1 and 2 should start from different spawn points.")
	_assert(game.spawn_paths[1][0] != game.spawn_paths[2][0], "Level 3 route 2 and 3 should start from different spawn points.")
	_assert(game.spawn_paths[0][4] != game.spawn_paths[1][4], "Level 3 routes should keep independent early branches.")

	var route_spawn_response := game._execute_console_command("spawn 1 shield 3")
	await process_frame
	_assert(route_spawn_response == "已生成1个护盾兵。", "Spawn console command should support route argument with localized enemy type.")
	_assert(not route_spawn_response.contains("shield"), "Route spawn response should not expose internal enemy ids.")
	var route_enemy := game.enemy_layer.get_child(game.enemy_layer.get_child_count() - 1) as Enemy
	_assert(route_enemy.path_points[0] == game.spawn_paths[2][0], "Route argument should spawn enemy on requested route.")
	_assert(route_enemy.path_points == game.spawn_paths[2], "Route argument should assign the full requested route path.")
	_assert(is_same(route_enemy.path_points, game.spawn_paths[2]), "Spawned enemies should share cached route path arrays instead of duplicating them.")
	_assert(is_equal_approx(float(route_enemy.get("_total_path_length")), game._get_spawn_path_length(2)), "Spawned enemies should reuse the cached route length.")

	game._execute_console_command("level 10")
	await process_frame
	_assert(game.current_level_index == 9, "Console should load level 10.")
	_assert(game.wave_manager.enemy_types.has("taunt"), "Late levels should add taunt enemies to force target priority decisions.")
	cached_road_cells = game.map_layer.get("_cached_road_cells")
	cached_route_paths = game.map_layer.get("_cached_route_paths")
	cached_ground_rects = game.map_layer.get("_cached_ground_rects")
	cached_ground_colors = game.map_layer.get("_cached_ground_colors")
	cached_grid_lines = game.map_layer.get("_cached_grid_lines")
	cached_road_edge_rects = game.map_layer.get("_cached_road_edge_rects")
	_assert(cached_road_cells.size() == game.road_cells.size(), "Map renderer road cache should refresh when changing levels.")
	_assert(cached_route_paths.size() == game.spawn_paths.size(), "Map renderer route cache should refresh when changing levels.")
	_assert(cached_ground_rects.size() == game.map_cols * game.map_rows, "Map renderer ground tile cache should refresh when changing levels.")
	_assert(cached_ground_colors.size() == cached_ground_rects.size(), "Map renderer ground color cache should refresh when changing levels.")
	_assert(cached_grid_lines.size() == (game.map_cols + 1 + game.map_rows + 1) * 2, "Map renderer grid line cache should refresh when changing levels.")
	_assert(cached_road_edge_rects.size() == game.road_cells.size(), "Map renderer road rect cache should refresh when changing levels.")
	_assert(game.spawn_path_lengths.size() == game.spawn_paths.size(), "Level 10 should cache route lengths for every spawn path.")
	_assert(game.map_cols == 48, "Level 10 should apply its larger map width.")
	_assert(game.map_rows == 24, "Level 10 should apply its larger map height.")
	_assert(game.get_map_pixel_width() > 960, "Large maps should be wider than the default viewport.")
	_assert(game.get_map_pixel_height() > 640, "Large maps should be taller than the default viewport.")
	_assert(game.path_points[game.path_points.size() - 1].x > 1400.0, "Level 10 route should end near the far side of the larger map.")
	_assert(game.scene_theme.has("field_a") and game.scene_theme.has("road"), "Loaded levels should apply scene theme colors.")
	for zoom_step in range(30):
		game._adjust_camera_zoom(-1, Vector2(480.0, 320.0))
	var min_zoom := game._get_min_camera_zoom()
	_assert(is_equal_approx(game.camera.zoom.x, min_zoom), "Ctrl mouse wheel zoom-out should stop at the full-map zoom.")
	_assert(960.0 / game.camera.zoom.x >= float(game.get_map_pixel_width()), "Full-map zoom should show the complete map width.")
	_assert(640.0 / game.camera.zoom.y >= float(game.get_map_pixel_height()), "Full-map zoom should show the complete map height.")
	_assert(is_equal_approx(game.camera.position.y, float(game.get_map_pixel_height()) * 0.5), "Full-map zoom should center axes that fit inside the view.")
	game.camera.zoom = Vector2.ONE
	game.camera.position = Vector2(768.0, 448.0)
	game._clamp_camera_to_map()
	var camera_before_drag := game.camera.position
	var middle_press := InputEventMouseButton.new()
	middle_press.button_index = MOUSE_BUTTON_MIDDLE
	middle_press.pressed = true
	middle_press.position = Vector2(480.0, 320.0)
	game._unhandled_input(middle_press)
	var drag_motion := InputEventMouseMotion.new()
	drag_motion.position = Vector2(544.0, 352.0)
	drag_motion.relative = Vector2(64.0, 32.0)
	game._unhandled_input(drag_motion)
	var middle_release := InputEventMouseButton.new()
	middle_release.button_index = MOUSE_BUTTON_MIDDLE
	middle_release.pressed = false
	middle_release.position = Vector2(544.0, 352.0)
	game._unhandled_input(middle_release)
	_assert(game.camera.position != camera_before_drag, "Mouse drag should pan the map camera.")

	var ui_particles_before_victory := _count_particles(game.ui.ui_root)
	var victory_response := game._execute_console_command("victory")
	await process_frame
	_assert(victory_response == "胜利动画已触发。", "Victory console command should report animation trigger.")
	_assert(game.is_game_over, "Victory console command should end the game.")
	_assert(game.ui.end_overlay.visible, "Victory should show the end animation overlay.")
	_assert(game.ui.end_title_label.text == "胜利", "Victory overlay should show victory title.")
	_assert(game.ui.end_restart_button.text == "重新开始本关" and game.ui.end_main_menu_button.text == "返回开始界面", "End overlay should expose clear restart and main-menu actions.")
	_assert(_count_particles(game.ui.ui_root) == ui_particles_before_victory, "Victory overlay should not spawn UI particles after popup effects moved to rebound animation.")
	game.ui._on_end_restart_pressed()
	await process_frame
	_assert(not game.is_game_over and game.has_game_started, "End restart button should restart active gameplay.")
	_assert(not game.ui.end_overlay.visible, "End restart button should hide the end overlay.")
	_assert(is_equal_approx(game.ui.end_overlay.modulate.a, 0.0), "Hidden end overlay should reset its opacity after restart.")
	_assert(game.ui.end_title_label.scale.is_equal_approx(Vector2.ONE), "Hidden end overlay should reset its title scale after restart.")

	game.queue_free()
	await process_frame
	_clear_level_start_save_for_test()

	game = main_scene.instantiate() as Main
	root.add_child(game)
	await process_frame
	game._on_game_start_pressed()
	game.gold = 200
	game._on_tower_build_requested("basic")
	var defeat_panel_tower_built := game.build_manager.try_build_at(game.build_manager.grid_to_center(Vector2i(1, 1)))
	await process_frame
	_assert(defeat_panel_tower_built and game.ui.tower_panel.visible, "Defeat setup should show a selected tower panel.")
	var defeat_panel_tower := game.build_manager.selected_tower
	game.ui.set_console_visible(true, false)
	_assert(game.ui.is_console_visible() and game.ui.console_panel.visible, "Defeat setup should leave the console open.")
	game._add_card_to_hand_or_pending(game._make_debug_reward_card("missile"))
	await process_frame
	game._pause_game()
	_assert(game.is_game_paused and game.ui.pause_overlay.visible, "Defeat setup should leave the pause menu open.")
	game.ui.show_tower_panel(defeat_panel_tower)
	_assert(game.ui.tower_panel.visible, "Defeat setup should restore a stale tower panel over gameplay.")
	if game.ui._card_controls.is_empty():
		_assert(false, "Defeat setup should create a draggable card.")
	else:
		var defeat_drag_card := game.ui._card_controls[0]
		game.ui._start_card_drag(defeat_drag_card, 0, Vector2(760.0, 480.0))
	_assert(game.ui._drag_card_control != null and game.ui.card_area_preview.visible, "Defeat setup should leave an active area-card drag.")
	var ui_particles_before_defeat := _count_particles(game.ui.ui_root)
	var defeat_response := game._execute_console_command("defeat")
	await process_frame
	_assert(defeat_response == "失败动画已触发。", "Defeat console command should report animation trigger.")
	_assert(game.is_game_over, "Defeat console command should end the game.")
	_assert(game.ui.end_overlay.visible, "Defeat console command should show the end animation overlay.")
	_assert(not game.ui.is_console_visible() and not game.ui.console_panel.visible, "End overlay should close the console so the animation is visible.")
	_assert(not game.ui.pause_overlay.visible, "End overlay should immediately hide the pause menu.")
	_assert(not game.ui.tower_panel.visible, "End overlay should immediately hide tower panels.")
	_assert(game.ui._drag_card_control == null, "End overlay should clear active card drags.")
	_assert(not game.ui.card_hand_zone.visible, "End overlay should hide the card hand.")
	_assert(not game.ui.card_area_preview.visible, "End overlay should hide area-card previews.")
	_assert(game.ui.end_title_label.text == "失败", "Defeat overlay should show defeat title.")
	_assert(game.ui.end_restart_button.text == "重新开始本关" and game.ui.end_main_menu_button.text == "返回开始界面", "Defeat overlay should expose clear recovery actions.")
	_assert(_count_particles(game.ui.ui_root) == ui_particles_before_defeat, "Defeat overlay should not spawn UI particles after popup effects moved to rebound animation.")
	game.ui._on_end_main_menu_pressed()
	await process_frame
	_assert(not game.has_game_started, "End main-menu button should leave gameplay.")
	_assert(game.ui.start_overlay.visible and not game.ui.end_overlay.visible, "End main-menu button should return to the start screen.")
	_assert(is_equal_approx(game.ui.end_overlay.modulate.a, 0.0), "Hidden end overlay should reset its opacity after returning to the start screen.")
	_assert(game.ui.end_title_label.scale.is_equal_approx(Vector2.ONE), "Hidden end overlay should reset its title scale after returning to the start screen.")

	game.queue_free()
	await process_frame
	_restore_level_start_save_snapshot_for_test()
	_finish()


func _read_level_start_save_for_test() -> Dictionary:
	var config := ConfigFile.new()
	var error := config.load(LEVEL_START_SAVE_PATH)
	if error != OK:
		return {}
	return {
		"has_file": true,
		"has_save": bool(config.get_value(LEVEL_START_SAVE_SECTION, "has_save", false)),
		"level_index": int(config.get_value(LEVEL_START_SAVE_SECTION, "level_index", 0)),
		"highest_unlocked_level_index": int(config.get_value(LEVEL_START_SAVE_SECTION, "highest_unlocked_level_index", 0)),
		"gold": int(config.get_value(LEVEL_START_SAVE_SECTION, "gold", 0)),
		"base_health": int(config.get_value(LEVEL_START_SAVE_SECTION, "base_health", 0)),
		"max_base_health": int(config.get_value(LEVEL_START_SAVE_SECTION, "max_base_health", 0)),
	}


func _clear_level_start_save_for_test() -> void:
	var config := ConfigFile.new()
	config.set_value(LEVEL_START_SAVE_SECTION, "has_save", false)
	config.save(LEVEL_START_SAVE_PATH)


func _restore_level_start_save_for_test(save_data: Dictionary) -> void:
	if save_data.is_empty() or not bool(save_data.get("has_file", false)):
		if FileAccess.file_exists(LEVEL_START_SAVE_PATH):
			DirAccess.remove_absolute(ProjectSettings.globalize_path(LEVEL_START_SAVE_PATH))
		return
	var config := ConfigFile.new()
	config.set_value(LEVEL_START_SAVE_SECTION, "has_save", bool(save_data.get("has_save", false)))
	config.set_value(LEVEL_START_SAVE_SECTION, "level_index", int(save_data.get("level_index", 0)))
	config.set_value(LEVEL_START_SAVE_SECTION, "highest_unlocked_level_index", int(save_data.get("highest_unlocked_level_index", 0)))
	config.set_value(LEVEL_START_SAVE_SECTION, "gold", int(save_data.get("gold", 0)))
	config.set_value(LEVEL_START_SAVE_SECTION, "base_health", int(save_data.get("base_health", 0)))
	config.set_value(LEVEL_START_SAVE_SECTION, "max_base_health", int(save_data.get("max_base_health", 0)))
	config.save(LEVEL_START_SAVE_PATH)


func _restore_level_start_save_snapshot_for_test() -> void:
	if not _has_level_start_save_snapshot:
		return
	_restore_level_start_save_for_test(_level_start_save_snapshot)
	_has_level_start_save_snapshot = false


func _assert(condition: bool, message: String) -> void:
	_last_checkpoint = message
	if condition:
		print("[PASS] ", message)
	else:
		push_error("[FAIL] " + message)
		_failures.append(message)


func _count_particles(node: Node) -> int:
	if node == null:
		return 0

	var count := 0
	for child in node.get_children():
		if child is CPUParticles2D:
			count += 1
	return count


func _count_named_children(node: Node, child_name: String) -> int:
	if node == null:
		return 0

	var count := 0
	for child in node.get_children():
		if child.name == child_name:
			count += 1
	return count


func _find_impact_effect(node: Node, effect_name: String):
	if node == null:
		return null

	for child in node.get_children():
		if child.has_method("_draw_cannon_impact") and child.name == effect_name:
			return child
	return null


func _hand_card_has_icon_text(ui: GameUI, card_index: int, icon_text: String) -> bool:
	if card_index < 0 or card_index >= ui._card_controls.size():
		return false

	var card_control := ui._card_controls[card_index]
	if not is_instance_valid(card_control):
		return false

	for child in card_control.get_children():
		var label := child as Label
		if label != null and label.text == icon_text:
			return true
	return false


func _tower_buttons_match_unlock_state(ui: GameUI, current_level_index: int) -> bool:
	for button in ui._build_option_buttons:
		if button == null or not is_instance_valid(button):
			return false
		var unlock_level := int(button.get_meta("unlock_level", 0))
		if button.disabled != (current_level_index < unlock_level):
			return false
	return true


func _reward_card_icons_are_localized(game: Main) -> bool:
	for card in game._get_reward_card_pool():
		var icon := game.ui._card_icon(card)
		if icon.contains("$") or _contains_ascii_letter(icon):
			return false
	return true


func _reward_card_ids_are_unique(game: Main) -> bool:
	var seen: Dictionary = {}
	for card in game._get_reward_card_pool():
		var card_id := str((card as Dictionary).get("id", ""))
		if card_id.is_empty() or seen.has(card_id):
			return false
		seen[card_id] = true
	return true


func _reward_card_rarities_are_valid(game: Main) -> bool:
	for card in game._get_reward_card_pool():
		var rarity := str((card as Dictionary).get("rarity", ""))
		if not _is_valid_reward_card_rarity(rarity):
			return false
	return true


func _is_valid_reward_card_rarity(rarity: String) -> bool:
	var valid_rarities := {
		"white": true,
		"blue": true,
		"purple": true,
		"gold": true,
		"red": true,
	}
	return valid_rarities.has(rarity)


func _contains_ascii_letter(text: String) -> bool:
	for index in range(text.length()):
		var code := text.unicode_at(index)
		if (code >= 65 and code <= 90) or (code >= 97 and code <= 122):
			return true
	return false


func _finish() -> void:
	if _finished:
		return
	_finished = true
	_restore_level_start_save_snapshot_for_test()
	var exit_code := 0
	if _failures.is_empty():
		print("逻辑冒烟测试通过。")
	else:
		print("逻辑冒烟测试失败：", _failures)
		exit_code = 1
	call_deferred("_quit_after_cleanup", exit_code)


func _quit_after_cleanup(exit_code: int) -> void:
	# Windows 上 Godot 4.7 偶尔会在 --script 冒烟测试结束时，因为同一帧仍有
	# queue_free 的 UI/特效节点等待释放而触发原生访问冲突。这里主动让引擎多
	# 处理两帧清理队列，再退出进程，避免把脚本断言失败伪装成 Godot 崩溃。
	await process_frame
	await process_frame
	quit(exit_code)
