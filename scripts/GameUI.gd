extends CanvasLayer
class_name GameUI

const TOWER_PANEL_OPEN_POSITION := Vector2(694.0, 78.0)
const TOWER_PANEL_CLOSED_POSITION := Vector2(714.0, 78.0)
const TOWER_PANEL_ANIMATION_TIME := 0.16
const TOWER_CATEGORY_SUPPORT := "support"
const TOWER_CATEGORY_WEAPON := "weapon"
const TOWER_CONFIG_DEFAULT_COST: int = 50
const TOWER_CONFIG_MAX_COST: int = 10000
const TOWER_CONFIG_MAX_DAMAGE: int = 10000
const TOWER_CONFIG_MAX_RANGE: float = 2000.0
const TOWER_CONFIG_DEFAULT_INTERVAL: float = 1.0
const TOWER_CONFIG_MAX_INTERVAL: float = 30.0
const TOWER_CONFIG_MAX_MULTIPLIER: float = 5.0
const TOWER_CONFIG_MAX_UNLOCK_LEVEL: int = 99
const LEVEL_CONFIG_DEFAULT_WAVES: int = 0
const LEVEL_CONFIG_MAX_WAVES: int = 99
const DEFAULT_TOWER_DISPLAY_NAME := "防御塔"
const DEFAULT_TOWER_CATEGORY_LABEL := "武器塔"
const DEFAULT_TOWER_ICON_TEXT := "塔"
const DEFAULT_LEVEL_DISPLAY_NAME := "未知关卡"
const DEFAULT_CARD_DISPLAY_NAME := "卡牌"
const DEFAULT_CARD_TYPE_LABEL := "卡牌"
const DEFAULT_CARD_ICON_TEXT := "卡"
const CARD_RARITY_WHITE := "white"
const CARD_RARITY_BLUE := "blue"
const CARD_RARITY_PURPLE := "purple"
const CARD_RARITY_GOLD := "gold"
const CARD_RARITY_RED := "red"
const CARD_RARITY_WHITE_LABEL := "白色"
const CARD_RARITY_BLUE_LABEL := "蓝色"
const CARD_RARITY_PURPLE_LABEL := "紫色"
const CARD_RARITY_GOLD_LABEL := "金色"
const CARD_RARITY_RED_LABEL := "红色"
const CARD_RARITY_WHITE_COLOR := Color(0.92, 0.94, 0.96)
const CARD_RARITY_BLUE_COLOR := Color(0.40, 0.72, 1.0)
const CARD_RARITY_PURPLE_COLOR := Color(0.74, 0.48, 1.0)
const CARD_RARITY_GOLD_COLOR := Color(1.0, 0.78, 0.24)
const CARD_RARITY_RED_COLOR := Color(1.0, 0.34, 0.24)
const CARD_FACE_MAX_BORDER_WIDTH: int = 8
const CARD_FACE_MAX_COUNT: int = 12
const CARD_FACE_MAX_SIZE: float = 32.0
const CARD_AREA_PREVIEW_DEFAULT_RADIUS: float = 92.0
const CARD_AREA_PREVIEW_MAX_RADIUS: float = 640.0
const GOLD_STATUS_TEMPLATE := "金币：%d"
const BASE_HEALTH_STATUS_TEMPLATE := "基地：%d/%d"
const LEVEL_STATUS_TEMPLATE := "关卡：%d/%d"
const WAVE_STATUS_TEMPLATE := "波次：%d/%d"
const START_WAVE_BUTTON_TEXT := "开始波次"
const NEXT_LEVEL_BUTTON_TEXT := "下一关"
const TOWER_PANEL_CLOSE_BUTTON_TEXT := "关闭"
const TOWER_UPGRADE_PLACEHOLDER_TEXT := "升级"
const TOWER_SELL_PLACEHOLDER_TEXT := "出售"
const BUILD_PANEL_TITLE_TEXT := "建造"
const BUILD_PANEL_COLLAPSE_TEXT := "收起建塔"
const BUILD_PANEL_EXPAND_TEXT := "展开建塔"
const CARD_HAND_COLLAPSE_TEXT := "收起手牌"
const CARD_HAND_EXPAND_TEXT := "展开手牌"
const START_TITLE_TEXT := "像素塔防"
const START_SUBTITLE_TEXT := "布置防线，适应多路线进攻，守住每一座基地。"
const START_GAME_BUTTON_TEXT := "开始游戏"
const CONTINUE_GAME_BUTTON_TEXT := "继续游戏"
const LEVEL_SELECT_BUTTON_TEXT := "选择关卡"
const UPDATE_ANNOUNCEMENT_BUTTON_TEXT := "更新公告"
const CODEX_BUTTON_TEXT := "图鉴"
const CODEX_TITLE_TEXT := "作战图鉴"
const CODEX_SUBTITLE_TEXT := "横向浏览所有怪物和炮塔，点击条目查看属性、功能和外形。"
const CODEX_CLOSE_BUTTON_TEXT := "返回"
const CODEX_TOWER_KIND_TEXT := "炮塔"
const CODEX_ENEMY_KIND_TEXT := "怪物"
const SAVE_OVERWRITE_TITLE_TEXT := "覆盖继续存档"
const SAVE_OVERWRITE_MESSAGE_TEMPLATE := "从第%02d关 %s 开始会覆盖当前继续游戏存档。确认后，以后继续游戏会回到这一关的开局状态。"
const EXIT_TO_START_TITLE_TEXT := "离开当前关卡"
const EXIT_TO_START_MESSAGE_TEXT := "离开后可以在开始界面点击继续游戏，从本关开局状态重新开始。"
const CONFIRM_BUTTON_TEXT := "确认"
const CANCEL_BUTTON_TEXT := "取消"
const UPDATE_ANNOUNCEMENT_POPUP_TITLE_TEXT := "本次更新"
const UPDATE_ANNOUNCEMENT_HISTORY_TITLE_TEXT := "更新公告"
const UPDATE_ANNOUNCEMENT_CLOSE_TEXT := "关闭"
const UPDATE_ANNOUNCEMENT_KNOWN_TEXT := "知道了"
const LEVEL_SELECT_TITLE_TEXT := "选择关卡"
const LEVEL_SELECT_SUBTITLE_TEXT := "后续关卡会拥有更大的地图、更多路线和不同场景风格。"
const LEVEL_SELECT_CLOSE_BUTTON_TEXT := "返回"
const LEVEL_SELECT_CARD_TEMPLATE := "第%02d关  %s\n%d波  |  %d条路线\n%s"
const END_RESTART_BUTTON_TEXT := "重新开始本关"
const END_MAIN_MENU_BUTTON_TEXT := "返回开始界面"
const PAUSE_TITLE_TEXT := "游戏暂停"
const PAUSE_HINT_TEXT := "按 Esc 键或点击继续返回战场"
const PAUSE_RESUME_BUTTON_TEXT := "继续游戏"
const CONSOLE_TITLE_TEXT := "调试控制台 - F1 / ` 打开关闭，回车执行，Tab键补全，输入 help 查看命令"
const CONSOLE_PLACEHOLDER_TEXT := "输入命令"
const CONSOLE_INITIAL_LINE_TEXT := "输入 help 查看命令。按 Tab 键自动补全。"
const CARD_HAND_EXPANDED_LABEL_TEMPLATE := "卡牌 %d/5"
const CARD_HAND_COLLAPSED_LABEL_TEMPLATE := "卡牌\n%d/5"
const CARD_HAND_DISCARD_SUFFIX_TEXT := "  选择一张丢弃"
const LOCKED_LEVEL_BUTTON_TEMPLATE := "%s\n未解锁"
const LOCKED_LEVEL_TOOLTIP_TEXT := "请先通关前置关卡。"
const TOWER_UNLOCK_TOOLTIP_TEMPLATE := "%s | 第%d关解锁"
const COMPACT_TOWER_TOOLTIP_TEMPLATE := "%s | %s | %d金币 | %s"
const SUPPORT_TOWER_STATS_TEMPLATE := "伤害增幅 +%d%% | 射程增幅 +%d%%"
const WEAPON_TOWER_STATS_TEMPLATE := "伤害 %d | 射程 %d | 间隔 %.2f秒"
const SUPPORT_TOWER_BUTTON_TEMPLATE := "%s\n%d金  伤+%d%%  射+%d%%"
const WEAPON_TOWER_BUTTON_TEMPLATE := "%s\n%d金  伤%d  射%d"
const CONSOLE_COMPLETION_MISSING_TEMPLATE := "没有可补全项：%s"
const CONSOLE_COMPLETION_OPTIONS_TEMPLATE := "可选补全：%s"
const TOWER_PANEL_INFO_TEMPLATE := "%s  等级 %d\n伤害 %d   射程 %d\n间隔 %.2f秒"
const TOWER_PANEL_TRAIT_APPEND_TEMPLATE := "%s\n%s\n%s"
const TOWER_UPGRADE_BUTTON_TEMPLATE := "升级（%d金币）"
const TOWER_MAX_LEVEL_BUTTON_TEXT := "已满级"
const TOWER_SELL_BUTTON_TEMPLATE := "出售（%d金币）"
const LEVEL_INTRO_TITLE_TEMPLATE := "第%02d关 / 共%02d关"
const LEVEL_CLEAR_CONSOLE_TEMPLATE := "第%d关完成：%s"
const LEVEL_CLEAR_TITLE_TEXT := "关卡完成"
const LEVEL_CLEAR_SUBTITLE_TEMPLATE := "第%02d关  %s"
const LEVEL_CLEAR_NEXT_BUTTON_TEXT := "进入下一关"
const CARD_SELL_ZONE_ICON_TEXT := "金"
const PENDING_CARD_KEEP_HINT_TEXT := "点旧卡替换"
const PENDING_CARD_REJECT_BUTTON_TEXT := "放弃新卡"
const PENDING_CARD_TITLE_TEMPLATE := "新卡牌：%s"
const PENDING_CARD_DESCRIPTION_TEXT := "手牌已满。点击一张旧卡替换，或直接放弃新卡。"
const HAND_CARD_DISCARD_HINT_TEXT := "丢弃"
const HAND_CARD_DRAG_HINT_TEXT := "拖拽"
const PENDING_CARD_TIMER_TEMPLATE := "自动放弃 %.0f秒"
const DAMAGE_BOOST_CARD_ICON_TEXT := "攻"
const RANGE_BOOST_CARD_ICON_TEXT := "射"
const FIRE_RATE_BOOST_CARD_ICON_TEXT := "速"
const HEAL_CARD_ICON_TEXT := "疗"
const MISSILE_CARD_ICON_TEXT := "爆"
const CRYO_CARD_ICON_TEXT := "冻"
const FIRESTORM_CARD_ICON_TEXT := "火"
const GLOBAL_FREEZE_CARD_ICON_TEXT := "冰"
const RISKY_CACHE_CARD_ICON_TEXT := "赌"
const FORTIFY_CARD_ICON_TEXT := "盾"
const GOLD_CARD_ICON_TEXT := "金"
const BAIT_BEACON_CARD_ICON_TEXT := "诱"
const ROAD_SPIKES_CARD_ICON_TEXT := "刺"
const COIN_MAGNET_CARD_ICON_TEXT := "磁"
const TIME_WARP_CARD_ICON_TEXT := "隙"
const TOWER_SWAP_CARD_ICON_TEXT := "调"
const OVERLOAD_DEBT_CARD_ICON_TEXT := "债"
const PANIC_BUTTON_CARD_ICON_TEXT := "急"
const BOUNTY_MARK_CARD_ICON_TEXT := "赏"
const REROLL_CACHE_CARD_ICON_TEXT := "换"

signal start_wave_pressed
signal tower_build_requested(type_id: String)
signal next_level_pressed
signal upgrade_pressed
signal sell_pressed
signal tower_panel_close_pressed
signal game_start_pressed
signal continue_game_pressed
signal level_selected(level_index: int)
signal save_overwrite_confirmed(level_index: int)
signal exit_to_start_confirmed
signal update_announcement_dismissed(announcement_id: String)
signal reward_card_play_requested(card_index: int, drop_position: Vector2)
signal reward_card_discard_requested(card_index: int)
signal reward_card_reject_requested
signal reward_card_sell_requested(card_index: int)
signal console_command_submitted(command: String)
signal pause_resume_pressed
signal pause_restart_pressed
signal pause_main_menu_pressed
signal end_restart_pressed
signal end_main_menu_pressed

var gold_label: Label
var base_health_label: Label
var level_label: Label
var wave_label: Label
var message_label: Label
var start_wave_button: Button
var build_tower_button: Button
var next_level_button: Button
var build_panel: Panel
var build_options_scroll: ScrollContainer
var build_options_container: HBoxContainer
var compact_build_options_scroll: ScrollContainer
var compact_build_options_container: HBoxContainer
var tower_panel: Panel
var tower_info_label: Label
var upgrade_button: Button
var sell_button: Button
var tower_panel_close_button: Button
var start_overlay: Panel
var start_game_button: Button
var continue_game_button: Button
var level_select_button: Button
var update_announcement_button: Button
var codex_button: Button
var confirm_dialog_panel: Panel
var confirm_dialog_card: Panel
var confirm_dialog_title_label: Label
var confirm_dialog_message_label: Label
var confirm_dialog_confirm_button: Button
var confirm_dialog_cancel_button: Button
var update_announcement_popup: Panel
var update_announcement_popup_card: Panel
var update_announcement_popup_title_label: Label
var update_announcement_popup_meta_label: Label
var update_announcement_popup_body: RichTextLabel
var update_announcement_history_panel: Panel
var update_announcement_history_container: VBoxContainer
var update_announcement_history_close_button: Button
var codex_panel: Panel
var codex_list_container: HBoxContainer
var codex_detail_preview: CodexIconPreview
var codex_detail_title_label: Label
var codex_detail_meta_label: Label
var codex_detail_body_label: RichTextLabel
var level_select_panel: Panel
var level_select_scroll: ScrollContainer
var level_buttons_container: GridContainer
var level_banner_panel: Panel
var level_banner_title_label: Label
var level_banner_subtitle_label: Label
var level_clear_panel: Panel
var level_clear_title_label: Label
var level_clear_subtitle_label: Label
var level_clear_next_button: Button
var end_overlay: Panel
var end_title_label: Label
var end_subtitle_label: Label
var end_restart_button: Button
var end_main_menu_button: Button
var pause_overlay: Panel
var pause_menu_panel: Panel
var pause_hint_label: Label
var pause_resume_button: Button
var pause_restart_button: Button
var pause_main_menu_button: Button
var console_panel: Panel
var console_title_label: Label
var console_output: RichTextLabel
var console_input: LineEdit
var last_console_line: String = ""
var ui_root: Control
var card_hand_zone: Panel
var card_pending_panel: Panel
var card_pending_title_label: Label
var card_pending_description_label: Label
var card_pending_timer_label: Label
var card_pending_keep_hint_label: Label
var card_pending_reject_button: Button
var card_detail_panel: Panel
var card_detail_title_label: Label
var card_detail_description_label: Label
var card_hand_toggle_button: Button
var card_sell_zone: Panel
var card_area_preview: AreaCardPreview

var _selected_tower: Tower
var _update_announcements: Array[Dictionary] = []
var _active_update_announcement_id: String = ""
var _update_announcement_tween: Tween
var _end_animation_time: float = 0.0
var _end_animation_duration: float = 0.85
var _end_animation_active: bool = false
var _build_panel_expanded: bool = true
var _screen_tween: Tween
var _build_panel_tween: Tween
var _tower_panel_tween: Tween
var _pause_overlay_tween: Tween
var _console_panel_tween: Tween
var _level_banner_tween: Tween
var _level_clear_tween: Tween
var _build_option_buttons: Array[Button] = []
var _compact_build_option_buttons: Array[Button] = []
var _level_buttons: Array[Button] = []
var _hand_cards: Array[Dictionary] = []
var _card_controls: Array[Control] = []
var _pending_card: Dictionary = {}
var _discard_mode: bool = false
var _discard_animation_active: bool = false
var _pending_card_effect_id: String = ""
var _card_hand_expanded: bool = true
var _card_hand_available: bool = false
var _card_hand_tween: Tween
var _current_tower_unlock_level: int = 0
var _highest_unlocked_level_index: int = 0
var _confirm_dialog_mode: String = ""
var _confirm_dialog_level_index: int = 0
var _drag_card_index: int = -1
var _drag_card_control: Control
var _drag_offset: Vector2 = Vector2.ZERO
var _drag_start_position: Vector2 = Vector2.ZERO
var _drag_start_rotation: float = 0.0
var _last_gold: int = -999999
var _last_base_health: int = -999999
var _last_max_base_health: int = -999999
var _last_level: int = -999999
var _last_total_levels: int = -999999
var _last_wave: int = -999999
var _last_total_waves: int = -999999
var _last_message: String = ""
var _last_start_wave_enabled: int = -1
var _last_build_enabled: int = -1
var _last_next_level_enabled: int = -1
var _console_visible_requested: bool = false
var _tower_panel_cache_id: int = -1
var _tower_panel_cache_info: String = ""
var _tower_panel_cache_upgrade_text: String = ""
var _tower_panel_cache_upgrade_disabled: bool = false
var _tower_panel_cache_sell_text: String = ""
var _status_text_write_count: int = 0
var _ui_particle_config: Dictionary = {
	"name": "UIParticles",
	"amount": 18,
	"lifetime": 0.72,
	"emission_radius": 12.0,
	"velocity_min": 8.0,
	"velocity_max": 40.0,
	"scale_min": 1.0,
	"scale_max": 3.2,
	"gravity": Vector2(0.0, 140.0),
	"spread": 180.0,
	"color": ACCENT,
	"z_index": 120,
	"process_mode": Node.PROCESS_MODE_ALWAYS,
}

const HUD_BG := Color(0.030, 0.040, 0.046, 0.92)
const HUD_BG_DARK := Color(0.015, 0.020, 0.026, 0.95)
const HUD_BORDER := Color(0.210, 0.310, 0.330, 0.95)
const TEXT_MAIN := Color(0.88, 0.94, 0.91)
const TEXT_MUTED := Color(0.56, 0.66, 0.64)
const ACCENT := Color(0.24, 0.76, 0.72)
const WARNING := Color(0.90, 0.62, 0.24)
const DANGER := Color(0.88, 0.22, 0.18)
const PANEL_INK := Color(0.018, 0.024, 0.030, 0.96)
const CARD_SIZE := Vector2(104.0, 148.0)
const CARD_HAND_CENTER := Vector2(775.0, 488.0)
const CARD_HAND_ZONE := Rect2(Vector2(592.0, 388.0), Vector2(354.0, 146.0))
const CARD_SELL_ZONE := Rect2(Vector2(868.0, 348.0), Vector2(58.0, 48.0))


class AreaCardPreview:
	extends Control

	var radius: float = 92.0
	var accent: Color = Color(1.0, 0.48, 0.25)

	func _draw() -> void:
		draw_circle(Vector2.ZERO, radius, Color(accent.r, accent.g, accent.b, 0.12))
		draw_arc(Vector2.ZERO, radius, 0.0, TAU, 72, Color(accent.r, accent.g, accent.b, 0.75), 3.0, true)
		draw_line(Vector2(-12.0, 0.0), Vector2(12.0, 0.0), Color(accent.r, accent.g, accent.b, 0.95), 2.0, true)
		draw_line(Vector2(0.0, -12.0), Vector2(0.0, 12.0), Color(accent.r, accent.g, accent.b, 0.95), 2.0, true)


class CodexIconPreview:
	extends Control

	var item_kind: String = "tower"
	var config: Dictionary = {}
	var preview_node: Node2D
	var support_item: bool = false

	func set_item(new_kind: String, new_config: Dictionary, new_support_item: bool = false) -> void:
		item_kind = new_kind
		config = new_config.duplicate(true)
		support_item = new_support_item
		_refresh_preview_node()
		queue_redraw()

	func _notification(what: int) -> void:
		if what == NOTIFICATION_RESIZED and preview_node != null and is_instance_valid(preview_node):
			preview_node.position = size * 0.5
			preview_node.scale = Vector2.ONE * _get_preview_scale()

	func _draw() -> void:
		draw_rect(Rect2(Vector2.ZERO, size), Color(0.018, 0.026, 0.032, 0.88))
		draw_rect(Rect2(Vector2.ONE, size - Vector2(2.0, 2.0)), _get_item_color().darkened(0.18), false, 2.0)

	func _refresh_preview_node() -> void:
		if preview_node != null and is_instance_valid(preview_node):
			preview_node.queue_free()
		preview_node = null

		preview_node = _make_enemy_preview_node() if item_kind == "enemy" else _make_tower_preview_node()
		if preview_node == null:
			return
		preview_node.name = "ActualCodexPreview"
		preview_node.position = size * 0.5
		preview_node.scale = Vector2.ONE * _get_preview_scale()
		preview_node.set_process(false)
		preview_node.set_physics_process(false)
		add_child(preview_node)

	func _make_tower_preview_node() -> Tower:
		var tower := Tower.new()
		tower.setup(null, Vector2i.ZERO, config)
		tower.selected = false
		if support_item:
			tower.apply_augmentation(config)
		return tower

	func _make_enemy_preview_node() -> Enemy:
		var enemy := Enemy.new()
		var route_points: Array[Vector2] = [Vector2.ZERO, Vector2.RIGHT]
		enemy.setup(route_points, 100, 1.0, 0, config, 1.0)
		enemy.health = enemy.max_health
		enemy.set_visual_preview_only(true)
		return enemy


	func _get_preview_scale() -> float:
		var preview_extent := minf(size.x, size.y)
		if item_kind == "enemy":
			return clampf(preview_extent / 58.0, 0.85, 2.4)
		return clampf(preview_extent / 88.0, 0.72, 1.80)

	func _get_item_color() -> Color:
		return _get_config_color("color", Color(0.42, 0.82, 1.0))

	func _get_config_color(key: String, fallback: Color) -> Color:
		var raw_value: Variant = config.get(key, fallback)
		if raw_value is Color:
			return raw_value
		return fallback


const CONSOLE_COMMANDS: Array[String] = [
	"help",
	"start",
	"wave",
	"level",
	"next",
	"gold",
	"setgold",
	"damage",
	"heal",
	"basehp",
	"spawn",
	"clear",
	"card",
	"usecard",
	"victory",
	"defeat",
	"restart",
	"status",
]
const CONSOLE_CARD_ARGS: Array[String] = [
	"boost",
	"range",
	"rate",
	"heal",
	"missile",
	"cryo",
	"firestorm",
	"freeze",
	"risk",
	"fortify",
	"gold",
	"bait",
	"spikes",
	"magnet",
	"warp",
	"swap",
	"overload",
	"panic",
	"bounty",
	"reroll",
]


func setup(tower_configs: Array[Dictionary] = [], level_configs: Array[Dictionary] = [], enemy_configs: Array[Dictionary] = []) -> void:
	layer = 10
	process_mode = Node.PROCESS_MODE_ALWAYS

	var root := Control.new()
	ui_root = root
	root.name = "UIRoot"
	root.process_mode = Node.PROCESS_MODE_ALWAYS
	root.position = Vector2.ZERO
	root.size = Vector2(960.0, 640.0)
	root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(root)

	var top_bar := Panel.new()
	top_bar.position = Vector2(12.0, 8.0)
	top_bar.size = Vector2(936.0, 48.0)
	top_bar.mouse_filter = Control.MOUSE_FILTER_STOP
	top_bar.add_theme_stylebox_override("panel", _panel_style(HUD_BG, HUD_BORDER, 0))
	root.add_child(top_bar)

	gold_label = _make_label(Vector2(26.0, 14.0), Vector2(112.0, 28.0), WARNING)
	root.add_child(gold_label)

	base_health_label = _make_label(Vector2(148.0, 14.0), Vector2(146.0, 28.0), Color(0.96, 0.42, 0.36))
	root.add_child(base_health_label)

	level_label = _make_label(Vector2(304.0, 14.0), Vector2(104.0, 28.0), ACCENT)
	root.add_child(level_label)

	wave_label = _make_label(Vector2(418.0, 14.0), Vector2(112.0, 28.0), Color(0.70, 0.80, 1.0))
	root.add_child(wave_label)

	start_wave_button = _make_button(_get_start_wave_button_text(), Vector2(548.0, 14.0), Vector2(118.0, 36.0), ACCENT)
	start_wave_button.pressed.connect(_on_start_wave_pressed)
	_set_button_enabled(start_wave_button, false)
	root.add_child(start_wave_button)

	next_level_button = _make_button(_get_next_level_button_text(), Vector2(674.0, 14.0), Vector2(112.0, 36.0), WARNING)
	next_level_button.pressed.connect(_on_next_level_pressed)
	_set_button_enabled(next_level_button, false)
	root.add_child(next_level_button)

	message_label = _make_label(Vector2(798.0, 10.0), Vector2(136.0, 44.0), TEXT_MUTED)
	message_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	root.add_child(message_label)

	_create_build_panel(root, tower_configs)

	tower_panel = Panel.new()
	tower_panel.position = TOWER_PANEL_CLOSED_POSITION
	tower_panel.size = Vector2(250.0, 196.0)
	tower_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	tower_panel.visible = false
	tower_panel.modulate.a = 0.0
	tower_panel.add_theme_stylebox_override("panel", _panel_style(HUD_BG, Color(0.36, 0.50, 0.52), 0))
	root.add_child(tower_panel)

	tower_info_label = _make_label(Vector2(14.0, 10.0), Vector2(156.0, 112.0), TEXT_MAIN)
	tower_info_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	tower_panel.add_child(tower_info_label)

	tower_panel_close_button = _make_button(_get_tower_panel_close_button_text(), Vector2(178.0, 10.0), Vector2(58.0, 30.0), TEXT_MUTED)
	tower_panel_close_button.pressed.connect(_on_tower_panel_close_pressed)
	tower_panel.add_child(tower_panel_close_button)

	upgrade_button = _make_button(_get_tower_upgrade_placeholder_text(), Vector2(14.0, 136.0), Vector2(106.0, 42.0), ACCENT)
	upgrade_button.pressed.connect(_on_upgrade_pressed)
	tower_panel.add_child(upgrade_button)

	sell_button = _make_button(_get_tower_sell_placeholder_text(), Vector2(130.0, 136.0), Vector2(106.0, 42.0), DANGER)
	sell_button.pressed.connect(_on_sell_pressed)
	tower_panel.add_child(sell_button)

	start_overlay = Panel.new()
	start_overlay.position = Vector2.ZERO
	start_overlay.size = Vector2(960.0, 640.0)
	start_overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	start_overlay.add_theme_stylebox_override("panel", _panel_style(Color(0.014, 0.020, 0.026, 0.98), Color(0.014, 0.020, 0.026, 0.0), 0))
	root.add_child(start_overlay)
	_add_tactical_background(start_overlay, ACCENT, true)

	var title_rule := ColorRect.new()
	title_rule.color = ACCENT
	title_rule.position = Vector2(358.0, 168.0)
	title_rule.size = Vector2(244.0, 3.0)
	start_overlay.add_child(title_rule)

	var title_label := Label.new()
	title_label.text = _get_start_title_text()
	title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	title_label.position = Vector2(250.0, 180.0)
	title_label.size = Vector2(460.0, 54.0)
	title_label.add_theme_font_size_override("font_size", 38)
	title_label.add_theme_color_override("font_color", TEXT_MAIN)
	start_overlay.add_child(title_label)

	var title_shadow := ColorRect.new()
	title_shadow.color = Color(0.0, 0.0, 0.0, 0.28)
	title_shadow.position = Vector2(304.0, 232.0)
	title_shadow.size = Vector2(352.0, 3.0)
	title_shadow.mouse_filter = Control.MOUSE_FILTER_IGNORE
	start_overlay.add_child(title_shadow)

	var subtitle_label := Label.new()
	subtitle_label.text = _get_start_subtitle_text()
	subtitle_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	subtitle_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	subtitle_label.position = Vector2(260.0, 244.0)
	subtitle_label.size = Vector2(440.0, 34.0)
	subtitle_label.add_theme_color_override("font_color", TEXT_MUTED)
	start_overlay.add_child(subtitle_label)

	start_game_button = _make_button(_get_start_game_button_text(), Vector2(390.0, 286.0), Vector2(180.0, 46.0), ACCENT)
	start_game_button.pressed.connect(_on_start_game_pressed)
	start_overlay.add_child(start_game_button)

	continue_game_button = _make_button(_get_continue_game_button_text(), Vector2(390.0, 340.0), Vector2(180.0, 42.0), Color(0.58, 0.72, 1.0))
	continue_game_button.pressed.connect(_on_continue_game_pressed)
	_set_button_enabled(continue_game_button, false)
	start_overlay.add_child(continue_game_button)

	level_select_button = _make_button(_get_level_select_button_text(), Vector2(390.0, 394.0), Vector2(180.0, 42.0), WARNING)
	level_select_button.pressed.connect(_on_level_select_pressed)
	start_overlay.add_child(level_select_button)

	codex_button = _make_button(_get_codex_button_text(), Vector2(390.0, 448.0), Vector2(180.0, 42.0), ACCENT)
	codex_button.pressed.connect(_on_codex_pressed)
	start_overlay.add_child(codex_button)

	update_announcement_button = _make_button(_get_update_announcement_button_text(), Vector2(390.0, 502.0), Vector2(180.0, 42.0), Color(0.58, 0.72, 1.0))
	update_announcement_button.pressed.connect(_on_update_announcement_pressed)
	start_overlay.add_child(update_announcement_button)

	_create_level_select_panel(root, level_configs)
	_create_codex_panel(root, tower_configs, enemy_configs)

	_create_gameplay_overlays(root)
	_create_card_hand_ui(root)
	_create_pause_overlay(root)
	_create_end_overlay(root)
	_create_console(root)
	_create_update_announcement_ui(root)
	_create_confirm_dialog(root)


func _process(delta: float) -> void:
	if _drag_card_control != null:
		_update_dragged_card_position(get_viewport().get_mouse_position())

	if not _end_animation_active:
		return

	_end_animation_time = minf(_end_animation_time + delta, _end_animation_duration)
	var t := _end_animation_time / _end_animation_duration
	var eased := 1.0 - pow(1.0 - t, 3.0)
	end_overlay.modulate.a = eased
	end_title_label.scale = Vector2.ONE * lerpf(0.82, 1.0, eased)

	if _end_animation_time >= _end_animation_duration:
		_end_animation_active = false


func _input(event: InputEvent) -> void:
	if _drag_card_control == null:
		return

	if event is InputEventMouseMotion:
		_update_dragged_card_position(get_viewport().get_mouse_position())
		get_viewport().set_input_as_handled()
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		_finish_card_drag(get_viewport().get_mouse_position())
		get_viewport().set_input_as_handled()


func update_status(gold: int, base_health: int, max_base_health: int, level: int, total_levels: int, wave: int, total_waves: int, message: String) -> void:
	var gold_changed := gold != _last_gold
	var health_changed := base_health != _last_base_health or max_base_health != _last_max_base_health
	var level_changed := level != _last_level or total_levels != _last_total_levels
	var wave_changed := wave != _last_wave or total_waves != _last_total_waves
	var message_changed := message != _last_message
	if not gold_changed and not health_changed and not level_changed and not wave_changed and not message_changed:
		return

	if gold_changed:
		_last_gold = gold
		_set_status_label_text(gold_label, _format_gold_status_text(gold))
	if health_changed:
		_last_base_health = base_health
		_last_max_base_health = max_base_health
		_set_status_label_text(base_health_label, _format_base_health_status_text(base_health, max_base_health))
	if level_changed:
		_last_level = level
		_last_total_levels = total_levels
		_set_status_label_text(level_label, _format_level_status_text(level, total_levels))
	if wave_changed:
		_last_wave = wave
		_last_total_waves = total_waves
		_set_status_label_text(wave_label, _format_wave_status_text(wave, total_waves))
	if message_changed:
		_last_message = message
		_set_status_label_text(message_label, message)


func _format_gold_status_text(gold: int) -> String:
	return GOLD_STATUS_TEMPLATE % gold


func _format_base_health_status_text(base_health: int, max_base_health: int) -> String:
	return BASE_HEALTH_STATUS_TEMPLATE % [base_health, max_base_health]


func _format_level_status_text(level: int, total_levels: int) -> String:
	return LEVEL_STATUS_TEMPLATE % [level, total_levels]


func _format_wave_status_text(wave: int, total_waves: int) -> String:
	return WAVE_STATUS_TEMPLATE % [wave, total_waves]


func _get_start_wave_button_text() -> String:
	return START_WAVE_BUTTON_TEXT


func _get_next_level_button_text() -> String:
	return NEXT_LEVEL_BUTTON_TEXT


func _get_tower_panel_close_button_text() -> String:
	return TOWER_PANEL_CLOSE_BUTTON_TEXT


func _get_tower_upgrade_placeholder_text() -> String:
	return TOWER_UPGRADE_PLACEHOLDER_TEXT


func _get_tower_sell_placeholder_text() -> String:
	return TOWER_SELL_PLACEHOLDER_TEXT


func _get_build_panel_title_text() -> String:
	return BUILD_PANEL_TITLE_TEXT


func _get_build_panel_toggle_text(expanded: bool) -> String:
	return BUILD_PANEL_COLLAPSE_TEXT if expanded else BUILD_PANEL_EXPAND_TEXT


func _get_card_hand_toggle_text(expanded: bool) -> String:
	return CARD_HAND_COLLAPSE_TEXT if expanded else CARD_HAND_EXPAND_TEXT


func _format_card_hand_label_text(card_count: int, expanded: bool, discard_mode: bool) -> String:
	var label_text := CARD_HAND_EXPANDED_LABEL_TEMPLATE % card_count if expanded else CARD_HAND_COLLAPSED_LABEL_TEMPLATE % card_count
	if discard_mode:
		label_text += CARD_HAND_DISCARD_SUFFIX_TEXT
	return label_text


func _get_start_title_text() -> String:
	return START_TITLE_TEXT


func _get_start_subtitle_text() -> String:
	return START_SUBTITLE_TEXT


func _get_start_game_button_text() -> String:
	return START_GAME_BUTTON_TEXT


func _get_continue_game_button_text() -> String:
	return CONTINUE_GAME_BUTTON_TEXT


func _get_level_select_button_text() -> String:
	return LEVEL_SELECT_BUTTON_TEXT


func _get_save_overwrite_title_text() -> String:
	return SAVE_OVERWRITE_TITLE_TEXT


func _format_save_overwrite_message_text(level: int, level_name: String) -> String:
	return SAVE_OVERWRITE_MESSAGE_TEMPLATE % [level, level_name]


func _get_exit_to_start_title_text() -> String:
	return EXIT_TO_START_TITLE_TEXT


func _get_exit_to_start_message_text() -> String:
	return EXIT_TO_START_MESSAGE_TEXT


func _get_confirm_button_text() -> String:
	return CONFIRM_BUTTON_TEXT


func _get_cancel_button_text() -> String:
	return CANCEL_BUTTON_TEXT


func _get_update_announcement_button_text() -> String:
	return UPDATE_ANNOUNCEMENT_BUTTON_TEXT


func _get_codex_button_text() -> String:
	return CODEX_BUTTON_TEXT


func _get_codex_title_text() -> String:
	return CODEX_TITLE_TEXT


func _get_codex_subtitle_text() -> String:
	return CODEX_SUBTITLE_TEXT


func _get_codex_close_button_text() -> String:
	return CODEX_CLOSE_BUTTON_TEXT


func _get_update_announcement_popup_title_text() -> String:
	return UPDATE_ANNOUNCEMENT_POPUP_TITLE_TEXT


func _get_update_announcement_history_title_text() -> String:
	return UPDATE_ANNOUNCEMENT_HISTORY_TITLE_TEXT


func _get_update_announcement_close_text() -> String:
	return UPDATE_ANNOUNCEMENT_CLOSE_TEXT


func _get_update_announcement_known_text() -> String:
	return UPDATE_ANNOUNCEMENT_KNOWN_TEXT


func _get_level_select_title_text() -> String:
	return LEVEL_SELECT_TITLE_TEXT


func _get_level_select_subtitle_text() -> String:
	return LEVEL_SELECT_SUBTITLE_TEXT


func _get_level_select_close_button_text() -> String:
	return LEVEL_SELECT_CLOSE_BUTTON_TEXT


func _get_end_restart_button_text() -> String:
	return END_RESTART_BUTTON_TEXT


func _get_end_main_menu_button_text() -> String:
	return END_MAIN_MENU_BUTTON_TEXT


func _get_pause_title_text() -> String:
	return PAUSE_TITLE_TEXT


func _get_pause_hint_text() -> String:
	return PAUSE_HINT_TEXT


func _get_pause_resume_button_text() -> String:
	return PAUSE_RESUME_BUTTON_TEXT


func _get_console_title_text() -> String:
	return CONSOLE_TITLE_TEXT


func _get_console_placeholder_text() -> String:
	return CONSOLE_PLACEHOLDER_TEXT


func _get_console_initial_line_text() -> String:
	return CONSOLE_INITIAL_LINE_TEXT


func _format_locked_level_button_text(base_text: String) -> String:
	return LOCKED_LEVEL_BUTTON_TEMPLATE % base_text


func _get_locked_level_tooltip_text() -> String:
	return LOCKED_LEVEL_TOOLTIP_TEXT


func _format_tower_unlock_tooltip_text(base_tooltip: String, unlock_level: int) -> String:
	return TOWER_UNLOCK_TOOLTIP_TEMPLATE % [base_tooltip, unlock_level + 1]


func _format_compact_tower_tooltip_text(config: Dictionary) -> String:
	return COMPACT_TOWER_TOOLTIP_TEMPLATE % [
		_get_tower_display_name(config),
		_get_tower_category_label(config),
		_get_tower_config_cost(config),
		_format_tower_config_stats(config)
	]


func _format_support_tower_stats_text(config: Dictionary) -> String:
	return SUPPORT_TOWER_STATS_TEMPLATE % [
		_format_multiplier_bonus(config, "damage_multiplier"),
		_format_multiplier_bonus(config, "range_multiplier")
	]


func _format_weapon_tower_stats_text(config: Dictionary) -> String:
	return WEAPON_TOWER_STATS_TEMPLATE % [
		_get_tower_config_damage(config),
		int(_get_tower_config_range(config)),
		_get_tower_config_interval(config)
	]


func _format_support_tower_button_text(config: Dictionary) -> String:
	return SUPPORT_TOWER_BUTTON_TEMPLATE % [
		_get_tower_display_name(config),
		_get_tower_config_cost(config),
		_format_multiplier_bonus(config, "damage_multiplier"),
		_format_multiplier_bonus(config, "range_multiplier")
	]


func _format_weapon_tower_button_text(config: Dictionary) -> String:
	return WEAPON_TOWER_BUTTON_TEMPLATE % [
		_get_tower_display_name(config),
		_get_tower_config_cost(config),
		_get_tower_config_damage(config),
		int(_get_tower_config_range(config))
	]


func _format_console_completion_missing_text(current_token: String) -> String:
	return CONSOLE_COMPLETION_MISSING_TEMPLATE % current_token


func _format_console_completion_options_text(matches: Array[String]) -> String:
	return CONSOLE_COMPLETION_OPTIONS_TEMPLATE % ", ".join(matches)


func _get_damage_boost_card_icon_text() -> String:
	return DAMAGE_BOOST_CARD_ICON_TEXT


func _get_range_boost_card_icon_text() -> String:
	return RANGE_BOOST_CARD_ICON_TEXT


func _get_fire_rate_boost_card_icon_text() -> String:
	return FIRE_RATE_BOOST_CARD_ICON_TEXT


func _get_heal_card_icon_text() -> String:
	return HEAL_CARD_ICON_TEXT


func _get_missile_card_icon_text() -> String:
	return MISSILE_CARD_ICON_TEXT


func _get_cryo_card_icon_text() -> String:
	return CRYO_CARD_ICON_TEXT


func _get_firestorm_card_icon_text() -> String:
	return FIRESTORM_CARD_ICON_TEXT


func _get_global_freeze_card_icon_text() -> String:
	return GLOBAL_FREEZE_CARD_ICON_TEXT


func _get_risky_cache_card_icon_text() -> String:
	return RISKY_CACHE_CARD_ICON_TEXT


func _get_fortify_card_icon_text() -> String:
	return FORTIFY_CARD_ICON_TEXT


func _get_gold_card_icon_text() -> String:
	return GOLD_CARD_ICON_TEXT


func _get_bait_beacon_card_icon_text() -> String:
	return BAIT_BEACON_CARD_ICON_TEXT


func _get_road_spikes_card_icon_text() -> String:
	return ROAD_SPIKES_CARD_ICON_TEXT


func _get_coin_magnet_card_icon_text() -> String:
	return COIN_MAGNET_CARD_ICON_TEXT


func _get_time_warp_card_icon_text() -> String:
	return TIME_WARP_CARD_ICON_TEXT


func _get_tower_swap_card_icon_text() -> String:
	return TOWER_SWAP_CARD_ICON_TEXT


func _get_overload_debt_card_icon_text() -> String:
	return OVERLOAD_DEBT_CARD_ICON_TEXT


func _get_panic_button_card_icon_text() -> String:
	return PANIC_BUTTON_CARD_ICON_TEXT


func _get_bounty_mark_card_icon_text() -> String:
	return BOUNTY_MARK_CARD_ICON_TEXT


func _get_reroll_cache_card_icon_text() -> String:
	return REROLL_CACHE_CARD_ICON_TEXT


func _format_tower_panel_info_text(tower: Tower) -> String:
	var info_text := TOWER_PANEL_INFO_TEMPLATE % [
		tower.display_name,
		tower.level,
		tower.get_effective_damage(),
		int(tower.get_effective_range()),
		tower.get_effective_attack_interval()
	]
	return TOWER_PANEL_TRAIT_APPEND_TEMPLATE % [info_text, tower.get_trait_summary(), tower.get_upgrade_preview()]


func _get_tower_upgrade_button_text(tower: Tower) -> String:
	if tower.can_upgrade():
		return TOWER_UPGRADE_BUTTON_TEMPLATE % tower.get_upgrade_cost()
	return TOWER_MAX_LEVEL_BUTTON_TEXT


func _is_tower_upgrade_button_disabled(tower: Tower) -> bool:
	return not tower.can_upgrade()


func _format_tower_sell_button_text(tower: Tower) -> String:
	return TOWER_SELL_BUTTON_TEMPLATE % tower.get_sell_value()


func _format_level_intro_title_text(level: int, total_levels: int) -> String:
	return LEVEL_INTRO_TITLE_TEMPLATE % [level, total_levels]


func _format_level_clear_console_text(level: int, level_name: String) -> String:
	return LEVEL_CLEAR_CONSOLE_TEMPLATE % [level, level_name]


func _get_level_clear_title_text() -> String:
	return LEVEL_CLEAR_TITLE_TEXT


func _format_level_clear_subtitle_text(level: int, level_name: String) -> String:
	return LEVEL_CLEAR_SUBTITLE_TEMPLATE % [level, level_name]


func _get_level_clear_next_button_text() -> String:
	return LEVEL_CLEAR_NEXT_BUTTON_TEXT


func _get_card_sell_zone_icon_text() -> String:
	return CARD_SELL_ZONE_ICON_TEXT


func _get_pending_card_keep_hint_text() -> String:
	return PENDING_CARD_KEEP_HINT_TEXT


func _get_pending_card_reject_button_text() -> String:
	return PENDING_CARD_REJECT_BUTTON_TEXT


func _format_pending_card_title_text(card: Dictionary) -> String:
	return PENDING_CARD_TITLE_TEMPLATE % _get_card_display_name(card)


func _get_pending_card_description_text() -> String:
	return PENDING_CARD_DESCRIPTION_TEXT


func _get_hand_card_hint_text(discard_mode: bool) -> String:
	return HAND_CARD_DISCARD_HINT_TEXT if discard_mode else HAND_CARD_DRAG_HINT_TEXT


func _format_pending_card_timer_text(seconds_left: float) -> String:
	return PENDING_CARD_TIMER_TEMPLATE % maxf(seconds_left, 0.0)


func _set_status_label_text(label: Label, text: String) -> void:
	if label.text == text:
		return
	label.text = text
	_status_text_write_count += 1


func _set_button_enabled(button: Button, enabled: bool) -> void:
	if button == null or not is_instance_valid(button):
		return
	var disabled := not enabled
	var cursor_shape := Control.CURSOR_POINTING_HAND if enabled else Control.CURSOR_ARROW
	if button.disabled == disabled and button.mouse_default_cursor_shape == cursor_shape:
		return
	button.disabled = disabled
	button.mouse_default_cursor_shape = cursor_shape


func set_start_wave_enabled(enabled: bool) -> void:
	var state := 1 if enabled else 0
	if state == _last_start_wave_enabled:
		return
	_last_start_wave_enabled = state
	_set_button_enabled(start_wave_button, enabled)


func set_build_enabled(enabled: bool) -> void:
	var state := 1 if enabled else 0
	if state == _last_build_enabled:
		return
	_last_build_enabled = state
	_set_button_enabled(build_tower_button, enabled)
	_apply_tower_button_states()


func set_next_level_enabled(enabled: bool) -> void:
	var state := 1 if enabled else 0
	if state == _last_next_level_enabled:
		return
	_last_next_level_enabled = state
	_set_button_enabled(next_level_button, enabled)
	_set_button_enabled(level_clear_next_button, enabled)


func set_continue_game_enabled(enabled: bool) -> void:
	_set_button_enabled(continue_game_button, enabled)


func set_tower_unlock_level(level_index: int) -> void:
	_current_tower_unlock_level = maxi(level_index, 0)
	_apply_tower_button_states()


func set_highest_unlocked_level(level_index: int) -> void:
	_highest_unlocked_level_index = maxi(level_index, 0)
	for button in _level_buttons:
		if button == null or not is_instance_valid(button):
			continue
		var button_level := int(button.get_meta("level_index", 0))
		var unlocked := button_level <= _highest_unlocked_level_index
		_set_button_enabled(button, unlocked)
		var base_text := str(button.get_meta("base_text", button.text))
		button.text = base_text if unlocked else _format_locked_level_button_text(base_text)
		button.tooltip_text = "" if unlocked else _get_locked_level_tooltip_text()
		button.modulate = Color.WHITE if unlocked else Color(0.62, 0.68, 0.66, 0.72)


func set_card_hand_available(available: bool) -> void:
	var was_available := _card_hand_available
	_card_hand_available = available
	if not available:
		_card_hand_expanded = false
		_clear_card_drag_state()
		_apply_card_hand_zone_final_state(false, false)
		for card_control in _card_controls:
			if is_instance_valid(card_control):
				card_control.queue_free()
		_card_controls.clear()
		if card_sell_zone != null:
			card_sell_zone.visible = false
		if card_pending_panel != null:
			card_pending_panel.visible = false
		if card_detail_panel != null:
			card_detail_panel.visible = false
		if card_area_preview != null:
			card_area_preview.visible = false
		return

	if not was_available:
		_card_hand_expanded = true
	if card_hand_zone != null:
		card_hand_zone.visible = true
	_refresh_card_hand()


func _apply_tower_button_states() -> void:
	var globally_enabled := _last_build_enabled == 1
	for button in _build_option_buttons:
		_apply_single_tower_button_state(button, globally_enabled)
	for button in _compact_build_option_buttons:
		_apply_single_tower_button_state(button, globally_enabled)


func _apply_single_tower_button_state(button: Button, globally_enabled: bool) -> void:
	if button == null or not is_instance_valid(button):
		return
	var unlock_level := int(button.get_meta("unlock_level", 0))
	var unlocked := _current_tower_unlock_level >= unlock_level
	_set_button_enabled(button, globally_enabled and unlocked)
	var base_tooltip := str(button.get_meta("base_tooltip", button.tooltip_text))
	button.tooltip_text = base_tooltip if unlocked else _format_tower_unlock_tooltip_text(base_tooltip, unlock_level)


func show_start_screen() -> void:
	_kill_screen_tween()
	set_console_visible(false, false)
	hide_pause_menu(true)
	hide_confirm_dialog(false)
	hide_update_announcement_popup(false)
	hide_update_announcement_history()
	set_card_hand_available(false)
	hide_tower_panel(true)
	hide_level_intro()
	_apply_start_screen_final_state()


func hide_start_screen() -> void:
	hide_confirm_dialog(false)
	hide_update_announcement_popup(false)
	hide_update_announcement_history()
	_animate_to_gameplay()


func show_end_overlay(title: String, subtitle: String, title_color: Color) -> void:
	set_console_visible(false, false)
	hide_pause_menu(true)
	set_card_hand_available(false)
	hide_tower_panel(true)
	end_title_label.text = title
	end_title_label.add_theme_color_override("font_color", title_color)
	end_subtitle_label.text = subtitle
	end_overlay.visible = true
	end_overlay.modulate.a = 0.0
	end_title_label.scale = Vector2.ONE * 0.82
	_end_animation_time = 0.0
	_end_animation_active = true


func hide_end_overlay() -> void:
	end_overlay.visible = false
	end_overlay.modulate.a = 0.0
	end_title_label.scale = Vector2.ONE
	_end_animation_active = false
	_end_animation_time = 0.0


func show_level_intro(level: int, level_name: String, total_levels: int, delay: float = 0.0) -> void:
	_kill_level_banner_tween()
	level_banner_title_label.text = _format_level_intro_title_text(level, total_levels)
	level_banner_subtitle_label.text = level_name
	level_banner_panel.visible = true
	level_banner_panel.position = Vector2(300.0, -70.0)
	level_banner_panel.modulate.a = 0.0
	_play_popup_bounce(level_banner_panel, 0.86, 0.24)

	_level_banner_tween = create_tween()
	if delay > 0.0:
		_level_banner_tween.tween_interval(delay)
	_level_banner_tween.tween_property(level_banner_panel, "position", Vector2(300.0, 76.0), 0.26).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	_level_banner_tween.parallel().tween_property(level_banner_panel, "modulate:a", 1.0, 0.18)
	_level_banner_tween.tween_interval(1.0)
	_level_banner_tween.tween_property(level_banner_panel, "position", Vector2(300.0, 48.0), 0.22).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	_level_banner_tween.parallel().tween_property(level_banner_panel, "modulate:a", 0.0, 0.18)
	_level_banner_tween.finished.connect(func() -> void:
		level_banner_panel.visible = false
		level_banner_panel.position = Vector2(300.0, -70.0)
		level_banner_panel.modulate.a = 0.0
	)


func hide_level_intro() -> void:
	_kill_level_banner_tween()
	level_banner_panel.visible = false
	level_banner_panel.position = Vector2(300.0, -70.0)
	level_banner_panel.modulate.a = 0.0


func show_level_clear(level: int, level_name: String) -> void:
	write_console_line(_format_level_clear_console_text(level, level_name))
	_kill_level_clear_tween()
	level_clear_title_label.text = _get_level_clear_title_text()
	level_clear_subtitle_label.text = _format_level_clear_subtitle_text(level, level_name)
	level_clear_panel.visible = true
	level_clear_panel.position = Vector2(304.0, -142.0)
	level_clear_panel.modulate.a = 0.0
	_play_popup_bounce(level_clear_panel, 0.84, 0.24)

	_level_clear_tween = create_tween()
	_level_clear_tween.tween_property(level_clear_panel, "position", Vector2(304.0, 92.0), 0.28).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	_level_clear_tween.parallel().tween_property(level_clear_panel, "modulate:a", 1.0, 0.18)
	_level_clear_tween.finished.connect(func() -> void:
		_apply_level_clear_final_state(true)
	)


func hide_level_clear() -> void:
	_kill_level_clear_tween()
	_apply_level_clear_final_state(false)


func _apply_level_clear_final_state(visible: bool) -> void:
	level_clear_panel.visible = visible
	level_clear_panel.position = Vector2(304.0, 92.0) if visible else Vector2(304.0, -142.0)
	level_clear_panel.modulate.a = 1.0 if visible else 0.0


func update_card_hand(cards: Array[Dictionary], pending_card: Dictionary = {}, discard_mode: bool = false) -> void:
	_hand_cards = cards.duplicate(true)
	_pending_card = pending_card.duplicate(true)
	_discard_mode = discard_mode
	_discard_animation_active = false
	_refresh_card_hand()


func toggle_console() -> void:
	set_console_visible(not _console_visible_requested)


func set_console_visible(visible: bool, animated: bool = true) -> void:
	_console_visible_requested = visible
	if _console_panel_tween != null and _console_panel_tween.is_valid():
		_console_panel_tween.kill()

	if visible:
		console_panel.visible = true
		console_panel.modulate.a = 0.0 if animated else 1.0
		console_input.grab_focus()
		if animated:
			_play_popup_bounce(console_panel, 0.96, 0.14)
	else:
		console_input.release_focus()

	if not animated:
		console_panel.visible = visible
		console_panel.modulate.a = 1.0 if visible else 0.0
		return

	_console_panel_tween = create_tween()
	_console_panel_tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	if visible:
		_console_panel_tween.tween_property(console_panel, "modulate:a", 1.0, 0.10)
	else:
		_console_panel_tween.tween_property(console_panel, "modulate:a", 0.0, 0.10)
		_console_panel_tween.tween_callback(func() -> void:
			if not _console_visible_requested:
				console_panel.visible = false
		)


func is_console_visible() -> bool:
	return _console_visible_requested


func write_console_line(text: String) -> void:
	last_console_line = text
	console_output.append_text(text + "\n")


func _play_popup_bounce(target: Control, start_scale: float = 0.86, duration: float = 0.22) -> void:
	if target == null:
		return
	target.pivot_offset = target.size * 0.5
	target.scale = Vector2.ONE * start_scale
	var tween := create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(target, "scale", Vector2.ONE, duration).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func _spawn_ui_particles(screen_position: Vector2, color: Color, amount: int, radius: float, effect_name: String) -> void:
	if ui_root == null:
		return
	_apply_ui_particle_profile(effect_name, amount, radius, color)


func _get_end_overlay_particle_name(title_color: Color) -> String:
	if title_color.g >= title_color.r:
		return "VictoryOverlayParticles"
	return "DefeatOverlayParticles"


func _apply_ui_particle_profile(effect_name: String, amount: int, radius: float, color: Color) -> void:
	_ui_particle_config.clear()
	_ui_particle_config.merge(_get_base_ui_particle_config(effect_name, amount, radius, color), true)
	_ui_particle_config.merge(_get_ui_particle_profile_overrides(effect_name, amount, radius), true)


func _get_base_ui_particle_config(effect_name: String, amount: int, radius: float, color: Color) -> Dictionary:
	return {
		"name": effect_name,
		"amount": amount,
		"lifetime": 0.72,
		"emission_radius": radius * 0.35,
		"direction": Vector2.UP,
		"velocity_min": radius * 0.25,
		"velocity_max": radius * 1.25,
		"scale_min": 1.0,
		"scale_max": 3.2,
		"gravity": Vector2(0.0, 140.0),
		"spread": 180.0,
		"explosiveness": 0.88,
		"randomness": 0.48,
		"angular_velocity_min": -120.0,
		"angular_velocity_max": 120.0,
		"damping_min": 18.0,
		"damping_max": 70.0,
		"color": color,
		"z_index": 120,
		"process_mode": Node.PROCESS_MODE_ALWAYS,
	}


func _get_ui_particle_profile_overrides(effect_name: String, amount: int, radius: float) -> Dictionary:
	match effect_name:
		"VictoryOverlayParticles":
			return {
				"amount": maxi(amount, 96),
				"lifetime": 1.25,
				"emission_radius": radius * 0.58,
				"direction": Vector2.UP,
				"spread": 105.0,
				"velocity_min": radius * 0.18,
				"velocity_max": radius * 0.96,
				"gravity": Vector2(0.0, -80.0),
				"scale_min": 1.8,
				"scale_max": 4.8,
				"damping_min": 34.0,
				"damping_max": 90.0,
			}
		"DefeatOverlayParticles":
			return {
				"amount": maxi(amount, 72),
				"lifetime": 0.95,
				"emission_radius": radius * 0.42,
				"direction": Vector2.DOWN,
				"spread": 82.0,
				"velocity_min": radius * 0.20,
				"velocity_max": radius * 0.84,
				"gravity": Vector2(0.0, 420.0),
				"scale_min": 1.3,
				"scale_max": 3.4,
				"angular_velocity_min": -80.0,
				"angular_velocity_max": 80.0,
				"damping_min": 8.0,
				"damping_max": 36.0,
			}
		"LevelClearParticles":
			return {
				"lifetime": 1.08,
				"emission_radius": radius * 0.62,
				"direction": Vector2.UP,
				"spread": 72.0,
				"velocity_min": radius * 0.12,
				"velocity_max": radius * 0.72,
				"gravity": Vector2(0.0, -46.0),
				"scale_min": 1.4,
				"scale_max": 3.8,
				"damping_min": 22.0,
				"damping_max": 86.0,
			}
		"LevelIntroParticles":
			return {
				"lifetime": 0.48,
				"emission_radius": radius * 0.18,
				"direction": Vector2.RIGHT,
				"spread": 34.0,
				"velocity_min": radius * 0.56,
				"velocity_max": radius * 1.38,
				"gravity": Vector2.ZERO,
				"scale_min": 0.8,
				"scale_max": 2.1,
			}
		"CardConsumeParticles":
			return {
				"lifetime": 0.44,
				"emission_radius": radius * 0.20,
				"direction": Vector2.UP,
				"spread": 138.0,
				"velocity_min": radius * 0.48,
				"velocity_max": radius * 1.62,
				"gravity": Vector2(0.0, 80.0),
				"scale_min": 0.8,
				"scale_max": 2.2,
			}
		"CardDiscardParticles":
			return {
				"lifetime": 0.52,
				"emission_radius": radius * 0.24,
				"direction": Vector2.DOWN,
				"spread": 48.0,
				"velocity_min": radius * 0.32,
				"velocity_max": radius * 1.10,
				"gravity": Vector2(0.0, 360.0),
				"scale_min": 0.7,
				"scale_max": 1.7,
				"damping_min": 4.0,
				"damping_max": 28.0,
			}
		"PauseParticles":
			return {
				"lifetime": 0.86,
				"emission_radius": radius * 0.45,
				"direction": Vector2.UP,
				"spread": 180.0,
				"velocity_min": radius * 0.06,
				"velocity_max": radius * 0.28,
				"gravity": Vector2.ZERO,
				"scale_min": 0.7,
				"scale_max": 1.5,
				"explosiveness": 0.52,
			}
		"ConfirmDialogParticles":
			return {
				"lifetime": 0.62,
				"emission_radius": radius * 0.30,
				"direction": Vector2.UP,
				"spread": 42.0,
				"velocity_min": radius * 0.18,
				"velocity_max": radius * 0.82,
				"gravity": Vector2(0.0, 180.0),
				"scale_min": 0.9,
				"scale_max": 2.0,
			}
		"UpdatePopupParticles":
			return {
				"amount": maxi(amount, 34),
				"lifetime": 0.74,
				"emission_radius": radius * 0.24,
				"direction": Vector2.UP,
				"spread": 68.0,
				"velocity_min": radius * 0.20,
				"velocity_max": radius * 0.92,
				"gravity": Vector2(0.0, 36.0),
				"scale_min": 0.8,
				"scale_max": 1.9,
				"damping_min": 24.0,
				"damping_max": 78.0,
			}
		"UpdateHistoryParticles":
			return {
				"amount": maxi(amount, 26),
				"lifetime": 0.82,
				"emission_radius": radius * 0.42,
				"direction": Vector2.RIGHT,
				"spread": 28.0,
				"velocity_min": radius * 0.18,
				"velocity_max": radius * 0.70,
				"gravity": Vector2.ZERO,
				"scale_min": 0.6,
				"scale_max": 1.5,
				"explosiveness": 0.42,
				"damping_min": 30.0,
				"damping_max": 96.0,
			}
		"PendingCardParticles":
			return {
				"amount": maxi(amount, 30),
				"lifetime": 0.68,
				"emission_radius": radius * 0.34,
				"direction": Vector2.UP,
				"spread": 96.0,
				"velocity_min": radius * 0.22,
				"velocity_max": radius * 1.12,
				"gravity": Vector2(0.0, 96.0),
				"scale_min": 0.9,
				"scale_max": 2.4,
				"damping_min": 18.0,
				"damping_max": 62.0,
			}
		"CardSellParticles":
			return {
				"lifetime": 0.46,
				"emission_radius": radius * 0.20,
				"direction": Vector2.UP,
				"spread": 58.0,
				"velocity_min": radius * 0.42,
				"velocity_max": radius * 1.36,
				"gravity": Vector2(0.0, -120.0),
				"scale_min": 0.7,
				"scale_max": 1.9,
			}
		"BuildPanelParticles":
			return {
				"lifetime": 0.38,
				"emission_radius": radius * 0.18,
				"direction": Vector2.RIGHT,
				"spread": 22.0,
				"velocity_min": radius * 0.36,
				"velocity_max": radius * 1.18,
				"gravity": Vector2.ZERO,
				"scale_min": 0.5,
				"scale_max": 1.3,
				"explosiveness": 0.72,
				"damping_min": 26.0,
				"damping_max": 80.0,
			}
		"LevelSelectOpenParticles":
			return {
				"amount": maxi(amount, 28),
				"lifetime": 0.62,
				"emission_radius": radius * 0.36,
				"direction": Vector2.LEFT,
				"spread": 34.0,
				"velocity_min": radius * 0.30,
				"velocity_max": radius * 1.06,
				"gravity": Vector2.ZERO,
				"scale_min": 0.8,
				"scale_max": 2.0,
				"damping_min": 28.0,
				"damping_max": 88.0,
			}
		"LevelSelectCloseParticles":
			return {
				"amount": maxi(amount, 22),
				"lifetime": 0.48,
				"emission_radius": radius * 0.24,
				"direction": Vector2.RIGHT,
				"spread": 30.0,
				"velocity_min": radius * 0.28,
				"velocity_max": radius * 0.88,
				"gravity": Vector2.ZERO,
				"scale_min": 0.6,
				"scale_max": 1.5,
				"explosiveness": 0.62,
				"damping_min": 34.0,
				"damping_max": 96.0,
			}
		"ConsolePanelParticles":
			return {
				"amount": maxi(amount, 18),
				"lifetime": 0.42,
				"emission_radius": radius * 0.18,
				"direction": Vector2.UP,
				"spread": 26.0,
				"velocity_min": radius * 0.28,
				"velocity_max": radius * 0.86,
				"gravity": Vector2.ZERO,
				"scale_min": 0.5,
				"scale_max": 1.3,
				"explosiveness": 0.58,
				"damping_min": 38.0,
				"damping_max": 100.0,
			}
		"StartGameParticles":
			return {
				"lifetime": 0.78,
				"emission_radius": radius * 0.50,
				"direction": Vector2.UP,
				"spread": 124.0,
				"velocity_min": radius * 0.32,
				"velocity_max": radius * 1.72,
				"gravity": Vector2(0.0, 40.0),
				"scale_min": 1.2,
				"scale_max": 3.6,
			}
		_:
			return {}


func show_tower_panel(tower: Tower = null) -> void:
	_selected_tower = tower

	if not is_instance_valid(tower):
		hide_tower_panel(false)
		return

	var info_text := _format_tower_panel_info_text(tower)
	var upgrade_text := _get_tower_upgrade_button_text(tower)
	var upgrade_disabled := _is_tower_upgrade_button_disabled(tower)
	var sell_text := _format_tower_sell_button_text(tower)
	var tower_id := int(tower.get_instance_id())
	if (
		tower_panel.visible
		and tower_id == _tower_panel_cache_id
		and info_text == _tower_panel_cache_info
		and upgrade_text == _tower_panel_cache_upgrade_text
		and upgrade_disabled == _tower_panel_cache_upgrade_disabled
		and sell_text == _tower_panel_cache_sell_text
	):
		return

	_show_tower_panel_animated()
	_tower_panel_cache_id = tower_id
	_tower_panel_cache_info = info_text
	_tower_panel_cache_upgrade_text = upgrade_text
	_tower_panel_cache_upgrade_disabled = upgrade_disabled
	_tower_panel_cache_sell_text = sell_text
	tower_info_label.text = info_text
	upgrade_button.text = upgrade_text
	_set_button_enabled(upgrade_button, not upgrade_disabled)
	sell_button.text = sell_text


func hide_tower_panel(immediate: bool = false) -> void:
	_selected_tower = null
	if tower_panel == null:
		return

	if immediate:
		if _tower_panel_tween != null and _tower_panel_tween.is_valid():
			_tower_panel_tween.kill()
		tower_panel.visible = false
		tower_panel.position = TOWER_PANEL_CLOSED_POSITION
		tower_panel.modulate.a = 0.0
	elif tower_panel.visible:
		_hide_tower_panel_animated()

	_reset_tower_panel_cache()


func _show_tower_panel_animated() -> void:
	if _tower_panel_tween != null:
		_tower_panel_tween.kill()

	if tower_panel.visible:
		tower_panel.position = TOWER_PANEL_OPEN_POSITION
		tower_panel.modulate.a = 1.0
		return

	tower_panel.visible = true
	tower_panel.position = TOWER_PANEL_CLOSED_POSITION
	tower_panel.modulate.a = 0.0
	_tower_panel_tween = create_tween()
	_tower_panel_tween.tween_property(tower_panel, "position", TOWER_PANEL_OPEN_POSITION, TOWER_PANEL_ANIMATION_TIME).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	_tower_panel_tween.parallel().tween_property(tower_panel, "modulate:a", 1.0, TOWER_PANEL_ANIMATION_TIME * 0.75)


func _hide_tower_panel_animated() -> void:
	if _tower_panel_tween != null:
		_tower_panel_tween.kill()

	_tower_panel_tween = create_tween()
	_tower_panel_tween.tween_property(tower_panel, "position", TOWER_PANEL_CLOSED_POSITION, TOWER_PANEL_ANIMATION_TIME).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	_tower_panel_tween.parallel().tween_property(tower_panel, "modulate:a", 0.0, TOWER_PANEL_ANIMATION_TIME * 0.75)
	_tower_panel_tween.tween_callback(func() -> void:
		tower_panel.visible = false
	)


func _reset_tower_panel_cache() -> void:
	_tower_panel_cache_id = -1
	_tower_panel_cache_info = ""
	_tower_panel_cache_upgrade_text = ""
	_tower_panel_cache_upgrade_disabled = false
	_tower_panel_cache_sell_text = ""


func _make_label(label_position: Vector2, label_size: Vector2, color: Color = TEXT_MAIN) -> Label:
	var label := Label.new()
	label.position = label_position
	label.size = label_size
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.add_theme_color_override("font_color", color)
	label.add_theme_font_size_override("font_size", 13)
	return label


func _make_button(text: String, button_position: Vector2, button_size: Vector2, accent: Color = ACCENT) -> Button:
	var button := Button.new()
	button.text = text
	button.position = button_position
	button.size = button_size
	button.focus_mode = Control.FOCUS_NONE
	button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	_apply_button_style(button, accent)
	return button


func _add_tactical_background(parent: Control, accent: Color, route_preview: bool) -> void:
	var background := Control.new()
	background.name = "TacticalBackground"
	background.position = Vector2.ZERO
	background.size = parent.size
	background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	parent.add_child(background)

	var grid_color := Color(accent.r, accent.g, accent.b, 0.075)
	for x in range(0, 961, 32):
		_add_rect(background, Vector2(float(x), 0.0), Vector2(1.0, 640.0), grid_color)
	for y in range(0, 641, 32):
		_add_rect(background, Vector2(0.0, float(y)), Vector2(960.0, 1.0), grid_color)

	_add_rect(background, Vector2(42.0, 42.0), Vector2(120.0, 4.0), accent)
	_add_rect(background, Vector2(42.0, 42.0), Vector2(4.0, 120.0), accent)
	_add_rect(background, Vector2(798.0, 594.0), Vector2(120.0, 4.0), accent.darkened(0.1))
	_add_rect(background, Vector2(914.0, 478.0), Vector2(4.0, 120.0), accent.darkened(0.1))

	_add_rect(background, Vector2(96.0, 514.0), Vector2(110.0, 28.0), Color(0.020, 0.030, 0.034, 0.62))
	_add_rect(background, Vector2(754.0, 96.0), Vector2(96.0, 28.0), Color(0.020, 0.030, 0.034, 0.48))
	_add_rect(background, Vector2(112.0, 522.0), Vector2(18.0, 12.0), accent.darkened(0.15))
	_add_rect(background, Vector2(786.0, 104.0), Vector2(16.0, 12.0), accent.darkened(0.08))

	if route_preview:
		var route_color := Color(0.90, 0.62, 0.24, 0.56)
		_add_pixel_line(background, Vector2(104.0, 470.0), Vector2(256.0, 470.0), route_color, 5.0)
		_add_pixel_line(background, Vector2(256.0, 470.0), Vector2(256.0, 392.0), route_color, 5.0)
		_add_pixel_line(background, Vector2(256.0, 392.0), Vector2(450.0, 392.0), route_color, 5.0)
		_add_pixel_line(background, Vector2(450.0, 392.0), Vector2(450.0, 452.0), route_color, 5.0)
		_add_pixel_line(background, Vector2(450.0, 452.0), Vector2(686.0, 452.0), route_color, 5.0)
		_add_rect(background, Vector2(86.0, 450.0), Vector2(36.0, 42.0), Color(0.18, 0.10, 0.07, 0.82))
		_add_rect(background, Vector2(668.0, 426.0), Vector2(54.0, 54.0), Color(0.12, 0.30, 0.34, 0.74))
		_add_rect(background, Vector2(684.0, 440.0), Vector2(22.0, 22.0), Color(0.28, 0.92, 0.78, 0.66))


func _add_rect(parent: Control, rect_position: Vector2, rect_size: Vector2, color: Color) -> void:
	var rect := ColorRect.new()
	rect.position = rect_position
	rect.size = rect_size
	rect.color = color
	rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	parent.add_child(rect)


func _add_pixel_line(parent: Control, from_position: Vector2, to_position: Vector2, color: Color, thickness: float) -> void:
	var rect_position := Vector2(minf(from_position.x, to_position.x), minf(from_position.y, to_position.y))
	var rect_size := Vector2(absf(to_position.x - from_position.x), absf(to_position.y - from_position.y))
	if rect_size.x < 1.0:
		rect_position.x -= thickness * 0.5
		rect_size.x = thickness
	else:
		rect_size.y = thickness
	if rect_size.y < 1.0:
		rect_position.y -= thickness * 0.5
		rect_size.y = thickness
	_add_rect(parent, rect_position, rect_size, color)


func _panel_style(bg: Color, border: Color, radius: int) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = bg
	style.border_color = border
	style.border_width_left = 1
	style.border_width_top = 1
	style.border_width_right = 1
	style.border_width_bottom = 1
	style.corner_radius_top_left = radius
	style.corner_radius_top_right = radius
	style.corner_radius_bottom_left = radius
	style.corner_radius_bottom_right = radius
	style.content_margin_left = 8.0
	style.content_margin_right = 8.0
	style.content_margin_top = 5.0
	style.content_margin_bottom = 5.0
	return style


func _card_style(bg: Color, border: Color) -> StyleBoxFlat:
	var style := _panel_style(bg, border, 0)
	style.border_width_left = 2
	style.border_width_top = 2
	style.border_width_right = 2
	style.border_width_bottom = 2
	style.shadow_color = Color(0.0, 0.0, 0.0, 0.45)
	style.shadow_size = 6
	style.shadow_offset = Vector2(0.0, 3.0)
	return style


func _card_face_style(face_style: Dictionary) -> StyleBoxFlat:
	var style := _panel_style(
		_get_card_face_color(face_style, "bg", Color(0.032, 0.038, 0.045, 0.99)),
		_get_card_face_color(face_style, "accent", CARD_RARITY_WHITE_COLOR),
		0
	)
	var border_width := _get_card_face_int(face_style, "border_width", 2, 0, CARD_FACE_MAX_BORDER_WIDTH)
	style.border_width_left = border_width
	style.border_width_top = border_width
	style.border_width_right = border_width
	style.border_width_bottom = border_width
	style.shadow_color = Color(0.0, 0.0, 0.0, 0.48)
	style.shadow_size = 7 + _get_card_face_int(face_style, "pip_count", 0, 0, CARD_FACE_MAX_COUNT)
	style.shadow_offset = Vector2(0.0, 3.0)
	return style


func _apply_button_style(button: Button, accent: Color, is_tower_card: bool = false) -> void:
	var normal_bg := Color(0.044, 0.056, 0.064, 0.96)
	var hover_bg := Color(0.060, 0.078, 0.086, 0.98)
	var pressed_bg := Color(0.026, 0.036, 0.042, 1.0)
	var disabled_bg := Color(0.040, 0.045, 0.050, 0.72)
	var radius := 0
	var border_width := 2 if is_tower_card else 1

	var normal := _panel_style(normal_bg, accent.darkened(0.15), radius)
	var hover := _panel_style(hover_bg, accent, radius)
	var pressed := _panel_style(pressed_bg, accent.lightened(0.12), radius)
	var disabled := _panel_style(disabled_bg, Color(0.18, 0.21, 0.22, 0.7), radius)
	for style in [normal, hover, pressed, disabled]:
		style.border_width_left = border_width
		style.border_width_top = border_width
		style.border_width_right = border_width
		style.border_width_bottom = border_width

	button.add_theme_stylebox_override("normal", normal)
	button.add_theme_stylebox_override("hover", hover)
	button.add_theme_stylebox_override("pressed", pressed)
	button.add_theme_stylebox_override("disabled", disabled)
	button.add_theme_color_override("font_color", TEXT_MAIN)
	button.add_theme_color_override("font_hover_color", accent.lightened(0.35))
	button.add_theme_color_override("font_pressed_color", TEXT_MAIN)
	button.add_theme_color_override("font_disabled_color", Color(0.42, 0.48, 0.47))
	button.add_theme_font_size_override("font_size", 12 if is_tower_card else 13)


func _create_build_panel(root: Control, tower_configs: Array[Dictionary]) -> void:
	_build_option_buttons.clear()
	_compact_build_option_buttons.clear()
	build_panel = Panel.new()
	build_panel.position = Vector2(0.0, 508.0)
	build_panel.size = Vector2(960.0, 132.0)
	build_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	build_panel.add_theme_stylebox_override("panel", _panel_style(HUD_BG_DARK, Color(0.22, 0.30, 0.32), 0))
	root.add_child(build_panel)

	var build_title := Label.new()
	build_title.text = _get_build_panel_title_text()
	build_title.position = Vector2(18.0, 10.0)
	build_title.size = Vector2(86.0, 20.0)
	build_title.add_theme_font_size_override("font_size", 11)
	build_title.add_theme_color_override("font_color", TEXT_MUTED)
	build_panel.add_child(build_title)

	build_tower_button = _make_button(_get_build_panel_toggle_text(true), Vector2(14.0, 36.0), Vector2(96.0, 36.0), ACCENT)
	build_tower_button.pressed.connect(_on_build_menu_toggled)
	_set_button_enabled(build_tower_button, false)
	build_panel.add_child(build_tower_button)

	build_options_scroll = ScrollContainer.new()
	build_options_scroll.position = Vector2(126.0, 8.0)
	build_options_scroll.size = Vector2(812.0, 118.0)
	build_options_scroll.mouse_filter = Control.MOUSE_FILTER_STOP
	build_options_scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO
	build_options_scroll.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	build_panel.add_child(build_options_scroll)

	build_options_container = HBoxContainer.new()
	build_options_container.position = Vector2.ZERO
	build_options_container.custom_minimum_size = Vector2(0.0, 100.0)
	build_options_container.add_theme_constant_override("separation", 8)
	build_options_scroll.add_child(build_options_container)

	compact_build_options_scroll = ScrollContainer.new()
	compact_build_options_scroll.position = Vector2(126.0, 8.0)
	compact_build_options_scroll.size = Vector2(812.0, 42.0)
	compact_build_options_scroll.visible = false
	compact_build_options_scroll.mouse_filter = Control.MOUSE_FILTER_STOP
	compact_build_options_scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO
	compact_build_options_scroll.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	build_panel.add_child(compact_build_options_scroll)

	compact_build_options_container = HBoxContainer.new()
	compact_build_options_container.position = Vector2.ZERO
	compact_build_options_container.custom_minimum_size = Vector2(0.0, 38.0)
	compact_build_options_container.add_theme_constant_override("separation", 6)
	compact_build_options_scroll.add_child(compact_build_options_container)

	var current_category := ""
	for config in tower_configs:
		var category := _get_tower_category_label(config)
		if category != current_category:
			current_category = category
			var category_label := Label.new()
			category_label.text = category
			category_label.custom_minimum_size = Vector2(48.0, 96.0)
			category_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
			category_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			category_label.add_theme_font_size_override("font_size", 11)
			category_label.add_theme_color_override("font_color", TEXT_MUTED)
			build_options_container.add_child(category_label)

		var tower_button := Button.new()
		var type_id := str(config.get("id", "basic"))
		tower_button.text = _format_tower_button_text(config)
		tower_button.custom_minimum_size = Vector2(166.0, 96.0)
		tower_button.focus_mode = Control.FOCUS_NONE
		tower_button.tooltip_text = _format_tower_config_stats(config)
		_apply_button_style(tower_button, _get_tower_config_color(config), true)
		tower_button.set_meta("type_id", type_id)
		tower_button.set_meta("unlock_level", _get_tower_config_unlock_level(config))
		tower_button.set_meta("base_tooltip", tower_button.tooltip_text)
		tower_button.pressed.connect(_on_tower_option_pressed.bind(type_id))
		build_options_container.add_child(tower_button)
		_build_option_buttons.append(tower_button)

		var compact_button := Button.new()
		compact_button.text = _get_tower_icon_text(config)
		compact_button.custom_minimum_size = Vector2(48.0, 36.0)
		compact_button.focus_mode = Control.FOCUS_NONE
		compact_button.tooltip_text = _format_compact_tower_tooltip_text(config)
		_apply_button_style(compact_button, _get_tower_config_color(config), true)
		compact_button.set_meta("type_id", type_id)
		compact_button.set_meta("unlock_level", _get_tower_config_unlock_level(config))
		compact_button.set_meta("base_tooltip", compact_button.tooltip_text)
		compact_button.pressed.connect(_on_tower_option_pressed.bind(type_id))
		compact_build_options_container.add_child(compact_button)
		_compact_build_option_buttons.append(compact_button)

	_apply_tower_button_states()


func _format_tower_config_stats(config: Dictionary) -> String:
	if _is_support_tower_config(config):
		return _format_support_tower_stats_text(config)

	return _format_weapon_tower_stats_text(config)


func _format_tower_button_text(config: Dictionary) -> String:
	if _is_support_tower_config(config):
		return _format_support_tower_button_text(config)

	return _format_weapon_tower_button_text(config)


func _get_tower_display_name(config: Dictionary) -> String:
	var display_name := str(config.get("name", "")).strip_edges()
	return display_name if not display_name.is_empty() else _get_default_tower_display_name()


func _get_tower_category_label(config: Dictionary) -> String:
	var category_label := str(config.get("category_label", "")).strip_edges()
	return category_label if not category_label.is_empty() else _get_default_tower_category_label()


func _get_tower_icon_text(config: Dictionary) -> String:
	var icon_text := str(config.get("icon", "")).strip_edges()
	if not icon_text.is_empty() and not _has_ascii_letter(icon_text):
		return icon_text
	var display_name := _get_tower_display_name(config)
	var fallback_icon := display_name.substr(0, 1) if not display_name.is_empty() else _get_default_tower_icon_text()
	return fallback_icon if not _has_ascii_letter(fallback_icon) else _get_default_tower_icon_text()


func _get_default_tower_display_name() -> String:
	return DEFAULT_TOWER_DISPLAY_NAME


func _get_default_tower_category_label() -> String:
	return DEFAULT_TOWER_CATEGORY_LABEL


func _get_default_tower_icon_text() -> String:
	return DEFAULT_TOWER_ICON_TEXT


func _has_ascii_letter(text: String) -> bool:
	for index in range(text.length()):
		var code := text.unicode_at(index)
		if (code >= 65 and code <= 90) or (code >= 97 and code <= 122):
			return true
	return false


func _is_support_tower_config(config: Dictionary) -> bool:
	return _get_tower_config_category(config) == TOWER_CATEGORY_SUPPORT


func _format_multiplier_bonus(config: Dictionary, key: String) -> int:
	return int(round((_get_tower_config_multiplier(config, key) - 1.0) * 100.0))


func _get_tower_config_category(config: Dictionary) -> String:
	var category := str(config.get("category", TOWER_CATEGORY_WEAPON)).strip_edges()
	if category == TOWER_CATEGORY_SUPPORT:
		return TOWER_CATEGORY_SUPPORT
	return TOWER_CATEGORY_WEAPON


func _get_tower_config_cost(config: Dictionary) -> int:
	return _get_tower_config_positive_int(config, "cost", TOWER_CONFIG_DEFAULT_COST, TOWER_CONFIG_MAX_COST)


func _get_tower_config_damage(config: Dictionary) -> int:
	return _get_tower_config_non_negative_int(config, "damage", 0, TOWER_CONFIG_MAX_DAMAGE)


func _get_tower_config_range(config: Dictionary) -> float:
	return _get_tower_config_non_negative_float(config, "range", 0.0, TOWER_CONFIG_MAX_RANGE)


func _get_tower_config_interval(config: Dictionary) -> float:
	return _get_tower_config_positive_float(config, "interval", TOWER_CONFIG_DEFAULT_INTERVAL, TOWER_CONFIG_MAX_INTERVAL)


func _get_tower_config_multiplier(config: Dictionary, key: String) -> float:
	var raw_value: Variant = config.get(key, 1.0)
	if raw_value is int or raw_value is float:
		var value := float(raw_value)
		if value >= 1.0 and value <= TOWER_CONFIG_MAX_MULTIPLIER:
			return value
	return 1.0


func _get_tower_config_unlock_level(config: Dictionary) -> int:
	return _get_tower_config_non_negative_int(config, "unlock_level", 0, TOWER_CONFIG_MAX_UNLOCK_LEVEL)


func _get_tower_config_color(config: Dictionary) -> Color:
	var raw_color: Variant = config.get("color", ACCENT)
	if raw_color is Color:
		return raw_color
	return ACCENT


func _get_tower_config_positive_int(config: Dictionary, key: String, default_value: int, max_value: int) -> int:
	var value := _get_tower_config_non_negative_int(config, key, default_value, max_value)
	return value if value > 0 else default_value


func _get_tower_config_non_negative_int(config: Dictionary, key: String, default_value: int, max_value: int) -> int:
	var raw_value: Variant = config.get(key, default_value)
	if raw_value is int or raw_value is float:
		var value := int(round(float(raw_value)))
		if value >= 0 and value <= max_value:
			return value
	return default_value


func _get_tower_config_positive_float(config: Dictionary, key: String, default_value: float, max_value: float) -> float:
	var value := _get_tower_config_non_negative_float(config, key, default_value, max_value)
	return value if value > 0.0 else default_value


func _get_tower_config_non_negative_float(config: Dictionary, key: String, default_value: float, max_value: float) -> float:
	var raw_value: Variant = config.get(key, default_value)
	if raw_value is int or raw_value is float:
		var value := float(raw_value)
		if value >= 0.0 and value <= max_value:
			return value
	return default_value


func _format_level_select_button_text(index: int, config: Dictionary) -> String:
	return LEVEL_SELECT_CARD_TEMPLATE % [
		index + 1,
		_get_level_config_display_name(config),
		_get_level_config_wave_count(config),
		_get_level_config_route_count(config),
		_get_level_config_description(config)
	]


func _get_level_config_wave_count(config: Dictionary) -> int:
	var raw_waves: Variant = config.get("waves", LEVEL_CONFIG_DEFAULT_WAVES)
	if raw_waves is int or raw_waves is float:
		var wave_count := int(round(float(raw_waves)))
		if wave_count >= 0 and wave_count <= LEVEL_CONFIG_MAX_WAVES:
			return wave_count
	return LEVEL_CONFIG_DEFAULT_WAVES


func _get_level_config_route_count(config: Dictionary) -> int:
	var raw_routes: Variant = config.get("routes", [])
	if raw_routes is Array:
		return (raw_routes as Array).size()
	return 0


func _get_level_config_display_name(config: Dictionary) -> String:
	var display_name := str(config.get("name", "")).strip_edges()
	return display_name if not display_name.is_empty() else _get_default_level_display_name()


func _get_default_level_display_name() -> String:
	return DEFAULT_LEVEL_DISPLAY_NAME


func _get_level_config_description(config: Dictionary) -> String:
	return str(config.get("description", "")).strip_edges()


func _get_card_display_name(card: Dictionary) -> String:
	var display_name := str(card.get("name", "")).strip_edges()
	return display_name if not display_name.is_empty() else _get_default_card_display_name()


func _get_card_type_label(card: Dictionary) -> String:
	var type_label := str(card.get("type_label", "")).strip_edges()
	return type_label if not type_label.is_empty() else _get_default_card_type_label()


func _get_card_rarity(card: Dictionary) -> String:
	match str(card.get("rarity", CARD_RARITY_WHITE)).strip_edges().to_lower():
		CARD_RARITY_BLUE:
			return CARD_RARITY_BLUE
		CARD_RARITY_PURPLE:
			return CARD_RARITY_PURPLE
		CARD_RARITY_GOLD:
			return CARD_RARITY_GOLD
		CARD_RARITY_RED:
			return CARD_RARITY_RED
		_:
			return CARD_RARITY_WHITE


func _get_card_rarity_label(card: Dictionary) -> String:
	match _get_card_rarity(card):
		CARD_RARITY_BLUE:
			return CARD_RARITY_BLUE_LABEL
		CARD_RARITY_PURPLE:
			return CARD_RARITY_PURPLE_LABEL
		CARD_RARITY_GOLD:
			return CARD_RARITY_GOLD_LABEL
		CARD_RARITY_RED:
			return CARD_RARITY_RED_LABEL
		_:
			return CARD_RARITY_WHITE_LABEL


func _get_card_rarity_color(card: Dictionary) -> Color:
	match _get_card_rarity(card):
		CARD_RARITY_BLUE:
			return CARD_RARITY_BLUE_COLOR
		CARD_RARITY_PURPLE:
			return CARD_RARITY_PURPLE_COLOR
		CARD_RARITY_GOLD:
			return CARD_RARITY_GOLD_COLOR
		CARD_RARITY_RED:
			return CARD_RARITY_RED_COLOR
		_:
			return CARD_RARITY_WHITE_COLOR


func _get_card_rarity_face_style(card: Dictionary) -> Dictionary:
	var accent := _get_card_rarity_color(card)
	match _get_card_rarity(card):
		CARD_RARITY_BLUE:
			return {
				"accent": accent,
				"bg": Color(0.026, 0.038, 0.052, 0.99),
				"inner": Color(0.08, 0.16, 0.24, 0.18),
				"border_width": 2,
				"stripe_height": 6.0,
				"corner_size": 7.0,
				"rail_count": 2,
				"pip_count": 1,
				"shine_alpha": 0.045,
				"title_panel_alpha": 0.12,
				"icon_panel_alpha": 0.18,
			}
		CARD_RARITY_PURPLE:
			return {
				"accent": accent,
				"bg": Color(0.036, 0.030, 0.054, 0.99),
				"inner": Color(0.16, 0.08, 0.28, 0.20),
				"border_width": 3,
				"stripe_height": 7.0,
				"corner_size": 9.0,
				"rail_count": 3,
				"pip_count": 2,
				"shine_alpha": 0.075,
				"title_panel_alpha": 0.16,
				"icon_panel_alpha": 0.22,
			}
		CARD_RARITY_GOLD:
			return {
				"accent": accent,
				"bg": Color(0.052, 0.040, 0.018, 0.99),
				"inner": Color(0.32, 0.20, 0.05, 0.23),
				"border_width": 3,
				"stripe_height": 8.0,
				"corner_size": 11.0,
				"rail_count": 4,
				"pip_count": 3,
				"shine_alpha": 0.120,
				"title_panel_alpha": 0.20,
				"icon_panel_alpha": 0.28,
			}
		CARD_RARITY_RED:
			return {
				"accent": accent,
				"bg": Color(0.058, 0.022, 0.024, 0.99),
				"inner": Color(0.34, 0.06, 0.04, 0.25),
				"border_width": 4,
				"stripe_height": 9.0,
				"corner_size": 12.0,
				"rail_count": 5,
				"pip_count": 4,
				"shine_alpha": 0.155,
				"title_panel_alpha": 0.24,
				"icon_panel_alpha": 0.32,
			}
		_:
			return {
				"accent": accent,
				"bg": Color(0.032, 0.038, 0.045, 0.99),
				"inner": Color(0.12, 0.14, 0.16, 0.10),
				"border_width": 2,
				"stripe_height": 4.0,
				"corner_size": 0.0,
				"rail_count": 0,
				"pip_count": 0,
				"shine_alpha": 0.020,
				"title_panel_alpha": 0.08,
				"icon_panel_alpha": 0.14,
			}


func _get_card_rarity_face_detail_score(card: Dictionary) -> int:
	var face_style := _get_card_rarity_face_style(card)
	return (
		_get_card_face_int(face_style, "border_width", 2, 0, CARD_FACE_MAX_BORDER_WIDTH)
		+ _get_card_face_int(face_style, "rail_count", 0, 0, CARD_FACE_MAX_COUNT)
		+ _get_card_face_int(face_style, "pip_count", 0, 0, CARD_FACE_MAX_COUNT)
		+ int(_get_card_face_float(face_style, "corner_size", 0.0, 0.0, CARD_FACE_MAX_SIZE))
	)


func _get_card_face_accent(face_style: Dictionary) -> Color:
	return _get_card_face_color(face_style, "accent", CARD_RARITY_WHITE_COLOR)


func _get_card_face_color(face_style: Dictionary, key: String, fallback: Color) -> Color:
	var raw_value: Variant = face_style.get(key, fallback)
	if raw_value is Color:
		return raw_value
	return fallback


func _get_card_face_int(face_style: Dictionary, key: String, fallback: int, min_value: int, max_value: int) -> int:
	var raw_value: Variant = face_style.get(key, fallback)
	if raw_value is int or raw_value is float:
		var value := int(round(float(raw_value)))
		if value >= min_value and value <= max_value:
			return value
	return fallback


func _get_card_face_float(face_style: Dictionary, key: String, fallback: float, min_value: float, max_value: float) -> float:
	var raw_value: Variant = face_style.get(key, fallback)
	if raw_value is int or raw_value is float:
		var value := float(raw_value)
		if value >= min_value and value <= max_value:
			return value
	return fallback


func _get_default_card_display_name() -> String:
	return DEFAULT_CARD_DISPLAY_NAME


func _get_default_card_type_label() -> String:
	return DEFAULT_CARD_TYPE_LABEL


func _get_default_card_icon_text() -> String:
	return DEFAULT_CARD_ICON_TEXT


func _get_card_description(card: Dictionary) -> String:
	return str(card.get("description", "")).strip_edges()


func set_update_announcements(announcements: Array[Dictionary]) -> void:
	_update_announcements.clear()
	for announcement in announcements:
		_update_announcements.append(_get_sanitized_update_announcement(announcement as Dictionary))
	_refresh_update_announcement_history()


func show_latest_update_announcement(announcement: Dictionary) -> void:
	if announcement.is_empty():
		return
	announcement = _get_sanitized_update_announcement(announcement)
	_active_update_announcement_id = str(announcement.get("id", ""))
	update_announcement_popup_title_label.text = "%s：%s" % [_get_update_announcement_popup_title_text(), str(announcement.get("title", ""))]
	update_announcement_popup_meta_label.text = "%s  |  %s  |  %s" % [
		str(announcement.get("version", "")),
		str(announcement.get("date", "")),
		str(announcement.get("kind", "")),
	]
	update_announcement_popup_body.text = _format_update_announcement_body(announcement)
	_show_update_panel(update_announcement_popup, update_announcement_popup_card)


func show_update_announcement_history() -> void:
	_refresh_update_announcement_history()
	_show_update_panel(update_announcement_history_panel, update_announcement_history_panel)


func hide_update_announcement_popup(notify_dismissed: bool = false) -> void:
	var dismissed_id := _active_update_announcement_id
	_active_update_announcement_id = ""
	_hide_update_panel(update_announcement_popup)
	if notify_dismissed and not dismissed_id.is_empty():
		update_announcement_dismissed.emit(dismissed_id)


func hide_update_announcement_history() -> void:
	_hide_update_panel(update_announcement_history_panel)


func is_update_announcement_popup_visible() -> bool:
	return update_announcement_popup != null and update_announcement_popup.visible


func is_update_announcement_history_visible() -> bool:
	return update_announcement_history_panel != null and update_announcement_history_panel.visible


func _format_update_announcement_body(announcement: Dictionary) -> String:
	var lines: Array[String] = []
	var summary := _get_update_announcement_summary(announcement)
	if not summary.is_empty():
		lines.append(summary)
		lines.append("")
	for bullet in _get_update_announcement_bullets(announcement):
		lines.append("- %s" % bullet)
	return "\n".join(lines)


func _get_update_announcement_summary(announcement: Dictionary) -> String:
	return _get_update_announcement_text(announcement, "summary")


func _get_sanitized_update_announcement(announcement: Dictionary) -> Dictionary:
	return {
		"id": _get_update_announcement_text(announcement, "id"),
		"version": _get_update_announcement_text(announcement, "version"),
		"date": _get_update_announcement_text(announcement, "date"),
		"kind": _get_update_announcement_text(announcement, "kind"),
		"title": _get_update_announcement_text(announcement, "title"),
		"summary": _get_update_announcement_summary(announcement),
		"bullets": _get_update_announcement_bullets(announcement),
	}


func _get_update_announcement_text(announcement: Dictionary, key: String) -> String:
	var raw_value: Variant = announcement.get(key, "")
	if raw_value is String:
		return (raw_value as String).strip_edges()
	return ""


func _get_update_announcement_bullets(announcement: Dictionary) -> Array[String]:
	var raw_bullets: Variant = announcement.get("bullets", [])
	var bullets: Array[String] = []
	if raw_bullets is Array:
		for raw_bullet in raw_bullets as Array:
			if raw_bullet is String:
				var bullet := (raw_bullet as String).strip_edges()
				if not bullet.is_empty():
					bullets.append(bullet)
	return bullets


func _show_update_panel(panel: Panel, bounce_target: Control = null) -> void:
	if panel == null:
		return
	if _update_announcement_tween != null and _update_announcement_tween.is_valid():
		_update_announcement_tween.kill()
	panel.visible = true
	panel.modulate.a = 0.0
	panel.move_to_front()
	var target := bounce_target if bounce_target != null else panel
	_play_popup_bounce(target, 0.84, 0.24)
	_update_announcement_tween = create_tween()
	_update_announcement_tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	_update_announcement_tween.tween_property(panel, "modulate:a", 1.0, 0.16)


func _hide_update_panel(panel: Panel) -> void:
	if panel == null:
		return
	if _update_announcement_tween != null and _update_announcement_tween.is_valid():
		_update_announcement_tween.kill()
	if not panel.visible:
		panel.modulate.a = 0.0
		return
	_update_announcement_tween = create_tween()
	_update_announcement_tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	_update_announcement_tween.tween_property(panel, "modulate:a", 0.0, 0.12)
	_update_announcement_tween.tween_callback(func() -> void:
		panel.visible = false
	)


func _refresh_update_announcement_history() -> void:
	if update_announcement_history_container == null:
		return
	for child in update_announcement_history_container.get_children():
		update_announcement_history_container.remove_child(child)
		child.free()
	for announcement in _update_announcements:
		update_announcement_history_container.add_child(_make_update_announcement_card(announcement as Dictionary))


func _make_update_announcement_card(announcement: Dictionary) -> Panel:
	announcement = _get_sanitized_update_announcement(announcement)
	var card := Panel.new()
	card.custom_minimum_size = Vector2(748.0, 128.0)
	card.mouse_filter = Control.MOUSE_FILTER_IGNORE
	card.add_theme_stylebox_override("panel", _panel_style(Color(0.026, 0.034, 0.040, 0.98), Color(0.30, 0.44, 0.48), 0))

	var title := Label.new()
	title.text = "%s  %s" % [str(announcement.get("version", "")), str(announcement.get("title", ""))]
	title.position = Vector2(16.0, 10.0)
	title.size = Vector2(520.0, 28.0)
	title.add_theme_color_override("font_color", TEXT_MAIN)
	title.add_theme_font_size_override("font_size", 18)
	card.add_child(title)

	var meta := Label.new()
	meta.text = "%s  |  %s" % [str(announcement.get("date", "")), str(announcement.get("kind", ""))]
	meta.position = Vector2(560.0, 12.0)
	meta.size = Vector2(168.0, 24.0)
	meta.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	meta.add_theme_color_override("font_color", WARNING)
	meta.add_theme_font_size_override("font_size", 12)
	card.add_child(meta)

	var body := Label.new()
	body.text = _format_update_announcement_body(announcement)
	body.position = Vector2(16.0, 42.0)
	body.size = Vector2(710.0, 78.0)
	body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	body.add_theme_color_override("font_color", TEXT_MUTED)
	body.add_theme_font_size_override("font_size", 13)
	card.add_child(body)
	return card


func _create_level_select_panel(root: Control, level_configs: Array[Dictionary]) -> void:
	_level_buttons.clear()
	level_select_panel = Panel.new()
	level_select_panel.position = Vector2(960.0, 0.0)
	level_select_panel.size = Vector2(960.0, 640.0)
	level_select_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	level_select_panel.visible = false
	level_select_panel.modulate.a = 0.0
	level_select_panel.add_theme_stylebox_override("panel", _panel_style(Color(0.014, 0.020, 0.026, 0.98), Color(0.18, 0.42, 0.43), 0))
	root.add_child(level_select_panel)
	_add_tactical_background(level_select_panel, WARNING, false)

	var title := Label.new()
	title.text = _get_level_select_title_text()
	title.position = Vector2(260.0, 64.0)
	title.size = Vector2(440.0, 42.0)
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 30)
	title.add_theme_color_override("font_color", TEXT_MAIN)
	level_select_panel.add_child(title)

	var subtitle := Label.new()
	subtitle.text = _get_level_select_subtitle_text()
	subtitle.position = Vector2(220.0, 112.0)
	subtitle.size = Vector2(520.0, 28.0)
	subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	subtitle.add_theme_color_override("font_color", TEXT_MUTED)
	level_select_panel.add_child(subtitle)

	level_select_scroll = ScrollContainer.new()
	level_select_scroll.position = Vector2(78.0, 150.0)
	level_select_scroll.size = Vector2(812.0, 390.0)
	level_select_scroll.mouse_filter = Control.MOUSE_FILTER_STOP
	level_select_scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	level_select_scroll.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO
	level_select_panel.add_child(level_select_scroll)

	level_buttons_container = GridContainer.new()
	level_buttons_container.columns = 2
	level_buttons_container.position = Vector2.ZERO
	level_buttons_container.custom_minimum_size = Vector2(792.0, 0.0)
	level_buttons_container.add_theme_constant_override("separation", 10)
	level_buttons_container.add_theme_constant_override("h_separation", 12)
	level_buttons_container.add_theme_constant_override("v_separation", 10)
	level_select_scroll.add_child(level_buttons_container)

	for index in range(level_configs.size()):
		var config := level_configs[index]
		var button := Button.new()
		button.text = _format_level_select_button_text(index, config)
		button.custom_minimum_size = Vector2(384.0, 72.0)
		button.focus_mode = Control.FOCUS_NONE
		button.set_meta("base_text", button.text)
		button.set_meta("level_index", index)
		_apply_button_style(button, ACCENT if index == 0 else WARNING, true)
		button.pressed.connect(_on_level_button_pressed.bind(index))
		level_buttons_container.add_child(button)
		_level_buttons.append(button)

	var close_button := _make_button(_get_level_select_close_button_text(), Vector2(420.0, 582.0), Vector2(120.0, 40.0), DANGER)
	close_button.pressed.connect(_on_level_select_close_pressed)
	level_select_panel.add_child(close_button)


func _create_codex_panel(root: Control, tower_configs: Array[Dictionary], enemy_configs: Array[Dictionary]) -> void:
	codex_panel = Panel.new()
	codex_panel.position = Vector2(960.0, 0.0)
	codex_panel.size = Vector2(960.0, 640.0)
	codex_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	codex_panel.visible = false
	codex_panel.modulate.a = 0.0
	codex_panel.z_index = 102
	codex_panel.add_theme_stylebox_override("panel", _panel_style(Color(0.014, 0.020, 0.026, 0.98), ACCENT, 0))
	root.add_child(codex_panel)
	_add_tactical_background(codex_panel, ACCENT, false)

	var title := Label.new()
	title.text = _get_codex_title_text()
	title.position = Vector2(260.0, 42.0)
	title.size = Vector2(440.0, 42.0)
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 30)
	title.add_theme_color_override("font_color", TEXT_MAIN)
	codex_panel.add_child(title)

	var subtitle := Label.new()
	subtitle.text = _get_codex_subtitle_text()
	subtitle.position = Vector2(150.0, 88.0)
	subtitle.size = Vector2(660.0, 28.0)
	subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	subtitle.add_theme_color_override("font_color", TEXT_MUTED)
	codex_panel.add_child(subtitle)

	var list_scroll := ScrollContainer.new()
	list_scroll.position = Vector2(54.0, 128.0)
	list_scroll.size = Vector2(852.0, 138.0)
	list_scroll.mouse_filter = Control.MOUSE_FILTER_STOP
	list_scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO
	list_scroll.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	codex_panel.add_child(list_scroll)

	codex_list_container = HBoxContainer.new()
	codex_list_container.custom_minimum_size = Vector2(0.0, 124.0)
	codex_list_container.add_theme_constant_override("separation", 12)
	list_scroll.add_child(codex_list_container)

	var detail_panel := Panel.new()
	detail_panel.position = Vector2(94.0, 292.0)
	detail_panel.size = Vector2(772.0, 246.0)
	detail_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	detail_panel.add_theme_stylebox_override("panel", _panel_style(PANEL_INK, HUD_BORDER, 0))
	codex_panel.add_child(detail_panel)

	codex_detail_preview = CodexIconPreview.new()
	codex_detail_preview.position = Vector2(26.0, 34.0)
	codex_detail_preview.size = Vector2(158.0, 158.0)
	detail_panel.add_child(codex_detail_preview)

	codex_detail_title_label = Label.new()
	codex_detail_title_label.position = Vector2(214.0, 28.0)
	codex_detail_title_label.size = Vector2(500.0, 34.0)
	codex_detail_title_label.add_theme_font_size_override("font_size", 25)
	codex_detail_title_label.add_theme_color_override("font_color", TEXT_MAIN)
	detail_panel.add_child(codex_detail_title_label)

	codex_detail_meta_label = Label.new()
	codex_detail_meta_label.position = Vector2(214.0, 64.0)
	codex_detail_meta_label.size = Vector2(500.0, 24.0)
	codex_detail_meta_label.add_theme_color_override("font_color", WARNING)
	detail_panel.add_child(codex_detail_meta_label)

	codex_detail_body_label = RichTextLabel.new()
	codex_detail_body_label.position = Vector2(214.0, 96.0)
	codex_detail_body_label.size = Vector2(514.0, 122.0)
	codex_detail_body_label.fit_content = false
	codex_detail_body_label.scroll_active = true
	codex_detail_body_label.add_theme_color_override("default_color", TEXT_MUTED)
	codex_detail_body_label.add_theme_font_size_override("normal_font_size", 14)
	codex_detail_body_label.add_theme_stylebox_override("normal", _panel_style(Color(0.010, 0.016, 0.020, 0.86), Color(0.14, 0.25, 0.27), 0))
	detail_panel.add_child(codex_detail_body_label)

	var entries := _make_codex_entries(tower_configs, enemy_configs)
	for entry in entries:
		codex_list_container.add_child(_make_codex_entry_card(entry as Dictionary))
	if not entries.is_empty():
		_select_codex_entry(entries[0] as Dictionary)

	var close_button := _make_button(_get_codex_close_button_text(), Vector2(420.0, 582.0), Vector2(120.0, 40.0), DANGER)
	close_button.pressed.connect(_on_codex_close_pressed)
	codex_panel.add_child(close_button)


func _make_codex_entries(tower_configs: Array[Dictionary], enemy_configs: Array[Dictionary]) -> Array[Dictionary]:
	var entries: Array[Dictionary] = []
	for tower_config in tower_configs:
		entries.append({"kind": "tower", "config": (tower_config as Dictionary).duplicate(true)})
	for enemy_config in enemy_configs:
		entries.append({"kind": "enemy", "config": (enemy_config as Dictionary).duplicate(true)})
	return entries


func _make_codex_entry_card(entry: Dictionary) -> Panel:
	var config: Dictionary = entry.get("config", {})
	var kind := str(entry.get("kind", "tower"))
	var panel := Panel.new()
	panel.custom_minimum_size = Vector2(120.0, 122.0)
	panel.mouse_filter = Control.MOUSE_FILTER_PASS
	panel.add_theme_stylebox_override("panel", _panel_style(Color(0.020, 0.030, 0.036, 0.94), _get_codex_entry_color(entry), 0))

	var preview := CodexIconPreview.new()
	preview.position = Vector2(18.0, 8.0)
	preview.size = Vector2(84.0, 70.0)
	preview.mouse_filter = Control.MOUSE_FILTER_IGNORE
	preview.set_item(kind, config, kind == "tower" and _is_support_tower_config(config))
	panel.add_child(preview)

	var button := Button.new()
	button.position = Vector2(8.0, 82.0)
	button.size = Vector2(104.0, 34.0)
	button.text = "%s\n%s" % [_get_codex_kind_label(kind), _get_codex_config_name(config)]
	button.focus_mode = Control.FOCUS_NONE
	button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	_apply_button_style(button, _get_codex_entry_color(entry), true)
	button.pressed.connect(_on_codex_entry_pressed.bind(entry))
	panel.add_child(button)
	return panel


func _select_codex_entry(entry: Dictionary) -> void:
	var config: Dictionary = entry.get("config", {})
	var kind := str(entry.get("kind", "tower"))
	codex_detail_preview.set_item(kind, config, kind == "tower" and _is_support_tower_config(config))
	codex_detail_title_label.text = _get_codex_config_name(config)
	codex_detail_title_label.add_theme_color_override("font_color", _get_codex_entry_color(entry).lightened(0.18))
	codex_detail_meta_label.text = _format_codex_meta_text(kind, config)
	codex_detail_body_label.text = _format_codex_body_text(kind, config)
	_play_popup_bounce(codex_detail_preview, 0.78, 0.18)


func _get_codex_kind_label(kind: String) -> String:
	return CODEX_ENEMY_KIND_TEXT if kind == "enemy" else CODEX_TOWER_KIND_TEXT


func _get_codex_config_name(config: Dictionary) -> String:
	var display_name := str(config.get("name", "")).strip_edges()
	return display_name if not display_name.is_empty() else "Unknown"


func _get_codex_entry_color(entry: Dictionary) -> Color:
	var config: Dictionary = entry.get("config", {})
	var raw_color: Variant = config.get("color", ACCENT)
	if raw_color is Color:
		return raw_color
	return ACCENT


func _format_codex_meta_text(kind: String, config: Dictionary) -> String:
	if kind == "enemy":
		return "%s  |  ID: %s" % [CODEX_ENEMY_KIND_TEXT, str(config.get("id", "enemy"))]
	return "%s  |  %s  |  ID: %s" % [CODEX_TOWER_KIND_TEXT, str(config.get("category_label", DEFAULT_TOWER_CATEGORY_LABEL)), str(config.get("id", "tower"))]


func _format_codex_body_text(kind: String, config: Dictionary) -> String:
	if kind == "enemy":
		return _format_enemy_codex_body(config)
	return _format_tower_codex_body(config)


func _format_tower_codex_body(config: Dictionary) -> String:
	var lines: Array[String] = []
	lines.append("费用：%d 金币" % _get_tower_config_cost(config))
	lines.append("解锁：第 %d 关" % (_get_tower_config_unlock_level(config) + 1))
	if _is_support_tower_config(config):
		lines.append("属性：伤害 +%d%%，射程 +%d%%" % [_format_multiplier_bonus(config, "damage_multiplier"), _format_multiplier_bonus(config, "range_multiplier")])
	else:
		lines.append("属性：伤害 %d  |  射程 %d  |  间隔 %.2f 秒" % [_get_tower_config_damage(config), int(_get_tower_config_range(config)), _get_tower_config_interval(config)])
		lines.append("弹丸速度：%d" % int(float(config.get("projectile_speed", 0.0))))
	var type_id := str(config.get("id", "basic"))
	match type_id:
		"rapid":
			lines.append("功能：高射速炮塔，适合追击漏掉的快速怪和补刀残血目标。")
		"shotgun":
			lines.append("功能：散射多枚弹丸，近距离对成群怪物效果最好。")
		"cannon":
			lines.append("功能：重型溅射输出。爆炸半径 %.0f，边缘伤害 %.0f%%。" % [float(config.get("splash_radius", 0.0)), float(config.get("splash_ratio", 0.0)) * 100.0])
		"sniper":
			lines.append("功能：超远距离精准点杀，弹丸可穿透 %d 个目标。" % int(config.get("pierce", 0)))
		"amplifier":
			lines.append("功能：支援增幅层，不单独射击；建造时叠加到已有炮塔上。")
		_:
			lines.append("功能：均衡的基础炮塔，提供稳定单体输出。")
	return "\n".join(lines)


func _format_enemy_codex_body(config: Dictionary) -> String:
	var lines: Array[String] = []
	lines.append("生命倍率 x%.2f  |  速度倍率 x%.2f  |  奖励倍率 x%.2f" % [float(config.get("health_mul", 1.0)), float(config.get("speed_mul", 1.0)), float(config.get("reward_mul", 1.0))])
	lines.append("体型半径：%.1f  |  基地伤害：%d" % [float(config.get("radius", 12.0)), int(config.get("base_damage", 1))])
	match str(config.get("id", "grunt")):
		"runner":
			lines.append("功能：高速压迫单位，会惩罚攻速慢或覆盖不足的防线。")
		"brute":
			lines.append("功能：慢速重甲单位，生命更高，到达基地时伤害更高。")
		"shield":
			lines.append("功能：持盾怪物，用来检验防线的持续输出和覆盖。")
		"taunt":
			lines.append("功能：嘲讽堡垒单位，会吸引炮塔火力并保护同波次怪物推进。")
		"elite":
			lines.append("功能：后期精英威胁，生命很高，击杀后奖励也更高。")
		_:
			lines.append("功能：基础怪物，用来衡量普通输出和经济节奏。")
	return "\n".join(lines)


func _create_gameplay_overlays(root: Control) -> void:
	level_banner_panel = Panel.new()
	level_banner_panel.position = Vector2(300.0, -70.0)
	level_banner_panel.size = Vector2(360.0, 74.0)
	level_banner_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	level_banner_panel.visible = false
	level_banner_panel.z_index = 30
	level_banner_panel.add_theme_stylebox_override("panel", _panel_style(PANEL_INK, ACCENT, 0))
	root.add_child(level_banner_panel)

	var banner_line := ColorRect.new()
	banner_line.color = ACCENT
	banner_line.position = Vector2(0.0, 0.0)
	banner_line.size = Vector2(360.0, 4.0)
	level_banner_panel.add_child(banner_line)

	level_banner_title_label = Label.new()
	level_banner_title_label.position = Vector2(16.0, 12.0)
	level_banner_title_label.size = Vector2(328.0, 28.0)
	level_banner_title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	level_banner_title_label.add_theme_font_size_override("font_size", 22)
	level_banner_title_label.add_theme_color_override("font_color", TEXT_MAIN)
	level_banner_panel.add_child(level_banner_title_label)

	level_banner_subtitle_label = Label.new()
	level_banner_subtitle_label.position = Vector2(16.0, 40.0)
	level_banner_subtitle_label.size = Vector2(328.0, 22.0)
	level_banner_subtitle_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	level_banner_subtitle_label.add_theme_font_size_override("font_size", 13)
	level_banner_subtitle_label.add_theme_color_override("font_color", TEXT_MUTED)
	level_banner_panel.add_child(level_banner_subtitle_label)

	level_clear_panel = Panel.new()
	level_clear_panel.position = Vector2(304.0, -142.0)
	level_clear_panel.size = Vector2(352.0, 134.0)
	level_clear_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	level_clear_panel.visible = false
	level_clear_panel.z_index = 35
	level_clear_panel.add_theme_stylebox_override("panel", _panel_style(Color(0.022, 0.034, 0.030, 0.95), Color(0.56, 0.82, 0.46), 0))
	root.add_child(level_clear_panel)

	var clear_line := ColorRect.new()
	clear_line.color = Color(0.72, 0.92, 0.48)
	clear_line.position = Vector2(0.0, 0.0)
	clear_line.size = Vector2(352.0, 5.0)
	level_clear_panel.add_child(clear_line)

	level_clear_title_label = Label.new()
	level_clear_title_label.position = Vector2(16.0, 16.0)
	level_clear_title_label.size = Vector2(320.0, 32.0)
	level_clear_title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	level_clear_title_label.add_theme_font_size_override("font_size", 24)
	level_clear_title_label.add_theme_color_override("font_color", Color(0.78, 1.0, 0.58))
	level_clear_panel.add_child(level_clear_title_label)

	level_clear_subtitle_label = Label.new()
	level_clear_subtitle_label.position = Vector2(16.0, 50.0)
	level_clear_subtitle_label.size = Vector2(320.0, 22.0)
	level_clear_subtitle_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	level_clear_subtitle_label.add_theme_font_size_override("font_size", 13)
	level_clear_subtitle_label.add_theme_color_override("font_color", TEXT_MUTED)
	level_clear_panel.add_child(level_clear_subtitle_label)

	level_clear_next_button = _make_button(_get_level_clear_next_button_text(), Vector2(96.0, 84.0), Vector2(160.0, 36.0), WARNING)
	level_clear_next_button.pressed.connect(_on_next_level_pressed)
	_set_button_enabled(level_clear_next_button, false)
	level_clear_panel.add_child(level_clear_next_button)


func _create_card_hand_ui(root: Control) -> void:
	card_hand_zone = Panel.new()
	card_hand_zone.position = CARD_HAND_ZONE.position
	card_hand_zone.size = CARD_HAND_ZONE.size
	card_hand_zone.mouse_filter = Control.MOUSE_FILTER_IGNORE
	card_hand_zone.visible = false
	card_hand_zone.z_index = 25
	card_hand_zone.add_theme_stylebox_override("panel", _panel_style(Color(0.0, 0.0, 0.0, 0.0), Color(0.0, 0.0, 0.0, 0.0), 0))
	root.add_child(card_hand_zone)

	var hand_label := Label.new()
	hand_label.text = _format_card_hand_label_text(0, true, false)
	hand_label.name = "CardHandLabel"
	hand_label.position = Vector2(12.0, 8.0)
	hand_label.size = Vector2(150.0, 22.0)
	hand_label.add_theme_font_size_override("font_size", 11)
	hand_label.add_theme_color_override("font_color", Color(0.80, 0.86, 0.84, 0.72))
	card_hand_zone.add_child(hand_label)

	card_hand_toggle_button = _make_button(_get_card_hand_toggle_text(true), Vector2(138.0, 4.0), Vector2(74.0, 26.0), ACCENT)
	card_hand_toggle_button.pressed.connect(_on_card_hand_toggle_pressed)
	card_hand_zone.add_child(card_hand_toggle_button)

	card_sell_zone = Panel.new()
	card_sell_zone.position = CARD_SELL_ZONE.position
	card_sell_zone.size = CARD_SELL_ZONE.size
	card_sell_zone.mouse_filter = Control.MOUSE_FILTER_IGNORE
	card_sell_zone.visible = false
	card_sell_zone.z_index = 58
	card_sell_zone.add_theme_stylebox_override("panel", _card_style(Color(0.050, 0.024, 0.024, 0.90), DANGER))
	root.add_child(card_sell_zone)

	var trash_lid := ColorRect.new()
	trash_lid.color = Color(1.0, 0.62, 0.50)
	trash_lid.position = Vector2(17.0, 10.0)
	trash_lid.size = Vector2(24.0, 4.0)
	trash_lid.mouse_filter = Control.MOUSE_FILTER_IGNORE
	card_sell_zone.add_child(trash_lid)

	var trash_body := ColorRect.new()
	trash_body.color = Color(1.0, 0.62, 0.50, 0.74)
	trash_body.position = Vector2(20.0, 16.0)
	trash_body.size = Vector2(18.0, 20.0)
	trash_body.mouse_filter = Control.MOUSE_FILTER_IGNORE
	card_sell_zone.add_child(trash_body)

	var sell_icon := Label.new()
	sell_icon.text = _get_card_sell_zone_icon_text()
	sell_icon.position = Vector2(0.0, 18.0)
	sell_icon.size = card_sell_zone.size
	sell_icon.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	sell_icon.add_theme_font_size_override("font_size", 14)
	sell_icon.add_theme_color_override("font_color", Color(0.18, 0.06, 0.04))
	card_sell_zone.add_child(sell_icon)

	card_pending_panel = Panel.new()
	card_pending_panel.position = Vector2(330.0, 256.0)
	card_pending_panel.size = Vector2(300.0, 116.0)
	card_pending_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	card_pending_panel.visible = false
	card_pending_panel.z_index = 50
	card_pending_panel.add_theme_stylebox_override("panel", _card_style(Color(0.050, 0.036, 0.026, 0.96), WARNING))
	root.add_child(card_pending_panel)

	card_pending_title_label = Label.new()
	card_pending_title_label.position = Vector2(14.0, 12.0)
	card_pending_title_label.size = Vector2(272.0, 26.0)
	card_pending_title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	card_pending_title_label.add_theme_font_size_override("font_size", 17)
	card_pending_title_label.add_theme_color_override("font_color", WARNING)
	card_pending_panel.add_child(card_pending_title_label)

	card_pending_description_label = Label.new()
	card_pending_description_label.position = Vector2(16.0, 44.0)
	card_pending_description_label.size = Vector2(268.0, 58.0)
	card_pending_description_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	card_pending_description_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	card_pending_description_label.add_theme_font_size_override("font_size", 13)
	card_pending_description_label.add_theme_color_override("font_color", TEXT_MAIN)
	card_pending_panel.add_child(card_pending_description_label)

	card_pending_timer_label = Label.new()
	card_pending_timer_label.position = Vector2(16.0, 84.0)
	card_pending_timer_label.size = Vector2(104.0, 22.0)
	card_pending_timer_label.add_theme_font_size_override("font_size", 12)
	card_pending_timer_label.add_theme_color_override("font_color", WARNING)
	card_pending_panel.add_child(card_pending_timer_label)

	card_pending_keep_hint_label = Label.new()
	card_pending_keep_hint_label.text = _get_pending_card_keep_hint_text()
	card_pending_keep_hint_label.position = Vector2(122.0, 84.0)
	card_pending_keep_hint_label.size = Vector2(86.0, 20.0)
	card_pending_keep_hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	card_pending_keep_hint_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	card_pending_keep_hint_label.add_theme_font_size_override("font_size", 12)
	card_pending_keep_hint_label.add_theme_color_override("font_color", ACCENT.lightened(0.20))
	card_pending_panel.add_child(card_pending_keep_hint_label)

	card_pending_reject_button = _make_button(_get_pending_card_reject_button_text(), Vector2(212.0, 80.0), Vector2(72.0, 28.0), DANGER)
	card_pending_reject_button.pressed.connect(_on_pending_card_reject_pressed)
	card_pending_panel.add_child(card_pending_reject_button)

	card_detail_panel = Panel.new()
	card_detail_panel.position = Vector2(610.0, 260.0)
	card_detail_panel.size = Vector2(280.0, 112.0)
	card_detail_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	card_detail_panel.visible = false
	card_detail_panel.z_index = 55
	card_detail_panel.add_theme_stylebox_override("panel", _card_style(PANEL_INK, ACCENT))
	root.add_child(card_detail_panel)

	card_detail_title_label = Label.new()
	card_detail_title_label.position = Vector2(14.0, 12.0)
	card_detail_title_label.size = Vector2(252.0, 26.0)
	card_detail_title_label.add_theme_font_size_override("font_size", 17)
	card_detail_title_label.add_theme_color_override("font_color", TEXT_MAIN)
	card_detail_panel.add_child(card_detail_title_label)

	card_detail_description_label = Label.new()
	card_detail_description_label.position = Vector2(14.0, 42.0)
	card_detail_description_label.size = Vector2(252.0, 58.0)
	card_detail_description_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	card_detail_description_label.add_theme_font_size_override("font_size", 13)
	card_detail_description_label.add_theme_color_override("font_color", TEXT_MUTED)
	card_detail_panel.add_child(card_detail_description_label)

	card_area_preview = AreaCardPreview.new()
	card_area_preview.mouse_filter = Control.MOUSE_FILTER_IGNORE
	card_area_preview.visible = false
	card_area_preview.z_index = 96
	root.add_child(card_area_preview)


func _update_card_hand_zone_layout(animated: bool) -> void:
	if card_hand_zone == null:
		return

	var target_position := _get_card_hand_target_position(_card_hand_expanded)
	var target_size := _get_card_hand_target_size(_card_hand_expanded)

	card_hand_zone.visible = _card_hand_available
	if _card_hand_tween != null and _card_hand_tween.is_valid():
		_card_hand_tween.kill()
	if animated:
		_card_hand_tween = create_tween()
		_card_hand_tween.set_parallel(true)
		_card_hand_tween.tween_property(card_hand_zone, "position", target_position, 0.18).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		_card_hand_tween.tween_property(card_hand_zone, "size", target_size, 0.18).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		_card_hand_tween.finished.connect(func() -> void:
			_apply_card_hand_zone_final_state(_card_hand_expanded, _card_hand_available, false)
		)
	else:
		_apply_card_hand_zone_final_state(_card_hand_expanded, _card_hand_available)

	var hand_label := card_hand_zone.get_node_or_null("CardHandLabel") as Label
	if hand_label != null:
		hand_label.position = Vector2(8.0, 8.0) if _card_hand_expanded else Vector2(4.0, 8.0)
		hand_label.size = Vector2(126.0, 22.0) if _card_hand_expanded else Vector2(68.0, 44.0)
		hand_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT if _card_hand_expanded else HORIZONTAL_ALIGNMENT_CENTER
		hand_label.autowrap_mode = TextServer.AUTOWRAP_OFF if _card_hand_expanded else TextServer.AUTOWRAP_WORD_SMART

	if card_hand_toggle_button != null:
		card_hand_toggle_button.position = Vector2(138.0, 4.0) if _card_hand_expanded else Vector2(4.0, 64.0)
		card_hand_toggle_button.size = Vector2(74.0, 26.0) if _card_hand_expanded else Vector2(68.0, 34.0)


func _get_card_hand_target_position(expanded: bool) -> Vector2:
	return CARD_HAND_ZONE.position if expanded else Vector2(884.0, 410.0)


func _get_card_hand_target_size(expanded: bool) -> Vector2:
	return CARD_HAND_ZONE.size if expanded else Vector2(76.0, 112.0)


func _apply_card_hand_zone_final_state(expanded: bool, available: bool, stop_tween: bool = true) -> void:
	if card_hand_zone == null:
		return
	if stop_tween and _card_hand_tween != null and _card_hand_tween.is_valid():
		_card_hand_tween.kill()
	card_hand_zone.visible = available
	card_hand_zone.position = _get_card_hand_target_position(expanded)
	card_hand_zone.size = _get_card_hand_target_size(expanded)


func _refresh_card_hand() -> void:
	if not _card_hand_available:
		return
	for card_control in _card_controls:
		if is_instance_valid(card_control):
			card_control.queue_free()
	_card_controls.clear()
	_drag_card_index = -1
	_drag_card_control = null
	card_detail_panel.visible = false
	_update_card_hand_zone_layout(true)
	if card_hand_toggle_button != null:
		card_hand_toggle_button.text = _get_card_hand_toggle_text(_card_hand_expanded)
	if card_sell_zone != null:
		card_sell_zone.visible = _card_hand_expanded and not _discard_mode and not _hand_cards.is_empty()

	var hand_label := card_hand_zone.get_node_or_null("CardHandLabel") as Label
	if hand_label != null:
		hand_label.text = _format_card_hand_label_text(_hand_cards.size(), _card_hand_expanded, _discard_mode)

	card_pending_panel.visible = _discard_mode and not _pending_card.is_empty()
	if card_pending_panel.visible:
		card_pending_title_label.text = _format_pending_card_title_text(_pending_card)
		card_pending_description_label.text = _get_pending_card_description_text()
		var pending_effect_id := "%s:%s" % [str(_pending_card.get("id", "")), str(_pending_card.get("rarity", ""))]
		if pending_effect_id != _pending_card_effect_id:
			_pending_card_effect_id = pending_effect_id
			_play_popup_bounce(card_pending_panel, 0.86, 0.20)
	else:
		_pending_card_effect_id = ""

	if not _card_hand_expanded:
		_layout_card_controls(false)
		return

	for index in range(_hand_cards.size()):
		var card := _make_card_control(_hand_cards[index], index)
		ui_root.add_child(card)
		_card_controls.append(card)

	_layout_card_controls(true)


func _make_card_control(card: Dictionary, index: int) -> Panel:
	var panel := Panel.new()
	panel.name = "HandCard%d" % index
	panel.size = CARD_SIZE
	panel.pivot_offset = CARD_SIZE * 0.5
	panel.mouse_filter = Control.MOUSE_FILTER_STOP
	panel.z_index = 36 + index
	panel.tooltip_text = _get_card_description(card)
	var accent := _card_color(card)
	var face_style := _get_card_rarity_face_style(card)
	var rarity_color := _get_card_face_accent(face_style)
	panel.add_theme_stylebox_override("panel", _card_face_style(face_style))
	panel.gui_input.connect(_on_card_gui_input.bind(panel, index))
	panel.mouse_entered.connect(_on_card_mouse_entered.bind(panel, index))
	panel.mouse_exited.connect(_on_card_mouse_exited.bind(panel, index))

	_add_card_face_background(panel, face_style, accent)

	var type_label := Label.new()
	type_label.text = "%s·%s" % [_get_card_rarity_label(card), _get_card_type_label(card)]
	type_label.position = Vector2(8.0, 10.0)
	type_label.size = Vector2(88.0, 18.0)
	type_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	type_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	type_label.add_theme_font_size_override("font_size", 9)
	type_label.add_theme_color_override("font_color", rarity_color)
	panel.add_child(type_label)

	var title := Label.new()
	title.text = _get_card_display_name(card)
	title.position = Vector2(8.0, 32.0)
	title.size = Vector2(88.0, 34.0)
	title.mouse_filter = Control.MOUSE_FILTER_IGNORE
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	title.add_theme_font_size_override("font_size", 13)
	title.add_theme_color_override("font_color", rarity_color)
	panel.add_child(title)

	var icon := Label.new()
	icon.text = _card_icon(card)
	icon.position = Vector2(12.0, 70.0)
	icon.size = Vector2(80.0, 30.0)
	icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	icon.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	icon.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	icon.add_theme_font_size_override("font_size", 24)
	icon.add_theme_color_override("font_color", rarity_color.lightened(0.12))
	panel.add_child(icon)

	var icon_frame := Panel.new()
	icon_frame.position = Vector2(23.0, 67.0)
	icon_frame.size = Vector2(58.0, 38.0)
	icon_frame.mouse_filter = Control.MOUSE_FILTER_IGNORE
	icon_frame.add_theme_stylebox_override("panel", _panel_style(Color(accent.r, accent.g, accent.b, _get_card_face_float(face_style, "icon_panel_alpha", 0.14, 0.0, 1.0)), Color(rarity_color.r, rarity_color.g, rarity_color.b, 0.54), 0))
	panel.add_child(icon_frame)
	panel.move_child(icon_frame, panel.get_child_count() - 2)

	var hint := Label.new()
	hint.text = _get_hand_card_hint_text(_discard_mode)
	hint.position = Vector2(8.0, 114.0)
	hint.size = Vector2(88.0, 20.0)
	hint.mouse_filter = Control.MOUSE_FILTER_IGNORE
	hint.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hint.add_theme_font_size_override("font_size", 10)
	hint.add_theme_color_override("font_color", TEXT_MUTED)
	panel.add_child(hint)

	return panel


func _add_card_face_background(panel: Panel, face_style: Dictionary, card_accent: Color) -> void:
	var rarity_color := _get_card_face_accent(face_style)
	var stripe_height := _get_card_face_float(face_style, "stripe_height", 4.0, 0.0, CARD_FACE_MAX_SIZE)

	var stripe := ColorRect.new()
	stripe.name = "RarityStripe"
	stripe.color = rarity_color
	stripe.position = Vector2.ZERO
	stripe.size = Vector2(CARD_SIZE.x, stripe_height)
	stripe.mouse_filter = Control.MOUSE_FILTER_IGNORE
	panel.add_child(stripe)

	var inner := ColorRect.new()
	inner.name = "RarityInnerField"
	inner.color = _get_card_face_color(face_style, "inner", Color(0.12, 0.14, 0.16, 0.10))
	inner.position = Vector2(7.0, 9.0)
	inner.size = Vector2(CARD_SIZE.x - 14.0, CARD_SIZE.y - 18.0)
	inner.mouse_filter = Control.MOUSE_FILTER_IGNORE
	panel.add_child(inner)

	var title_plate := ColorRect.new()
	title_plate.name = "RarityTitlePlate"
	title_plate.color = Color(rarity_color.r, rarity_color.g, rarity_color.b, _get_card_face_float(face_style, "title_panel_alpha", 0.08, 0.0, 1.0))
	title_plate.position = Vector2(9.0, 30.0)
	title_plate.size = Vector2(CARD_SIZE.x - 18.0, 38.0)
	title_plate.mouse_filter = Control.MOUSE_FILTER_IGNORE
	panel.add_child(title_plate)

	var shine := ColorRect.new()
	shine.name = "RarityShine"
	shine.color = Color(1.0, 1.0, 1.0, _get_card_face_float(face_style, "shine_alpha", 0.02, 0.0, 1.0))
	shine.position = Vector2(9.0, 10.0)
	shine.size = Vector2(CARD_SIZE.x - 18.0, 18.0)
	shine.mouse_filter = Control.MOUSE_FILTER_IGNORE
	panel.add_child(shine)

	_add_card_face_rails(panel, face_style, card_accent)
	_add_card_face_corner_marks(panel, face_style)
	_add_card_face_pips(panel, face_style)


func _add_card_face_rails(panel: Panel, face_style: Dictionary, card_accent: Color) -> void:
	var rail_count := _get_card_face_int(face_style, "rail_count", 0, 0, CARD_FACE_MAX_COUNT)
	if rail_count <= 0:
		return
	var rarity_color := _get_card_face_accent(face_style)
	for rail_index in range(rail_count):
		var rail := ColorRect.new()
		rail.name = "RarityRail%d" % rail_index
		var rail_alpha := 0.16 + float(rail_index) * 0.035
		rail.color = Color(card_accent.r, card_accent.g, card_accent.b, rail_alpha)
		rail.position = Vector2(12.0 + float(rail_index) * 7.0, 105.0 + float(rail_index % 2) * 5.0)
		rail.size = Vector2(80.0 - float(rail_index) * 9.0, 2.0)
		rail.mouse_filter = Control.MOUSE_FILTER_IGNORE
		panel.add_child(rail)

		if rail_index >= 2:
			var spark := ColorRect.new()
			spark.name = "RarityRailSpark%d" % rail_index
			spark.color = Color(rarity_color.r, rarity_color.g, rarity_color.b, 0.48)
			spark.position = rail.position + Vector2(rail.size.x - 4.0, -1.0)
			spark.size = Vector2(4.0, 4.0)
			spark.mouse_filter = Control.MOUSE_FILTER_IGNORE
			panel.add_child(spark)


func _add_card_face_corner_marks(panel: Panel, face_style: Dictionary) -> void:
	var corner_size := _get_card_face_float(face_style, "corner_size", 0.0, 0.0, CARD_FACE_MAX_SIZE)
	if corner_size <= 0.0:
		return
	var rarity_color := _get_card_face_accent(face_style)
	var positions := [
		Vector2(7.0, 9.0),
		Vector2(CARD_SIZE.x - 7.0 - corner_size, 9.0),
		Vector2(7.0, CARD_SIZE.y - 9.0 - corner_size),
		Vector2(CARD_SIZE.x - 7.0 - corner_size, CARD_SIZE.y - 9.0 - corner_size),
	]
	for corner_index in range(positions.size()):
		var corner := ColorRect.new()
		corner.name = "RarityCorner%d" % corner_index
		corner.color = Color(rarity_color.r, rarity_color.g, rarity_color.b, 0.52)
		corner.position = positions[corner_index]
		corner.size = Vector2(corner_size, 2.0)
		corner.mouse_filter = Control.MOUSE_FILTER_IGNORE
		panel.add_child(corner)

		var vertical := ColorRect.new()
		vertical.name = "RarityCornerVertical%d" % corner_index
		vertical.color = Color(rarity_color.r, rarity_color.g, rarity_color.b, 0.44)
		vertical.position = positions[corner_index]
		vertical.size = Vector2(2.0, corner_size)
		vertical.mouse_filter = Control.MOUSE_FILTER_IGNORE
		panel.add_child(vertical)


func _add_card_face_pips(panel: Panel, face_style: Dictionary) -> void:
	var pip_count := _get_card_face_int(face_style, "pip_count", 0, 0, CARD_FACE_MAX_COUNT)
	if pip_count <= 0:
		return
	var rarity_color := _get_card_face_accent(face_style)
	for pip_index in range(pip_count):
		var pip := ColorRect.new()
		pip.name = "RarityPip%d" % pip_index
		pip.color = Color(rarity_color.r, rarity_color.g, rarity_color.b, 0.72)
		pip.position = Vector2(13.0 + float(pip_index) * 8.0, CARD_SIZE.y - 24.0)
		pip.size = Vector2(4.0, 4.0)
		pip.mouse_filter = Control.MOUSE_FILTER_IGNORE
		panel.add_child(pip)


func _layout_card_controls(animated: bool) -> void:
	var count := _card_controls.size()
	for index in range(count):
		var card_control := _card_controls[index]
		if not is_instance_valid(card_control) or card_control == _drag_card_control:
			continue
		var offset := float(index) - float(count - 1) * 0.5
		var target_position := CARD_HAND_CENTER + Vector2(offset * 44.0 - CARD_SIZE.x * 0.5, absf(offset) * 9.0 - CARD_SIZE.y * 0.46)
		var target_rotation := offset * 8.0
		if animated:
			card_control.position = target_position + Vector2(0.0, 44.0)
			card_control.modulate.a = 0.0
			var tween := create_tween()
			tween.set_parallel(true)
			tween.tween_property(card_control, "position", target_position, 0.18).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
			tween.tween_property(card_control, "rotation_degrees", target_rotation, 0.18)
			tween.tween_property(card_control, "modulate:a", 1.0, 0.12)
		else:
			card_control.position = target_position
			card_control.rotation_degrees = target_rotation
			card_control.modulate.a = 1.0


func _card_color(card: Dictionary) -> Color:
	match _get_card_id(card):
		"tower_boost":
			return Color(0.48, 0.72, 0.92)
		"range_boost":
			return Color(0.36, 0.66, 0.90)
		"fire_rate_boost":
			return Color(0.42, 0.86, 0.58)
		"heal":
			return Color(0.46, 0.82, 0.58)
		"missile":
			return Color(0.94, 0.48, 0.28)
		"cryo":
			return Color(0.42, 0.82, 0.92)
		"firestorm":
			return Color(1.00, 0.34, 0.16)
		"global_freeze":
			return Color(0.58, 0.92, 1.00)
		"risky_cache":
			return Color(0.78, 0.60, 0.92)
		"fortify":
			return Color(0.72, 0.78, 0.64)
		"gold":
			return Color(0.96, 0.72, 0.28)
		"bait_beacon":
			return Color(1.0, 0.74, 0.22)
		"road_spikes":
			return Color(0.90, 0.58, 0.30)
		"coin_magnet":
			return Color(1.0, 0.82, 0.26)
		"time_warp":
			return Color(0.68, 0.48, 1.0)
		"tower_swap":
			return Color(0.48, 1.0, 0.78)
		"overload_debt":
			return Color(1.0, 0.38, 0.70)
		"panic_button":
			return Color(1.0, 0.90, 0.32)
		"bounty_mark":
			return Color(1.0, 0.68, 0.18)
		"reroll_cache":
			return Color(0.72, 0.56, 1.0)
		_:
			return ACCENT


func _card_icon(card: Dictionary) -> String:
	match _get_card_id(card):
		"tower_boost":
			return _get_damage_boost_card_icon_text()
		"range_boost":
			return _get_range_boost_card_icon_text()
		"fire_rate_boost":
			return _get_fire_rate_boost_card_icon_text()
		"heal":
			return _get_heal_card_icon_text()
		"missile":
			return _get_missile_card_icon_text()
		"cryo":
			return _get_cryo_card_icon_text()
		"firestorm":
			return _get_firestorm_card_icon_text()
		"global_freeze":
			return _get_global_freeze_card_icon_text()
		"risky_cache":
			return _get_risky_cache_card_icon_text()
		"fortify":
			return _get_fortify_card_icon_text()
		"gold":
			return _get_gold_card_icon_text()
		"bait_beacon":
			return _get_bait_beacon_card_icon_text()
		"road_spikes":
			return _get_road_spikes_card_icon_text()
		"coin_magnet":
			return _get_coin_magnet_card_icon_text()
		"time_warp":
			return _get_time_warp_card_icon_text()
		"tower_swap":
			return _get_tower_swap_card_icon_text()
		"overload_debt":
			return _get_overload_debt_card_icon_text()
		"panic_button":
			return _get_panic_button_card_icon_text()
		"bounty_mark":
			return _get_bounty_mark_card_icon_text()
		"reroll_cache":
			return _get_reroll_cache_card_icon_text()
		_:
			return _get_default_card_icon_text()


func _is_area_target_card(card: Dictionary) -> bool:
	return _get_card_id(card) in ["missile", "cryo", "firestorm", "global_freeze", "bait_beacon", "road_spikes", "time_warp", "tower_swap", "bounty_mark"]


func _get_card_area_preview_radius(card: Dictionary) -> float:
	var raw_radius: Variant = card.get("radius", CARD_AREA_PREVIEW_DEFAULT_RADIUS)
	if raw_radius is int or raw_radius is float:
		var radius := float(raw_radius)
		if radius > 0.0 and radius <= CARD_AREA_PREVIEW_MAX_RADIUS:
			return radius
	return CARD_AREA_PREVIEW_DEFAULT_RADIUS


func _get_card_id(card: Dictionary) -> String:
	var card_id := _normalize_reward_card_id(str(card.get("id", "")))
	if card_id.is_empty():
		card_id = _normalize_reward_card_id(str(card.get("card_id", "")))
	return card_id


func _normalize_reward_card_id(raw_id: String) -> String:
	match raw_id.strip_edges().to_lower():
		"boost", "tower", "damage", "dmg", "tower_boost":
			return "tower_boost"
		"range", "rng", "range_boost":
			return "range_boost"
		"rate", "speed", "fire", "fire_rate", "fire_rate_boost":
			return "fire_rate_boost"
		"heal", "repair":
			return "heal"
		"missile", "attack", "aoe":
			return "missile"
		"cryo", "slow", "ice":
			return "cryo"
		"firestorm", "fire_screen", "fire_all", "flame":
			return "firestorm"
		"global_freeze", "freeze", "freeze_all":
			return "global_freeze"
		"risk", "risky", "risky_cache":
			return "risky_cache"
		"fortify", "defense", "def":
			return "fortify"
		"gold", "money":
			return "gold"
		"bait", "beacon", "lure", "bait_beacon":
			return "bait_beacon"
		"spikes", "road_spikes", "trap":
			return "road_spikes"
		"magnet", "coin", "coin_magnet":
			return "coin_magnet"
		"warp", "time", "time_warp":
			return "time_warp"
		"swap", "tower_swap", "dispatch":
			return "tower_swap"
		"overload", "debt", "overload_debt":
			return "overload_debt"
		"panic", "panic_button", "emergency":
			return "panic_button"
		"bounty", "mark", "bounty_mark":
			return "bounty_mark"
		"reroll", "reroll_cache", "redraw":
			return "reroll_cache"
		_:
			return raw_id.strip_edges().to_lower()


func _on_card_mouse_entered(panel: Control, index: int) -> void:
	if _drag_card_control != null or index < 0 or index >= _hand_cards.size():
		return
	var card := _hand_cards[index]
	card_detail_title_label.text = _get_card_display_name(card)
	card_detail_title_label.add_theme_color_override("font_color", _get_card_rarity_color(card))
	card_detail_description_label.text = "%s效果 | %s" % [_get_card_rarity_label(card), _get_card_description(card)]
	card_detail_panel.visible = true
	panel.z_index = 70
	var target_position := panel.position + Vector2(0.0, -24.0)
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(panel, "position", target_position, 0.12).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(panel, "scale", Vector2.ONE * 1.08, 0.12)
	tween.tween_property(panel, "rotation_degrees", 0.0, 0.12)


func _on_card_mouse_exited(panel: Control, _index: int) -> void:
	if _drag_card_control == panel:
		return
	card_detail_panel.visible = false
	panel.scale = Vector2.ONE
	_layout_card_controls(false)


func _on_card_gui_input(event: InputEvent, panel: Control, index: int) -> void:
	if _discard_animation_active:
		return

	if index < 0 or index >= _hand_cards.size():
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if _discard_mode:
				_play_discard_animation(panel, index)
				return
			_start_card_drag(panel, index, get_viewport().get_mouse_position())
			get_viewport().set_input_as_handled()
		else:
			if _drag_card_control == panel:
				var drop_position := get_viewport().get_mouse_position()
				_finish_card_drag(drop_position)
				get_viewport().set_input_as_handled()
	elif event is InputEventMouseMotion and _drag_card_control == panel:
		_update_dragged_card_position(get_viewport().get_mouse_position())
		get_viewport().set_input_as_handled()


func _start_card_drag(panel: Control, index: int, mouse_position: Vector2) -> void:
	_drag_card_index = index
	_drag_card_control = panel
	_drag_start_position = panel.position
	_drag_start_rotation = panel.rotation_degrees
	_drag_offset = mouse_position - panel.position
	panel.z_index = 95
	panel.move_to_front()
	panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	panel.rotation_degrees = 0.0
	panel.scale = Vector2.ONE * 1.08
	card_detail_panel.visible = false
	if index >= 0 and index < _hand_cards.size() and _is_area_target_card(_hand_cards[index]):
		var drag_card := _hand_cards[index]
		panel.visible = false
		card_area_preview.radius = _get_card_area_preview_radius(drag_card)
		card_area_preview.accent = _card_color(drag_card)
		card_area_preview.visible = true
	_update_dragged_card_position(mouse_position)


func _update_dragged_card_position(mouse_position: Vector2) -> void:
	if _drag_card_control == null:
		return
	_drag_card_control.position = mouse_position - _drag_offset
	if card_area_preview != null and card_area_preview.visible:
		card_area_preview.position = mouse_position
		card_area_preview.queue_redraw()


func _finish_card_drag(drop_position: Vector2) -> void:
	if _drag_card_control == null or _drag_card_index < 0:
		return

	var global_card_rect := Rect2(_drag_card_control.position, _drag_card_control.size * _drag_card_control.scale)
	if card_sell_zone != null and card_sell_zone.visible and CARD_SELL_ZONE.has_point(drop_position):
		reward_card_sell_requested.emit(_drag_card_index)
		_clear_card_drag_state()
		return

	var release_outside_stack := not CARD_HAND_ZONE.intersects(global_card_rect) or not CARD_HAND_ZONE.has_point(drop_position)
	if release_outside_stack:
		reward_card_play_requested.emit(_drag_card_index, drop_position)
	else:
		_snap_dragged_card_back()


func _snap_dragged_card_back() -> void:
	if _drag_card_control == null:
		return
	var panel := _drag_card_control
	panel.visible = true
	panel.mouse_filter = Control.MOUSE_FILTER_STOP
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(panel, "position", _drag_start_position, 0.16).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(panel, "rotation_degrees", _drag_start_rotation, 0.16)
	tween.tween_property(panel, "scale", Vector2.ONE, 0.12)
	_drag_card_index = -1
	_drag_card_control = null
	card_detail_panel.visible = false
	if card_area_preview != null:
		card_area_preview.visible = false


func reject_dragged_card() -> void:
	_snap_dragged_card_back()


func _clear_card_drag_state() -> void:
	if _drag_card_control != null:
		_drag_card_control.visible = true
		_drag_card_control.mouse_filter = Control.MOUSE_FILTER_STOP
	_drag_card_index = -1
	_drag_card_control = null
	card_detail_panel.visible = false
	if card_area_preview != null:
		card_area_preview.visible = false


func update_pending_card_timeout(seconds_left: float) -> void:
	if card_pending_timer_label != null:
		card_pending_timer_label.text = _format_pending_card_timer_text(seconds_left)


func consume_card_and_refresh(index: int, cards: Array[Dictionary], pending_card: Dictionary = {}, discard_mode: bool = false, effect_name: String = "CardConsumeParticles") -> void:
	if index < 0 or index >= _card_controls.size() or not is_instance_valid(_card_controls[index]):
		update_card_hand(cards, pending_card, discard_mode)
		return

	var panel := _card_controls[index]
	panel.mouse_filter = Control.MOUSE_FILTER_STOP
	_drag_card_index = -1
	_drag_card_control = null
	card_detail_panel.visible = false
	if card_area_preview != null:
		card_area_preview.visible = false
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(panel, "position", panel.position + Vector2(0.0, -92.0), 0.18).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tween.tween_property(panel, "modulate:a", 0.0, 0.16)
	tween.tween_property(panel, "scale", Vector2.ONE * 0.72, 0.18)
	tween.finished.connect(func() -> void:
		update_card_hand(cards, pending_card, discard_mode)
	)


func _play_discard_animation(panel: Control, index: int) -> void:
	if _discard_animation_active:
		return
	_discard_animation_active = true
	for card_control in _card_controls:
		if is_instance_valid(card_control):
			card_control.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(panel, "position", panel.position + Vector2(0.0, 60.0), 0.16).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tween.tween_property(panel, "modulate:a", 0.0, 0.14)
	tween.finished.connect(func() -> void:
		reward_card_discard_requested.emit(index)
	)


func _set_build_panel_expanded(expanded: bool) -> void:
	_build_panel_expanded = expanded
	build_tower_button.text = _get_build_panel_toggle_text(expanded)
	if _build_panel_tween != null and _build_panel_tween.is_valid():
		_build_panel_tween.kill()

	if expanded:
		build_options_scroll.visible = true
		compact_build_options_scroll.visible = false
		build_options_scroll.modulate.a = 0.0
		compact_build_options_scroll.modulate.a = 0.0
	else:
		build_options_scroll.visible = true
		compact_build_options_scroll.visible = true
		build_options_scroll.modulate.a = 1.0
		compact_build_options_scroll.modulate.a = 0.0

	_build_panel_tween = create_tween()
	_build_panel_tween.set_parallel(true)
	_build_panel_tween.tween_property(build_panel, "size:y", 132.0 if expanded else 56.0, 0.18).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	_build_panel_tween.tween_property(build_panel, "position:y", 508.0 if expanded else 584.0, 0.18).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	_build_panel_tween.tween_property(build_options_scroll, "modulate:a", 1.0 if expanded else 0.0, 0.12)
	_build_panel_tween.tween_property(compact_build_options_scroll, "modulate:a", 0.0 if expanded else 1.0, 0.12)
	if not expanded:
		_build_panel_tween.finished.connect(func() -> void:
			if not _build_panel_expanded:
				_apply_build_panel_final_state(false)
		)
	else:
		_build_panel_tween.finished.connect(func() -> void:
			if _build_panel_expanded:
				_apply_build_panel_final_state(true)
		)


func _apply_build_panel_final_state(expanded: bool) -> void:
	build_panel.size.y = 132.0 if expanded else 56.0
	build_panel.position.y = 508.0 if expanded else 584.0
	build_options_scroll.visible = expanded
	build_options_scroll.modulate.a = 1.0 if expanded else 0.0
	compact_build_options_scroll.visible = not expanded
	compact_build_options_scroll.modulate.a = 0.0 if expanded else 1.0


func _create_end_overlay(root: Control) -> void:
	end_overlay = Panel.new()
	end_overlay.position = Vector2.ZERO
	end_overlay.size = Vector2(960.0, 640.0)
	end_overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	end_overlay.visible = false
	end_overlay.z_index = 40
	end_overlay.add_theme_stylebox_override("panel", _panel_style(Color(0.015, 0.02, 0.022, 0.90), Color(0, 0, 0, 0), 0))
	root.add_child(end_overlay)

	end_title_label = Label.new()
	end_title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	end_title_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	end_title_label.position = Vector2(180.0, 218.0)
	end_title_label.size = Vector2(600.0, 72.0)
	end_title_label.pivot_offset = Vector2(300.0, 36.0)
	end_title_label.add_theme_font_size_override("font_size", 52)
	end_overlay.add_child(end_title_label)

	end_subtitle_label = Label.new()
	end_subtitle_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	end_subtitle_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	end_subtitle_label.position = Vector2(200.0, 304.0)
	end_subtitle_label.size = Vector2(560.0, 58.0)
	end_subtitle_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	end_subtitle_label.add_theme_color_override("font_color", TEXT_MUTED)
	end_overlay.add_child(end_subtitle_label)

	end_restart_button = _make_button(_get_end_restart_button_text(), Vector2(282.0, 386.0), Vector2(180.0, 44.0), WARNING)
	end_restart_button.pressed.connect(_on_end_restart_pressed)
	end_overlay.add_child(end_restart_button)

	end_main_menu_button = _make_button(_get_end_main_menu_button_text(), Vector2(498.0, 386.0), Vector2(180.0, 44.0), DANGER)
	end_main_menu_button.pressed.connect(_on_end_main_menu_pressed)
	end_overlay.add_child(end_main_menu_button)


func _create_pause_overlay(root: Control) -> void:
	pause_overlay = Panel.new()
	pause_overlay.position = Vector2.ZERO
	pause_overlay.size = Vector2(960.0, 640.0)
	pause_overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	pause_overlay.visible = false
	pause_overlay.z_index = 98
	pause_overlay.process_mode = Node.PROCESS_MODE_ALWAYS
	pause_overlay.add_theme_stylebox_override("panel", _panel_style(Color(0.010, 0.014, 0.018, 0.82), Color(0.0, 0.0, 0.0, 0.0), 0))
	root.add_child(pause_overlay)

	pause_menu_panel = Panel.new()
	var menu_panel := pause_menu_panel
	menu_panel.position = Vector2(318.0, 156.0)
	menu_panel.size = Vector2(324.0, 328.0)
	menu_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	menu_panel.process_mode = Node.PROCESS_MODE_ALWAYS
	menu_panel.add_theme_stylebox_override("panel", _panel_style(Color(0.020, 0.030, 0.036, 0.98), ACCENT, 0))
	pause_overlay.add_child(menu_panel)

	var title_label := Label.new()
	title_label.text = _get_pause_title_text()
	title_label.position = Vector2(34.0, 34.0)
	title_label.size = Vector2(256.0, 42.0)
	title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	title_label.add_theme_font_size_override("font_size", 30)
	title_label.add_theme_color_override("font_color", TEXT_MAIN)
	menu_panel.add_child(title_label)

	pause_hint_label = Label.new()
	pause_hint_label.text = _get_pause_hint_text()
	pause_hint_label.position = Vector2(34.0, 82.0)
	pause_hint_label.size = Vector2(256.0, 28.0)
	pause_hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	pause_hint_label.add_theme_color_override("font_color", TEXT_MUTED)
	menu_panel.add_child(pause_hint_label)

	pause_resume_button = _make_button(_get_pause_resume_button_text(), Vector2(62.0, 132.0), Vector2(200.0, 44.0), ACCENT)
	pause_resume_button.process_mode = Node.PROCESS_MODE_ALWAYS
	pause_resume_button.pressed.connect(_on_pause_resume_pressed)
	menu_panel.add_child(pause_resume_button)

	pause_restart_button = _make_button(_get_end_restart_button_text(), Vector2(62.0, 192.0), Vector2(200.0, 44.0), WARNING)
	pause_restart_button.process_mode = Node.PROCESS_MODE_ALWAYS
	pause_restart_button.pressed.connect(_on_pause_restart_pressed)
	menu_panel.add_child(pause_restart_button)

	pause_main_menu_button = _make_button(_get_end_main_menu_button_text(), Vector2(62.0, 252.0), Vector2(200.0, 44.0), DANGER)
	pause_main_menu_button.process_mode = Node.PROCESS_MODE_ALWAYS
	pause_main_menu_button.pressed.connect(_on_pause_main_menu_pressed)
	menu_panel.add_child(pause_main_menu_button)


func _create_update_announcement_ui(root: Control) -> void:
	update_announcement_popup = Panel.new()
	update_announcement_popup.position = Vector2.ZERO
	update_announcement_popup.size = Vector2(960.0, 640.0)
	update_announcement_popup.mouse_filter = Control.MOUSE_FILTER_STOP
	update_announcement_popup.visible = false
	update_announcement_popup.modulate.a = 0.0
	update_announcement_popup.z_index = 104
	update_announcement_popup.process_mode = Node.PROCESS_MODE_ALWAYS
	update_announcement_popup.add_theme_stylebox_override("panel", _panel_style(Color(0.010, 0.014, 0.018, 0.78), Color(0.0, 0.0, 0.0, 0.0), 0))
	root.add_child(update_announcement_popup)

	update_announcement_popup_card = Panel.new()
	var popup_card := update_announcement_popup_card
	popup_card.position = Vector2(236.0, 126.0)
	popup_card.size = Vector2(488.0, 388.0)
	popup_card.mouse_filter = Control.MOUSE_FILTER_STOP
	popup_card.add_theme_stylebox_override("panel", _panel_style(Color(0.020, 0.030, 0.036, 0.99), Color(0.58, 0.72, 1.0), 0))
	update_announcement_popup.add_child(popup_card)

	var popup_line := ColorRect.new()
	popup_line.color = Color(0.58, 0.72, 1.0)
	popup_line.position = Vector2(0.0, 0.0)
	popup_line.size = Vector2(488.0, 4.0)
	popup_card.add_child(popup_line)

	update_announcement_popup_title_label = Label.new()
	update_announcement_popup_title_label.position = Vector2(24.0, 24.0)
	update_announcement_popup_title_label.size = Vector2(440.0, 34.0)
	update_announcement_popup_title_label.add_theme_color_override("font_color", TEXT_MAIN)
	update_announcement_popup_title_label.add_theme_font_size_override("font_size", 24)
	popup_card.add_child(update_announcement_popup_title_label)

	update_announcement_popup_meta_label = Label.new()
	update_announcement_popup_meta_label.position = Vector2(24.0, 62.0)
	update_announcement_popup_meta_label.size = Vector2(440.0, 24.0)
	update_announcement_popup_meta_label.add_theme_color_override("font_color", WARNING)
	update_announcement_popup_meta_label.add_theme_font_size_override("font_size", 13)
	popup_card.add_child(update_announcement_popup_meta_label)

	update_announcement_popup_body = RichTextLabel.new()
	update_announcement_popup_body.position = Vector2(24.0, 104.0)
	update_announcement_popup_body.size = Vector2(440.0, 200.0)
	update_announcement_popup_body.fit_content = false
	update_announcement_popup_body.scroll_active = true
	update_announcement_popup_body.add_theme_color_override("default_color", TEXT_MUTED)
	update_announcement_popup_body.add_theme_font_size_override("normal_font_size", 14)
	update_announcement_popup_body.add_theme_stylebox_override("normal", _panel_style(Color(0.012, 0.018, 0.022, 0.92), Color(0.16, 0.25, 0.30), 0))
	popup_card.add_child(update_announcement_popup_body)

	var known_button := _make_button(_get_update_announcement_known_text(), Vector2(178.0, 326.0), Vector2(132.0, 42.0), ACCENT)
	known_button.process_mode = Node.PROCESS_MODE_ALWAYS
	known_button.pressed.connect(_on_update_announcement_popup_close_pressed)
	popup_card.add_child(known_button)

	update_announcement_history_panel = Panel.new()
	update_announcement_history_panel.position = Vector2.ZERO
	update_announcement_history_panel.size = Vector2(960.0, 640.0)
	update_announcement_history_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	update_announcement_history_panel.visible = false
	update_announcement_history_panel.modulate.a = 0.0
	update_announcement_history_panel.z_index = 103
	update_announcement_history_panel.process_mode = Node.PROCESS_MODE_ALWAYS
	update_announcement_history_panel.add_theme_stylebox_override("panel", _panel_style(Color(0.012, 0.018, 0.024, 0.96), Color(0.0, 0.0, 0.0, 0.0), 0))
	root.add_child(update_announcement_history_panel)
	_add_tactical_background(update_announcement_history_panel, WARNING, false)

	var history_title := Label.new()
	history_title.text = _get_update_announcement_history_title_text()
	history_title.position = Vector2(300.0, 42.0)
	history_title.size = Vector2(360.0, 42.0)
	history_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	history_title.add_theme_color_override("font_color", TEXT_MAIN)
	history_title.add_theme_font_size_override("font_size", 30)
	update_announcement_history_panel.add_child(history_title)

	var scroll := ScrollContainer.new()
	scroll.position = Vector2(88.0, 104.0)
	scroll.size = Vector2(784.0, 432.0)
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	scroll.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO
	scroll.mouse_filter = Control.MOUSE_FILTER_STOP
	update_announcement_history_panel.add_child(scroll)

	update_announcement_history_container = VBoxContainer.new()
	update_announcement_history_container.custom_minimum_size = Vector2(760.0, 0.0)
	update_announcement_history_container.add_theme_constant_override("separation", 12)
	scroll.add_child(update_announcement_history_container)

	update_announcement_history_close_button = _make_button(_get_update_announcement_close_text(), Vector2(420.0, 570.0), Vector2(120.0, 42.0), DANGER)
	update_announcement_history_close_button.process_mode = Node.PROCESS_MODE_ALWAYS
	update_announcement_history_close_button.pressed.connect(_on_update_announcement_history_close_pressed)
	update_announcement_history_panel.add_child(update_announcement_history_close_button)


func _create_confirm_dialog(root: Control) -> void:
	confirm_dialog_panel = Panel.new()
	confirm_dialog_panel.position = Vector2.ZERO
	confirm_dialog_panel.size = Vector2(960.0, 640.0)
	confirm_dialog_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	confirm_dialog_panel.visible = false
	confirm_dialog_panel.modulate.a = 0.0
	confirm_dialog_panel.z_index = 108
	confirm_dialog_panel.process_mode = Node.PROCESS_MODE_ALWAYS
	confirm_dialog_panel.add_theme_stylebox_override("panel", _panel_style(Color(0.010, 0.014, 0.018, 0.72), Color(0.0, 0.0, 0.0, 0.0), 0))
	root.add_child(confirm_dialog_panel)

	confirm_dialog_card = Panel.new()
	var dialog_card := confirm_dialog_card
	dialog_card.position = Vector2(260.0, 208.0)
	dialog_card.size = Vector2(440.0, 224.0)
	dialog_card.mouse_filter = Control.MOUSE_FILTER_STOP
	dialog_card.process_mode = Node.PROCESS_MODE_ALWAYS
	dialog_card.add_theme_stylebox_override("panel", _panel_style(Color(0.020, 0.030, 0.036, 0.99), WARNING, 0))
	confirm_dialog_panel.add_child(dialog_card)

	var top_line := ColorRect.new()
	top_line.color = WARNING
	top_line.position = Vector2.ZERO
	top_line.size = Vector2(440.0, 4.0)
	top_line.mouse_filter = Control.MOUSE_FILTER_IGNORE
	dialog_card.add_child(top_line)

	confirm_dialog_title_label = Label.new()
	confirm_dialog_title_label.position = Vector2(24.0, 24.0)
	confirm_dialog_title_label.size = Vector2(392.0, 34.0)
	confirm_dialog_title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	confirm_dialog_title_label.add_theme_color_override("font_color", TEXT_MAIN)
	confirm_dialog_title_label.add_theme_font_size_override("font_size", 24)
	dialog_card.add_child(confirm_dialog_title_label)

	confirm_dialog_message_label = Label.new()
	confirm_dialog_message_label.position = Vector2(34.0, 74.0)
	confirm_dialog_message_label.size = Vector2(372.0, 72.0)
	confirm_dialog_message_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	confirm_dialog_message_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	confirm_dialog_message_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	confirm_dialog_message_label.add_theme_color_override("font_color", TEXT_MUTED)
	dialog_card.add_child(confirm_dialog_message_label)

	confirm_dialog_cancel_button = _make_button(_get_cancel_button_text(), Vector2(88.0, 164.0), Vector2(116.0, 38.0), TEXT_MUTED)
	confirm_dialog_cancel_button.process_mode = Node.PROCESS_MODE_ALWAYS
	confirm_dialog_cancel_button.pressed.connect(_on_confirm_dialog_cancel_pressed)
	dialog_card.add_child(confirm_dialog_cancel_button)

	confirm_dialog_confirm_button = _make_button(_get_confirm_button_text(), Vector2(236.0, 164.0), Vector2(116.0, 38.0), DANGER)
	confirm_dialog_confirm_button.process_mode = Node.PROCESS_MODE_ALWAYS
	confirm_dialog_confirm_button.pressed.connect(_on_confirm_dialog_confirm_pressed)
	dialog_card.add_child(confirm_dialog_confirm_button)


func show_save_overwrite_confirm(level_index: int, level_name: String) -> void:
	_show_confirm_dialog("save_overwrite", _get_save_overwrite_title_text(), _format_save_overwrite_message_text(level_index + 1, level_name), level_index)


func show_exit_to_start_confirm() -> void:
	_show_confirm_dialog("exit_to_start", _get_exit_to_start_title_text(), _get_exit_to_start_message_text(), 0)


func hide_confirm_dialog(animated: bool = true) -> void:
	if confirm_dialog_panel == null:
		return
	if not animated:
		confirm_dialog_panel.visible = false
		confirm_dialog_panel.modulate.a = 0.0
		_confirm_dialog_mode = ""
		return
	if not confirm_dialog_panel.visible:
		return
	var tween := create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(confirm_dialog_panel, "modulate:a", 0.0, 0.10)
	tween.tween_callback(func() -> void:
		confirm_dialog_panel.visible = false
		_confirm_dialog_mode = ""
	)


func is_confirm_dialog_visible() -> bool:
	return confirm_dialog_panel != null and confirm_dialog_panel.visible


func _show_confirm_dialog(mode: String, title: String, message: String, level_index: int) -> void:
	if confirm_dialog_panel == null:
		return
	_confirm_dialog_mode = mode
	_confirm_dialog_level_index = level_index
	confirm_dialog_title_label.text = title
	confirm_dialog_message_label.text = message
	confirm_dialog_panel.visible = true
	confirm_dialog_panel.modulate.a = 0.0
	_play_popup_bounce(confirm_dialog_card, 0.82, 0.22)
	var tween := create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(confirm_dialog_panel, "modulate:a", 1.0, 0.12)


func show_pause_menu() -> void:
	if _pause_overlay_tween != null and _pause_overlay_tween.is_valid():
		_pause_overlay_tween.kill()
	pause_overlay.visible = true
	pause_overlay.modulate.a = 0.0
	_play_popup_bounce(pause_menu_panel, 0.86, 0.20)
	_pause_overlay_tween = create_tween()
	_pause_overlay_tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	_pause_overlay_tween.tween_property(pause_overlay, "modulate:a", 1.0, 0.12)


func hide_pause_menu(immediate: bool = false) -> void:
	if _pause_overlay_tween != null and _pause_overlay_tween.is_valid():
		_pause_overlay_tween.kill()

	if immediate:
		pause_overlay.modulate.a = 0.0
		pause_overlay.visible = false
		return

	if not pause_overlay.visible:
		pause_overlay.modulate.a = 0.0
		return

	_pause_overlay_tween = create_tween()
	_pause_overlay_tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	_pause_overlay_tween.tween_property(pause_overlay, "modulate:a", 0.0, 0.10)
	_pause_overlay_tween.tween_callback(func() -> void:
		pause_overlay.visible = false
	)


func is_pause_menu_visible() -> bool:
	return pause_overlay != null and pause_overlay.visible


func cancel_card_drag() -> void:
	if _drag_card_control != null:
		_snap_dragged_card_back()
	else:
		card_detail_panel.visible = false
		if card_area_preview != null:
			card_area_preview.visible = false


func _create_console(root: Control) -> void:
	console_panel = Panel.new()
	console_panel.position = Vector2(18.0, 332.0)
	console_panel.size = Vector2(924.0, 290.0)
	console_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	console_panel.visible = false
	console_panel.modulate.a = 0.0
	console_panel.z_index = 100
	console_panel.add_theme_stylebox_override("panel", _panel_style(Color(0.012, 0.016, 0.018, 0.97), Color(0.28, 0.42, 0.44), 0))
	root.add_child(console_panel)

	console_title_label = Label.new()
	console_title_label.text = _get_console_title_text()
	console_title_label.position = Vector2(12.0, 8.0)
	console_title_label.size = Vector2(900.0, 24.0)
	console_title_label.add_theme_color_override("font_color", ACCENT)
	console_title_label.add_theme_font_size_override("font_size", 12)
	console_panel.add_child(console_title_label)

	console_output = RichTextLabel.new()
	console_output.position = Vector2(12.0, 38.0)
	console_output.size = Vector2(900.0, 198.0)
	console_output.fit_content = false
	console_output.scroll_following = true
	console_output.add_theme_color_override("default_color", Color(0.80, 0.90, 0.86))
	console_output.add_theme_stylebox_override("normal", _panel_style(Color(0.02, 0.026, 0.028, 0.92), Color(0.12, 0.18, 0.19), 0))
	console_panel.add_child(console_output)

	console_input = LineEdit.new()
	console_input.position = Vector2(12.0, 246.0)
	console_input.size = Vector2(900.0, 32.0)
	console_input.placeholder_text = _get_console_placeholder_text()
	console_input.add_theme_stylebox_override("normal", _panel_style(Color(0.03, 0.038, 0.04, 1.0), Color(0.20, 0.34, 0.34), 0))
	console_input.add_theme_stylebox_override("focus", _panel_style(Color(0.035, 0.046, 0.048, 1.0), ACCENT, 0))
	console_input.add_theme_color_override("font_color", TEXT_MAIN)
	console_input.add_theme_color_override("font_placeholder_color", TEXT_MUTED)
	console_input.gui_input.connect(_on_console_input_gui_input)
	console_input.text_submitted.connect(_on_console_text_submitted)
	console_panel.add_child(console_input)

	write_console_line(_get_console_initial_line_text())


func _on_start_wave_pressed() -> void:
	start_wave_pressed.emit()


func _on_build_menu_toggled() -> void:
	_set_build_panel_expanded(not _build_panel_expanded)


func _on_card_hand_toggle_pressed() -> void:
	if not _card_hand_available:
		return
	_card_hand_expanded = not _card_hand_expanded
	_refresh_card_hand()


func _on_pending_card_reject_pressed() -> void:
	reward_card_reject_requested.emit()


func _on_tower_option_pressed(type_id: String) -> void:
	tower_build_requested.emit(type_id)


func _on_next_level_pressed() -> void:
	next_level_pressed.emit()


func _on_upgrade_pressed() -> void:
	upgrade_pressed.emit()


func _on_sell_pressed() -> void:
	sell_pressed.emit()


func _on_tower_panel_close_pressed() -> void:
	tower_panel_close_pressed.emit()


func _on_pause_resume_pressed() -> void:
	pause_resume_pressed.emit()


func _on_pause_restart_pressed() -> void:
	pause_restart_pressed.emit()


func _on_pause_main_menu_pressed() -> void:
	pause_main_menu_pressed.emit()


func _on_end_restart_pressed() -> void:
	end_restart_pressed.emit()


func _on_end_main_menu_pressed() -> void:
	end_main_menu_pressed.emit()


func _on_start_game_pressed() -> void:
	game_start_pressed.emit()


func _on_continue_game_pressed() -> void:
	continue_game_pressed.emit()


func _on_level_select_pressed() -> void:
	_animate_level_select_open()


func _on_codex_pressed() -> void:
	_animate_codex_open()


func _on_codex_close_pressed() -> void:
	_animate_codex_close()


func _on_codex_entry_pressed(entry: Dictionary) -> void:
	_select_codex_entry(entry)


func _on_update_announcement_pressed() -> void:
	show_update_announcement_history()


func _on_confirm_dialog_cancel_pressed() -> void:
	hide_confirm_dialog()


func _on_confirm_dialog_confirm_pressed() -> void:
	var mode := _confirm_dialog_mode
	var level_index := _confirm_dialog_level_index
	hide_confirm_dialog(false)
	match mode:
		"save_overwrite":
			save_overwrite_confirmed.emit(level_index)
		"exit_to_start":
			exit_to_start_confirmed.emit()


func _on_update_announcement_popup_close_pressed() -> void:
	hide_update_announcement_popup(true)


func _on_update_announcement_history_close_pressed() -> void:
	hide_update_announcement_history()


func _on_level_select_close_pressed() -> void:
	_animate_level_select_close()


func _on_level_button_pressed(level_index: int) -> void:
	level_selected.emit(level_index)


func _animate_level_select_open() -> void:
	_kill_screen_tween()
	start_overlay.visible = true
	level_select_panel.visible = true
	start_overlay.position = Vector2.ZERO
	level_select_panel.position = Vector2(960.0, 0.0)
	level_select_panel.modulate.a = 0.0

	_screen_tween = create_tween()
	_screen_tween.set_parallel(true)
	_screen_tween.tween_property(start_overlay, "position", Vector2(-180.0, 0.0), 0.28).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	_screen_tween.tween_property(start_overlay, "modulate:a", 0.35, 0.22)
	_screen_tween.tween_property(level_select_panel, "position", Vector2.ZERO, 0.32).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	_screen_tween.tween_property(level_select_panel, "modulate:a", 1.0, 0.24)
	_screen_tween.finished.connect(func() -> void:
		_apply_level_select_final_state(true)
	)


func _animate_level_select_close() -> void:
	_kill_screen_tween()
	start_overlay.visible = true
	level_select_panel.visible = true
	start_overlay.position = Vector2(-180.0, 0.0)
	start_overlay.modulate.a = 0.35

	_screen_tween = create_tween()
	_screen_tween.set_parallel(true)
	_screen_tween.tween_property(start_overlay, "position", Vector2.ZERO, 0.30).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	_screen_tween.tween_property(start_overlay, "modulate:a", 1.0, 0.22)
	_screen_tween.tween_property(level_select_panel, "position", Vector2(960.0, 0.0), 0.28).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	_screen_tween.tween_property(level_select_panel, "modulate:a", 0.0, 0.18)
	_screen_tween.finished.connect(func() -> void:
		_apply_level_select_final_state(false)
	)


func _animate_codex_open() -> void:
	_kill_screen_tween()
	start_overlay.visible = true
	codex_panel.visible = true
	start_overlay.position = Vector2.ZERO
	codex_panel.position = Vector2(960.0, 0.0)
	codex_panel.modulate.a = 0.0
	_play_popup_bounce(codex_panel, 0.98, 0.16)

	_screen_tween = create_tween()
	_screen_tween.set_parallel(true)
	_screen_tween.tween_property(start_overlay, "position", Vector2(-180.0, 0.0), 0.28).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	_screen_tween.tween_property(start_overlay, "modulate:a", 0.35, 0.22)
	_screen_tween.tween_property(codex_panel, "position", Vector2.ZERO, 0.32).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	_screen_tween.tween_property(codex_panel, "modulate:a", 1.0, 0.24)
	_screen_tween.finished.connect(func() -> void:
		_apply_codex_final_state(true)
	)


func _animate_codex_close() -> void:
	_kill_screen_tween()
	start_overlay.visible = true
	codex_panel.visible = true
	start_overlay.position = Vector2(-180.0, 0.0)
	start_overlay.modulate.a = 0.35

	_screen_tween = create_tween()
	_screen_tween.set_parallel(true)
	_screen_tween.tween_property(start_overlay, "position", Vector2.ZERO, 0.30).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	_screen_tween.tween_property(start_overlay, "modulate:a", 1.0, 0.22)
	_screen_tween.tween_property(codex_panel, "position", Vector2(960.0, 0.0), 0.28).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	_screen_tween.tween_property(codex_panel, "modulate:a", 0.0, 0.18)
	_screen_tween.finished.connect(func() -> void:
		_apply_codex_final_state(false)
	)


func _apply_codex_final_state(open: bool) -> void:
	start_overlay.visible = true
	start_overlay.position = Vector2(-180.0, 0.0) if open else Vector2.ZERO
	start_overlay.modulate.a = 0.35 if open else 1.0
	codex_panel.visible = open
	codex_panel.position = Vector2.ZERO if open else Vector2(960.0, 0.0)
	codex_panel.modulate.a = 1.0 if open else 0.0


func _animate_to_gameplay() -> void:
	_kill_screen_tween()
	var level_was_visible := level_select_panel.visible
	start_overlay.visible = true

	_screen_tween = create_tween()
	_screen_tween.set_parallel(true)
	_screen_tween.tween_property(start_overlay, "position", Vector2(-220.0, 0.0), 0.26).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	_screen_tween.tween_property(start_overlay, "modulate:a", 0.0, 0.20)
	if level_was_visible:
		_screen_tween.tween_property(level_select_panel, "position", Vector2(-160.0, 0.0), 0.30).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
		_screen_tween.tween_property(level_select_panel, "modulate:a", 0.0, 0.20)
	_screen_tween.finished.connect(func() -> void:
		_apply_gameplay_screen_final_state()
	)


func _apply_start_screen_final_state() -> void:
	start_overlay.visible = true
	start_overlay.position = Vector2.ZERO
	start_overlay.modulate.a = 1.0
	level_select_panel.visible = false
	level_select_panel.position = Vector2(960.0, 0.0)
	level_select_panel.modulate.a = 0.0
	if codex_panel != null:
		codex_panel.visible = false
		codex_panel.position = Vector2(960.0, 0.0)
		codex_panel.modulate.a = 0.0


func _apply_level_select_final_state(open: bool) -> void:
	start_overlay.visible = true
	start_overlay.position = Vector2(-180.0, 0.0) if open else Vector2.ZERO
	start_overlay.modulate.a = 0.35 if open else 1.0
	level_select_panel.visible = open
	level_select_panel.position = Vector2.ZERO if open else Vector2(960.0, 0.0)
	level_select_panel.modulate.a = 1.0 if open else 0.0


func _apply_gameplay_screen_final_state() -> void:
	start_overlay.visible = false
	level_select_panel.visible = false
	if codex_panel != null:
		codex_panel.visible = false
		codex_panel.position = Vector2(960.0, 0.0)
		codex_panel.modulate.a = 0.0
	start_overlay.position = Vector2.ZERO
	level_select_panel.position = Vector2(960.0, 0.0)
	start_overlay.modulate.a = 1.0
	level_select_panel.modulate.a = 0.0


func _kill_screen_tween() -> void:
	if _screen_tween != null and _screen_tween.is_valid():
		_screen_tween.kill()


func _kill_level_banner_tween() -> void:
	if _level_banner_tween != null and _level_banner_tween.is_valid():
		_level_banner_tween.kill()


func _kill_level_clear_tween() -> void:
	if _level_clear_tween != null and _level_clear_tween.is_valid():
		_level_clear_tween.kill()


func _on_console_text_submitted(text: String) -> void:
	var command := text.strip_edges()
	console_input.clear()
	if command.is_empty():
		return

	write_console_line("> " + command)
	console_command_submitted.emit(command)


func _on_console_input_gui_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_TAB:
		_complete_console_input()
		console_input.accept_event()


func _complete_console_input() -> void:
	var raw_text := console_input.text
	var caret := console_input.caret_column
	var before_caret := raw_text.substr(0, caret)
	var after_caret := raw_text.substr(caret)
	var tokens := before_caret.split(" ", false)
	var completing_new_token := before_caret.ends_with(" ")
	var token_index := tokens.size()
	var current_token := ""

	if not completing_new_token and not tokens.is_empty():
		token_index = tokens.size() - 1
		current_token = str(tokens[token_index])

	var candidates := _get_console_completion_candidates(tokens, token_index)
	var matches := _filter_completion_matches(candidates, current_token)

	if matches.is_empty():
		write_console_line(_format_console_completion_missing_text(current_token))
		return

	if matches.size() == 1:
		_apply_console_completion(matches[0], token_index, tokens, completing_new_token, after_caret)
		return

	var common_prefix := _get_common_prefix(matches)
	if common_prefix.length() > current_token.length():
		_apply_console_completion(common_prefix, token_index, tokens, completing_new_token, after_caret, false)
	else:
		write_console_line(_format_console_completion_options_text(matches))


func _get_console_completion_candidates(tokens: PackedStringArray, token_index: int) -> Array[String]:
	if token_index <= 0:
		return CONSOLE_COMMANDS

	if not tokens.is_empty() and str(tokens[0]).to_lower() == "card" and token_index == 1:
		return CONSOLE_CARD_ARGS

	return []


func _filter_completion_matches(candidates: Array[String], prefix: String) -> Array[String]:
	var matches: Array[String] = []
	var lowered_prefix := prefix.to_lower()
	for candidate in candidates:
		if candidate.begins_with(lowered_prefix):
			matches.append(candidate)
	return matches


func _get_common_prefix(values: Array[String]) -> String:
	if values.is_empty():
		return ""

	var prefix := values[0]
	for value in values:
		while not value.begins_with(prefix) and not prefix.is_empty():
			prefix = prefix.substr(0, prefix.length() - 1)
	return prefix


func _apply_console_completion(completion: String, token_index: int, tokens: PackedStringArray, completing_new_token: bool, after_caret: String, append_space: bool = true) -> void:
	var result_tokens: Array[String] = []
	for token in tokens:
		result_tokens.append(str(token))

	if completing_new_token:
		result_tokens.append(completion)
	elif token_index < result_tokens.size():
		result_tokens[token_index] = completion
	else:
		result_tokens.append(completion)

	var suffix := " " if append_space else ""
	console_input.text = " ".join(result_tokens) + suffix + after_caret
	console_input.caret_column = (" ".join(result_tokens) + suffix).length()

