extends Node2D
class_name Main

const ParticleBurst := preload("res://scripts/ParticleBurst.gd")
const ImpactEffect := preload("res://scripts/ImpactEffect.gd")
const MapRendererScene := preload("res://scripts/MapRenderer.gd")
const WorldDecalRendererScene := preload("res://scripts/WorldDecalRenderer.gd")
const WorldOverlayRendererScene := preload("res://scripts/WorldOverlayRenderer.gd")
const UpdateAnnouncementsData := preload("res://scripts/UpdateAnnouncements.gd")
const MAP_HEIGHT: int = 640
const GRID_SIZE: int = 32
const ANNOUNCEMENT_STATE_PATH := "user://announcement_state.cfg"
const LEVEL_START_SAVE_PATH := "user://level_start_save.cfg"
const LEVEL_START_SAVE_SECTION := "level_start"
const BASE_GRID_COLS: int = 30
const BASE_GRID_ROWS: int = 15
const MAX_LEVEL_GRID_COLS: int = 64
const MAX_LEVEL_GRID_ROWS: int = 32
const PLAY_TOP: int = 64
const INITIAL_GOLD: int = 180
const MAX_GOLD: int = 5000
const INITIAL_BASE_HEALTH: int = 20
const MAX_LEVEL_BASE_HEALTH: int = 200
const MAX_SAVED_BASE_HEALTH: int = 500
const DEFAULT_LEVEL_BONUS_GOLD: int = 60
const MAX_LEVEL_BONUS_GOLD: int = 1000
const DEFAULT_LEVEL_REPAIR: int = 6
const MAX_LEVEL_REPAIR: int = 100
const DEFAULT_LEVEL_WAVES: int = 4
const MAX_LEVEL_WAVES: int = 20
const ENEMY_BASE_DAMAGE: int = 1
const INTERMISSION_SECONDS: float = 5.0
const WAVE_CLEAR_BONUS_BASE: int = 14
const WAVE_CLEAR_BONUS_PER_LEVEL: int = 3
const WAVE_CLEAR_BONUS_PER_WAVE: int = 3
const WAVE_CLEAR_BONUS_PER_EXTRA_ROUTE: int = 3
const CARD_HAND_LIMIT: int = 5
const PENDING_CARD_TIMEOUT: float = 12.0
const CARD_RARITY_WHITE := "white"
const CARD_RARITY_BLUE := "blue"
const CARD_RARITY_PURPLE := "purple"
const CARD_RARITY_GOLD := "gold"
const CARD_RARITY_RED := "red"
const CARD_RARITIES: Array[String] = [CARD_RARITY_WHITE, CARD_RARITY_BLUE, CARD_RARITY_PURPLE, CARD_RARITY_GOLD, CARD_RARITY_RED]
const CARD_RARITY_WHITE_POWER: float = 1.00
const CARD_RARITY_BLUE_POWER: float = 1.15
const CARD_RARITY_PURPLE_POWER: float = 1.35
const CARD_RARITY_GOLD_POWER: float = 1.60
const CARD_RARITY_RED_POWER: float = 1.90
const REWARD_CARD_INT_FIELDS: Array[String] = ["damage", "amount", "heal", "panic_heal", "max_hp", "jackpot_gold", "fallback_gold", "bonus_gold", "charges"]
const REWARD_CARD_FLOAT_FIELDS: Array[String] = ["duration", "radius", "strength"]
const REWARD_CARD_MULTIPLIER_FIELDS: Array[String] = ["multiplier", "damage_multiplier", "fire_rate_multiplier"]
const REWARD_CARD_RATIO_FIELDS: Array[String] = ["bonus_ratio", "jackpot_chance"]
const REWARD_CARD_SLOW_FIELDS: Array[String] = ["slow_multiplier"]
const DEFAULT_TOWER_DISPLAY_NAME := "防御塔"
const DEFAULT_CARD_DISPLAY_NAME := "卡牌"
const DEFAULT_REWARD_CARD_ID := "tower_boost"
const DEFAULT_ENEMY_TYPE_DISPLAY_NAME := "敌人"
const DEFAULT_LEVEL_DISPLAY_NAME := "未命名关卡"
const CURRENT_LEVEL_MESSAGE_TEMPLATE := "第%d关：%s"
const LOCKED_LEVEL_MESSAGE_TEMPLATE := "第%d关尚未解锁，请先通关前置关卡。"
const WAVE_STARTED_MESSAGE_TEMPLATE := "第%d关第%d波已开始。"
const WAVE_START_BLOCKED_MESSAGE_TEXT := "暂时不能开始新一波。"
const TOWER_LOCKED_MESSAGE_TEMPLATE := "%s 将在第%d关解锁。"
const PAUSE_MESSAGE_TEXT := "游戏已暂停。"
const RESUME_MESSAGE_TEXT := "游戏继续。"
const LEVEL_RESTART_MESSAGE_TEMPLATE := "第%d关已重新开始。"
const START_SCREEN_MESSAGE_TEXT := "建造防御塔，然后开始第一波进攻。"
const CONTINUE_SAVE_MISSING_MESSAGE_TEXT := "没有可继续的关卡存档。"
const CONTINUE_SAVE_LOADED_MESSAGE_TEMPLATE := "继续第%d关：%s。"
const WAVE_SPAWN_FINISHED_MESSAGE_TEMPLATE := "第%d波敌人已出动，清空敌人可获得卡牌。"
const FINAL_WAVE_SPAWN_FINISHED_MESSAGE_TEXT := "最终波已出动，清空所有敌人。"
const GOLD_REWARD_MESSAGE_TEMPLATE := "金币+%d。"
const BASE_DAMAGE_MESSAGE_TEMPLATE := "基地受到%d点伤害。"
const ELITE_STUN_MESSAGE_TEMPLATE := "精英怪爆炸，眩晕%d座炮塔。"
const LEVEL_COMPLETE_MESSAGE_TEMPLATE := "第%d关已完成，可以进入下一关。"
const INTERMISSION_MESSAGE_TEMPLATE := "第%d波已清空，下一波将在%.1f秒后开始。"
const AUTO_WAVE_STARTED_MESSAGE_TEMPLATE := "第%d关第%d波自动开始。"
const AUTO_WAVE_BLOCKED_MESSAGE_TEXT := "自动波次暂时无法开始。"
const REWARD_CARD_CONSOLE_TEMPLATE := "获得奖励卡牌：%s"
const REWARD_CARD_STORED_MESSAGE_TEMPLATE := "已存入奖励卡牌：%s。"
const REWARD_CARD_HAND_FULL_MESSAGE_TEMPLATE := "手牌已满，请丢弃一张来保留%s。"
const PENDING_CARD_BLOCKS_PLAY_MESSAGE_TEXT := "有新卡待处理时，不能先使用旧卡腾出空位。"
const REWARD_CARD_REPLACED_MESSAGE_TEMPLATE := "已丢弃%s，并保留%s。"
const PENDING_CARD_REJECTED_MESSAGE_TEXT := "已放弃新卡牌。"
const PENDING_CARD_TIMEOUT_MESSAGE_TEXT := "新卡牌超时，已自动丢弃。"
const PENDING_CARD_BLOCKS_SELL_MESSAGE_TEXT := "有新卡待处理时，不能先出售旧卡腾出空位。"
const REWARD_CARD_DEFAULT_SELL_VALUE: int = 28
const REWARD_CARD_MAX_SELL_VALUE: int = 120
const REWARD_CARD_SOLD_MESSAGE_TEMPLATE := "已出售卡牌，金币+%d。"
const TOWER_BOOST_DEFAULT_MULTIPLIER: float = 1.25
const TOWER_BOOST_MAX_MULTIPLIER: float = 3.0
const TOWER_BOOST_DEFAULT_DURATION: float = 10.0
const TOWER_BOOST_MAX_DURATION: float = 60.0
const RANGE_BOOST_DEFAULT_MULTIPLIER: float = 1.18
const RANGE_BOOST_MAX_MULTIPLIER: float = 3.0
const RANGE_BOOST_DEFAULT_DURATION: float = 12.0
const RANGE_BOOST_MAX_DURATION: float = 60.0
const FIRE_RATE_BOOST_DEFAULT_MULTIPLIER: float = 1.35
const FIRE_RATE_BOOST_MAX_MULTIPLIER: float = 3.0
const FIRE_RATE_BOOST_DEFAULT_DURATION: float = 8.0
const FIRE_RATE_BOOST_MAX_DURATION: float = 60.0
const DAMAGE_BOOST_CARD_MESSAGE_TEMPLATE := "卡牌生效：%d座塔在%.0f秒内伤害提高。"
const RANGE_BOOST_CARD_MESSAGE_TEMPLATE := "卡牌生效：%d座塔在%.0f秒内射程提高。"
const FIRE_RATE_BOOST_CARD_MESSAGE_TEMPLATE := "卡牌生效：%d座塔在%.0f秒内攻速提高。"
const HEAL_CARD_DEFAULT_AMOUNT: int = 6
const HEAL_CARD_MAX_AMOUNT: int = 40
const HEAL_CARD_MESSAGE_TEMPLATE := "卡牌生效：基地修复%d点生命。"
const MISSILE_CARD_DEFAULT_DAMAGE: int = 270
const MISSILE_CARD_MAX_DAMAGE: int = 1200
const MISSILE_CARD_DEFAULT_RADIUS: float = 92.0
const MISSILE_CARD_MAX_RADIUS: float = 320.0
const MISSILE_CARD_EMPTY_MESSAGE_TEXT := "导弹目标区域内没有敌人。"
const MISSILE_CARD_HIT_MESSAGE_TEMPLATE := "卡牌生效：导弹命中%d个敌人。"
const CRYO_CARD_DEFAULT_DAMAGE: int = 25
const CRYO_CARD_MAX_DAMAGE: int = 600
const CRYO_CARD_DEFAULT_RADIUS: float = 104.0
const CRYO_CARD_MAX_RADIUS: float = 320.0
const CRYO_CARD_DEFAULT_SLOW_MULTIPLIER: float = 0.45
const CRYO_CARD_DEFAULT_DURATION: float = 6.0
const CRYO_CARD_MAX_DURATION: float = 60.0
const CRYO_CARD_EMPTY_MESSAGE_TEXT := "冷冻地雷目标区域内没有敌人。"
const CRYO_CARD_HIT_MESSAGE_TEMPLATE := "卡牌生效：冷冻地雷影响%d个敌人。"
const FIRESTORM_CARD_DEFAULT_DAMAGE: int = 135
const FIRESTORM_CARD_MAX_DAMAGE: int = 1200
const FIRESTORM_CARD_DEFAULT_RADIUS: float = 360.0
const FIRESTORM_CARD_EMPTY_MESSAGE_TEXT := "全屏火焰没有可攻击的敌人。"
const FIRESTORM_CARD_HIT_MESSAGE_TEMPLATE := "卡牌生效：全屏火焰灼烧%d个敌人。"
const GLOBAL_FREEZE_CARD_DEFAULT_DAMAGE: int = 10
const GLOBAL_FREEZE_CARD_MAX_DAMAGE: int = 600
const GLOBAL_FREEZE_CARD_DEFAULT_RADIUS: float = 360.0
const GLOBAL_FREEZE_CARD_DEFAULT_SLOW_MULTIPLIER: float = 0.20
const GLOBAL_FREEZE_CARD_DEFAULT_DURATION: float = 4.0
const GLOBAL_FREEZE_CARD_MAX_DURATION: float = 60.0
const GLOBAL_FREEZE_CARD_EMPTY_MESSAGE_TEXT := "冻结全屏没有可影响的敌人。"
const GLOBAL_FREEZE_CARD_HIT_MESSAGE_TEMPLATE := "卡牌生效：冻结全屏影响%d个敌人。"
const GOLD_CARD_DEFAULT_AMOUNT: int = 85
const GOLD_CARD_MAX_AMOUNT: int = 1000
const GOLD_CARD_MESSAGE_TEMPLATE := "卡牌生效：金币+%d。"
const RISKY_CACHE_DEFAULT_JACKPOT_CHANCE: float = 0.25
const RISKY_CACHE_MAX_JACKPOT_CHANCE: float = 0.95
const RISKY_CACHE_DEFAULT_JACKPOT_GOLD: int = 180
const RISKY_CACHE_DEFAULT_FALLBACK_GOLD: int = 35
const RISKY_CACHE_MAX_GOLD_REWARD: int = 1000
const RISKY_CACHE_DEFAULT_FALLBACK_DAMAGE: int = 1
const RISKY_CACHE_MAX_FALLBACK_DAMAGE: int = 10
const RISKY_CACHE_SUCCESS_MESSAGE_TEMPLATE := "不稳定补给成功：金币+%d。"
const RISKY_CACHE_FAILURE_MESSAGE_TEMPLATE := "不稳定补给失稳：金币+%d，基地受%d点伤害。"
const FORTIFY_DEFAULT_MAX_HP_GAIN: int = 2
const FORTIFY_MAX_HP_GAIN_LIMIT: int = 20
const FORTIFY_DEFAULT_HEAL: int = 4
const FORTIFY_HEAL_LIMIT: int = 40
const FORTIFY_CARD_MESSAGE_TEMPLATE := "卡牌生效：基地生命上限+%d，并修复%d点。"
const BAIT_BEACON_CARD_EMPTY_MESSAGE_TEXT := "诱饵信标附近没有敌人。"
const BAIT_BEACON_CARD_HIT_MESSAGE_TEMPLATE := "卡牌生效：诱饵信标牵引%d个敌人。"
const BAIT_BEACON_DEFAULT_RADIUS: float = 150.0
const BAIT_BEACON_MAX_RADIUS: float = 320.0
const BAIT_BEACON_DEFAULT_DURATION: float = 3.2
const BAIT_BEACON_MAX_DURATION: float = 60.0
const BAIT_BEACON_DEFAULT_STRENGTH: float = 0.72
const BAIT_BEACON_MAX_STRENGTH: float = 2.0
const ROAD_SPIKES_CARD_MESSAGE_TEXT := "卡牌生效：尖刺路障已部署。"
const ROAD_SPIKE_DEFAULT_RADIUS: float = 52.0
const ROAD_SPIKE_MAX_RADIUS: float = 220.0
const ROAD_SPIKE_DEFAULT_DAMAGE: int = 38
const ROAD_SPIKE_MAX_DAMAGE: int = 400
const ROAD_SPIKE_DEFAULT_CHARGES: int = 4
const ROAD_SPIKE_MAX_CHARGES: int = 20
const ROAD_SPIKE_DEFAULT_DURATION: float = 10.0
const ROAD_SPIKE_MAX_DURATION: float = 60.0
const ROAD_SPIKE_DEFAULT_SLOW_MULTIPLIER: float = 0.55
const COIN_MAGNET_DEFAULT_DURATION: float = 12.0
const COIN_MAGNET_MAX_DURATION: float = 60.0
const COIN_MAGNET_DEFAULT_BONUS_RATIO: float = 0.45
const COIN_MAGNET_MAX_BONUS_RATIO: float = 2.0
const COIN_MAGNET_CARD_MESSAGE_TEMPLATE := "卡牌生效：%.0f秒内击杀金币提高%d%%。"
const TIME_WARP_DEFAULT_RADIUS: float = 118.0
const TIME_WARP_MAX_RADIUS: float = 320.0
const TIME_WARP_DEFAULT_SLOW_MULTIPLIER: float = 0.35
const TIME_WARP_DEFAULT_HASTE_MULTIPLIER: float = 1.35
const TIME_WARP_MAX_HASTE_MULTIPLIER: float = 3.0
const TIME_WARP_DEFAULT_DURATION: float = 4.5
const TIME_WARP_MAX_DURATION: float = 60.0
const TIME_WARP_CARD_EMPTY_MESSAGE_TEXT := "时间裂隙没有影响到敌人。"
const TIME_WARP_CARD_HIT_MESSAGE_TEMPLATE := "卡牌生效：时间裂隙扭曲%d个敌人。"
const TOWER_SWAP_CARD_EMPTY_MESSAGE_TEXT := "塔位调度需要释放在防御塔附近。"
const TOWER_SWAP_CARD_HIT_MESSAGE_TEXT := "卡牌生效：目标防御塔进入调度状态。"
const TOWER_SWAP_DEFAULT_RADIUS: float = 72.0
const TOWER_SWAP_MAX_RADIUS: float = 220.0
const TOWER_SWAP_DEFAULT_DAMAGE_MULTIPLIER: float = 1.18
const TOWER_SWAP_DEFAULT_FIRE_RATE_MULTIPLIER: float = 1.45
const TOWER_SWAP_MAX_MULTIPLIER: float = 3.0
const TOWER_SWAP_DEFAULT_DURATION: float = 7.0
const TOWER_SWAP_MAX_DURATION: float = 60.0
const OVERLOAD_DEBT_DEFAULT_DAMAGE_MULTIPLIER: float = 1.50
const OVERLOAD_DEBT_DEFAULT_FIRE_RATE_MULTIPLIER: float = 1.55
const OVERLOAD_DEBT_MAX_MULTIPLIER: float = 3.0
const OVERLOAD_DEBT_DEFAULT_DURATION: float = 5.0
const OVERLOAD_DEBT_MAX_DURATION: float = 60.0
const OVERLOAD_DEBT_DEFAULT_DEBT_MULTIPLIER: float = 0.72
const OVERLOAD_DEBT_DEFAULT_DEBT_DURATION: float = 4.0
const OVERLOAD_DEBT_CARD_MESSAGE_TEMPLATE := "卡牌生效：全塔透支超频%.0f秒，之后会短暂降速。"
const PANIC_BUTTON_DEFAULT_LOW_HEALTH_RATIO: float = 0.35
const PANIC_BUTTON_DEFAULT_HEAL: int = 3
const PANIC_BUTTON_MAX_HEAL: int = 40
const PANIC_BUTTON_DEFAULT_PANIC_HEAL: int = 8
const PANIC_BUTTON_MAX_PANIC_HEAL: int = 40
const PANIC_BUTTON_DEFAULT_SLOW_MULTIPLIER: float = 0.18
const PANIC_BUTTON_DEFAULT_DURATION: float = 2.2
const PANIC_BUTTON_MAX_DURATION: float = 60.0
const PANIC_BUTTON_CARD_MESSAGE_TEXT := "紧急按钮启动：基地获得战场缓冲。"
const BOUNTY_MARK_DEFAULT_RADIUS: float = 130.0
const BOUNTY_MARK_MAX_RADIUS: float = 320.0
const BOUNTY_MARK_DEFAULT_BONUS_GOLD: int = 120
const BOUNTY_MARK_MAX_BONUS_GOLD: int = 1000
const BOUNTY_MARK_CARD_EMPTY_MESSAGE_TEXT := "悬赏标记范围内没有敌人。"
const BOUNTY_MARK_CARD_HIT_MESSAGE_TEMPLATE := "卡牌生效：已悬赏%s，击杀额外+%d金币。"
const REROLL_CACHE_CARD_EMPTY_MESSAGE_TEXT := "战术改签需要至少一张旧手牌。"
const REROLL_CACHE_CARD_MESSAGE_TEXT := "卡牌生效：已改签最左侧手牌。"
const UNKNOWN_REWARD_CARD_MESSAGE_TEXT := "未知卡牌。"
const VICTORY_MESSAGE_TEXT := "胜利！所有关卡已清空。"
const VICTORY_TITLE_TEXT := "胜利"
const VICTORY_SUBTITLE_TEXT := "所有关卡已完成，基地仍然存活。"
const DEFEAT_MESSAGE_TEXT := "失败，基地已被摧毁。"
const DEFEAT_TITLE_TEXT := "失败"
const DEFEAT_SUBTITLE_TEXT := "基地已经失守，可以使用控制台或重新开始继续测试。"
const CONSOLE_GAME_STARTED_RESPONSE_TEXT := "游戏已开始。"
const CONSOLE_GAME_ALREADY_STARTED_RESPONSE_TEXT := "游戏已经开始。"
const CONSOLE_WAVE_REQUESTED_RESPONSE_TEXT := "已请求开始波次。"
const CONSOLE_LEVEL_LOADED_RESPONSE_TEMPLATE := "已载入第%d关。"
const CONSOLE_NEXT_LEVEL_REQUESTED_RESPONSE_TEXT := "已请求进入下一关。"
const CONSOLE_GOLD_ADDED_MESSAGE_TEMPLATE := "调试：增加%d金币。"
const CONSOLE_GOLD_ADDED_RESPONSE_TEMPLATE := "金币增加%d，当前%d。"
const CONSOLE_GOLD_SET_MESSAGE_TEMPLATE := "调试：金币设置为%d。"
const CONSOLE_GOLD_SET_RESPONSE_TEMPLATE := "金币已设置为%d。"
const CONSOLE_BASE_HEALTH_RESPONSE_TEMPLATE := "基地生命：%d/%d"
const CONSOLE_BASE_HEALED_MESSAGE_TEMPLATE := "调试：基地修复%d点。"
const CONSOLE_BASE_HEALTH_SET_MESSAGE_TEXT := "调试：基地生命已设置。"
const CONSOLE_ENEMY_SPAWNED_MESSAGE_TEMPLATE := "调试：生成%d个%s。"
const CONSOLE_ENEMY_SPAWNED_RESPONSE_TEMPLATE := "已生成%d个%s。"
const CONSOLE_ENEMIES_CLEARED_MESSAGE_TEXT := "调试：敌人已清空。"
const CONSOLE_CLEAR_RESPONSE_TEXT := "敌人和子弹已清空。"
const CONSOLE_REWARD_CARD_CREATED_RESPONSE_TEMPLATE := "已创建奖励卡牌：%s"
const CONSOLE_NO_STORED_CARD_RESPONSE_TEXT := "没有已存储的卡牌。"
const CONSOLE_CARD_USED_RESPONSE_TEXT := "卡牌已使用。"
const CONSOLE_CARD_UNAVAILABLE_RESPONSE_TEXT := "卡牌暂时无法使用。"
const CONSOLE_VICTORY_TRIGGERED_RESPONSE_TEXT := "胜利动画已触发。"
const CONSOLE_DEFEAT_TRIGGERED_RESPONSE_TEXT := "失败动画已触发。"
const CONSOLE_RELOAD_RESPONSE_TEXT := "正在重载场景。"
const CONSOLE_STATUS_RESPONSE_TEMPLATE := "当前状态：第%d/%d关，金币%d，基地生命%d/%d，波次%d/%d，敌人%d个，自动波次%s，间隔%.1f秒，游戏结束%s。"
const CONSOLE_UNKNOWN_COMMAND_RESPONSE_TEMPLATE := "未知命令：%s。输入 help 查看可用命令。"
const CONSOLE_BASE_DAMAGED_MESSAGE_TEMPLATE := "调试：基地受到%d点伤害。"
const CONSOLE_TRUE_TEXT := "是"
const CONSOLE_FALSE_TEXT := "否"
const CAMERA_MAX_ZOOM: float = 2.25
const CAMERA_ZOOM_STEP: float = 1.12
const MAX_PARTICLE_NODES: int = 180
const WORLD_LAYER_MAP: int = -100
const WORLD_LAYER_DECALS: int = -55
const WORLD_LAYER_TOWERS: int = 10
const WORLD_LAYER_ENEMIES: int = 24
const WORLD_LAYER_PROJECTILES: int = 42
const WORLD_LAYER_IMPACTS: int = 64
const WORLD_LAYER_PARTICLES: int = 76
const WORLD_LAYER_OVERLAY: int = 96
const WORLD_LAYER_BUILD_PREVIEW: int = 98
const DEFAULT_ENEMY_TYPE_ID := "grunt"
const ELITE_ENEMY_TYPE_ID := "elite"
const THEME_COLOR_KEYS: Array[String] = [
	"field_a",
	"field_b",
	"grid",
	"road",
	"road_dark",
	"road_light",
	"road_edge",
	"bg",
	"water",
	"base_body",
	"base_plate",
	"base_glow",
]

var path_points: Array[Vector2] = []
var spawn_paths: Array[Array] = []
var spawn_path_lengths: Array[float] = []
var road_cells: Dictionary = {}
var tower_configs: Dictionary = {}
var enemy_type_configs: Dictionary = {}
var level_configs: Array[Dictionary] = []
var current_level_index: int = 0
var highest_unlocked_level_index: int = 0
var is_level_complete: bool = false
var map_cols: int = BASE_GRID_COLS
var map_rows: int = BASE_GRID_ROWS
var scene_theme: Dictionary = {}

var gold: int = INITIAL_GOLD
var max_base_health: int = INITIAL_BASE_HEALTH
var base_health: int = INITIAL_BASE_HEALTH
var is_game_over: bool = false
var has_game_started: bool = false
var is_game_paused: bool = false

var tower_layer: Node2D
var enemy_layer: Node2D
var projectile_layer: Node2D
var impact_layer: Node2D
var particle_layer: Node2D
var map_layer: Node2D
var world_decal_layer: Node2D
var world_overlay_layer: Node2D
var build_manager: BuildManager
var wave_manager: WaveManager
var ui: GameUI
var camera: Camera2D

var _enemy_cache: Array[Enemy] = []
var _tower_cache: Array[Tower] = []
var _projectile_cache: Array[Projectile] = []
var _world_particle_count: int = 0
var _world_particle_ids: Dictionary = {}
var _message: String = _get_start_screen_message_text()
var _base_hit_flash: float = 0.0
var _auto_waves_enabled: bool = false
var _intermission_active: bool = false
var _intermission_timer: float = 0.0
var _card_hand: Array[Dictionary] = []
var _pending_reward_card: Dictionary = {}
var _pending_reward_timeout: float = 0.0
var _missile_effect_position: Vector2 = Vector2.ZERO
var _missile_effect_radius: float = 0.0
var _missile_effect_timer: float = 0.0
var _world_effect_color: Color = Color(1.0, 0.46, 0.14)
var _world_effect_accent_color: Color = Color(1.0, 0.88, 0.35)
var _road_spike_traps: Array[Dictionary] = []
var _coin_magnet_timer: float = 0.0
var _coin_magnet_bonus_ratio: float = 0.0
var _overload_debt_timer: float = 0.0
var _overload_debt_multiplier: float = 1.0
var _overload_debt_duration: float = 0.0
var _bounty_enemy_id: int = 0
var _bounty_bonus_gold: int = 0
var _is_camera_dragging: bool = false
var _camera_drag_button: MouseButton = MOUSE_BUTTON_NONE
var _last_camera_drag_mouse: Vector2 = Vector2.ZERO
var _muzzle_particle_config: Dictionary = {
	"name": "MuzzleParticles",
	"amount": 8,
	"lifetime": 0.24,
	"velocity_min": 20.0,
	"velocity_max": 76.0,
	"scale_min": 0.8,
	"scale_max": 1.8,
	"gravity": Vector2.ZERO,
	"direction": Vector2.UP,
	"spread": 62.0,
	"color": Color(1.0, 0.83, 0.2),
}


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = false
	_init_configs()
	_create_layers()
	_create_camera()
	_create_managers()
	_create_ui()
	_load_level(0, false)
	_refresh_ui()
	_queue_world_redraw()


func _process(delta: float) -> void:
	if is_game_paused:
		return

	_update_camera_movement(delta)

	if _base_hit_flash > 0.0:
		_base_hit_flash = maxf(_base_hit_flash - delta, 0.0)
		_queue_world_redraw()

	if _missile_effect_timer > 0.0:
		_missile_effect_timer = maxf(_missile_effect_timer - delta, 0.0)
		_queue_world_redraw()

	_update_reward_card_timers(delta)
	_update_road_spike_traps(delta)

	if not _pending_reward_card.is_empty():
		_pending_reward_timeout = maxf(_pending_reward_timeout - delta, 0.0)
		if ui != null:
			ui.update_pending_card_timeout(_pending_reward_timeout)
		if _pending_reward_timeout <= 0.0:
			_reject_pending_reward_card(_get_pending_card_timeout_message_text())

	if _intermission_active:
		_intermission_timer = maxf(_intermission_timer - delta, 0.0)
		_message = _format_intermission_message_text(wave_manager.current_wave, _intermission_timer)
		if _intermission_timer <= 0.0:
			_intermission_active = false
			_start_next_auto_wave()
		_refresh_ui()

	_refresh_selected_tower_panel()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_F1 or event.keycode == KEY_QUOTELEFT:
			ui.toggle_console()
			get_viewport().set_input_as_handled()
			return

		if ui.is_console_visible():
			if event.keycode == KEY_ESCAPE:
				ui.set_console_visible(false)
				get_viewport().set_input_as_handled()
			return

	if ui.is_console_visible():
		get_viewport().set_input_as_handled()
		return

	if not has_game_started:
		return

	if event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_ESCAPE:
		if is_game_paused:
			_resume_game()
		elif not is_game_over:
			_pause_game()
		get_viewport().set_input_as_handled()
		return

	if is_game_paused:
		get_viewport().set_input_as_handled()
		return

	if event is InputEventMouseButton and event.pressed and event.ctrl_pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_adjust_camera_zoom(1, event.position)
			get_viewport().set_input_as_handled()
			return
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_adjust_camera_zoom(-1, event.position)
			get_viewport().set_input_as_handled()
			return

	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var world_position := screen_to_world(event.position)
		if build_manager.is_building:
			build_manager.try_build_at(world_position)
		else:
			build_manager.try_select_at(world_position)
		_refresh_ui()
		get_viewport().set_input_as_handled()
		return

	if event is InputEventMouseButton and (event.button_index == MOUSE_BUTTON_RIGHT or event.button_index == MOUSE_BUTTON_MIDDLE):
		if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT and build_manager.is_building:
			build_manager.cancel_build_mode()
			_refresh_ui()
			get_viewport().set_input_as_handled()
			return
		_is_camera_dragging = event.pressed
		_camera_drag_button = event.button_index if event.pressed else MOUSE_BUTTON_NONE
		_last_camera_drag_mouse = event.position
		get_viewport().set_input_as_handled()
		return

	if event is InputEventMouseMotion and _is_camera_dragging:
		var mouse_event := event as InputEventMouseMotion
		camera.position -= mouse_event.relative / camera.zoom.x
		_clamp_camera_to_map()
		get_viewport().set_input_as_handled()


func add_projectile(projectile: Projectile) -> void:
	projectile.set_game(self)
	projectile_layer.add_child(projectile)
	_register_projectile(projectile)


func get_active_projectiles() -> Array[Projectile]:
	var projectiles: Array[Projectile] = _projectile_cache.duplicate()
	return projectiles


func _queue_world_redraw() -> void:
	if world_decal_layer != null:
		world_decal_layer.queue_redraw()
	if world_overlay_layer != null:
		world_overlay_layer.queue_redraw()


func _show_world_area_effect(center: Vector2, radius: float, color: Color, accent_color: Color, duration: float = 0.45) -> void:
	_missile_effect_position = center
	_missile_effect_radius = radius
	_world_effect_color = color
	_world_effect_accent_color = accent_color
	_missile_effect_timer = duration
	_queue_world_redraw()


func _register_projectile(projectile: Projectile) -> void:
	if projectile == null or not is_instance_valid(projectile) or _projectile_cache.has(projectile):
		return
	_projectile_cache.append(projectile)
	projectile.tree_exiting.connect(_on_registered_projectile_exiting.bind(projectile), CONNECT_ONE_SHOT)


func _on_registered_projectile_exiting(projectile: Projectile) -> void:
	_projectile_cache.erase(projectile)


func spawn_particle_burst(world_position: Vector2, config: Dictionary = {}) -> CPUParticles2D:
	if particle_layer == null:
		return null
	if _world_particle_count >= MAX_PARTICLE_NODES and not bool(config.get("important", false)):
		return null
	var particle := ParticleBurst.spawn(particle_layer, world_position, config)
	if particle != null:
		_register_world_particle(particle)
	return particle


func get_world_particle_count() -> int:
	return _world_particle_count


func _register_world_particle(particle: CPUParticles2D) -> void:
	var instance_id := particle.get_instance_id()
	if _world_particle_ids.has(instance_id):
		return
	_world_particle_ids[instance_id] = true
	_world_particle_count = _world_particle_ids.size()
	particle.tree_exiting.connect(_on_world_particle_exiting.bind(instance_id), CONNECT_ONE_SHOT)


func _on_world_particle_exiting(instance_id: int) -> void:
	if not _world_particle_ids.has(instance_id):
		return
	_world_particle_ids.erase(instance_id)
	_world_particle_count = _world_particle_ids.size()


func spawn_muzzle_particles(world_position: Vector2, direction: Vector2, color: Color) -> void:
	_muzzle_particle_config["direction"] = direction
	_muzzle_particle_config["color"] = color.lightened(0.15)
	spawn_particle_burst(world_position, _muzzle_particle_config)


func spawn_area_particles(world_position: Vector2, radius: float, color: Color, amount: int = 34, effect_name: String = "AreaParticles") -> void:
	spawn_particle_burst(world_position, _get_area_particle_config(effect_name, radius, color, amount))


func _get_area_particle_config(effect_name: String, radius: float, color: Color, amount: int) -> Dictionary:
	var config: Dictionary = {
		"name": effect_name,
		"amount": amount,
		"lifetime": 0.58,
		"emission_radius": radius * 0.34,
		"direction": Vector2.UP,
		"velocity_min": radius * 0.28,
		"velocity_max": radius * 1.12,
		"scale_min": 1.2,
		"scale_max": 3.2,
		"gravity": Vector2.ZERO,
		"spread": 180.0,
		"color": color,
	}

	match effect_name:
		"EliteStunParticles":
			config.merge({
				"lifetime": 0.82,
				"emission_radius": radius * 0.50,
				"velocity_min": radius * 0.10,
				"velocity_max": radius * 0.68,
				"gravity": Vector2(0.0, -42.0),
				"scale_min": 1.4,
				"scale_max": 4.2,
			}, true)
		"TowerBoostParticles":
			config.merge({
				"lifetime": 0.76,
				"emission_radius": radius * 0.20,
				"direction": Vector2.UP,
				"spread": 76.0,
				"velocity_min": radius * 0.18,
				"velocity_max": radius * 0.84,
				"gravity": Vector2(0.0, -74.0),
			}, true)
		"RangeBoostParticles":
			config.merge({
				"lifetime": 0.92,
				"emission_radius": radius * 0.52,
				"velocity_min": radius * 0.08,
				"velocity_max": radius * 0.34,
				"scale_min": 0.9,
				"scale_max": 2.4,
			}, true)
		"FireRateBoostParticles":
			config.merge({
				"lifetime": 0.42,
				"emission_radius": radius * 0.18,
				"spread": 46.0,
				"velocity_min": radius * 0.72,
				"velocity_max": radius * 1.92,
				"scale_min": 0.8,
				"scale_max": 2.0,
			}, true)
		"HealParticles", "FortifyParticles":
			config.merge({
				"lifetime": 0.90,
				"emission_radius": radius * 0.28,
				"direction": Vector2.UP,
				"spread": 68.0,
				"velocity_min": radius * 0.12,
				"velocity_max": radius * 0.58,
				"gravity": Vector2(0.0, -96.0),
				"scale_min": 1.1,
				"scale_max": 2.8,
			}, true)
		"MissileCardParticles":
			config.merge({
				"lifetime": 0.46,
				"emission_radius": radius * 0.18,
				"velocity_min": radius * 0.62,
				"velocity_max": radius * 1.74,
				"scale_min": 1.4,
				"scale_max": 4.0,
			}, true)
		"CryoCardParticles", "GlobalFreezeParticles":
			config.merge({
				"lifetime": 0.98,
				"emission_radius": radius * 0.42,
				"velocity_min": radius * 0.05,
				"velocity_max": radius * 0.40,
				"gravity": Vector2(0.0, -24.0),
				"scale_min": 0.8,
				"scale_max": 2.6,
			}, true)
		"FirestormParticles":
			config.merge({
				"lifetime": 0.72,
				"emission_radius": radius * 0.58,
				"direction": Vector2.DOWN,
				"spread": 54.0,
				"velocity_min": radius * 0.20,
				"velocity_max": radius * 0.82,
				"gravity": Vector2(0.0, 520.0),
				"scale_min": 1.8,
				"scale_max": 5.0,
			}, true)
		"BaitBeaconParticles":
			config.merge({
				"lifetime": 1.10,
				"emission_radius": radius * 0.50,
				"direction": Vector2.UP,
				"spread": 360.0,
				"velocity_min": radius * 0.03,
				"velocity_max": radius * 0.22,
				"scale_min": 0.9,
				"scale_max": 2.3,
				"damping_min": 56.0,
				"damping_max": 130.0,
			}, true)
		"TimeWarpParticles":
			config.merge({
				"lifetime": 1.18,
				"emission_radius": radius * 0.62,
				"direction": Vector2.RIGHT,
				"spread": 18.0,
				"velocity_min": radius * 0.16,
				"velocity_max": radius * 0.64,
				"scale_min": 0.7,
				"scale_max": 2.0,
				"angular_velocity_min": -260.0,
				"angular_velocity_max": 260.0,
				"damping_min": 34.0,
				"damping_max": 86.0,
			}, true)
		"RoadSpikesParticles":
			config.merge({
				"lifetime": 0.38,
				"emission_radius": radius * 0.24,
				"direction": Vector2.DOWN,
				"spread": 64.0,
				"velocity_min": radius * 0.24,
				"velocity_max": radius * 0.82,
				"gravity": Vector2(0.0, 300.0),
				"scale_min": 0.7,
				"scale_max": 1.9,
			}, true)
		"CoinMagnetParticles", "GoldBurstParticles":
			config.merge({
				"lifetime": 0.86,
				"emission_radius": radius * 0.24,
				"direction": Vector2.UP,
				"spread": 48.0,
				"velocity_min": radius * 0.22,
				"velocity_max": radius * 0.92,
				"gravity": Vector2(0.0, -160.0),
				"scale_min": 1.1,
				"scale_max": 3.4,
			}, true)
		"TowerSwapParticles":
			config.merge({
				"lifetime": 0.58,
				"emission_radius": radius * 0.18,
				"direction": Vector2.RIGHT,
				"spread": 28.0,
				"velocity_min": radius * 0.44,
				"velocity_max": radius * 1.46,
				"scale_min": 0.9,
				"scale_max": 2.4,
				"damping_min": 20.0,
				"damping_max": 64.0,
			}, true)
		"OverloadDebtParticles":
			config.merge({
				"lifetime": 0.76,
				"emission_radius": radius * 0.38,
				"direction": Vector2.DOWN,
				"spread": 64.0,
				"velocity_min": radius * 0.30,
				"velocity_max": radius * 1.18,
				"gravity": Vector2(0.0, 340.0),
				"scale_min": 1.3,
				"scale_max": 4.0,
			}, true)
		"PanicButtonParticles":
			config.merge({
				"lifetime": 0.70,
				"emission_radius": radius * 0.44,
				"direction": Vector2.UP,
				"spread": 180.0,
				"velocity_min": radius * 0.18,
				"velocity_max": radius * 0.92,
				"gravity": Vector2(0.0, -180.0),
				"scale_min": 1.4,
				"scale_max": 4.4,
			}, true)
		"RerollCacheParticles":
			config.merge({
				"lifetime": 0.64,
				"emission_radius": radius * 0.24,
				"direction": Vector2.LEFT,
				"spread": 34.0,
				"velocity_min": radius * 0.28,
				"velocity_max": radius * 0.96,
				"scale_min": 0.8,
				"scale_max": 2.2,
				"damping_min": 30.0,
				"damping_max": 90.0,
			}, true)
		"BountyMarkParticles":
			config.merge({
				"lifetime": 0.58,
				"emission_radius": radius * 0.16,
				"direction": Vector2.UP,
				"spread": 36.0,
				"velocity_min": radius * 0.36,
				"velocity_max": radius * 1.18,
				"gravity": Vector2(0.0, -120.0),
			}, true)

	return config


func spawn_level_clear_particles(world_position: Vector2) -> CPUParticles2D:
	return spawn_particle_burst(world_position, {
		"name": "LevelClearWorldParticles",
		"amount": 66,
		"lifetime": 1.18,
		"emission_radius": 68.0,
		"direction": Vector2.UP,
		"spread": 82.0,
		"velocity_min": 28.0,
		"velocity_max": 138.0,
		"scale_min": 1.5,
		"scale_max": 3.9,
		"gravity": Vector2(0.0, -58.0),
		"damping_min": 24.0,
		"damping_max": 88.0,
		"color": Color(0.42, 1.0, 0.62),
		"z_index": 118,
		"important": true,
	})


func spawn_base_hit_particles(world_position: Vector2) -> void:
	spawn_particle_burst(world_position, {
		"name": "BaseHitParticles",
		"amount": 30,
		"lifetime": 0.62,
		"emission_radius": 16.0,
		"velocity_min": 42.0,
		"velocity_max": 170.0,
		"scale_min": 1.1,
		"scale_max": 3.0,
		"gravity": Vector2(0.0, 220.0),
		"color": Color(1.0, 0.34, 0.16),
		"important": true,
	})


func spawn_screen_particles(success: bool) -> CPUParticles2D:
	var center := camera.position if camera != null else get_map_center_position()
	var particle_name := "VictoryScreenParticles" if success else "DefeatScreenParticles"
	var color := Color(0.46, 1.0, 0.58) if success else Color(1.0, 0.24, 0.16)
	return spawn_particle_burst(center, {
		"name": particle_name,
		"amount": 104 if success else 74,
		"lifetime": 1.32 if success else 0.92,
		"emission_radius": 168.0 if success else 118.0,
		"direction": Vector2.UP if success else Vector2.DOWN,
		"spread": 112.0 if success else 78.0,
		"velocity_min": 54.0 if success else 38.0,
		"velocity_max": 260.0 if success else 190.0,
		"scale_min": 1.8 if success else 1.2,
		"scale_max": 4.8 if success else 3.3,
		"gravity": Vector2(0.0, -90.0) if success else Vector2(0.0, 430.0),
		"damping_min": 30.0 if success else 6.0,
		"damping_max": 96.0 if success else 34.0,
		"color": color,
		"z_index": 120,
		"important": true,
	})


func add_gold(amount: int) -> void:
	gold = clampi(gold + amount, 0, MAX_GOLD)
	_refresh_ui()


func spend_gold(amount: int) -> bool:
	if gold < amount:
		return false

	gold -= amount
	_refresh_ui()
	return true


func set_message(message: String) -> void:
	_message = message
	_refresh_ui()


func show_selected_tower(tower: Tower = null) -> void:
	ui.show_tower_panel(tower)


func _refresh_selected_tower_panel() -> void:
	if ui == null or build_manager == null:
		return
	if not ui.tower_panel.visible or not is_instance_valid(build_manager.selected_tower):
		return
	ui.show_tower_panel(build_manager.selected_tower)


func get_tower_config(type_id: String) -> Dictionary:
	var safe_type_id := _sanitize_tower_type_id(type_id)
	var config: Dictionary = tower_configs.get(safe_type_id, tower_configs["basic"])
	return config.duplicate(true)


func get_tower_configs() -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	for type_id in ["basic", "rapid", "shotgun", "cannon", "sniper", "amplifier"]:
		result.append(get_tower_config(type_id))
	return result


func get_level_configs() -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	for config in level_configs:
		result.append((config as Dictionary).duplicate(true))
	return result


func get_enemy_type_configs() -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	for type_id in ["grunt", "runner", "brute", "shield", "taunt", "elite"]:
		if enemy_type_configs.has(type_id):
			result.append((enemy_type_configs[type_id] as Dictionary).duplicate(true))
	return result


func _get_tower_type_display_name(type_id: String) -> String:
	var config := get_tower_config(type_id)
	var display_name := str(config.get("name", "")).strip_edges()
	return display_name if not display_name.is_empty() else _get_default_tower_display_name()


func _sanitize_tower_type_id(raw_type: Variant) -> String:
	var type_id := str(raw_type).strip_edges()
	if tower_configs.has(type_id):
		return type_id
	return "basic"


func get_current_level_config() -> Dictionary:
	var config: Dictionary = level_configs[current_level_index]
	return config.duplicate(true)


func _get_level_display_name(config: Dictionary) -> String:
	var level_name := str(config.get("name", "")).strip_edges()
	return level_name if not level_name.is_empty() else _get_default_level_display_name()


func _get_default_level_display_name() -> String:
	return DEFAULT_LEVEL_DISPLAY_NAME


func _get_default_tower_display_name() -> String:
	return DEFAULT_TOWER_DISPLAY_NAME


func _get_default_reward_card_display_name() -> String:
	return DEFAULT_CARD_DISPLAY_NAME


func _get_default_enemy_type_display_name() -> String:
	return DEFAULT_ENEMY_TYPE_DISPLAY_NAME


func _get_current_level_display_name() -> String:
	return _get_level_display_name(get_current_level_config())


func _format_current_level_message_text(level: int, level_name: String) -> String:
	return CURRENT_LEVEL_MESSAGE_TEMPLATE % [level, level_name]


func _format_locked_level_message_text(level: int) -> String:
	return LOCKED_LEVEL_MESSAGE_TEMPLATE % level


func _format_wave_started_message_text(level: int, wave: int) -> String:
	return WAVE_STARTED_MESSAGE_TEMPLATE % [level, wave]


func _get_wave_start_blocked_message_text() -> String:
	return WAVE_START_BLOCKED_MESSAGE_TEXT


func _format_tower_locked_message_text(tower_name: String, unlock_level: int) -> String:
	return TOWER_LOCKED_MESSAGE_TEMPLATE % [tower_name, unlock_level]


func _get_pause_message_text() -> String:
	return PAUSE_MESSAGE_TEXT


func _get_resume_message_text() -> String:
	return RESUME_MESSAGE_TEXT


func _format_level_restart_message_text(level: int) -> String:
	return LEVEL_RESTART_MESSAGE_TEMPLATE % level


func _get_start_screen_message_text() -> String:
	return START_SCREEN_MESSAGE_TEXT


func _get_continue_save_missing_message_text() -> String:
	return CONTINUE_SAVE_MISSING_MESSAGE_TEXT


func _format_continue_save_loaded_message_text(level: int, level_name: String) -> String:
	return CONTINUE_SAVE_LOADED_MESSAGE_TEMPLATE % [level, level_name]


func _format_wave_spawn_finished_message_text(wave: int) -> String:
	return WAVE_SPAWN_FINISHED_MESSAGE_TEMPLATE % wave


func _get_final_wave_spawn_finished_message_text() -> String:
	return FINAL_WAVE_SPAWN_FINISHED_MESSAGE_TEXT


func _format_gold_reward_message_text(reward: int) -> String:
	return GOLD_REWARD_MESSAGE_TEMPLATE % reward


func _format_base_damage_message_text(damage: int) -> String:
	return BASE_DAMAGE_MESSAGE_TEMPLATE % damage


func _format_elite_stun_message_text(stunned_count: int) -> String:
	return ELITE_STUN_MESSAGE_TEMPLATE % stunned_count


func _format_level_complete_message_text(level: int) -> String:
	return LEVEL_COMPLETE_MESSAGE_TEMPLATE % level


func _format_intermission_message_text(wave: int, seconds_left: float) -> String:
	return INTERMISSION_MESSAGE_TEMPLATE % [wave, seconds_left]


func _format_auto_wave_started_message_text(level: int, wave: int) -> String:
	return AUTO_WAVE_STARTED_MESSAGE_TEMPLATE % [level, wave]


func _get_auto_wave_blocked_message_text() -> String:
	return AUTO_WAVE_BLOCKED_MESSAGE_TEXT


func _format_reward_card_console_text(card_name: String) -> String:
	return REWARD_CARD_CONSOLE_TEMPLATE % card_name


func _format_reward_card_stored_message_text(card_name: String) -> String:
	return REWARD_CARD_STORED_MESSAGE_TEMPLATE % card_name


func _format_reward_card_hand_full_message_text(card_name: String) -> String:
	return REWARD_CARD_HAND_FULL_MESSAGE_TEMPLATE % card_name


func _get_pending_card_blocks_play_message_text() -> String:
	return PENDING_CARD_BLOCKS_PLAY_MESSAGE_TEXT


func _format_reward_card_replaced_message_text(discarded_name: String, kept_name: String) -> String:
	return REWARD_CARD_REPLACED_MESSAGE_TEMPLATE % [discarded_name, kept_name]


func _get_pending_card_rejected_message_text() -> String:
	return PENDING_CARD_REJECTED_MESSAGE_TEXT


func _get_pending_card_timeout_message_text() -> String:
	return PENDING_CARD_TIMEOUT_MESSAGE_TEXT


func _get_pending_card_blocks_sell_message_text() -> String:
	return PENDING_CARD_BLOCKS_SELL_MESSAGE_TEXT


func _format_reward_card_sold_message_text(sell_value: int) -> String:
	return REWARD_CARD_SOLD_MESSAGE_TEMPLATE % sell_value


func _format_damage_boost_card_message_text(boosted_count: int, duration: float) -> String:
	return DAMAGE_BOOST_CARD_MESSAGE_TEMPLATE % [boosted_count, duration]


func _format_range_boost_card_message_text(boosted_count: int, duration: float) -> String:
	return RANGE_BOOST_CARD_MESSAGE_TEMPLATE % [boosted_count, duration]


func _format_fire_rate_boost_card_message_text(boosted_count: int, duration: float) -> String:
	return FIRE_RATE_BOOST_CARD_MESSAGE_TEMPLATE % [boosted_count, duration]


func _format_heal_card_message_text(heal_amount: int) -> String:
	return HEAL_CARD_MESSAGE_TEMPLATE % heal_amount


func _get_missile_card_empty_message_text() -> String:
	return MISSILE_CARD_EMPTY_MESSAGE_TEXT


func _format_missile_card_hit_message_text(hit_count: int) -> String:
	return MISSILE_CARD_HIT_MESSAGE_TEMPLATE % hit_count


func _get_cryo_card_empty_message_text() -> String:
	return CRYO_CARD_EMPTY_MESSAGE_TEXT


func _format_cryo_card_hit_message_text(hit_count: int) -> String:
	return CRYO_CARD_HIT_MESSAGE_TEMPLATE % hit_count


func _get_firestorm_card_empty_message_text() -> String:
	return FIRESTORM_CARD_EMPTY_MESSAGE_TEXT


func _format_firestorm_card_hit_message_text(hit_count: int) -> String:
	return FIRESTORM_CARD_HIT_MESSAGE_TEMPLATE % hit_count


func _get_global_freeze_card_empty_message_text() -> String:
	return GLOBAL_FREEZE_CARD_EMPTY_MESSAGE_TEXT


func _format_global_freeze_card_hit_message_text(hit_count: int) -> String:
	return GLOBAL_FREEZE_CARD_HIT_MESSAGE_TEMPLATE % hit_count


func _format_gold_card_message_text(gold_amount: int) -> String:
	return GOLD_CARD_MESSAGE_TEMPLATE % gold_amount


func _format_risky_cache_success_message_text(gold_amount: int) -> String:
	return RISKY_CACHE_SUCCESS_MESSAGE_TEMPLATE % gold_amount


func _format_risky_cache_failure_message_text(gold_amount: int, damage: int) -> String:
	return RISKY_CACHE_FAILURE_MESSAGE_TEMPLATE % [gold_amount, damage]


func _format_fortify_card_message_text(max_hp_gain: int, heal_amount: int) -> String:
	return FORTIFY_CARD_MESSAGE_TEMPLATE % [max_hp_gain, heal_amount]


func _get_bait_beacon_card_empty_message_text() -> String:
	return BAIT_BEACON_CARD_EMPTY_MESSAGE_TEXT


func _format_bait_beacon_card_hit_message_text(hit_count: int) -> String:
	return BAIT_BEACON_CARD_HIT_MESSAGE_TEMPLATE % hit_count


func _get_road_spikes_card_message_text() -> String:
	return ROAD_SPIKES_CARD_MESSAGE_TEXT


func _format_coin_magnet_card_message_text(duration: float, bonus_percent: int) -> String:
	return COIN_MAGNET_CARD_MESSAGE_TEMPLATE % [duration, bonus_percent]


func _get_time_warp_card_empty_message_text() -> String:
	return TIME_WARP_CARD_EMPTY_MESSAGE_TEXT


func _format_time_warp_card_hit_message_text(hit_count: int) -> String:
	return TIME_WARP_CARD_HIT_MESSAGE_TEMPLATE % hit_count


func _get_tower_swap_card_empty_message_text() -> String:
	return TOWER_SWAP_CARD_EMPTY_MESSAGE_TEXT


func _get_tower_swap_card_hit_message_text() -> String:
	return TOWER_SWAP_CARD_HIT_MESSAGE_TEXT


func _format_overload_debt_card_message_text(duration: float) -> String:
	return OVERLOAD_DEBT_CARD_MESSAGE_TEMPLATE % duration


func _get_panic_button_card_message_text() -> String:
	return PANIC_BUTTON_CARD_MESSAGE_TEXT


func _get_bounty_mark_card_empty_message_text() -> String:
	return BOUNTY_MARK_CARD_EMPTY_MESSAGE_TEXT


func _format_bounty_mark_card_hit_message_text(enemy_name: String, bonus_gold: int) -> String:
	return BOUNTY_MARK_CARD_HIT_MESSAGE_TEMPLATE % [enemy_name, bonus_gold]


func _get_reroll_cache_card_empty_message_text() -> String:
	return REROLL_CACHE_CARD_EMPTY_MESSAGE_TEXT


func _get_reroll_cache_card_message_text() -> String:
	return REROLL_CACHE_CARD_MESSAGE_TEXT


func _get_unknown_reward_card_message_text() -> String:
	return UNKNOWN_REWARD_CARD_MESSAGE_TEXT


func _get_victory_message_text() -> String:
	return VICTORY_MESSAGE_TEXT


func _get_victory_title_text() -> String:
	return VICTORY_TITLE_TEXT


func _get_victory_subtitle_text() -> String:
	return VICTORY_SUBTITLE_TEXT


func _get_defeat_message_text() -> String:
	return DEFEAT_MESSAGE_TEXT


func _get_defeat_title_text() -> String:
	return DEFEAT_TITLE_TEXT


func _get_defeat_subtitle_text() -> String:
	return DEFEAT_SUBTITLE_TEXT


func _get_console_game_started_response_text() -> String:
	return CONSOLE_GAME_STARTED_RESPONSE_TEXT


func _get_console_game_already_started_response_text() -> String:
	return CONSOLE_GAME_ALREADY_STARTED_RESPONSE_TEXT


func _get_console_wave_requested_response_text() -> String:
	return CONSOLE_WAVE_REQUESTED_RESPONSE_TEXT


func _format_console_level_loaded_response_text(level: int) -> String:
	return CONSOLE_LEVEL_LOADED_RESPONSE_TEMPLATE % level


func _get_console_next_level_requested_response_text() -> String:
	return CONSOLE_NEXT_LEVEL_REQUESTED_RESPONSE_TEXT


func _format_console_gold_added_message_text(amount: int) -> String:
	return CONSOLE_GOLD_ADDED_MESSAGE_TEMPLATE % amount


func _format_console_gold_added_response_text(amount: int, current_gold: int) -> String:
	return CONSOLE_GOLD_ADDED_RESPONSE_TEMPLATE % [amount, current_gold]


func _format_console_gold_set_message_text(current_gold: int) -> String:
	return CONSOLE_GOLD_SET_MESSAGE_TEMPLATE % current_gold


func _format_console_gold_set_response_text(current_gold: int) -> String:
	return CONSOLE_GOLD_SET_RESPONSE_TEMPLATE % current_gold


func _format_console_base_health_response_text(current_health: int, maximum_health: int) -> String:
	return CONSOLE_BASE_HEALTH_RESPONSE_TEMPLATE % [current_health, maximum_health]


func _format_console_base_healed_message_text(heal_amount: int) -> String:
	return CONSOLE_BASE_HEALED_MESSAGE_TEMPLATE % heal_amount


func _get_console_base_health_set_message_text() -> String:
	return CONSOLE_BASE_HEALTH_SET_MESSAGE_TEXT


func _format_console_enemy_spawned_message_text(count: int, enemy_name: String) -> String:
	return CONSOLE_ENEMY_SPAWNED_MESSAGE_TEMPLATE % [count, enemy_name]


func _format_console_enemy_spawned_response_text(count: int, enemy_name: String) -> String:
	return CONSOLE_ENEMY_SPAWNED_RESPONSE_TEMPLATE % [count, enemy_name]


func _get_console_enemies_cleared_message_text() -> String:
	return CONSOLE_ENEMIES_CLEARED_MESSAGE_TEXT


func _get_console_clear_response_text() -> String:
	return CONSOLE_CLEAR_RESPONSE_TEXT


func _format_console_reward_card_created_response_text(card_name: String) -> String:
	return CONSOLE_REWARD_CARD_CREATED_RESPONSE_TEMPLATE % card_name


func _get_console_no_stored_card_response_text() -> String:
	return CONSOLE_NO_STORED_CARD_RESPONSE_TEXT


func _get_console_card_used_response_text() -> String:
	return CONSOLE_CARD_USED_RESPONSE_TEXT


func _get_console_card_unavailable_response_text() -> String:
	return CONSOLE_CARD_UNAVAILABLE_RESPONSE_TEXT


func _get_console_victory_triggered_response_text() -> String:
	return CONSOLE_VICTORY_TRIGGERED_RESPONSE_TEXT


func _get_console_defeat_triggered_response_text() -> String:
	return CONSOLE_DEFEAT_TRIGGERED_RESPONSE_TEXT


func _get_console_reload_response_text() -> String:
	return CONSOLE_RELOAD_RESPONSE_TEXT


func _format_console_status_response_text(
	level: int,
	total_levels: int,
	current_gold: int,
	current_base_health: int,
	maximum_base_health: int,
	current_wave: int,
	total_waves: int,
	enemy_count: int,
	auto_waves_enabled: bool,
	intermission_seconds: float,
	game_over: bool
) -> String:
	return CONSOLE_STATUS_RESPONSE_TEMPLATE % [
		level,
		total_levels,
		current_gold,
		current_base_health,
		maximum_base_health,
		current_wave,
		total_waves,
		enemy_count,
		_format_console_bool(auto_waves_enabled),
		intermission_seconds,
		_format_console_bool(game_over)
	]


func _format_console_unknown_command_response_text(action: String) -> String:
	return CONSOLE_UNKNOWN_COMMAND_RESPONSE_TEMPLATE % action


func _format_console_base_damaged_message_text(damage_amount: int) -> String:
	return CONSOLE_BASE_DAMAGED_MESSAGE_TEMPLATE % damage_amount


func _set_current_level_message() -> void:
	_message = _format_current_level_message_text(current_level_index + 1, _get_current_level_display_name())


func _show_current_level_intro(delay: float) -> void:
	ui.show_level_intro(current_level_index + 1, _get_current_level_display_name(), level_configs.size(), delay)


func is_tower_type_unlocked(type_id: String) -> bool:
	var config := get_tower_config(_sanitize_tower_type_id(type_id))
	return current_level_index >= _get_tower_unlock_level(config)


func _get_tower_unlock_level(config: Dictionary) -> int:
	return _sanitize_level_int(config.get("unlock_level", 0), 0, 0, maxi(level_configs.size() - 1, 0))


func get_active_enemies() -> Array[Enemy]:
	var enemies: Array[Enemy] = _enemy_cache.duplicate()
	return enemies


func get_active_enemy_count() -> int:
	var enemy_count := _enemy_cache.size()
	return enemy_count


func register_enemy(enemy: Enemy) -> void:
	if enemy == null or not is_instance_valid(enemy) or _enemy_cache.has(enemy):
		return
	_enemy_cache.append(enemy)
	enemy.tree_exiting.connect(_on_registered_enemy_exiting.bind(enemy), CONNECT_ONE_SHOT)


func _on_registered_enemy_exiting(enemy: Enemy) -> void:
	if not _enemy_cache.has(enemy):
		return
	_remove_enemy_from_cache(enemy)


func get_active_towers() -> Array[Tower]:
	var towers: Array[Tower] = _tower_cache.duplicate()
	return towers


func register_tower(tower: Tower) -> void:
	if not _is_valid_active_tower(tower) or _tower_cache.has(tower):
		return
	_tower_cache.append(tower)
	tower.tree_exiting.connect(_on_registered_tower_exiting.bind(tower), CONNECT_ONE_SHOT)


func unregister_tower(tower: Tower) -> void:
	if tower == null:
		return
	_tower_cache.erase(tower)


func _on_registered_tower_exiting(tower: Tower) -> void:
	unregister_tower(tower)


func _remove_enemy_from_cache(enemy: Enemy) -> void:
	var index := _enemy_cache.find(enemy)
	if index >= 0:
		_enemy_cache.remove_at(index)


func _theme_color(key: String, fallback: Color) -> Color:
	if scene_theme.has(key):
		return _get_valid_theme_color(scene_theme.get(key), fallback)
	return fallback


func _get_valid_theme_color(raw_color: Variant, fallback: Color) -> Color:
	if raw_color is Color:
		return raw_color
	return fallback


func _make_theme(field_a: Color, field_b: Color, grid: Color, road: Color, road_dark: Color, road_light: Color, road_edge: Color, bg: Color, water: Color, base_body: Color, base_plate: Color, base_glow: Color) -> Dictionary:
	return {
		"field_a": field_a,
		"field_b": field_b,
		"grid": grid,
		"road": road,
		"road_dark": road_dark,
		"road_light": road_light,
		"road_edge": road_edge,
		"bg": bg,
		"water": water,
		"base_body": base_body,
		"base_plate": base_plate,
		"base_glow": base_glow,
	}


func get_map_pixel_width() -> int:
	return map_cols * GRID_SIZE


func get_map_pixel_height() -> int:
	return PLAY_TOP + map_rows * GRID_SIZE


func get_map_pixel_size() -> Vector2:
	return Vector2(float(get_map_pixel_width()), float(get_map_pixel_height()))


func get_map_center_position() -> Vector2:
	return get_map_pixel_size() * 0.5


func get_camera_bounds_size() -> Vector2:
	return Vector2(float(get_map_pixel_width()), float(maxi(get_map_pixel_height(), MAP_HEIGHT)))


func get_camera_bounds_center() -> Vector2:
	return get_camera_bounds_size() * 0.5


func get_map_max_dimension() -> float:
	var map_size := get_map_pixel_size()
	return maxf(map_size.x, map_size.y)


func get_map_half_max_dimension() -> float:
	return get_map_max_dimension() * 0.5


func screen_to_world(screen_position: Vector2) -> Vector2:
	return get_viewport().get_canvas_transform().affine_inverse() * screen_position


func world_to_screen(world_position: Vector2) -> Vector2:
	return get_viewport().get_canvas_transform() * world_position


func get_base_position() -> Vector2:
	if not path_points.is_empty():
		var base_position := path_points[path_points.size() - 1]
		return base_position
	var map_size := get_map_pixel_size()
	return Vector2(map_size.x - float(GRID_SIZE) * 0.5, map_size.y * 0.5)


func _update_camera_movement(delta: float) -> void:
	if camera == null or ui == null or ui.is_console_visible():
		return

	var direction := Vector2.ZERO
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		direction.x -= 1.0
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		direction.x += 1.0
	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
		direction.y -= 1.0
	if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
		direction.y += 1.0

	if direction != Vector2.ZERO:
		camera.position += direction.normalized() * 420.0 * delta / camera.zoom.x
		_clamp_camera_to_map()


func _adjust_camera_zoom(direction: int, screen_focus: Vector2) -> void:
	if camera == null:
		return

	var world_before := screen_to_world(screen_focus)
	var current_zoom := camera.zoom.x
	var target_zoom := current_zoom * (CAMERA_ZOOM_STEP if direction > 0 else 1.0 / CAMERA_ZOOM_STEP)
	target_zoom = clampf(target_zoom, _get_min_camera_zoom(), CAMERA_MAX_ZOOM)
	camera.zoom = Vector2.ONE * target_zoom

	var world_after := screen_to_world(screen_focus)
	camera.position += world_before - world_after
	_clamp_camera_to_map()


func _get_min_camera_zoom() -> float:
	var viewport_size := get_viewport_rect().size
	var map_size := get_camera_bounds_size()
	var fit_zoom := minf(viewport_size.x / map_size.x, viewport_size.y / map_size.y)
	return clampf(fit_zoom, 0.15, 1.0)


func _clamp_camera_zoom() -> void:
	if camera == null:
		return
	var zoom_value := clampf(camera.zoom.x, _get_min_camera_zoom(), CAMERA_MAX_ZOOM)
	camera.zoom = Vector2.ONE * zoom_value


func _clamp_camera_to_map() -> void:
	if camera == null:
		return

	_clamp_camera_zoom()
	var viewport_size := get_viewport_rect().size
	var visible_size := viewport_size / camera.zoom.x
	var half_viewport := visible_size * 0.5
	var map_size := get_camera_bounds_size()

	if map_size.x <= visible_size.x:
		camera.position.x = map_size.x * 0.5
	else:
		camera.position.x = clampf(camera.position.x, half_viewport.x, map_size.x - half_viewport.x)

	if map_size.y <= visible_size.y:
		camera.position.y = map_size.y * 0.5
	else:
		camera.position.y = clampf(camera.position.y, half_viewport.y, map_size.y - half_viewport.y)


func _create_layers() -> void:
	map_layer = MapRendererScene.new()
	map_layer.name = "MapLayer"
	map_layer.z_index = WORLD_LAYER_MAP
	add_child(map_layer)
	map_layer.setup(self)

	world_decal_layer = WorldDecalRendererScene.new()
	world_decal_layer.name = "WorldDecalLayer"
	world_decal_layer.z_index = WORLD_LAYER_DECALS
	world_decal_layer.process_mode = Node.PROCESS_MODE_PAUSABLE
	add_child(world_decal_layer)
	world_decal_layer.setup(self)

	tower_layer = _create_world_layer("TowerLayer", WORLD_LAYER_TOWERS)
	enemy_layer = _create_world_layer("EnemyLayer", WORLD_LAYER_ENEMIES)
	projectile_layer = _create_world_layer("ProjectileLayer", WORLD_LAYER_PROJECTILES)
	impact_layer = _create_world_layer("ImpactLayer", WORLD_LAYER_IMPACTS)
	particle_layer = _create_world_layer("ParticleLayer", WORLD_LAYER_PARTICLES)

	world_overlay_layer = WorldOverlayRendererScene.new()
	world_overlay_layer.name = "WorldOverlayLayer"
	world_overlay_layer.z_index = WORLD_LAYER_OVERLAY
	world_overlay_layer.process_mode = Node.PROCESS_MODE_PAUSABLE
	add_child(world_overlay_layer)
	world_overlay_layer.setup(self)


func _create_world_layer(layer_name: String, layer_z_index: int) -> Node2D:
	var layer := Node2D.new()
	layer.name = layer_name
	layer.z_index = layer_z_index
	layer.process_mode = Node.PROCESS_MODE_PAUSABLE
	add_child(layer)
	return layer


func _create_camera() -> void:
	camera = Camera2D.new()
	camera.name = "GameCamera"
	camera.enabled = true
	camera.position = get_camera_bounds_center()
	add_child(camera)


func _create_managers() -> void:
	build_manager = BuildManager.new()
	build_manager.name = "BuildManager"
	build_manager.z_index = WORLD_LAYER_BUILD_PREVIEW
	build_manager.process_mode = Node.PROCESS_MODE_PAUSABLE
	add_child(build_manager)
	build_manager.setup(self, tower_layer, road_cells)

	wave_manager = WaveManager.new()
	wave_manager.name = "WaveManager"
	wave_manager.process_mode = Node.PROCESS_MODE_PAUSABLE
	add_child(wave_manager)
	wave_manager.wave_started.connect(_on_wave_started)
	wave_manager.enemy_spawn_requested.connect(_on_enemy_spawn_requested)
	wave_manager.wave_spawn_finished.connect(_on_wave_spawn_finished)


func _create_ui() -> void:
	ui = GameUI.new()
	ui.name = "GameUI"
	add_child(ui)
	ui.setup(get_tower_configs(), get_level_configs(), get_enemy_type_configs())
	ui.set_update_announcements(UpdateAnnouncementsData.get_recent_announcements())
	ui.set_highest_unlocked_level(highest_unlocked_level_index)
	ui.set_tower_unlock_level(current_level_index)
	ui.set_card_hand_available(false)
	ui.start_wave_pressed.connect(_on_start_wave_pressed)
	ui.tower_build_requested.connect(_on_tower_build_requested)
	ui.next_level_pressed.connect(_on_next_level_pressed)
	ui.upgrade_pressed.connect(_on_upgrade_pressed)
	ui.sell_pressed.connect(_on_sell_pressed)
	ui.tower_panel_close_pressed.connect(_on_tower_panel_close_pressed)
	ui.game_start_pressed.connect(_on_game_start_pressed)
	ui.continue_game_pressed.connect(_on_continue_game_pressed)
	ui.level_selected.connect(_on_level_selected)
	ui.save_overwrite_confirmed.connect(_on_save_overwrite_confirmed)
	ui.exit_to_start_confirmed.connect(_return_to_start_screen)
	ui.reward_card_play_requested.connect(_on_reward_card_play_requested)
	ui.reward_card_discard_requested.connect(_on_reward_card_discard_requested)
	ui.reward_card_reject_requested.connect(_on_reward_card_reject_requested)
	ui.reward_card_sell_requested.connect(_on_reward_card_sell_requested)
	ui.update_announcement_dismissed.connect(_on_update_announcement_dismissed)
	ui.console_command_submitted.connect(_on_console_command_submitted)
	ui.pause_resume_pressed.connect(_resume_game)
	ui.pause_restart_pressed.connect(_restart_current_level_from_pause)
	ui.pause_main_menu_pressed.connect(_request_return_to_start_screen_from_pause)
	ui.end_restart_pressed.connect(_restart_current_level)
	ui.end_main_menu_pressed.connect(_return_to_start_screen)
	ui.show_start_screen()
	ui.set_continue_game_enabled(_has_level_start_save())
	call_deferred("_show_latest_update_announcement_if_needed")


func _show_latest_update_announcement_if_needed() -> void:
	if ui == null:
		return
	var latest_id := UpdateAnnouncementsData.get_latest_announcement_id()
	if latest_id.is_empty() or _get_seen_update_announcement_id() == latest_id:
		return
	var announcements := UpdateAnnouncementsData.get_recent_announcements()
	if announcements.is_empty():
		return
	ui.show_latest_update_announcement(announcements[0] as Dictionary)


func _on_update_announcement_dismissed(announcement_id: String) -> void:
	_set_seen_update_announcement_id(announcement_id)


func _get_seen_update_announcement_id() -> String:
	var config := ConfigFile.new()
	var error := config.load(ANNOUNCEMENT_STATE_PATH)
	if error != OK:
		return ""
	return str(config.get_value("updates", "latest_seen", ""))


func _set_seen_update_announcement_id(announcement_id: String) -> void:
	if announcement_id.is_empty():
		return
	var config := ConfigFile.new()
	config.load(ANNOUNCEMENT_STATE_PATH)
	config.set_value("updates", "latest_seen", announcement_id)
	config.save(ANNOUNCEMENT_STATE_PATH)


func _has_level_start_save() -> bool:
	if not FileAccess.file_exists(LEVEL_START_SAVE_PATH):
		return false
	var save_data := _read_level_start_save()
	return bool(save_data.get("has_save", false))


func _read_level_start_save() -> Dictionary:
	var config := ConfigFile.new()
	var error := config.load(LEVEL_START_SAVE_PATH)
	if error != OK:
		return {}
	if not bool(config.get_value(LEVEL_START_SAVE_SECTION, "has_save", false)):
		return {}
	var max_level_index := maxi(level_configs.size() - 1, 0)
	var level_index := _sanitize_level_int(config.get_value(LEVEL_START_SAVE_SECTION, "level_index", 0), 0, 0, max_level_index)
	var max_saved_health := _sanitize_saved_base_health(config.get_value(LEVEL_START_SAVE_SECTION, "max_base_health", INITIAL_BASE_HEALTH))
	return {
		"has_save": true,
		"level_index": level_index,
		"highest_unlocked_level_index": _sanitize_level_int(config.get_value(LEVEL_START_SAVE_SECTION, "highest_unlocked_level_index", level_index), level_index, 0, max_level_index),
		"gold": _sanitize_level_int(config.get_value(LEVEL_START_SAVE_SECTION, "gold", INITIAL_GOLD), INITIAL_GOLD, 0, MAX_GOLD),
		"base_health": _sanitize_level_int(config.get_value(LEVEL_START_SAVE_SECTION, "base_health", max_saved_health), max_saved_health, 1, max_saved_health),
		"max_base_health": max_saved_health,
	}


func _save_level_start_state() -> void:
	var config := ConfigFile.new()
	var max_level_index := maxi(level_configs.size() - 1, 0)
	var saved_max_base_health := _sanitize_saved_base_health(max_base_health)
	var saved_base_health := clampi(base_health, 1, saved_max_base_health)
	config.set_value(LEVEL_START_SAVE_SECTION, "has_save", true)
	config.set_value(LEVEL_START_SAVE_SECTION, "level_index", clampi(current_level_index, 0, max_level_index))
	config.set_value(LEVEL_START_SAVE_SECTION, "highest_unlocked_level_index", clampi(highest_unlocked_level_index, 0, max_level_index))
	config.set_value(LEVEL_START_SAVE_SECTION, "gold", clampi(gold, 0, MAX_GOLD))
	config.set_value(LEVEL_START_SAVE_SECTION, "base_health", saved_base_health)
	config.set_value(LEVEL_START_SAVE_SECTION, "max_base_health", saved_max_base_health)
	config.save(LEVEL_START_SAVE_PATH)
	if ui != null:
		ui.set_continue_game_enabled(true)


func _should_warn_save_overwrite(level_index: int) -> bool:
	var save_data := _read_level_start_save()
	if save_data.is_empty():
		return false
	return level_index < _get_saved_level_index(save_data)


func _start_current_level_and_save(intro_delay: float = 0.30) -> void:
	has_game_started = true
	_save_level_start_state()
	ui.set_card_hand_available(true)
	ui.set_tower_unlock_level(current_level_index)
	ui.hide_start_screen()
	_set_current_level_message()
	_show_current_level_intro(intro_delay)
	_refresh_ui()


func _load_level_start_save() -> bool:
	var save_data := _read_level_start_save()
	if save_data.is_empty():
		return false
	var saved_level_index := _get_saved_level_index(save_data)
	_load_level(saved_level_index, false)
	var saved_highest_unlocked_level_index := _get_saved_highest_unlocked_level_index(save_data, saved_level_index)
	highest_unlocked_level_index = clampi(maxi(highest_unlocked_level_index, saved_highest_unlocked_level_index), 0, maxi(level_configs.size() - 1, 0))
	gold = _get_saved_gold(save_data)
	max_base_health = _get_saved_max_base_health(save_data)
	base_health = _get_saved_base_health(save_data, max_base_health)
	if ui != null:
		ui.set_highest_unlocked_level(highest_unlocked_level_index)
		ui.set_continue_game_enabled(true)
	return true


func _get_saved_level_index(save_data: Dictionary) -> int:
	return _sanitize_level_int(save_data.get("level_index", 0), 0, 0, maxi(level_configs.size() - 1, 0))


func _get_saved_highest_unlocked_level_index(save_data: Dictionary, saved_level_index: int) -> int:
	var max_level_index := maxi(level_configs.size() - 1, 0)
	var safe_saved_level_index := clampi(saved_level_index, 0, max_level_index)
	return _sanitize_level_int(save_data.get("highest_unlocked_level_index", safe_saved_level_index), safe_saved_level_index, 0, max_level_index)


func _get_saved_gold(save_data: Dictionary) -> int:
	return _sanitize_level_int(save_data.get("gold", gold), gold, 0, MAX_GOLD)


func _get_saved_max_base_health(save_data: Dictionary) -> int:
	return _sanitize_saved_base_health(save_data.get("max_base_health", max_base_health))


func _get_saved_base_health(save_data: Dictionary, saved_max_base_health: int) -> int:
	var safe_max_base_health := _sanitize_saved_base_health(saved_max_base_health)
	return _sanitize_level_int(save_data.get("base_health", base_health), base_health, 1, safe_max_base_health)


func _on_game_start_pressed() -> void:
	if _should_warn_save_overwrite(0):
		ui.show_save_overwrite_confirm(0, _get_level_display_name(level_configs[0]))
		return
	_load_level(0, false)
	_start_current_level_and_save()


func _on_continue_game_pressed() -> void:
	if not _load_level_start_save():
		_message = _get_continue_save_missing_message_text()
		if ui != null:
			ui.set_continue_game_enabled(false)
		_refresh_ui()
		return
	has_game_started = true
	ui.set_card_hand_available(true)
	ui.set_tower_unlock_level(current_level_index)
	ui.hide_start_screen()
	_message = _format_continue_save_loaded_message_text(current_level_index + 1, _get_current_level_display_name())
	_show_current_level_intro(0.30)
	_refresh_ui()


func _on_level_selected(level_index: int) -> void:
	if level_index > highest_unlocked_level_index:
		_message = _format_locked_level_message_text(level_index + 1)
		_refresh_ui()
		return
	if _should_warn_save_overwrite(level_index):
		ui.show_save_overwrite_confirm(level_index, _get_level_display_name(level_configs[level_index]))
		return
	_load_level(level_index, false)
	_start_current_level_and_save()


func _on_save_overwrite_confirmed(level_index: int) -> void:
	if level_index > highest_unlocked_level_index:
		_message = _format_locked_level_message_text(level_index + 1)
		_refresh_ui()
		return
	_load_level(level_index, false)
	_start_current_level_and_save()


func _on_start_wave_pressed() -> void:
	if is_game_paused or is_game_over or is_level_complete or not has_game_started:
		return

	_auto_waves_enabled = true
	if wave_manager.start_next_wave():
		build_manager.cancel_build_mode()
		_message = _format_wave_started_message_text(current_level_index + 1, wave_manager.current_wave)
	else:
		_message = _get_wave_start_blocked_message_text()

	_refresh_ui()


func _on_tower_build_requested(type_id: String) -> void:
	if is_game_paused or is_game_over or is_level_complete or not has_game_started:
		return

	var safe_type_id := _sanitize_tower_type_id(type_id)
	if not is_tower_type_unlocked(safe_type_id):
		var config := get_tower_config(safe_type_id)
		_message = _format_tower_locked_message_text(_get_tower_type_display_name(safe_type_id), _get_tower_unlock_level(config) + 1)
		_refresh_ui()
		return

	build_manager.enter_build_mode(safe_type_id)
	_refresh_ui()


func _on_next_level_pressed() -> void:
	if is_game_paused or not is_level_complete or current_level_index >= level_configs.size() - 1:
		return

	_unlock_level(current_level_index + 1)
	_load_level(current_level_index + 1, true)
	_save_level_start_state()
	_show_current_level_intro(0.05)
	_refresh_ui()


func _on_upgrade_pressed() -> void:
	if is_game_paused:
		return
	build_manager.upgrade_selected()
	_refresh_ui()


func _on_sell_pressed() -> void:
	if is_game_paused:
		return
	build_manager.sell_selected()
	_refresh_ui()


func _on_tower_panel_close_pressed() -> void:
	if build_manager != null:
		build_manager.clear_selection()
	_refresh_ui()


func _pause_game() -> void:
	if is_game_paused or not has_game_started or is_game_over:
		return

	if build_manager.is_building:
		build_manager.cancel_build_mode()
	build_manager.clear_selection()
	ui.cancel_card_drag()
	_is_camera_dragging = false
	_camera_drag_button = MOUSE_BUTTON_NONE
	is_game_paused = true
	get_tree().paused = true
	_message = _get_pause_message_text()
	ui.show_pause_menu()
	_refresh_ui()


func _resume_game() -> void:
	if not is_game_paused:
		return

	is_game_paused = false
	get_tree().paused = false
	ui.hide_pause_menu()
	_message = _get_resume_message_text()
	_refresh_ui()


func _restart_current_level_from_pause() -> void:
	_restart_current_level()


func _restart_current_level() -> void:
	var level_to_restart := current_level_index
	_set_pause_state(false, false)
	_load_level(level_to_restart, false)
	has_game_started = true
	_save_level_start_state()
	_message = _format_level_restart_message_text(current_level_index + 1)
	_show_current_level_intro(0.05)
	_refresh_ui()


func _request_return_to_start_screen_from_pause() -> void:
	if has_game_started and not is_game_over:
		ui.show_exit_to_start_confirm()
		return
	_return_to_start_screen()


func _return_to_start_screen() -> void:
	_set_pause_state(false, false)
	_load_level(0, false)
	has_game_started = false
	_message = _get_start_screen_message_text()
	ui.show_start_screen()
	ui.set_continue_game_enabled(_has_level_start_save())
	_refresh_ui()


func _set_pause_state(paused: bool, update_message: bool = true) -> void:
	is_game_paused = paused
	get_tree().paused = paused
	if ui != null:
		if paused:
			ui.show_pause_menu()
			if update_message:
				_message = _get_pause_message_text()
		else:
			ui.hide_pause_menu()
			if update_message:
				_message = _get_resume_message_text()


func _on_wave_started(_wave: int) -> void:
	_intermission_active = false
	if ui != null:
		ui.cancel_card_drag()
	_refresh_ui()


func _on_wave_spawn_finished(wave: int) -> void:
	var total_waves := wave_manager.total_waves
	if wave < total_waves:
		_message = _format_wave_spawn_finished_message_text(wave)
	else:
		_message = _get_final_wave_spawn_finished_message_text()
	_check_level_complete()
	_refresh_ui()


func _on_enemy_spawn_requested(type_id: String, enemy_health: int, enemy_speed: float, reward: int, route_index: int) -> void:
	if is_game_over or is_level_complete:
		return

	_spawn_enemy(type_id, enemy_health, enemy_speed, reward, 0.0, route_index)


func _on_enemy_died(enemy: Enemy) -> void:
	if is_game_over:
		return

	_remove_enemy_from_cache(enemy)
	spawn_particle_burst(enemy.global_position, {
		"name": "GoldRewardParticles",
		"amount": 10,
		"lifetime": 0.45,
		"emission_radius": 8.0,
		"velocity_min": 24.0,
		"velocity_max": 86.0,
		"scale_min": 0.8,
		"scale_max": 1.8,
		"gravity": Vector2(0.0, -120.0),
		"color": Color(1.0, 0.86, 0.28),
	})
	var final_reward := enemy.reward
	if _coin_magnet_timer > 0.0 and _coin_magnet_bonus_ratio > 0.0:
		final_reward += int(roundi(float(enemy.reward) * _coin_magnet_bonus_ratio))
	if _bounty_enemy_id != 0 and enemy.get_instance_id() == _bounty_enemy_id:
		final_reward += _bounty_bonus_gold
		_bounty_enemy_id = 0
		_bounty_bonus_gold = 0
	add_gold(final_reward)
	if enemy.enemy_type_id == "elite":
		_trigger_elite_death_blast(enemy.global_position)
	_message = _format_gold_reward_message_text(final_reward)
	_check_level_complete()
	_refresh_ui()


func _on_enemy_reached_end(enemy: Enemy) -> void:
	if is_game_over:
		return

	_remove_enemy_from_cache(enemy)
	base_health -= max(enemy.base_damage, ENEMY_BASE_DAMAGE)
	_base_hit_flash = 0.35
	spawn_base_hit_particles(get_base_position())
	_queue_world_redraw()

	if base_health <= 0:
		_defeat()
	else:
		_message = _format_base_damage_message_text(max(enemy.base_damage, ENEMY_BASE_DAMAGE))
		_check_level_complete()
		_refresh_ui()


func _trigger_elite_death_blast(world_position: Vector2) -> void:
	var stun_radius := 108.0
	var stun_radius_sq := stun_radius * stun_radius
	var stunned := 0
	for tower in _collect_valid_active_towers():
		if world_position.distance_squared_to(tower.global_position) <= stun_radius_sq:
			tower.apply_stun(2.5)
			stunned += 1
	spawn_area_particles(world_position, stun_radius, Color(0.78, 0.90, 1.0), 62, "EliteStunParticles")
	if stunned > 0:
		_message = _format_elite_stun_message_text(stunned)


func _unlock_level(level_index: int) -> void:
	highest_unlocked_level_index = clampi(maxi(highest_unlocked_level_index, level_index), 0, level_configs.size() - 1)
	if ui != null:
		ui.set_highest_unlocked_level(highest_unlocked_level_index)


func _check_level_complete() -> void:
	if is_game_over or is_level_complete:
		return

	if wave_manager == null or wave_manager.is_spawning or get_active_enemy_count() > 0 or wave_manager.current_wave <= 0:
		return

	if wave_manager.is_all_waves_finished():
		if current_level_index >= level_configs.size() - 1:
			_victory()
		else:
			_unlock_level(current_level_index + 1)
			_offer_reward_card(wave_manager.current_wave)
			is_level_complete = true
			_intermission_active = false
			build_manager.cancel_build_mode()
			build_manager.clear_selection()
			_message = _format_level_complete_message_text(current_level_index + 1)
			spawn_level_clear_particles(get_base_position())
			ui.show_level_clear(current_level_index + 1, _get_current_level_display_name())
			_refresh_ui()
	elif _auto_waves_enabled and not _intermission_active:
		_start_intermission()


func _start_intermission() -> void:
	_intermission_active = true
	_intermission_timer = INTERMISSION_SECONDS
	_offer_reward_card(wave_manager.current_wave)
	_message = _format_intermission_message_text(wave_manager.current_wave, _intermission_timer)
	_refresh_ui()


func _start_next_auto_wave() -> void:
	if is_game_over or is_level_complete or not _auto_waves_enabled:
		return

	if wave_manager.start_next_wave():
		ui.cancel_card_drag()
		build_manager.cancel_build_mode()
		_message = _format_auto_wave_started_message_text(current_level_index + 1, wave_manager.current_wave)
	else:
		_message = _get_auto_wave_blocked_message_text()
	_refresh_ui()


func _offer_reward_card(wave: int) -> void:
	var clear_bonus := _get_wave_clear_gold_bonus(wave)
	add_gold(clear_bonus)
	var card := _make_reward_card(wave)
	_add_card_to_hand_or_pending(card)
	ui.write_console_line(_format_reward_card_console_text(_get_reward_card_display_name(card)))


func _get_wave_clear_gold_bonus(wave: int) -> int:
	var route_bonus := maxi(spawn_paths.size() - 1, 0) * WAVE_CLEAR_BONUS_PER_EXTRA_ROUTE
	return WAVE_CLEAR_BONUS_BASE + current_level_index * WAVE_CLEAR_BONUS_PER_LEVEL + wave * WAVE_CLEAR_BONUS_PER_WAVE + route_bonus


func _add_card_to_hand_or_pending(card: Dictionary) -> void:
	var normalized_card := _normalize_reward_card(card)
	if _card_hand.size() < CARD_HAND_LIMIT:
		_card_hand.append(normalized_card)
		_pending_reward_card.clear()
		_pending_reward_timeout = 0.0
		ui.update_card_hand(_card_hand, _pending_reward_card, false)
		_message = _format_reward_card_stored_message_text(_get_reward_card_display_name(normalized_card))
	else:
		_pending_reward_card = normalized_card
		_pending_reward_timeout = PENDING_CARD_TIMEOUT
		ui.update_card_hand(_card_hand, _pending_reward_card, true)
		ui.update_pending_card_timeout(_pending_reward_timeout)
		_message = _format_reward_card_hand_full_message_text(_get_reward_card_display_name(normalized_card))


func _make_reward_card(wave: int) -> Dictionary:
	var card_pool := _get_reward_card_pool()
	var pool_index := (wave - 1 + current_level_index * 2) % card_pool.size()
	return _roll_reward_card_strength((card_pool[pool_index] as Dictionary).duplicate(true), wave)


func _get_reward_card_pool() -> Array[Dictionary]:
	return [
		{
			"id": "tower_boost",
			"name": "超频核心",
			"type_label": "增益",
			"rarity": CARD_RARITY_BLUE,
			"description": "所有已建防御塔在10秒内伤害提高25%。",
			"multiplier": TOWER_BOOST_DEFAULT_MULTIPLIER,
			"duration": TOWER_BOOST_DEFAULT_DURATION,
		},
		{
			"id": "heal",
			"name": "战地维修",
			"type_label": "治疗",
			"rarity": CARD_RARITY_WHITE,
			"description": "恢复6点基地生命值，不能超过当前上限。",
			"amount": HEAL_CARD_DEFAULT_AMOUNT,
		},
		{
			"id": "missile",
			"name": "轨道导弹",
			"type_label": "攻击",
			"rarity": CARD_RARITY_PURPLE,
			"description": "拖到目标区域释放，中等范围内造成270点伤害。",
			"damage": MISSILE_CARD_DEFAULT_DAMAGE,
			"radius": MISSILE_CARD_DEFAULT_RADIUS,
		},
		{
			"id": "gold",
			"name": "紧急军费",
			"type_label": "资源",
			"rarity": CARD_RARITY_WHITE,
			"description": "立即获得85金币，但会占用一次卡牌使用机会。",
			"amount": GOLD_CARD_DEFAULT_AMOUNT,
		},
		{
			"id": "range_boost",
			"name": "信号中继",
			"type_label": "增益",
			"rarity": CARD_RARITY_BLUE,
			"description": "所有已建防御塔在12秒内射程提高18%。",
			"multiplier": RANGE_BOOST_DEFAULT_MULTIPLIER,
			"duration": RANGE_BOOST_DEFAULT_DURATION,
		},
		{
			"id": "fire_rate_boost",
			"name": "急速协议",
			"type_label": "增益",
			"rarity": CARD_RARITY_PURPLE,
			"description": "所有已建防御塔在8秒内攻击速度提高35%。",
			"multiplier": FIRE_RATE_BOOST_DEFAULT_MULTIPLIER,
			"duration": FIRE_RATE_BOOST_DEFAULT_DURATION,
		},
		{
			"id": "cryo",
			"name": "冷冻地雷",
			"type_label": "控制",
			"rarity": CARD_RARITY_BLUE,
			"description": "拖到区域释放，造成25点伤害，并让范围内敌人减速55%，持续6秒。",
			"damage": CRYO_CARD_DEFAULT_DAMAGE,
			"radius": CRYO_CARD_DEFAULT_RADIUS,
			"slow_multiplier": CRYO_CARD_DEFAULT_SLOW_MULTIPLIER,
			"duration": CRYO_CARD_DEFAULT_DURATION,
		},
		{
			"id": "fortify",
			"name": "基地加固",
			"type_label": "防御",
			"rarity": CARD_RARITY_PURPLE,
			"description": "基地生命上限提高2点，并修复4点生命，适合长关卡。",
			"max_hp": FORTIFY_DEFAULT_MAX_HP_GAIN,
			"heal": FORTIFY_DEFAULT_HEAL,
		},
		{
			"id": "firestorm",
			"name": "全屏火焰",
			"type_label": "攻击",
			"rarity": CARD_RARITY_GOLD,
			"description": "拖出后显示打击范围；释放时灼烧全屏敌人，造成135点伤害。",
			"damage": FIRESTORM_CARD_DEFAULT_DAMAGE,
			"radius": FIRESTORM_CARD_DEFAULT_RADIUS,
			"sell_value": 36,
		},
		{
			"id": "global_freeze",
			"name": "冻结全屏",
			"type_label": "控制",
			"rarity": CARD_RARITY_GOLD,
			"description": "拖出后显示打击范围；释放时冻结全屏敌人，造成10点伤害并大幅减速。",
			"damage": GLOBAL_FREEZE_CARD_DEFAULT_DAMAGE,
			"radius": GLOBAL_FREEZE_CARD_DEFAULT_RADIUS,
			"slow_multiplier": GLOBAL_FREEZE_CARD_DEFAULT_SLOW_MULTIPLIER,
			"duration": GLOBAL_FREEZE_CARD_DEFAULT_DURATION,
			"sell_value": 36,
		},
		{
			"id": "risky_cache",
			"name": "不稳定补给",
			"type_label": "概率",
			"rarity": CARD_RARITY_RED,
			"description": "25%概率获得180金币；否则获得35金币并让基地受1点伤害。",
			"jackpot_chance": RISKY_CACHE_DEFAULT_JACKPOT_CHANCE,
			"jackpot_gold": RISKY_CACHE_DEFAULT_JACKPOT_GOLD,
			"fallback_gold": RISKY_CACHE_DEFAULT_FALLBACK_GOLD,
			"fallback_damage": RISKY_CACHE_DEFAULT_FALLBACK_DAMAGE,
			"sell_value": 30,
		},
		{
			"id": "bait_beacon",
			"name": "诱饵信标",
			"type_label": "操控",
			"rarity": CARD_RARITY_BLUE,
			"description": "拖到地图上释放，牵引附近敌人向信标靠拢，方便聚怪打爆发。",
			"radius": BAIT_BEACON_DEFAULT_RADIUS,
			"duration": BAIT_BEACON_DEFAULT_DURATION,
			"strength": BAIT_BEACON_DEFAULT_STRENGTH,
			"sell_value": 32,
		},
		{
			"id": "road_spikes",
			"name": "尖刺路障",
			"type_label": "陷阱",
			"rarity": CARD_RARITY_WHITE,
			"description": "拖到路径附近部署，前4个踩中的敌人受到伤害并短暂减速。",
			"damage": ROAD_SPIKE_DEFAULT_DAMAGE,
			"radius": ROAD_SPIKE_DEFAULT_RADIUS,
			"charges": ROAD_SPIKE_DEFAULT_CHARGES,
			"slow_multiplier": ROAD_SPIKE_DEFAULT_SLOW_MULTIPLIER,
			"duration": ROAD_SPIKE_DEFAULT_DURATION,
			"sell_value": 30,
		},
		{
			"id": "coin_magnet",
			"name": "战利品磁铁",
			"type_label": "资源",
			"rarity": CARD_RARITY_BLUE,
			"description": "12秒内击杀金币提高45%，适合在敌人密集时使用。",
			"bonus_ratio": COIN_MAGNET_DEFAULT_BONUS_RATIO,
			"duration": COIN_MAGNET_DEFAULT_DURATION,
			"sell_value": 34,
		},
		{
			"id": "time_warp",
			"name": "时间裂隙",
			"type_label": "风险",
			"rarity": CARD_RARITY_PURPLE,
			"description": "拖到区域释放：区域内敌人减速，区域外敌人短暂加速。",
			"radius": TIME_WARP_DEFAULT_RADIUS,
			"slow_multiplier": TIME_WARP_DEFAULT_SLOW_MULTIPLIER,
			"haste_multiplier": TIME_WARP_DEFAULT_HASTE_MULTIPLIER,
			"duration": TIME_WARP_DEFAULT_DURATION,
			"sell_value": 34,
		},
		{
			"id": "tower_swap",
			"name": "塔位调度",
			"type_label": "战术",
			"rarity": CARD_RARITY_BLUE,
			"description": "拖到一座塔附近释放，让该塔短时间提高攻速和伤害。",
			"radius": TOWER_SWAP_DEFAULT_RADIUS,
			"damage_multiplier": TOWER_SWAP_DEFAULT_DAMAGE_MULTIPLIER,
			"fire_rate_multiplier": TOWER_SWAP_DEFAULT_FIRE_RATE_MULTIPLIER,
			"duration": TOWER_SWAP_DEFAULT_DURATION,
			"sell_value": 30,
		},
		{
			"id": "overload_debt",
			"name": "透支超频",
			"type_label": "风险",
			"rarity": CARD_RARITY_RED,
			"description": "全塔短时间大幅增强，结束后会短暂降速。",
			"damage_multiplier": OVERLOAD_DEBT_DEFAULT_DAMAGE_MULTIPLIER,
			"fire_rate_multiplier": OVERLOAD_DEBT_DEFAULT_FIRE_RATE_MULTIPLIER,
			"duration": OVERLOAD_DEBT_DEFAULT_DURATION,
			"debt_multiplier": OVERLOAD_DEBT_DEFAULT_DEBT_MULTIPLIER,
			"debt_duration": OVERLOAD_DEBT_DEFAULT_DEBT_DURATION,
			"sell_value": 38,
		},
		{
			"id": "panic_button",
			"name": "紧急按钮",
			"type_label": "救急",
			"rarity": CARD_RARITY_GOLD,
			"description": "基地低血量时触发全屏缓冲并大量修复，否则只小幅修复。",
			"low_health_ratio": PANIC_BUTTON_DEFAULT_LOW_HEALTH_RATIO,
			"heal": PANIC_BUTTON_DEFAULT_HEAL,
			"panic_heal": PANIC_BUTTON_DEFAULT_PANIC_HEAL,
			"slow_multiplier": PANIC_BUTTON_DEFAULT_SLOW_MULTIPLIER,
			"duration": PANIC_BUTTON_DEFAULT_DURATION,
			"sell_value": 32,
		},
		{
			"id": "bounty_mark",
			"name": "悬赏标记",
			"type_label": "资源",
			"rarity": CARD_RARITY_PURPLE,
			"description": "拖到区域释放，标记范围内生命最高的敌人，击杀额外获得金币。",
			"radius": BOUNTY_MARK_DEFAULT_RADIUS,
			"bonus_gold": BOUNTY_MARK_DEFAULT_BONUS_GOLD,
			"sell_value": 36,
		},
		{
			"id": "reroll_cache",
			"name": "战术改签",
			"type_label": "手牌",
			"rarity": CARD_RARITY_GOLD,
			"description": "使用后丢弃最左侧旧手牌，并补入一张新的奖励卡。",
			"sell_value": 24,
		},
	]


func _normalize_reward_card(card: Dictionary) -> Dictionary:
	var source := card.duplicate(true)
	var card_id := _normalize_reward_card_id(str(source.get("id", "")))
	if not _is_known_reward_card_id(card_id):
		card_id = _normalize_reward_card_id(str(source.get("card_id", "")))
	var has_known_source_id := _is_known_reward_card_id(card_id)
	card_id = _sanitize_reward_card_id(card_id)

	var defaults := _get_reward_card_definition(card_id)
	var normalized := defaults.duplicate(true)
	if has_known_source_id:
		for key in source.keys():
			normalized[key] = source[key]
	normalized["id"] = card_id
	normalized["card_id"] = card_id
	normalized["rarity"] = _sanitize_reward_card_rarity(normalized.get("rarity", CARD_RARITY_WHITE), defaults.get("rarity", CARD_RARITY_WHITE))
	_sanitize_reward_card_numeric_fields(normalized)
	if not bool(normalized.get("_rarity_scaled", false)):
		_apply_reward_card_rarity_power(normalized)
		normalized["_rarity_scaled"] = true
	return normalized


func _reward_card_uses_strength_roll(card: Dictionary) -> bool:
	var strength_keys := [
		"multiplier",
		"damage_multiplier",
		"fire_rate_multiplier",
		"slow_multiplier",
		"haste_multiplier",
		"bonus_ratio",
		"strength",
		"jackpot_chance",
	]
	for key in strength_keys:
		if card.has(key):
			return true
	return false


func _roll_reward_card_strength(card: Dictionary, wave: int) -> Dictionary:
	if not _reward_card_uses_strength_roll(card):
		return card
	var rarity := _pick_reward_card_strength_rarity(wave)
	card["rarity"] = rarity
	card["strength_multiplier"] = _get_reward_card_rarity_power(rarity)
	return card


func _pick_reward_card_strength_rarity(wave: int) -> String:
	var level_bonus := clampf(float(current_level_index) * 0.008 + float(maxi(wave - 1, 0)) * 0.004, 0.0, 0.12)
	var roll := randf()
	if roll < 0.42 - level_bonus:
		return CARD_RARITY_WHITE
	if roll < 0.72 - level_bonus * 0.45:
		return CARD_RARITY_BLUE
	if roll < 0.91 - level_bonus * 0.2:
		return CARD_RARITY_PURPLE
	if roll < 0.985:
		return CARD_RARITY_GOLD
	return CARD_RARITY_RED


func _apply_reward_card_rarity_power(card: Dictionary) -> void:
	var power := _get_reward_card_rarity_power(str(card.get("rarity", CARD_RARITY_WHITE)))
	_scale_card_int_fields(card, REWARD_CARD_INT_FIELDS, power)
	_scale_card_float_fields(card, ["duration"], 1.0 + (power - 1.0) * 0.45)
	_scale_card_float_fields(card, ["radius"], 1.0 + (power - 1.0) * 0.25)
	_scale_card_multiplier_fields(card, REWARD_CARD_MULTIPLIER_FIELDS, power)
	_scale_card_ratio_fields(card, REWARD_CARD_RATIO_FIELDS, power)
	_scale_card_float_fields(card, ["strength"], power)
	_scale_card_slow_fields(card, REWARD_CARD_SLOW_FIELDS, power)


func _sanitize_reward_card_numeric_fields(card: Dictionary) -> void:
	_sanitize_reward_card_numeric_field_group(card, REWARD_CARD_INT_FIELDS)
	_sanitize_reward_card_numeric_field_group(card, REWARD_CARD_FLOAT_FIELDS)
	_sanitize_reward_card_numeric_field_group(card, REWARD_CARD_MULTIPLIER_FIELDS)
	_sanitize_reward_card_numeric_field_group(card, REWARD_CARD_RATIO_FIELDS)
	_sanitize_reward_card_numeric_field_group(card, REWARD_CARD_SLOW_FIELDS)


func _sanitize_reward_card_numeric_field_group(card: Dictionary, keys: Array[String]) -> void:
	for key in keys:
		_get_numeric_reward_card_field(card, key)


func _scale_card_int_fields(card: Dictionary, keys: Array[String], power: float) -> void:
	for key in keys:
		var value: Variant = _get_numeric_reward_card_field(card, key)
		if value != null:
			card[key] = maxi(1, int(roundi(float(value) * power)))


func _scale_card_float_fields(card: Dictionary, keys: Array[String], power: float) -> void:
	for key in keys:
		var value: Variant = _get_numeric_reward_card_field(card, key)
		if value != null:
			card[key] = snappedf(float(value) * power, 0.05)


func _scale_card_multiplier_fields(card: Dictionary, keys: Array[String], power: float) -> void:
	for key in keys:
		var value: Variant = _get_numeric_reward_card_field(card, key)
		if value != null:
			var base_multiplier := float(value)
			card[key] = snappedf(1.0 + (base_multiplier - 1.0) * power, 0.01)


func _scale_card_ratio_fields(card: Dictionary, keys: Array[String], power: float) -> void:
	for key in keys:
		var value: Variant = _get_numeric_reward_card_field(card, key)
		if value != null:
			card[key] = clampf(snappedf(float(value) * power, 0.01), 0.0, 0.95)


func _scale_card_slow_fields(card: Dictionary, keys: Array[String], power: float) -> void:
	for key in keys:
		var value: Variant = _get_numeric_reward_card_field(card, key)
		if value != null:
			var base_multiplier := float(value)
			card[key] = clampf(snappedf(1.0 - (1.0 - base_multiplier) * power, 0.01), 0.12, 1.0)


func _get_numeric_reward_card_field(card: Dictionary, key: String):
	if not card.has(key):
		return null
	var raw_value: Variant = card[key]
	if raw_value is int or raw_value is float:
		return raw_value
	_restore_reward_card_default_field(card, key)
	raw_value = card.get(key)
	if raw_value is int or raw_value is float:
		return raw_value
	return null


func _restore_reward_card_default_field(card: Dictionary, key: String) -> void:
	var card_id := _sanitize_reward_card_id(card.get("id", DEFAULT_REWARD_CARD_ID))
	var defaults := _get_reward_card_definition(card_id)
	if defaults.has(key):
		card[key] = defaults[key]
	else:
		card.erase(key)


func _sanitize_reward_card_rarity(raw_rarity: Variant, fallback_rarity: Variant = CARD_RARITY_WHITE) -> String:
	var rarity := str(raw_rarity).strip_edges().to_lower()
	if _is_valid_reward_card_rarity(rarity):
		return rarity
	var fallback := str(fallback_rarity).strip_edges().to_lower()
	if _is_valid_reward_card_rarity(fallback):
		return fallback
	return CARD_RARITY_WHITE


func _is_valid_reward_card_rarity(rarity: String) -> bool:
	return CARD_RARITIES.has(rarity)


func _get_reward_card_rarity_power(rarity: String) -> float:
	match _sanitize_reward_card_rarity(rarity):
		CARD_RARITY_BLUE:
			return CARD_RARITY_BLUE_POWER
		CARD_RARITY_PURPLE:
			return CARD_RARITY_PURPLE_POWER
		CARD_RARITY_GOLD:
			return CARD_RARITY_GOLD_POWER
		CARD_RARITY_RED:
			return CARD_RARITY_RED_POWER
		_:
			return CARD_RARITY_WHITE_POWER


func _get_reward_card_display_name(card: Dictionary) -> String:
	var source_display_name := str(card.get("name", "")).strip_edges()
	if not source_display_name.is_empty():
		return source_display_name
	var normalized_card := _normalize_reward_card(card)
	var display_name := str(normalized_card.get("name", "")).strip_edges()
	return display_name if not display_name.is_empty() else _get_default_reward_card_display_name()


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
		"firestorm", "flame", "fire_all", "burn_all":
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


func _sanitize_reward_card_id(raw_id: Variant, fallback_id: String = DEFAULT_REWARD_CARD_ID) -> String:
	var card_id := _normalize_reward_card_id(str(raw_id))
	if _is_known_reward_card_id(card_id):
		return card_id
	return fallback_id if _is_known_reward_card_id(fallback_id) else DEFAULT_REWARD_CARD_ID


func _is_known_reward_card_id(card_id: String) -> bool:
	for card in _get_reward_card_pool():
		var reward_card := card as Dictionary
		if str(reward_card.get("id", "")) == card_id:
			return true
	return false


func _get_reward_card_definition(card_id: String) -> Dictionary:
	var safe_card_id := _normalize_reward_card_id(card_id)
	for card in _get_reward_card_pool():
		var reward_card := card as Dictionary
		if str(reward_card.get("id", "")) == safe_card_id:
			var card_snapshot := reward_card.duplicate(true)
			return card_snapshot
	return {}


func _on_reward_card_play_requested(card_index: int, drop_position: Vector2) -> void:
	if is_game_paused or is_game_over:
		ui.reject_dragged_card()
		return

	if card_index < 0 or card_index >= _card_hand.size():
		ui.reject_dragged_card()
		return

	if not _pending_reward_card.is_empty():
		_message = _get_pending_card_blocks_play_message_text()
		ui.reject_dragged_card()
		_refresh_ui()
		return

	var card := _card_hand[card_index]
	var card_id := _normalize_reward_card_id(str(_normalize_reward_card(card).get("id", "")))
	if card_id == "reroll_cache":
		if _apply_reroll_cache_card(card_index):
			ui.update_card_hand(_card_hand, _pending_reward_card, false)
		else:
			ui.reject_dragged_card()
		_refresh_ui()
		return

	var world_drop_position := screen_to_world(drop_position)
	if _apply_reward_card(card, world_drop_position):
		_card_hand.remove_at(card_index)
		ui.consume_card_and_refresh(card_index, _card_hand, _pending_reward_card, not _pending_reward_card.is_empty())
	else:
		ui.reject_dragged_card()
	_refresh_ui()


func _on_reward_card_discard_requested(card_index: int) -> void:
	if is_game_paused or is_game_over:
		ui.update_card_hand(_card_hand, _pending_reward_card, not _pending_reward_card.is_empty())
		return

	if _pending_reward_card.is_empty() or card_index < 0 or card_index >= _card_hand.size():
		ui.update_card_hand(_card_hand, _pending_reward_card, not _pending_reward_card.is_empty())
		return

	var discarded_name := _get_reward_card_display_name(_card_hand[card_index])
	var kept_card := _normalize_reward_card(_pending_reward_card)
	_card_hand.remove_at(card_index)
	_card_hand.append(kept_card)
	var kept_name := _get_reward_card_display_name(kept_card)
	_pending_reward_card.clear()
	_pending_reward_timeout = 0.0
	_clear_reward_card_effect_state()
	_message = _format_reward_card_replaced_message_text(discarded_name, kept_name)
	ui.update_card_hand(_card_hand, _pending_reward_card, false)
	_refresh_ui()


func _on_reward_card_reject_requested() -> void:
	_reject_pending_reward_card(_get_pending_card_rejected_message_text())


func _reject_pending_reward_card(message: String) -> void:
	if _pending_reward_card.is_empty():
		return
	_pending_reward_card.clear()
	_pending_reward_timeout = 0.0
	_message = message
	ui.update_card_hand(_card_hand, _pending_reward_card, false)
	_refresh_ui()


func _on_reward_card_sell_requested(card_index: int) -> void:
	if is_game_paused or is_game_over:
		ui.reject_dragged_card()
		return
	if not _pending_reward_card.is_empty():
		_message = _get_pending_card_blocks_sell_message_text()
		ui.reject_dragged_card()
		_refresh_ui()
		return
	if card_index < 0 or card_index >= _card_hand.size():
		ui.reject_dragged_card()
		return

	var sold_card := _normalize_reward_card(_card_hand[card_index])
	var sell_value := _get_reward_card_sell_value(sold_card)
	_card_hand.remove_at(card_index)
	add_gold(sell_value)
	_message = _format_reward_card_sold_message_text(sell_value)
	ui.consume_card_and_refresh(card_index, _card_hand, _pending_reward_card, false, "CardSellParticles")
	_refresh_ui()


func _apply_reward_card(card: Dictionary, drop_position: Vector2 = Vector2.ZERO) -> bool:
	var normalized_card := _normalize_reward_card(card)
	var card_id := _normalize_reward_card_id(str(normalized_card.get("id", "")))
	match card_id:
		"tower_boost":
			var multiplier := _get_tower_boost_card_multiplier(normalized_card)
			var duration := _get_tower_boost_card_duration(normalized_card)
			var boosted := _for_each_valid_active_tower(func(tower: Tower) -> void:
				tower.apply_damage_boost(multiplier, duration)
			)
			spawn_area_particles(get_base_position(), 78.0, Color(1.0, 0.78, 0.24), 34, "TowerBoostParticles")
			_message = _format_damage_boost_card_message_text(boosted, duration)
			return _finish_reward_card_success(card_id, drop_position, normalized_card)
		"range_boost":
			var multiplier := _get_range_boost_card_multiplier(normalized_card)
			var duration := _get_range_boost_card_duration(normalized_card)
			var boosted := _for_each_valid_active_tower(func(tower: Tower) -> void:
				tower.apply_range_boost(multiplier, duration)
			)
			spawn_area_particles(get_base_position(), 96.0, Color(0.46, 0.78, 1.0), 34, "RangeBoostParticles")
			_message = _format_range_boost_card_message_text(boosted, duration)
			return _finish_reward_card_success(card_id, drop_position, normalized_card)
		"fire_rate_boost":
			var multiplier := _get_fire_rate_boost_card_multiplier(normalized_card)
			var duration := _get_fire_rate_boost_card_duration(normalized_card)
			var boosted := _for_each_valid_active_tower(func(tower: Tower) -> void:
				tower.apply_fire_rate_boost(multiplier, duration)
			)
			spawn_area_particles(get_base_position(), 72.0, Color(0.58, 1.0, 0.70), 34, "FireRateBoostParticles")
			_message = _format_fire_rate_boost_card_message_text(boosted, duration)
			return _finish_reward_card_success(card_id, drop_position, normalized_card)
		"heal":
			var heal_amount := _get_heal_card_amount(normalized_card)
			var before := base_health
			base_health = mini(base_health + heal_amount, max_base_health)
			spawn_area_particles(get_base_position(), 58.0, Color(0.50, 1.0, 0.58), 28, "HealParticles")
			_message = _format_heal_card_message_text(base_health - before)
			return _finish_reward_card_success(card_id, drop_position, normalized_card)
		"missile":
			var radius := _get_missile_card_radius(normalized_card)
			var damage_amount := _get_missile_card_damage(normalized_card)
			var center := _clamp_to_play_area(drop_position)
			var hit_count := _damage_enemies_in_radius(center, radius, damage_amount)
			if hit_count <= 0:
				_message = _get_missile_card_empty_message_text()
				return false
			return _finish_area_reward_card_success(card_id, drop_position, normalized_card, center, radius, Color(1.0, 0.46, 0.14), Color(1.0, 0.88, 0.35), radius, 56, "MissileCardParticles", _format_missile_card_hit_message_text(hit_count))
		"cryo":
			var radius := _get_cryo_card_radius(normalized_card)
			var damage_amount := _get_cryo_card_damage(normalized_card)
			var slow_multiplier := _get_cryo_card_slow_multiplier(normalized_card)
			var duration := _get_cryo_card_duration(normalized_card)
			var center := _clamp_to_play_area(drop_position)
			var hit_count := _damage_and_slow_enemies_in_radius(center, radius, damage_amount, slow_multiplier, duration)
			if hit_count <= 0:
				_message = _get_cryo_card_empty_message_text()
				return false
			return _finish_area_reward_card_success(card_id, drop_position, normalized_card, center, radius, Color(0.46, 0.86, 1.0), Color(0.84, 1.0, 1.0), radius, 56, "CryoCardParticles", _format_cryo_card_hit_message_text(hit_count))
		"firestorm":
			var damage_amount := _get_firestorm_card_damage(normalized_card)
			var hit_count := _damage_all_enemies(damage_amount)
			if hit_count <= 0:
				_message = _get_firestorm_card_empty_message_text()
				return false
			var center := get_map_center_position()
			var visual_radius := get_map_half_max_dimension()
			return _finish_area_reward_card_success(card_id, drop_position, normalized_card, center, visual_radius, Color(1.0, 0.30, 0.12), Color(1.0, 0.82, 0.22), 180.0, 72, "FirestormParticles", _format_firestorm_card_hit_message_text(hit_count))
		"global_freeze":
			var damage_amount := _get_global_freeze_card_damage(normalized_card)
			var slow_multiplier := _get_global_freeze_card_slow_multiplier(normalized_card)
			var duration := _get_global_freeze_card_duration(normalized_card)
			var hit_count := _damage_and_slow_all_enemies(damage_amount, slow_multiplier, duration)
			if hit_count <= 0:
				_message = _get_global_freeze_card_empty_message_text()
				return false
			var center := get_map_center_position()
			var visual_radius := get_map_half_max_dimension()
			return _finish_area_reward_card_success(card_id, drop_position, normalized_card, center, visual_radius, Color(0.52, 0.86, 1.0), Color(0.88, 1.0, 1.0), 180.0, 72, "GlobalFreezeParticles", _format_global_freeze_card_hit_message_text(hit_count))
		"bait_beacon":
			var radius := _get_bait_beacon_card_radius(normalized_card)
			var duration := _get_bait_beacon_card_duration(normalized_card)
			var strength := _get_bait_beacon_card_strength(normalized_card)
			var center := _clamp_to_play_area(drop_position)
			var hit_count := _attract_enemies_in_radius(center, radius, duration, strength)
			if hit_count <= 0:
				_message = _get_bait_beacon_card_empty_message_text()
				return false
			return _finish_area_reward_card_success(card_id, drop_position, normalized_card, center, radius, Color(1.0, 0.78, 0.22), Color(1.0, 0.95, 0.48), radius, 58, "BaitBeaconParticles", _format_bait_beacon_card_hit_message_text(hit_count))
		"road_spikes":
			var center := _clamp_to_play_area(drop_position)
			var radius := _get_road_spike_card_radius(normalized_card)
			_road_spike_traps.append({
				"position": center,
				"radius": radius,
				"damage": _get_road_spike_card_damage(normalized_card),
				"charges": _get_road_spike_card_charges(normalized_card),
				"slow_multiplier": _get_road_spike_card_slow_multiplier(normalized_card),
				"time": _get_road_spike_card_duration(normalized_card),
				"hit_ids": {},
			})
			return _finish_area_reward_card_success(card_id, drop_position, normalized_card, center, radius, Color(0.90, 0.64, 0.30), Color(1.0, 0.84, 0.42), radius, 34, "RoadSpikesParticles", _get_road_spikes_card_message_text())
		"coin_magnet":
			var duration := _get_coin_magnet_card_duration(normalized_card)
			var bonus_ratio := _get_coin_magnet_card_bonus_ratio(normalized_card)
			_coin_magnet_timer = maxf(_coin_magnet_timer, duration)
			_coin_magnet_bonus_ratio = maxf(_coin_magnet_bonus_ratio, bonus_ratio)
			spawn_area_particles(get_base_position(), 88.0, Color(1.0, 0.86, 0.24), 44, "CoinMagnetParticles")
			_message = _format_coin_magnet_card_message_text(duration, int(roundi(bonus_ratio * 100.0)))
			return _finish_reward_card_success(card_id, drop_position, normalized_card)
		"time_warp":
			var radius := _get_time_warp_card_radius(normalized_card)
			var center := _clamp_to_play_area(drop_position)
			var hit_count := _apply_time_warp(
				center,
				radius,
				_get_time_warp_card_slow_multiplier(normalized_card),
				_get_time_warp_card_haste_multiplier(normalized_card),
				_get_time_warp_card_duration(normalized_card)
			)
			if hit_count <= 0:
				_message = _get_time_warp_card_empty_message_text()
				return false
			return _finish_area_reward_card_success(card_id, drop_position, normalized_card, center, radius, Color(0.70, 0.46, 1.0), Color(0.94, 0.82, 1.0), radius, 60, "TimeWarpParticles", _format_time_warp_card_hit_message_text(hit_count))
		"tower_swap":
			var tower := _find_tower_near(drop_position, _get_tower_swap_card_radius(normalized_card))
			if tower == null:
				_message = _get_tower_swap_card_empty_message_text()
				return false
			var duration := _get_tower_swap_card_duration(normalized_card)
			tower.apply_damage_boost(_get_tower_swap_card_damage_multiplier(normalized_card), duration)
			tower.apply_fire_rate_boost(_get_tower_swap_card_fire_rate_multiplier(normalized_card), duration)
			spawn_area_particles(tower.global_position, 64.0, Color(0.52, 1.0, 0.78), 36, "TowerSwapParticles")
			_message = _get_tower_swap_card_hit_message_text()
			return _finish_reward_card_success(card_id, tower.global_position, normalized_card)
		"overload_debt":
			var duration := _get_overload_debt_card_duration(normalized_card)
			var damage_multiplier := _get_overload_debt_card_damage_multiplier(normalized_card)
			var fire_rate_multiplier := _get_overload_debt_card_fire_rate_multiplier(normalized_card)
			_for_each_valid_active_tower(func(tower: Tower) -> void:
				tower.apply_damage_boost(damage_multiplier, duration)
				tower.apply_fire_rate_boost(fire_rate_multiplier, duration)
			)
			_overload_debt_timer = duration
			_overload_debt_multiplier = _get_overload_debt_card_debt_multiplier(normalized_card)
			_overload_debt_duration = _get_overload_debt_card_debt_duration(normalized_card)
			spawn_area_particles(get_base_position(), 100.0, Color(1.0, 0.36, 0.70), 62, "OverloadDebtParticles")
			_message = _format_overload_debt_card_message_text(duration)
			return _finish_reward_card_success(card_id, drop_position, normalized_card)
		"panic_button":
			var low_health_ratio := _get_panic_button_card_low_health_ratio(normalized_card)
			var is_panic := float(base_health) / float(maxi(max_base_health, 1)) <= low_health_ratio
			var heal_amount := _get_panic_button_card_panic_heal(normalized_card) if is_panic else _get_panic_button_card_heal(normalized_card)
			base_health = mini(base_health + heal_amount, max_base_health)
			if is_panic:
				_damage_and_slow_all_enemies(0, _get_panic_button_card_slow_multiplier(normalized_card), _get_panic_button_card_duration(normalized_card))
			spawn_area_particles(get_base_position(), 118.0 if is_panic else 68.0, Color(1.0, 0.92, 0.36), 64 if is_panic else 32, "PanicButtonParticles")
			_message = _get_panic_button_card_message_text()
			return _finish_reward_card_success(card_id, drop_position, normalized_card)
		"bounty_mark":
			var radius := _get_bounty_mark_card_radius(normalized_card)
			var center := _clamp_to_play_area(drop_position)
			var target := _find_highest_health_enemy_in_radius(center, radius)
			if target == null:
				_message = _get_bounty_mark_card_empty_message_text()
				return false
			_bounty_enemy_id = target.get_instance_id()
			_bounty_bonus_gold = _get_bounty_mark_card_bonus_gold(normalized_card)
			spawn_area_particles(target.global_position, 56.0, Color(1.0, 0.76, 0.18), 38, "BountyMarkParticles")
			_message = _format_bounty_mark_card_hit_message_text(target.enemy_name, _bounty_bonus_gold)
			return _finish_reward_card_success(card_id, target.global_position, normalized_card)
		"gold":
			var gold_amount := _get_gold_card_amount(normalized_card)
			add_gold(gold_amount)
			spawn_particle_burst(get_base_position(), {
				"name": "GoldCardParticles",
				"amount": 32,
				"lifetime": 0.62,
				"emission_radius": 18.0,
				"velocity_min": 32.0,
				"velocity_max": 130.0,
				"scale_min": 1.0,
				"scale_max": 2.8,
				"gravity": Vector2(0.0, -180.0),
				"color": Color(1.0, 0.84, 0.24),
			})
			_message = _format_gold_card_message_text(gold_amount)
			return _finish_reward_card_success(card_id, drop_position, normalized_card)
		"risky_cache":
			var chance := _get_risky_cache_card_jackpot_chance(normalized_card)
			if randf() <= chance:
				var jackpot_gold := _get_risky_cache_card_jackpot_gold(normalized_card)
				add_gold(jackpot_gold)
				spawn_area_particles(get_base_position(), 84.0, Color(1.0, 0.82, 0.28), 44, "GoldBurstParticles")
				_message = _format_risky_cache_success_message_text(jackpot_gold)
			else:
				var fallback_gold := _get_risky_cache_card_fallback_gold(normalized_card)
				var fallback_damage := _get_risky_cache_card_fallback_damage(normalized_card)
				add_gold(fallback_gold)
				_apply_base_damage(fallback_damage)
				_message = _format_risky_cache_failure_message_text(fallback_gold, fallback_damage)
			return _finish_reward_card_success(card_id, drop_position, normalized_card)
		"fortify":
			var max_hp_gain := _get_fortify_card_max_hp_gain(normalized_card)
			var heal_amount := _get_fortify_card_heal(normalized_card)
			max_base_health += max_hp_gain
			base_health = mini(base_health + heal_amount, max_base_health)
			spawn_area_particles(get_base_position(), 74.0, Color(0.62, 0.92, 1.0), 36, "FortifyParticles")
			_message = _format_fortify_card_message_text(max_hp_gain, heal_amount)
			return _finish_reward_card_success(card_id, drop_position, normalized_card)
		_:
			_message = _get_unknown_reward_card_message_text()
			return false


func _for_each_valid_active_tower(action: Callable) -> int:
	var applied_count := 0
	for tower in _collect_valid_active_towers():
		action.call(tower)
		applied_count += 1
	return applied_count


func _is_valid_active_tower(tower: Tower) -> bool:
	return tower != null and is_instance_valid(tower)


func _collect_valid_active_towers() -> Array[Tower]:
	var towers: Array[Tower] = []
	for tower in get_active_towers():
		if _is_valid_active_tower(tower):
			towers.append(tower)
	return towers


func _finish_area_reward_card_success(
	card_id: String,
	drop_position: Vector2,
	card: Dictionary,
	center: Vector2,
	visual_radius: float,
	area_color: Color,
	accent_color: Color,
	particle_radius: float,
	particle_amount: int,
	particle_name: String,
	message: String
) -> bool:
	_show_world_area_effect(center, visual_radius, area_color, accent_color)
	spawn_area_particles(center, particle_radius, area_color, particle_amount, particle_name)
	_message = message
	return _finish_reward_card_success(card_id, drop_position, card)


func _finish_reward_card_success(card_id: String, drop_position: Vector2, card: Dictionary) -> bool:
	_spawn_reward_card_release_effect(card_id, drop_position, card)
	return true


func _spawn_reward_card_release_effect(card_id: String, drop_position: Vector2, card: Dictionary) -> void:
	var release_position := _get_reward_card_release_position(card_id, drop_position)
	var release_style := _get_reward_card_release_style(card_id, card)
	var release_color: Color = release_style.get("color", _get_reward_card_rarity_color(str(card.get("rarity", CARD_RARITY_WHITE))))
	var release_profile := str(release_style.get("profile", "card_release"))
	var release_direction: Vector2 = release_style.get("direction", Vector2.RIGHT)
	var release_duration := float(release_style.get("duration", 0.42))
	var release_radius := _get_reward_card_release_radius(card_id, card)
	var effect_parent := world_overlay_layer if world_overlay_layer != null else impact_layer
	if effect_parent != null:
		ImpactEffect.spawn(effect_parent, release_position, {
			"name": "CardReleaseEffect",
			"profile": release_profile,
			"radius": release_radius,
			"direction": release_direction,
			"duration": release_duration,
			"width": 2.0,
			"spread_angle": 1.10,
			"color": release_color,
			"z_index": WORLD_LAYER_OVERLAY + 4,
		})

	spawn_particle_burst(release_position, _get_reward_card_release_particle_config(release_color, release_radius, release_profile, release_direction))


func _get_reward_card_release_position(card_id: String, drop_position: Vector2) -> Vector2:
	match card_id:
		"firestorm", "global_freeze":
			return get_map_center_position()
		"tower_boost", "range_boost", "fire_rate_boost", "heal", "gold", "risky_cache", "fortify", "coin_magnet", "overload_debt", "panic_button":
			return get_base_position()
		_:
			return _clamp_to_play_area(drop_position)


func _get_reward_card_release_style(card_id: String, card: Dictionary) -> Dictionary:
	var style := {
		"profile": "card_release",
		"color": _get_reward_card_rarity_color(str(card.get("rarity", CARD_RARITY_WHITE))),
		"direction": Vector2.RIGHT,
		"duration": 0.42,
	}
	match card_id:
		"missile", "firestorm":
			style["profile"] = "card_attack"
		"cryo", "global_freeze":
			style["profile"] = "card_freeze"
		"tower_boost", "range_boost", "fire_rate_boost", "tower_swap", "overload_debt":
			style["profile"] = "card_buff"
		"heal", "fortify", "panic_button":
			style["profile"] = "card_guard"
		"gold", "coin_magnet", "risky_cache", "bounty_mark":
			style["profile"] = "card_gold"
		"road_spikes":
			style["profile"] = "card_trap"
		"bait_beacon":
			style["profile"] = "card_beacon"
		"time_warp":
			style["profile"] = "card_warp"

	match card_id:
		"missile":
			style["color"] = Color(1.0, 0.44, 0.16)
		"firestorm":
			style["color"] = Color(1.0, 0.25, 0.10)
		"cryo", "global_freeze":
			style["color"] = Color(0.52, 0.88, 1.0)
		"tower_boost":
			style["color"] = Color(1.0, 0.78, 0.24)
		"range_boost":
			style["color"] = Color(0.46, 0.78, 1.0)
		"fire_rate_boost", "tower_swap":
			style["color"] = Color(0.58, 1.0, 0.70)
		"overload_debt":
			style["color"] = Color(1.0, 0.36, 0.70)
		"heal", "fortify", "panic_button":
			style["color"] = Color(0.62, 1.0, 0.76)
		"gold", "coin_magnet", "risky_cache", "bounty_mark":
			style["color"] = Color(1.0, 0.82, 0.22)
		"road_spikes":
			style["color"] = Color(0.92, 0.62, 0.30)
		"bait_beacon":
			style["color"] = Color(1.0, 0.76, 0.28)
		"time_warp":
			style["color"] = Color(0.74, 0.48, 1.0)

	match card_id:
		"missile", "firestorm", "road_spikes":
			style["direction"] = Vector2.DOWN
		"gold", "coin_magnet", "bounty_mark":
			style["direction"] = Vector2.UP

	match card_id:
		"firestorm", "global_freeze", "overload_debt", "panic_button":
			style["duration"] = 0.66
		"missile", "cryo", "time_warp":
			style["duration"] = 0.52

	return style


func _get_reward_card_rarity_color(rarity: String) -> Color:
	match _sanitize_reward_card_rarity(rarity):
		CARD_RARITY_BLUE:
			return Color(0.40, 0.72, 1.0)
		CARD_RARITY_PURPLE:
			return Color(0.74, 0.48, 1.0)
		CARD_RARITY_GOLD:
			return Color(1.0, 0.78, 0.24)
		CARD_RARITY_RED:
			return Color(1.0, 0.34, 0.24)
		_:
			return Color(0.92, 0.94, 0.96)


func _get_reward_card_release_radius(card_id: String, card: Dictionary) -> float:
	match card_id:
		"firestorm", "global_freeze":
			return minf(get_map_max_dimension() * 0.34, 260.0)
		"missile", "cryo", "bait_beacon", "time_warp", "bounty_mark":
			if card_id == "bait_beacon":
				return _get_bait_beacon_card_radius(card)
			if card_id == "time_warp":
				return _get_time_warp_card_radius(card)
			if card_id == "bounty_mark":
				return _get_bounty_mark_card_radius(card)
			if card_id == "missile":
				return _get_missile_card_radius(card)
			if card_id == "cryo":
				return _get_cryo_card_radius(card)
			return float(card.get("radius", 96.0))
		"tower_swap":
			return _get_tower_swap_card_radius(card)
		"road_spikes":
			return maxf(_get_road_spike_card_radius(card), 58.0)
		"overload_debt", "panic_button":
			return 120.0
		_:
			return 78.0


func _get_reward_card_release_particle_config(color: Color, radius: float, profile: String, direction: Vector2) -> Dictionary:
	var config := {
		"name": "CardReleaseParticles",
		"amount": 24,
		"lifetime": 0.46,
		"emission_radius": minf(radius * 0.18, 28.0),
		"direction": direction,
		"spread": 150.0,
		"velocity_min": 28.0,
		"velocity_max": 118.0,
		"scale_min": 0.7,
		"scale_max": 1.8,
		"gravity": Vector2.ZERO,
		"color": color,
		"z_index": WORLD_LAYER_OVERLAY + 6,
		"important": true,
	}
	match profile:
		"card_attack":
			config.merge({
				"amount": 42,
				"lifetime": 0.58,
				"spread": 72.0,
				"velocity_min": 80.0,
				"velocity_max": 220.0,
				"gravity": Vector2(0.0, 260.0),
				"scale_max": 3.0,
			}, true)
		"card_freeze":
			config.merge({
				"amount": 38,
				"lifetime": 0.72,
				"spread": 180.0,
				"velocity_min": 18.0,
				"velocity_max": 92.0,
				"gravity": Vector2(0.0, -40.0),
				"scale_max": 2.2,
			}, true)
		"card_gold":
			config.merge({
				"amount": 32,
				"lifetime": 0.62,
				"direction": Vector2.UP,
				"spread": 84.0,
				"velocity_min": 38.0,
				"velocity_max": 145.0,
				"gravity": Vector2(0.0, -170.0),
			}, true)
		"card_trap":
			config.merge({
				"amount": 26,
				"lifetime": 0.40,
				"direction": Vector2.DOWN,
				"spread": 48.0,
				"velocity_min": 44.0,
				"velocity_max": 130.0,
				"gravity": Vector2(0.0, 320.0),
			}, true)
		"card_warp":
			config.merge({
				"amount": 46,
				"lifetime": 0.78,
				"spread": 180.0,
				"velocity_min": 16.0,
				"velocity_max": 86.0,
				"angular_velocity_min": -220.0,
				"angular_velocity_max": 220.0,
			}, true)
	return config


func _is_valid_active_enemy(enemy: Enemy) -> bool:
	return enemy != null and is_instance_valid(enemy) and not enemy.is_dead and not enemy.has_reached_end


func _collect_valid_active_enemies() -> Array[Enemy]:
	var enemies: Array[Enemy] = []
	for enemy in get_active_enemies():
		if _is_valid_active_enemy(enemy):
			enemies.append(enemy)
	return enemies


func _collect_valid_active_enemies_in_radius(center: Vector2, radius: float) -> Array[Enemy]:
	var targets: Array[Enemy] = []
	var radius_sq := radius * radius
	for enemy in _collect_valid_active_enemies():
		if center.distance_squared_to(enemy.global_position) <= radius_sq:
			targets.append(enemy)
	return targets


func _find_best_missile_target(radius: float) -> Vector2:
	var enemies := _collect_valid_active_enemies()

	if enemies.is_empty():
		return Vector2.INF

	var radius_sq := radius * radius
	var best_position := enemies[0].global_position
	var best_count := -1
	for candidate in enemies:
		var count := 0
		for enemy in enemies:
			if candidate.global_position.distance_squared_to(enemy.global_position) <= radius_sq:
				count += 1
		if count > best_count:
			best_count = count
			best_position = candidate.global_position
	return best_position


func _get_console_card_auto_use_radius(card: Dictionary) -> float:
	var normalized_card := _normalize_reward_card(card)
	var card_id := _sanitize_reward_card_id(normalized_card.get("id", DEFAULT_REWARD_CARD_ID))
	return _get_reward_card_release_radius(card_id, normalized_card)


func _damage_enemies_in_radius(center: Vector2, radius: float, damage_amount: int) -> int:
	var targets := _collect_valid_active_enemies_in_radius(center, radius)

	for enemy in targets:
		if is_instance_valid(enemy):
			enemy.take_damage(damage_amount)
	return targets.size()


func _damage_and_slow_enemies_in_radius(center: Vector2, radius: float, damage_amount: int, slow_multiplier: float, duration: float) -> int:
	var targets := _collect_valid_active_enemies_in_radius(center, radius)

	for enemy in targets:
		if is_instance_valid(enemy):
			enemy.take_damage(damage_amount)
		if is_instance_valid(enemy):
			enemy.apply_slow(slow_multiplier, duration)
	return targets.size()


func _damage_all_enemies(damage_amount: int) -> int:
	var targets := _collect_valid_active_enemies()
	for enemy in targets:
		enemy.take_damage(damage_amount)
	return targets.size()


func _damage_and_slow_all_enemies(damage_amount: int, slow_multiplier: float, duration: float) -> int:
	var targets := _collect_valid_active_enemies()
	for enemy in targets:
		enemy.take_damage(damage_amount)
		enemy.apply_slow(slow_multiplier, duration)
	return targets.size()


func _update_reward_card_timers(delta: float) -> void:
	if _coin_magnet_timer > 0.0:
		_coin_magnet_timer = maxf(_coin_magnet_timer - delta, 0.0)
		if _coin_magnet_timer <= 0.0:
			_coin_magnet_bonus_ratio = 0.0
	if _overload_debt_timer > 0.0:
		_overload_debt_timer = maxf(_overload_debt_timer - delta, 0.0)
		if _overload_debt_timer <= 0.0:
			_for_each_valid_active_tower(func(tower: Tower) -> void:
				tower.fire_rate_multiplier = minf(tower.fire_rate_multiplier, _overload_debt_multiplier)
				tower.fire_rate_boost_time = maxf(tower.fire_rate_boost_time, _overload_debt_duration)
				tower.queue_redraw()
			)


func _clear_reward_card_effect_state() -> void:
	_road_spike_traps.clear()
	_coin_magnet_timer = 0.0
	_coin_magnet_bonus_ratio = 0.0
	_overload_debt_timer = 0.0
	_overload_debt_multiplier = 1.0
	_overload_debt_duration = 0.0
	_bounty_enemy_id = 0
	_bounty_bonus_gold = 0
	_queue_world_redraw()


func _update_road_spike_traps(delta: float) -> void:
	if _road_spike_traps.is_empty():
		return
	var needs_redraw := false
	for trap_index in range(_road_spike_traps.size() - 1, -1, -1):
		var trap := _road_spike_traps[trap_index]
		var time_remaining := _get_road_spike_trap_time(trap) - delta
		trap["time"] = time_remaining
		var charges := _get_road_spike_trap_charges(trap)
		if time_remaining <= 0.0 or charges <= 0:
			_road_spike_traps.remove_at(trap_index)
			needs_redraw = true
			continue
		var center := _get_road_spike_trap_position(trap)
		var radius := _get_road_spike_trap_radius(trap)
		var radius_sq := radius * radius
		var hit_ids := _get_road_spike_trap_hit_ids(trap)
		for enemy in _collect_valid_active_enemies():
			var enemy_id := enemy.get_instance_id()
			if hit_ids.has(enemy_id):
				continue
			if center.distance_squared_to(enemy.global_position) > radius_sq:
				continue
			hit_ids[enemy_id] = true
			enemy.take_damage(_get_road_spike_trap_damage(trap))
			if is_instance_valid(enemy):
				enemy.apply_slow(_get_road_spike_trap_slow_multiplier(trap), 2.0)
			charges -= 1
			needs_redraw = true
			spawn_area_particles(center, radius, Color(0.95, 0.62, 0.28), 18, "RoadSpikesParticles")
			if charges <= 0:
				break
		trap["charges"] = charges
		trap["hit_ids"] = hit_ids
		_road_spike_traps[trap_index] = trap
		if charges <= 0:
			_road_spike_traps.remove_at(trap_index)
			needs_redraw = true
	if needs_redraw:
		_queue_world_redraw()


func _get_road_spike_trap_hit_ids(trap: Dictionary) -> Dictionary:
	var raw_hit_ids: Variant = trap.get("hit_ids", {})
	if raw_hit_ids is Dictionary:
		return raw_hit_ids as Dictionary
	return {}


func _get_road_spike_trap_position(trap: Dictionary) -> Vector2:
	var raw_position: Variant = trap.get("position", Vector2.ZERO)
	if raw_position is Vector2:
		return raw_position as Vector2
	if raw_position is Vector2i:
		return Vector2(raw_position as Vector2i)
	return Vector2.ZERO


func _get_road_spike_card_radius(card: Dictionary) -> float:
	return _sanitize_road_spike_radius(card.get("radius", ROAD_SPIKE_DEFAULT_RADIUS))


func _get_road_spike_trap_radius(trap: Dictionary) -> float:
	return _sanitize_road_spike_radius(trap.get("radius", ROAD_SPIKE_DEFAULT_RADIUS))


func _get_road_spike_card_damage(card: Dictionary) -> int:
	return _sanitize_road_spike_damage(card.get("damage", ROAD_SPIKE_DEFAULT_DAMAGE))


func _get_road_spike_trap_damage(trap: Dictionary) -> int:
	return _sanitize_road_spike_damage(trap.get("damage", ROAD_SPIKE_DEFAULT_DAMAGE))


func _get_road_spike_card_charges(card: Dictionary) -> int:
	return _sanitize_road_spike_charges(card.get("charges", ROAD_SPIKE_DEFAULT_CHARGES))


func _get_road_spike_trap_charges(trap: Dictionary) -> int:
	return _sanitize_road_spike_charges(trap.get("charges", ROAD_SPIKE_DEFAULT_CHARGES))


func _get_road_spike_card_duration(card: Dictionary) -> float:
	return _sanitize_road_spike_duration(card.get("duration", ROAD_SPIKE_DEFAULT_DURATION))


func _get_road_spike_trap_time(trap: Dictionary) -> float:
	return _sanitize_road_spike_duration(trap.get("time", ROAD_SPIKE_DEFAULT_DURATION))


func _get_road_spike_card_slow_multiplier(card: Dictionary) -> float:
	return _sanitize_road_spike_slow_multiplier(card.get("slow_multiplier", ROAD_SPIKE_DEFAULT_SLOW_MULTIPLIER))


func _get_road_spike_trap_slow_multiplier(trap: Dictionary) -> float:
	return _sanitize_road_spike_slow_multiplier(trap.get("slow_multiplier", ROAD_SPIKE_DEFAULT_SLOW_MULTIPLIER))


func _sanitize_road_spike_radius(raw_radius: Variant) -> float:
	if raw_radius is int or raw_radius is float:
		var radius := float(raw_radius)
		if radius > 0.0 and radius <= ROAD_SPIKE_MAX_RADIUS:
			return radius
	return ROAD_SPIKE_DEFAULT_RADIUS


func _sanitize_road_spike_damage(raw_damage: Variant) -> int:
	if raw_damage is int or raw_damage is float:
		var damage := int(round(float(raw_damage)))
		if damage > 0 and damage <= ROAD_SPIKE_MAX_DAMAGE:
			return damage
	return ROAD_SPIKE_DEFAULT_DAMAGE


func _sanitize_road_spike_charges(raw_charges: Variant) -> int:
	if raw_charges is int or raw_charges is float:
		var charges := int(round(float(raw_charges)))
		if charges > 0 and charges <= ROAD_SPIKE_MAX_CHARGES:
			return charges
	return ROAD_SPIKE_DEFAULT_CHARGES


func _sanitize_road_spike_duration(raw_duration: Variant) -> float:
	if raw_duration is int or raw_duration is float:
		var duration := float(raw_duration)
		if duration > 0.0 and duration <= ROAD_SPIKE_MAX_DURATION:
			return duration
	return ROAD_SPIKE_DEFAULT_DURATION


func _sanitize_road_spike_slow_multiplier(raw_multiplier: Variant) -> float:
	if raw_multiplier is int or raw_multiplier is float:
		var multiplier := float(raw_multiplier)
		if multiplier > 0.0 and multiplier <= 1.0:
			return multiplier
	return ROAD_SPIKE_DEFAULT_SLOW_MULTIPLIER


func _get_coin_magnet_card_duration(card: Dictionary) -> float:
	return _sanitize_coin_magnet_duration(card.get("duration", COIN_MAGNET_DEFAULT_DURATION))


func _get_coin_magnet_card_bonus_ratio(card: Dictionary) -> float:
	return _sanitize_coin_magnet_bonus_ratio(card.get("bonus_ratio", COIN_MAGNET_DEFAULT_BONUS_RATIO))


func _sanitize_coin_magnet_duration(raw_duration: Variant) -> float:
	if raw_duration is int or raw_duration is float:
		var duration := float(raw_duration)
		if duration > 0.0 and duration <= COIN_MAGNET_MAX_DURATION:
			return duration
	return COIN_MAGNET_DEFAULT_DURATION


func _sanitize_coin_magnet_bonus_ratio(raw_ratio: Variant) -> float:
	if raw_ratio is int or raw_ratio is float:
		var ratio := float(raw_ratio)
		if ratio > 0.0 and ratio <= COIN_MAGNET_MAX_BONUS_RATIO:
			return ratio
	return COIN_MAGNET_DEFAULT_BONUS_RATIO


func _get_bait_beacon_card_radius(card: Dictionary) -> float:
	return _sanitize_bait_beacon_radius(card.get("radius", BAIT_BEACON_DEFAULT_RADIUS))


func _get_bait_beacon_card_duration(card: Dictionary) -> float:
	return _sanitize_bait_beacon_duration(card.get("duration", BAIT_BEACON_DEFAULT_DURATION))


func _get_bait_beacon_card_strength(card: Dictionary) -> float:
	return _sanitize_bait_beacon_strength(card.get("strength", BAIT_BEACON_DEFAULT_STRENGTH))


func _sanitize_bait_beacon_radius(raw_radius: Variant) -> float:
	if raw_radius is int or raw_radius is float:
		var radius := float(raw_radius)
		if radius > 0.0 and radius <= BAIT_BEACON_MAX_RADIUS:
			return radius
	return BAIT_BEACON_DEFAULT_RADIUS


func _sanitize_bait_beacon_duration(raw_duration: Variant) -> float:
	if raw_duration is int or raw_duration is float:
		var duration := float(raw_duration)
		if duration > 0.0 and duration <= BAIT_BEACON_MAX_DURATION:
			return duration
	return BAIT_BEACON_DEFAULT_DURATION


func _sanitize_bait_beacon_strength(raw_strength: Variant) -> float:
	if raw_strength is int or raw_strength is float:
		var strength := float(raw_strength)
		if strength > 0.0 and strength <= BAIT_BEACON_MAX_STRENGTH:
			return strength
	return BAIT_BEACON_DEFAULT_STRENGTH


func _get_time_warp_card_radius(card: Dictionary) -> float:
	return _sanitize_time_warp_radius(card.get("radius", TIME_WARP_DEFAULT_RADIUS))


func _get_time_warp_card_slow_multiplier(card: Dictionary) -> float:
	return _sanitize_time_warp_slow_multiplier(card.get("slow_multiplier", TIME_WARP_DEFAULT_SLOW_MULTIPLIER))


func _get_time_warp_card_haste_multiplier(card: Dictionary) -> float:
	return _sanitize_time_warp_haste_multiplier(card.get("haste_multiplier", TIME_WARP_DEFAULT_HASTE_MULTIPLIER))


func _get_time_warp_card_duration(card: Dictionary) -> float:
	return _sanitize_time_warp_duration(card.get("duration", TIME_WARP_DEFAULT_DURATION))


func _sanitize_time_warp_radius(raw_radius: Variant) -> float:
	if raw_radius is int or raw_radius is float:
		var radius := float(raw_radius)
		if radius > 0.0 and radius <= TIME_WARP_MAX_RADIUS:
			return radius
	return TIME_WARP_DEFAULT_RADIUS


func _sanitize_time_warp_slow_multiplier(raw_multiplier: Variant) -> float:
	if raw_multiplier is int or raw_multiplier is float:
		var multiplier := float(raw_multiplier)
		if multiplier > 0.0 and multiplier <= 1.0:
			return multiplier
	return TIME_WARP_DEFAULT_SLOW_MULTIPLIER


func _sanitize_time_warp_haste_multiplier(raw_multiplier: Variant) -> float:
	if raw_multiplier is int or raw_multiplier is float:
		var multiplier := float(raw_multiplier)
		if multiplier >= 1.0 and multiplier <= TIME_WARP_MAX_HASTE_MULTIPLIER:
			return multiplier
	return TIME_WARP_DEFAULT_HASTE_MULTIPLIER


func _sanitize_time_warp_duration(raw_duration: Variant) -> float:
	if raw_duration is int or raw_duration is float:
		var duration := float(raw_duration)
		if duration > 0.0 and duration <= TIME_WARP_MAX_DURATION:
			return duration
	return TIME_WARP_DEFAULT_DURATION


func _get_tower_swap_card_radius(card: Dictionary) -> float:
	return _sanitize_tower_swap_radius(card.get("radius", TOWER_SWAP_DEFAULT_RADIUS))


func _get_tower_swap_card_duration(card: Dictionary) -> float:
	return _sanitize_tower_swap_duration(card.get("duration", TOWER_SWAP_DEFAULT_DURATION))


func _get_tower_swap_card_damage_multiplier(card: Dictionary) -> float:
	return _sanitize_tower_swap_multiplier(card.get("damage_multiplier", TOWER_SWAP_DEFAULT_DAMAGE_MULTIPLIER), TOWER_SWAP_DEFAULT_DAMAGE_MULTIPLIER)


func _get_tower_swap_card_fire_rate_multiplier(card: Dictionary) -> float:
	return _sanitize_tower_swap_multiplier(card.get("fire_rate_multiplier", TOWER_SWAP_DEFAULT_FIRE_RATE_MULTIPLIER), TOWER_SWAP_DEFAULT_FIRE_RATE_MULTIPLIER)


func _sanitize_tower_swap_radius(raw_radius: Variant) -> float:
	if raw_radius is int or raw_radius is float:
		var radius := float(raw_radius)
		if radius > 0.0 and radius <= TOWER_SWAP_MAX_RADIUS:
			return radius
	return TOWER_SWAP_DEFAULT_RADIUS


func _sanitize_tower_swap_duration(raw_duration: Variant) -> float:
	if raw_duration is int or raw_duration is float:
		var duration := float(raw_duration)
		if duration > 0.0 and duration <= TOWER_SWAP_MAX_DURATION:
			return duration
	return TOWER_SWAP_DEFAULT_DURATION


func _sanitize_tower_swap_multiplier(raw_multiplier: Variant, default_multiplier: float) -> float:
	if raw_multiplier is int or raw_multiplier is float:
		var multiplier := float(raw_multiplier)
		if multiplier >= 1.0 and multiplier <= TOWER_SWAP_MAX_MULTIPLIER:
			return multiplier
	return default_multiplier


func _get_overload_debt_card_duration(card: Dictionary) -> float:
	return _sanitize_overload_debt_duration(card.get("duration", OVERLOAD_DEBT_DEFAULT_DURATION), OVERLOAD_DEBT_DEFAULT_DURATION)


func _get_overload_debt_card_damage_multiplier(card: Dictionary) -> float:
	return _sanitize_overload_debt_boost_multiplier(card.get("damage_multiplier", OVERLOAD_DEBT_DEFAULT_DAMAGE_MULTIPLIER), OVERLOAD_DEBT_DEFAULT_DAMAGE_MULTIPLIER)


func _get_overload_debt_card_fire_rate_multiplier(card: Dictionary) -> float:
	return _sanitize_overload_debt_boost_multiplier(card.get("fire_rate_multiplier", OVERLOAD_DEBT_DEFAULT_FIRE_RATE_MULTIPLIER), OVERLOAD_DEBT_DEFAULT_FIRE_RATE_MULTIPLIER)


func _get_overload_debt_card_debt_multiplier(card: Dictionary) -> float:
	return _sanitize_overload_debt_penalty_multiplier(card.get("debt_multiplier", OVERLOAD_DEBT_DEFAULT_DEBT_MULTIPLIER))


func _get_overload_debt_card_debt_duration(card: Dictionary) -> float:
	return _sanitize_overload_debt_duration(card.get("debt_duration", OVERLOAD_DEBT_DEFAULT_DEBT_DURATION), OVERLOAD_DEBT_DEFAULT_DEBT_DURATION)


func _sanitize_overload_debt_duration(raw_duration: Variant, default_duration: float) -> float:
	if raw_duration is int or raw_duration is float:
		var duration := float(raw_duration)
		if duration > 0.0 and duration <= OVERLOAD_DEBT_MAX_DURATION:
			return duration
	return default_duration


func _sanitize_overload_debt_boost_multiplier(raw_multiplier: Variant, default_multiplier: float) -> float:
	if raw_multiplier is int or raw_multiplier is float:
		var multiplier := float(raw_multiplier)
		if multiplier >= 1.0 and multiplier <= OVERLOAD_DEBT_MAX_MULTIPLIER:
			return multiplier
	return default_multiplier


func _sanitize_overload_debt_penalty_multiplier(raw_multiplier: Variant) -> float:
	if raw_multiplier is int or raw_multiplier is float:
		var multiplier := float(raw_multiplier)
		if multiplier > 0.0 and multiplier <= 1.0:
			return multiplier
	return OVERLOAD_DEBT_DEFAULT_DEBT_MULTIPLIER


func _get_panic_button_card_low_health_ratio(card: Dictionary) -> float:
	return _sanitize_panic_button_low_health_ratio(card.get("low_health_ratio", PANIC_BUTTON_DEFAULT_LOW_HEALTH_RATIO))


func _get_panic_button_card_heal(card: Dictionary) -> int:
	return _sanitize_panic_button_heal(card.get("heal", PANIC_BUTTON_DEFAULT_HEAL), PANIC_BUTTON_DEFAULT_HEAL, PANIC_BUTTON_MAX_HEAL)


func _get_panic_button_card_panic_heal(card: Dictionary) -> int:
	return _sanitize_panic_button_heal(card.get("panic_heal", PANIC_BUTTON_DEFAULT_PANIC_HEAL), PANIC_BUTTON_DEFAULT_PANIC_HEAL, PANIC_BUTTON_MAX_PANIC_HEAL)


func _get_bounty_mark_card_radius(card: Dictionary) -> float:
	return _sanitize_bounty_mark_radius(card.get("radius", BOUNTY_MARK_DEFAULT_RADIUS))


func _get_bounty_mark_card_bonus_gold(card: Dictionary) -> int:
	return _sanitize_bounty_mark_bonus_gold(card.get("bonus_gold", BOUNTY_MARK_DEFAULT_BONUS_GOLD))


func _get_risky_cache_card_jackpot_chance(card: Dictionary) -> float:
	return _sanitize_risky_cache_jackpot_chance(card.get("jackpot_chance", RISKY_CACHE_DEFAULT_JACKPOT_CHANCE))


func _get_risky_cache_card_jackpot_gold(card: Dictionary) -> int:
	return _sanitize_risky_cache_gold_reward(card.get("jackpot_gold", RISKY_CACHE_DEFAULT_JACKPOT_GOLD), RISKY_CACHE_DEFAULT_JACKPOT_GOLD)


func _get_risky_cache_card_fallback_gold(card: Dictionary) -> int:
	return _sanitize_risky_cache_gold_reward(card.get("fallback_gold", RISKY_CACHE_DEFAULT_FALLBACK_GOLD), RISKY_CACHE_DEFAULT_FALLBACK_GOLD)


func _get_risky_cache_card_fallback_damage(card: Dictionary) -> int:
	return _sanitize_risky_cache_fallback_damage(card.get("fallback_damage", RISKY_CACHE_DEFAULT_FALLBACK_DAMAGE))


func _get_fortify_card_max_hp_gain(card: Dictionary) -> int:
	return _sanitize_fortify_positive_int(card.get("max_hp", FORTIFY_DEFAULT_MAX_HP_GAIN), FORTIFY_DEFAULT_MAX_HP_GAIN, FORTIFY_MAX_HP_GAIN_LIMIT)


func _get_fortify_card_heal(card: Dictionary) -> int:
	return _sanitize_fortify_positive_int(card.get("heal", FORTIFY_DEFAULT_HEAL), FORTIFY_DEFAULT_HEAL, FORTIFY_HEAL_LIMIT)


func _get_gold_card_amount(card: Dictionary) -> int:
	return _sanitize_gold_card_amount(card.get("amount", GOLD_CARD_DEFAULT_AMOUNT))


func _get_heal_card_amount(card: Dictionary) -> int:
	return _sanitize_heal_card_amount(card.get("amount", HEAL_CARD_DEFAULT_AMOUNT))


func _get_reward_card_sell_value(card: Dictionary) -> int:
	return _sanitize_reward_card_sell_value(card.get("sell_value", REWARD_CARD_DEFAULT_SELL_VALUE))


func _get_missile_card_damage(card: Dictionary) -> int:
	return _sanitize_missile_damage(card.get("damage", MISSILE_CARD_DEFAULT_DAMAGE))


func _get_missile_card_radius(card: Dictionary) -> float:
	return _sanitize_missile_radius(card.get("radius", MISSILE_CARD_DEFAULT_RADIUS))


func _get_cryo_card_damage(card: Dictionary) -> int:
	return _sanitize_cryo_damage(card.get("damage", CRYO_CARD_DEFAULT_DAMAGE))


func _get_cryo_card_radius(card: Dictionary) -> float:
	return _sanitize_cryo_radius(card.get("radius", CRYO_CARD_DEFAULT_RADIUS))


func _get_cryo_card_slow_multiplier(card: Dictionary) -> float:
	return _sanitize_cryo_slow_multiplier(card.get("slow_multiplier", CRYO_CARD_DEFAULT_SLOW_MULTIPLIER))


func _get_cryo_card_duration(card: Dictionary) -> float:
	return _sanitize_cryo_duration(card.get("duration", CRYO_CARD_DEFAULT_DURATION))


func _get_firestorm_card_damage(card: Dictionary) -> int:
	return _sanitize_firestorm_damage(card.get("damage", FIRESTORM_CARD_DEFAULT_DAMAGE))


func _get_global_freeze_card_damage(card: Dictionary) -> int:
	return _sanitize_global_freeze_damage(card.get("damage", GLOBAL_FREEZE_CARD_DEFAULT_DAMAGE))


func _get_global_freeze_card_slow_multiplier(card: Dictionary) -> float:
	return _sanitize_global_freeze_slow_multiplier(card.get("slow_multiplier", GLOBAL_FREEZE_CARD_DEFAULT_SLOW_MULTIPLIER))


func _get_global_freeze_card_duration(card: Dictionary) -> float:
	return _sanitize_global_freeze_duration(card.get("duration", GLOBAL_FREEZE_CARD_DEFAULT_DURATION))


func _get_tower_boost_card_multiplier(card: Dictionary) -> float:
	return _sanitize_tower_boost_multiplier(card.get("multiplier", TOWER_BOOST_DEFAULT_MULTIPLIER))


func _get_tower_boost_card_duration(card: Dictionary) -> float:
	return _sanitize_tower_boost_duration(card.get("duration", TOWER_BOOST_DEFAULT_DURATION))


func _get_range_boost_card_multiplier(card: Dictionary) -> float:
	return _sanitize_range_boost_multiplier(card.get("multiplier", RANGE_BOOST_DEFAULT_MULTIPLIER))


func _get_range_boost_card_duration(card: Dictionary) -> float:
	return _sanitize_range_boost_duration(card.get("duration", RANGE_BOOST_DEFAULT_DURATION))


func _get_fire_rate_boost_card_multiplier(card: Dictionary) -> float:
	return _sanitize_fire_rate_boost_multiplier(card.get("multiplier", FIRE_RATE_BOOST_DEFAULT_MULTIPLIER))


func _get_fire_rate_boost_card_duration(card: Dictionary) -> float:
	return _sanitize_fire_rate_boost_duration(card.get("duration", FIRE_RATE_BOOST_DEFAULT_DURATION))


func _sanitize_bounty_mark_radius(raw_radius: Variant) -> float:
	if raw_radius is int or raw_radius is float:
		var radius := float(raw_radius)
		if radius > 0.0 and radius <= BOUNTY_MARK_MAX_RADIUS:
			return radius
	return BOUNTY_MARK_DEFAULT_RADIUS


func _sanitize_bounty_mark_bonus_gold(raw_bonus_gold: Variant) -> int:
	if raw_bonus_gold is int or raw_bonus_gold is float:
		var bonus_gold := int(round(float(raw_bonus_gold)))
		if bonus_gold > 0 and bonus_gold <= BOUNTY_MARK_MAX_BONUS_GOLD:
			return bonus_gold
	return BOUNTY_MARK_DEFAULT_BONUS_GOLD


func _sanitize_risky_cache_jackpot_chance(raw_chance: Variant) -> float:
	if raw_chance is int or raw_chance is float:
		var chance := float(raw_chance)
		if chance > 0.0 and chance <= RISKY_CACHE_MAX_JACKPOT_CHANCE:
			return chance
	return RISKY_CACHE_DEFAULT_JACKPOT_CHANCE


func _sanitize_risky_cache_gold_reward(raw_gold: Variant, default_gold: int) -> int:
	if raw_gold is int or raw_gold is float:
		var gold_amount := int(round(float(raw_gold)))
		if gold_amount > 0 and gold_amount <= RISKY_CACHE_MAX_GOLD_REWARD:
			return gold_amount
	return default_gold


func _sanitize_risky_cache_fallback_damage(raw_damage: Variant) -> int:
	if raw_damage is int or raw_damage is float:
		var damage_amount := int(round(float(raw_damage)))
		if damage_amount > 0 and damage_amount <= RISKY_CACHE_MAX_FALLBACK_DAMAGE:
			return damage_amount
	return RISKY_CACHE_DEFAULT_FALLBACK_DAMAGE


func _sanitize_fortify_positive_int(raw_value: Variant, default_value: int, max_value: int) -> int:
	if raw_value is int or raw_value is float:
		var value := int(round(float(raw_value)))
		if value > 0 and value <= max_value:
			return value
	return default_value


func _sanitize_gold_card_amount(raw_amount: Variant) -> int:
	if raw_amount is int or raw_amount is float:
		var amount := int(round(float(raw_amount)))
		if amount > 0 and amount <= GOLD_CARD_MAX_AMOUNT:
			return amount
	return GOLD_CARD_DEFAULT_AMOUNT


func _sanitize_heal_card_amount(raw_amount: Variant) -> int:
	if raw_amount is int or raw_amount is float:
		var amount := int(round(float(raw_amount)))
		if amount > 0 and amount <= HEAL_CARD_MAX_AMOUNT:
			return amount
	return HEAL_CARD_DEFAULT_AMOUNT


func _sanitize_reward_card_sell_value(raw_value: Variant) -> int:
	if raw_value is int or raw_value is float:
		var sell_value := int(round(float(raw_value)))
		if sell_value > 0 and sell_value <= REWARD_CARD_MAX_SELL_VALUE:
			return sell_value
	return REWARD_CARD_DEFAULT_SELL_VALUE


func _sanitize_missile_damage(raw_damage: Variant) -> int:
	if raw_damage is int or raw_damage is float:
		var damage_amount := int(round(float(raw_damage)))
		if damage_amount > 0 and damage_amount <= MISSILE_CARD_MAX_DAMAGE:
			return damage_amount
	return MISSILE_CARD_DEFAULT_DAMAGE


func _sanitize_missile_radius(raw_radius: Variant) -> float:
	if raw_radius is int or raw_radius is float:
		var radius := float(raw_radius)
		if radius > 0.0 and radius <= MISSILE_CARD_MAX_RADIUS:
			return radius
	return MISSILE_CARD_DEFAULT_RADIUS


func _sanitize_cryo_damage(raw_damage: Variant) -> int:
	if raw_damage is int or raw_damage is float:
		var damage_amount := int(round(float(raw_damage)))
		if damage_amount > 0 and damage_amount <= CRYO_CARD_MAX_DAMAGE:
			return damage_amount
	return CRYO_CARD_DEFAULT_DAMAGE


func _sanitize_cryo_radius(raw_radius: Variant) -> float:
	if raw_radius is int or raw_radius is float:
		var radius := float(raw_radius)
		if radius > 0.0 and radius <= CRYO_CARD_MAX_RADIUS:
			return radius
	return CRYO_CARD_DEFAULT_RADIUS


func _sanitize_cryo_slow_multiplier(raw_multiplier: Variant) -> float:
	if raw_multiplier is int or raw_multiplier is float:
		var multiplier := float(raw_multiplier)
		if multiplier > 0.0 and multiplier <= 1.0:
			return multiplier
	return CRYO_CARD_DEFAULT_SLOW_MULTIPLIER


func _sanitize_cryo_duration(raw_duration: Variant) -> float:
	if raw_duration is int or raw_duration is float:
		var duration := float(raw_duration)
		if duration > 0.0 and duration <= CRYO_CARD_MAX_DURATION:
			return duration
	return CRYO_CARD_DEFAULT_DURATION


func _sanitize_firestorm_damage(raw_damage: Variant) -> int:
	if raw_damage is int or raw_damage is float:
		var damage_amount := int(round(float(raw_damage)))
		if damage_amount > 0 and damage_amount <= FIRESTORM_CARD_MAX_DAMAGE:
			return damage_amount
	return FIRESTORM_CARD_DEFAULT_DAMAGE


func _sanitize_global_freeze_damage(raw_damage: Variant) -> int:
	if raw_damage is int or raw_damage is float:
		var damage_amount := int(round(float(raw_damage)))
		if damage_amount > 0 and damage_amount <= GLOBAL_FREEZE_CARD_MAX_DAMAGE:
			return damage_amount
	return GLOBAL_FREEZE_CARD_DEFAULT_DAMAGE


func _sanitize_global_freeze_slow_multiplier(raw_multiplier: Variant) -> float:
	if raw_multiplier is int or raw_multiplier is float:
		var multiplier := float(raw_multiplier)
		if multiplier > 0.0 and multiplier <= 1.0:
			return multiplier
	return GLOBAL_FREEZE_CARD_DEFAULT_SLOW_MULTIPLIER


func _sanitize_global_freeze_duration(raw_duration: Variant) -> float:
	if raw_duration is int or raw_duration is float:
		var duration := float(raw_duration)
		if duration > 0.0 and duration <= GLOBAL_FREEZE_CARD_MAX_DURATION:
			return duration
	return GLOBAL_FREEZE_CARD_DEFAULT_DURATION


func _sanitize_tower_boost_multiplier(raw_multiplier: Variant) -> float:
	if raw_multiplier is int or raw_multiplier is float:
		var multiplier := float(raw_multiplier)
		if multiplier >= 1.0 and multiplier <= TOWER_BOOST_MAX_MULTIPLIER:
			return multiplier
	return TOWER_BOOST_DEFAULT_MULTIPLIER


func _sanitize_tower_boost_duration(raw_duration: Variant) -> float:
	if raw_duration is int or raw_duration is float:
		var duration := float(raw_duration)
		if duration > 0.0 and duration <= TOWER_BOOST_MAX_DURATION:
			return duration
	return TOWER_BOOST_DEFAULT_DURATION


func _sanitize_range_boost_multiplier(raw_multiplier: Variant) -> float:
	if raw_multiplier is int or raw_multiplier is float:
		var multiplier := float(raw_multiplier)
		if multiplier >= 1.0 and multiplier <= RANGE_BOOST_MAX_MULTIPLIER:
			return multiplier
	return RANGE_BOOST_DEFAULT_MULTIPLIER


func _sanitize_range_boost_duration(raw_duration: Variant) -> float:
	if raw_duration is int or raw_duration is float:
		var duration := float(raw_duration)
		if duration > 0.0 and duration <= RANGE_BOOST_MAX_DURATION:
			return duration
	return RANGE_BOOST_DEFAULT_DURATION


func _sanitize_fire_rate_boost_multiplier(raw_multiplier: Variant) -> float:
	if raw_multiplier is int or raw_multiplier is float:
		var multiplier := float(raw_multiplier)
		if multiplier >= 1.0 and multiplier <= FIRE_RATE_BOOST_MAX_MULTIPLIER:
			return multiplier
	return FIRE_RATE_BOOST_DEFAULT_MULTIPLIER


func _sanitize_fire_rate_boost_duration(raw_duration: Variant) -> float:
	if raw_duration is int or raw_duration is float:
		var duration := float(raw_duration)
		if duration > 0.0 and duration <= FIRE_RATE_BOOST_MAX_DURATION:
			return duration
	return FIRE_RATE_BOOST_DEFAULT_DURATION


func _get_panic_button_card_slow_multiplier(card: Dictionary) -> float:
	return _sanitize_panic_button_slow_multiplier(card.get("slow_multiplier", PANIC_BUTTON_DEFAULT_SLOW_MULTIPLIER))


func _get_panic_button_card_duration(card: Dictionary) -> float:
	return _sanitize_panic_button_duration(card.get("duration", PANIC_BUTTON_DEFAULT_DURATION))


func _sanitize_panic_button_low_health_ratio(raw_ratio: Variant) -> float:
	if raw_ratio is int or raw_ratio is float:
		var ratio := float(raw_ratio)
		if ratio > 0.0 and ratio <= 1.0:
			return ratio
	return PANIC_BUTTON_DEFAULT_LOW_HEALTH_RATIO


func _sanitize_panic_button_heal(raw_heal: Variant, default_heal: int, max_heal: int) -> int:
	if raw_heal is int or raw_heal is float:
		var heal_amount := int(round(float(raw_heal)))
		if heal_amount > 0 and heal_amount <= max_heal:
			return heal_amount
	return default_heal


func _sanitize_panic_button_slow_multiplier(raw_multiplier: Variant) -> float:
	if raw_multiplier is int or raw_multiplier is float:
		var multiplier := float(raw_multiplier)
		if multiplier > 0.0 and multiplier <= 1.0:
			return multiplier
	return PANIC_BUTTON_DEFAULT_SLOW_MULTIPLIER


func _sanitize_panic_button_duration(raw_duration: Variant) -> float:
	if raw_duration is int or raw_duration is float:
		var duration := float(raw_duration)
		if duration > 0.0 and duration <= PANIC_BUTTON_MAX_DURATION:
			return duration
	return PANIC_BUTTON_DEFAULT_DURATION


func _attract_enemies_in_radius(center: Vector2, radius: float, duration: float, strength: float) -> int:
	var affected := 0
	for enemy in _collect_valid_active_enemies_in_radius(center, radius):
		enemy.apply_attraction(center, duration, strength)
		affected += 1
	return affected


func _apply_time_warp(center: Vector2, radius: float, slow_multiplier: float, haste_multiplier: float, duration: float) -> int:
	var radius_sq := radius * radius
	var affected := 0
	for enemy in _collect_valid_active_enemies():
		if center.distance_squared_to(enemy.global_position) <= radius_sq:
			enemy.apply_speed_effect(slow_multiplier, duration)
		else:
			enemy.apply_speed_effect(haste_multiplier, minf(duration, 2.2))
		affected += 1
	return affected


func _find_tower_near(world_position: Vector2, radius: float) -> Tower:
	var radius_sq := radius * radius
	var best_tower: Tower = null
	var best_distance_sq := INF
	for tower in _collect_valid_active_towers():
		var distance_sq := world_position.distance_squared_to(tower.global_position)
		if distance_sq <= radius_sq and distance_sq < best_distance_sq:
			best_tower = tower
			best_distance_sq = distance_sq
	return best_tower


func _find_highest_health_enemy_in_radius(center: Vector2, radius: float) -> Enemy:
	var best_enemy: Enemy = null
	var best_health := -1
	for enemy in _collect_valid_active_enemies_in_radius(center, radius):
		if enemy.health > best_health:
			best_health = enemy.health
			best_enemy = enemy
	return best_enemy


func _apply_reroll_cache_card(card_index: int) -> bool:
	if _card_hand.size() <= 1:
		_message = _get_reroll_cache_card_empty_message_text()
		return false
	var discard_index := 0 if card_index != 0 else 1
	_card_hand.remove_at(discard_index)
	if discard_index < card_index:
		card_index -= 1
	_card_hand.remove_at(card_index)
	_card_hand.append(_make_reward_card(wave_manager.current_wave + _card_hand.size() + 1))
	spawn_area_particles(get_base_position(), 72.0, Color(0.72, 0.56, 1.0), 34, "RerollCacheParticles")
	_spawn_reward_card_release_effect("reroll_cache", get_base_position(), _get_reward_card_definition("reroll_cache"))
	_message = _get_reroll_cache_card_message_text()
	return true


func _clamp_to_play_area(position_to_clamp: Vector2) -> Vector2:
	return Vector2(
		clampf(position_to_clamp.x, 0.0, float(get_map_pixel_width())),
		clampf(position_to_clamp.y, float(PLAY_TOP), float(get_map_pixel_height()))
	)


func _victory() -> void:
	_set_pause_state(false, false)
	_unlock_level(level_configs.size() - 1)
	is_game_over = true
	_intermission_active = false
	wave_manager.stop()
	build_manager.cancel_build_mode()
	build_manager.clear_selection()
	_message = _get_victory_message_text()
	spawn_screen_particles(true)
	ui.show_end_overlay(_get_victory_title_text(), _get_victory_subtitle_text(), Color(0.38, 0.95, 0.54))
	_refresh_ui()


func _defeat() -> void:
	_set_pause_state(false, false)
	is_game_over = true
	_intermission_active = false
	base_health = 0
	wave_manager.stop()
	build_manager.cancel_build_mode()
	build_manager.clear_selection()
	_clear_enemies_and_projectiles()
	_message = _get_defeat_message_text()
	spawn_screen_particles(false)
	ui.show_end_overlay(_get_defeat_title_text(), _get_defeat_subtitle_text(), Color(1.0, 0.28, 0.18))
	_refresh_ui()


func _refresh_ui() -> void:
	if ui == null:
		return

	ui.update_status(
		gold,
		base_health,
		max_base_health,
		current_level_index + 1,
		level_configs.size(),
		wave_manager.current_wave if wave_manager != null else 0,
		wave_manager.total_waves if wave_manager != null else 0,
		_message
	)
	ui.set_start_wave_enabled(has_game_started and not is_game_over and not is_level_complete and wave_manager != null and wave_manager.current_wave == 0 and wave_manager.can_start_wave())
	ui.set_next_level_enabled(has_game_started and is_level_complete and current_level_index < level_configs.size() - 1)
	ui.set_build_enabled(has_game_started and not is_game_over and not is_level_complete)

	if build_manager != null and is_instance_valid(build_manager.selected_tower):
		ui.show_tower_panel(build_manager.selected_tower)


func _load_level(level_index: int, keep_resources: bool) -> void:
	_set_pause_state(false, false)
	current_level_index = clampi(level_index, 0, level_configs.size() - 1)
	is_level_complete = false
	is_game_over = false
	_auto_waves_enabled = false
	_intermission_active = false
	_intermission_timer = 0.0
	_card_hand.clear()
	_pending_reward_card.clear()
	_pending_reward_timeout = 0.0

	var config := get_current_level_config()
	var level_map_size := _get_level_map_size(config)
	map_cols = level_map_size.x
	map_rows = level_map_size.y
	scene_theme = _get_level_theme(config)
	var level_routes := _get_level_routes(config)
	road_cells = _build_road_cells_for_routes(level_routes)
	spawn_paths = _build_spawn_paths(level_routes)
	spawn_path_lengths = _build_spawn_path_lengths(spawn_paths)
	path_points = spawn_paths[0] if not spawn_paths.is_empty() else []
	var level_resources := _get_level_resources(config)

	if not keep_resources:
		gold = clampi(int(level_resources["start_gold"]), 0, MAX_GOLD)
		base_health = int(level_resources["base_health"])
		max_base_health = base_health
	else:
		gold = clampi(maxi(gold + int(level_resources["level_bonus_gold"]), int(level_resources["start_gold"])), 0, MAX_GOLD)
		base_health = mini(base_health + int(level_resources["repair"]), max_base_health)

	_clear_towers()
	_clear_enemies_and_projectiles()
	build_manager.reset_occupied_tiles()
	build_manager.set_road_cells(road_cells)
	build_manager.clear_selection()
	wave_manager.setup(self, _get_level_wave_count(config), _get_level_enemy_types(config), spawn_paths.size())
	ui.hide_end_overlay()
	ui.hide_level_clear()
	ui.set_highest_unlocked_level(highest_unlocked_level_index)
	ui.set_tower_unlock_level(current_level_index)
	ui.set_card_hand_available(has_game_started)
	ui.update_card_hand(_card_hand, _pending_reward_card, false)
	_set_current_level_message()
	if map_layer != null:
		map_layer.redraw_map()
	_queue_world_redraw()
	if camera != null:
		camera.position = Vector2(float(get_map_pixel_width()) * 0.5, float(MAP_HEIGHT) * 0.5)
		_clamp_camera_to_map()


func _init_configs() -> void:
	tower_configs = {
		"basic": {
			"id": "basic", "name": "基础塔", "cost": 50, "damage": 15, "range": 130.0, "interval": 0.8, "projectile_speed": 360.0,
			"category": "weapon", "category_label": "武器塔", "icon": "基",
			"color": Color(0.32, 0.60, 0.86), "barrel_color": Color(0.075, 0.105, 0.130), "projectile_color": Color(0.42, 0.82, 1.0)
		},
		"rapid": {
			"id": "rapid", "name": "速射塔", "cost": 65, "damage": 8, "range": 115.0, "interval": 0.35, "projectile_speed": 430.0,
			"category": "weapon", "category_label": "武器塔", "icon": "速",
			"color": Color(0.32, 0.78, 0.62), "barrel_color": Color(0.060, 0.170, 0.140), "projectile_color": Color(0.46, 1.0, 0.70)
		},
		"shotgun": {
			"id": "shotgun", "name": "散弹塔", "cost": 85, "damage": 11, "range": 104.0, "interval": 0.95, "projectile_speed": 340.0,
			"category": "weapon", "category_label": "武器塔", "icon": "散", "shots": 5, "spread": 0.90,
			"color": Color(0.82, 0.64, 0.34), "barrel_color": Color(0.22, 0.13, 0.06), "projectile_color": Color(1.0, 0.76, 0.34)
		},
		"cannon": {
			"id": "cannon", "name": "重炮塔", "cost": 90, "damage": 32, "range": 115.0, "interval": 1.25, "projectile_speed": 300.0,
			"category": "weapon", "category_label": "武器塔", "icon": "炮", "splash_radius": 56.0, "splash_ratio": 0.52,
			"color": Color(0.88, 0.53, 0.26), "barrel_color": Color(0.215, 0.110, 0.070), "projectile_color": Color(1.0, 0.58, 0.22)
		},
		"sniper": {
			"id": "sniper", "name": "狙击塔", "cost": 110, "damage": 42, "range": 210.0, "interval": 1.55, "projectile_speed": 960.0,
			"category": "weapon", "category_label": "武器塔", "icon": "狙", "pierce": 2,
			"color": Color(0.62, 0.54, 0.90), "barrel_color": Color(0.135, 0.115, 0.205), "projectile_color": Color(0.86, 0.82, 1.0)
		},
		"amplifier": {
			"id": "amplifier", "name": "增幅塔", "cost": 95, "damage": 0, "range": 0.0, "interval": 0.0, "projectile_speed": 0.0,
			"category": "support", "category_label": "增益塔", "icon": "增", "damage_multiplier": 1.35, "range_multiplier": 1.18,
			"color": Color(0.52, 0.90, 0.76), "barrel_color": Color(0.10, 0.24, 0.18), "projectile_color": Color(0.52, 1.0, 0.78)
		},
	}

	var tower_unlock_levels := {
		"basic": 0,
		"rapid": 1,
		"shotgun": 2,
		"cannon": 3,
		"sniper": 4,
		"amplifier": 5,
	}
	for type_id in tower_unlock_levels.keys():
		if tower_configs.has(type_id):
			var config: Dictionary = tower_configs[type_id]
			config["unlock_level"] = int(tower_unlock_levels[type_id])
			tower_configs[type_id] = config

	enemy_type_configs = {
		"grunt": {"id": "grunt", "name": "步兵", "health_mul": 1.0, "speed_mul": 1.0, "reward_mul": 1.0, "radius": 12.0, "shape": "circle", "color": Color(0.82, 0.18, 0.15), "outline": Color(0.25, 0.05, 0.04), "base_damage": 1},
		"runner": {"id": "runner", "name": "疾行者", "health_mul": 0.7, "speed_mul": 1.55, "reward_mul": 1.0, "radius": 9.5, "shape": "diamond", "color": Color(0.95, 0.72, 0.16), "outline": Color(0.36, 0.24, 0.04), "base_damage": 1},
		"brute": {"id": "brute", "name": "重甲兵", "health_mul": 2.2, "speed_mul": 0.62, "reward_mul": 1.3, "radius": 17.0, "shape": "square", "color": Color(0.55, 0.22, 0.75), "outline": Color(0.18, 0.08, 0.26), "base_damage": 2},
		"shield": {"id": "shield", "name": "护盾兵", "health_mul": 1.55, "speed_mul": 0.85, "reward_mul": 1.2, "radius": 14.5, "shape": "triangle", "color": Color(0.20, 0.72, 0.86), "outline": Color(0.04, 0.21, 0.27), "base_damage": 1},
		"taunt": {"id": "taunt", "name": "嘲讽堡垒", "health_mul": 3.4, "speed_mul": 0.48, "reward_mul": 1.1, "radius": 19.5, "shape": "hex", "color": Color(0.34, 0.40, 0.46), "outline": Color(0.08, 0.10, 0.12), "base_damage": 2, "taunt": true},
		"elite": {"id": "elite", "name": "精英爆破兵", "health_mul": 3.0, "speed_mul": 0.70, "reward_mul": 1.6, "radius": 18.5, "shape": "hex", "color": Color(0.92, 0.34, 0.22), "outline": Color(0.34, 0.08, 0.05), "base_damage": 2},
	}

	level_configs = [
		{
			"name": "绿湾训练场", "description": "单入口草地路线，适合熟悉建塔和卡牌节奏。", "cols": 30, "rows": 15, "waves": 4, "start_gold": 180, "base_health": 20, "enemy_types": ["grunt"], "base": Vector2i(29, 7),
			"theme": _make_theme(Color(0.085, 0.125, 0.112), Color(0.070, 0.105, 0.096), Color(0.56, 0.76, 0.70, 0.055), Color(0.385, 0.335, 0.250), Color(0.255, 0.225, 0.180), Color(0.620, 0.530, 0.360), Color(0.145, 0.125, 0.100), Color(0.045, 0.055, 0.060), Color(0.055, 0.120, 0.155, 0.42), Color(0.22, 0.39, 0.48), Color(0.58, 0.68, 0.64), Color(0.22, 0.86, 0.78)),
			"routes": [
				[Vector2i(0, 7), Vector2i(5, 7), Vector2i(5, 3), Vector2i(13, 3), Vector2i(13, 11), Vector2i(22, 11), Vector2i(22, 7), Vector2i(29, 7)]
			]
		},
		{
			"name": "双折道", "description": "上下两路同时逼近基地，快速敌人开始出现。", "cols": 30, "rows": 15, "waves": 5, "start_gold": 205, "level_bonus_gold": 60, "repair": 5, "enemy_types": ["grunt", "runner"], "base": Vector2i(29, 7),
			"theme": _make_theme(Color(0.080, 0.120, 0.145), Color(0.060, 0.095, 0.125), Color(0.55, 0.78, 0.86, 0.055), Color(0.335, 0.310, 0.255), Color(0.190, 0.185, 0.165), Color(0.580, 0.555, 0.420), Color(0.100, 0.110, 0.115), Color(0.030, 0.048, 0.060), Color(0.035, 0.150, 0.210, 0.48), Color(0.18, 0.34, 0.46), Color(0.54, 0.72, 0.82), Color(0.28, 0.72, 0.98)),
			"routes": [
				[Vector2i(0, 12), Vector2i(7, 12), Vector2i(7, 8), Vector2i(3, 8), Vector2i(3, 4), Vector2i(14, 4), Vector2i(14, 7), Vector2i(29, 7)],
				[Vector2i(0, 2), Vector2i(8, 2), Vector2i(8, 6), Vector2i(18, 6), Vector2i(18, 10), Vector2i(24, 10), Vector2i(24, 7), Vector2i(29, 7)]
			]
		},
		{
			"name": "分裂堡垒", "description": "三条独立路线交错推进，重甲和护盾单位加入。", "cols": 30, "rows": 15, "waves": 6, "start_gold": 230, "level_bonus_gold": 70, "repair": 6, "enemy_types": ["grunt", "runner", "brute", "shield"], "base": Vector2i(29, 13),
			"theme": _make_theme(Color(0.105, 0.105, 0.122), Color(0.080, 0.084, 0.104), Color(0.72, 0.75, 0.86, 0.050), Color(0.350, 0.330, 0.300), Color(0.210, 0.205, 0.195), Color(0.620, 0.600, 0.520), Color(0.120, 0.125, 0.135), Color(0.038, 0.040, 0.052), Color(0.075, 0.105, 0.135, 0.34), Color(0.32, 0.34, 0.44), Color(0.72, 0.70, 0.84), Color(0.62, 0.64, 1.00)),
			"routes": [
				[Vector2i(0, 1), Vector2i(10, 1), Vector2i(10, 5), Vector2i(4, 5), Vector2i(4, 10), Vector2i(16, 10), Vector2i(16, 13), Vector2i(29, 13)],
				[Vector2i(0, 7), Vector2i(6, 7), Vector2i(6, 13), Vector2i(12, 13), Vector2i(12, 8), Vector2i(21, 8), Vector2i(21, 13), Vector2i(29, 13)],
				[Vector2i(0, 14), Vector2i(8, 14), Vector2i(8, 11), Vector2i(18, 11), Vector2i(18, 3), Vector2i(25, 3), Vector2i(25, 13), Vector2i(29, 13)]
			]
		},
		{
			"name": "河齿湿地", "description": "地图扩大到 34x17，三处刷怪点沿湿地河岸合围。", "cols": 34, "rows": 17, "waves": 7, "start_gold": 250, "level_bonus_gold": 75, "repair": 5, "enemy_types": ["grunt", "runner", "brute"], "base": Vector2i(33, 8),
			"theme": _make_theme(Color(0.065, 0.115, 0.105), Color(0.048, 0.092, 0.092), Color(0.44, 0.72, 0.66, 0.050), Color(0.315, 0.292, 0.212), Color(0.175, 0.165, 0.130), Color(0.545, 0.500, 0.325), Color(0.080, 0.095, 0.080), Color(0.025, 0.052, 0.055), Color(0.040, 0.170, 0.175, 0.54), Color(0.18, 0.42, 0.42), Color(0.56, 0.74, 0.62), Color(0.18, 0.92, 0.70)),
			"routes": [
				[Vector2i(0, 3), Vector2i(7, 3), Vector2i(7, 1), Vector2i(16, 1), Vector2i(16, 7), Vector2i(24, 7), Vector2i(24, 8), Vector2i(33, 8)],
				[Vector2i(0, 9), Vector2i(8, 9), Vector2i(8, 13), Vector2i(15, 13), Vector2i(15, 5), Vector2i(27, 5), Vector2i(27, 8), Vector2i(33, 8)],
				[Vector2i(0, 16), Vector2i(12, 16), Vector2i(12, 11), Vector2i(21, 11), Vector2i(21, 15), Vector2i(30, 15), Vector2i(30, 8), Vector2i(33, 8)]
			]
		},
		{
			"name": "铁苜蓿工区", "description": "34x17 工业区四路穿插，护盾单位会压缩建塔空间。", "cols": 34, "rows": 17, "waves": 7, "start_gold": 270, "level_bonus_gold": 80, "repair": 5, "enemy_types": ["grunt", "runner", "shield"], "base": Vector2i(33, 11),
			"theme": _make_theme(Color(0.092, 0.095, 0.086), Color(0.070, 0.074, 0.070), Color(0.82, 0.78, 0.58, 0.045), Color(0.300, 0.285, 0.250), Color(0.160, 0.155, 0.145), Color(0.565, 0.500, 0.350), Color(0.095, 0.090, 0.085), Color(0.042, 0.043, 0.040), Color(0.120, 0.112, 0.070, 0.34), Color(0.40, 0.38, 0.30), Color(0.82, 0.72, 0.48), Color(0.98, 0.72, 0.24)),
			"routes": [
				[Vector2i(0, 0), Vector2i(8, 0), Vector2i(8, 4), Vector2i(16, 4), Vector2i(16, 11), Vector2i(33, 11)],
				[Vector2i(0, 5), Vector2i(5, 5), Vector2i(5, 15), Vector2i(18, 15), Vector2i(18, 11), Vector2i(33, 11)],
				[Vector2i(0, 10), Vector2i(12, 10), Vector2i(12, 7), Vector2i(24, 7), Vector2i(24, 11), Vector2i(33, 11)],
				[Vector2i(0, 16), Vector2i(10, 16), Vector2i(10, 2), Vector2i(28, 2), Vector2i(28, 11), Vector2i(33, 11)]
			]
		},
		{
			"name": "碎裂三角洲", "description": "38x19 大型三角洲，四条路线在基地前分层交汇。", "cols": 38, "rows": 19, "waves": 8, "start_gold": 295, "level_bonus_gold": 85, "repair": 4, "enemy_types": ["grunt", "runner", "brute", "shield"], "base": Vector2i(37, 4),
			"theme": _make_theme(Color(0.070, 0.105, 0.130), Color(0.052, 0.083, 0.110), Color(0.54, 0.80, 0.92, 0.047), Color(0.285, 0.270, 0.235), Color(0.145, 0.145, 0.135), Color(0.520, 0.500, 0.410), Color(0.070, 0.085, 0.095), Color(0.024, 0.040, 0.054), Color(0.030, 0.135, 0.220, 0.56), Color(0.18, 0.32, 0.50), Color(0.48, 0.70, 0.84), Color(0.22, 0.66, 1.00)),
			"routes": [
				[Vector2i(0, 2), Vector2i(6, 2), Vector2i(6, 10), Vector2i(14, 10), Vector2i(14, 4), Vector2i(37, 4)],
				[Vector2i(0, 8), Vector2i(9, 8), Vector2i(9, 17), Vector2i(23, 17), Vector2i(23, 4), Vector2i(37, 4)],
				[Vector2i(0, 14), Vector2i(5, 14), Vector2i(5, 5), Vector2i(18, 5), Vector2i(18, 4), Vector2i(37, 4)],
				[Vector2i(0, 18), Vector2i(15, 18), Vector2i(15, 1), Vector2i(30, 1), Vector2i(30, 4), Vector2i(37, 4)]
			]
		},
		{
			"name": "灰烬螺旋", "description": "40x20 火山灰场景，路线长且绕，适合测试持续防线。", "cols": 40, "rows": 20, "waves": 8, "start_gold": 315, "level_bonus_gold": 90, "repair": 4, "enemy_types": ["runner", "brute", "shield"], "base": Vector2i(39, 15),
			"theme": _make_theme(Color(0.125, 0.090, 0.070), Color(0.090, 0.070, 0.062), Color(0.95, 0.46, 0.30, 0.048), Color(0.350, 0.245, 0.205), Color(0.185, 0.110, 0.095), Color(0.700, 0.380, 0.230), Color(0.100, 0.055, 0.050), Color(0.056, 0.036, 0.030), Color(0.220, 0.060, 0.030, 0.42), Color(0.52, 0.28, 0.22), Color(0.92, 0.54, 0.32), Color(1.00, 0.32, 0.12)),
			"routes": [
				[Vector2i(0, 1), Vector2i(10, 1), Vector2i(10, 13), Vector2i(3, 13), Vector2i(3, 18), Vector2i(20, 18), Vector2i(20, 15), Vector2i(39, 15)],
				[Vector2i(0, 7), Vector2i(14, 7), Vector2i(14, 2), Vector2i(27, 2), Vector2i(27, 15), Vector2i(39, 15)],
				[Vector2i(0, 15), Vector2i(8, 15), Vector2i(8, 9), Vector2i(17, 9), Vector2i(17, 12), Vector2i(31, 12), Vector2i(31, 15), Vector2i(39, 15)]
			]
		},
		{
			"name": "霜玻璃栈道", "description": "42x21 冰原地图，长直线和回折线混合，考验远程塔覆盖。", "cols": 42, "rows": 21, "waves": 9, "start_gold": 335, "level_bonus_gold": 95, "repair": 4, "enemy_types": ["grunt", "runner", "brute", "shield"], "base": Vector2i(41, 8),
			"theme": _make_theme(Color(0.090, 0.128, 0.150), Color(0.070, 0.105, 0.128), Color(0.70, 0.94, 1.00, 0.060), Color(0.330, 0.355, 0.360), Color(0.185, 0.215, 0.225), Color(0.680, 0.760, 0.760), Color(0.100, 0.130, 0.140), Color(0.034, 0.050, 0.064), Color(0.060, 0.170, 0.240, 0.46), Color(0.22, 0.42, 0.56), Color(0.66, 0.84, 0.92), Color(0.36, 0.88, 1.00)),
			"routes": [
				[Vector2i(0, 3), Vector2i(7, 3), Vector2i(7, 8), Vector2i(15, 8), Vector2i(15, 1), Vector2i(32, 1), Vector2i(32, 8), Vector2i(41, 8)],
				[Vector2i(0, 12), Vector2i(6, 12), Vector2i(6, 9), Vector2i(18, 9), Vector2i(18, 18), Vector2i(31, 18), Vector2i(31, 8), Vector2i(41, 8)],
				[Vector2i(0, 20), Vector2i(13, 20), Vector2i(13, 14), Vector2i(25, 14), Vector2i(25, 8), Vector2i(41, 8)]
			]
		},
		{
			"name": "黑曜扇面", "description": "44x22 暗色矿场，四处刷怪点像扇面一样压向基地。", "cols": 44, "rows": 22, "waves": 9, "start_gold": 355, "level_bonus_gold": 100, "repair": 3, "enemy_types": ["runner", "brute", "shield"], "base": Vector2i(43, 14),
			"theme": _make_theme(Color(0.070, 0.060, 0.082), Color(0.050, 0.046, 0.064), Color(0.70, 0.55, 0.90, 0.045), Color(0.285, 0.255, 0.300), Color(0.135, 0.120, 0.160), Color(0.520, 0.430, 0.600), Color(0.072, 0.062, 0.090), Color(0.026, 0.022, 0.036), Color(0.100, 0.055, 0.145, 0.38), Color(0.34, 0.24, 0.46), Color(0.68, 0.54, 0.86), Color(0.82, 0.42, 1.00)),
			"routes": [
				[Vector2i(0, 0), Vector2i(5, 0), Vector2i(5, 7), Vector2i(14, 7), Vector2i(14, 14), Vector2i(43, 14)],
				[Vector2i(0, 5), Vector2i(10, 5), Vector2i(10, 1), Vector2i(24, 1), Vector2i(24, 14), Vector2i(43, 14)],
				[Vector2i(0, 13), Vector2i(12, 13), Vector2i(12, 21), Vector2i(28, 21), Vector2i(28, 14), Vector2i(43, 14)],
				[Vector2i(0, 21), Vector2i(7, 21), Vector2i(7, 17), Vector2i(19, 17), Vector2i(19, 10), Vector2i(35, 10), Vector2i(35, 14), Vector2i(43, 14)]
			]
		},
		{
			"name": "终末堡垒", "description": "48x24 最终大地图，四路长线同时推进，所有敌人类型都会出现。", "cols": 48, "rows": 24, "waves": 10, "start_gold": 380, "level_bonus_gold": 115, "repair": 3, "enemy_types": ["grunt", "runner", "brute", "shield"], "base": Vector2i(47, 12),
			"theme": _make_theme(Color(0.060, 0.085, 0.088), Color(0.045, 0.066, 0.072), Color(0.76, 0.88, 0.72, 0.045), Color(0.330, 0.310, 0.270), Color(0.175, 0.165, 0.145), Color(0.620, 0.560, 0.410), Color(0.085, 0.092, 0.086), Color(0.020, 0.032, 0.035), Color(0.035, 0.115, 0.125, 0.40), Color(0.24, 0.38, 0.36), Color(0.78, 0.76, 0.58), Color(0.62, 1.00, 0.66)),
			"routes": [
				[Vector2i(0, 1), Vector2i(8, 1), Vector2i(8, 7), Vector2i(17, 7), Vector2i(17, 2), Vector2i(31, 2), Vector2i(31, 12), Vector2i(47, 12)],
				[Vector2i(0, 6), Vector2i(11, 6), Vector2i(11, 18), Vector2i(20, 18), Vector2i(20, 12), Vector2i(47, 12)],
				[Vector2i(0, 14), Vector2i(9, 14), Vector2i(9, 4), Vector2i(24, 4), Vector2i(24, 9), Vector2i(36, 9), Vector2i(36, 12), Vector2i(47, 12)],
				[Vector2i(0, 23), Vector2i(15, 23), Vector2i(15, 16), Vector2i(30, 16), Vector2i(30, 21), Vector2i(41, 21), Vector2i(41, 12), Vector2i(47, 12)]
			]
		},
	]

	for elite_level_index in [2, 5, 8, 9]:
		if elite_level_index >= 0 and elite_level_index < level_configs.size():
			var level_config: Dictionary = level_configs[elite_level_index]
			var enemy_types := _get_level_enemy_types(level_config)
			if not enemy_types.has(ELITE_ENEMY_TYPE_ID):
				enemy_types.append(ELITE_ENEMY_TYPE_ID)
			level_config["enemy_types"] = enemy_types
			level_configs[elite_level_index] = level_config

	for taunt_level_index in [5, 7, 8, 9]:
		if taunt_level_index >= 0 and taunt_level_index < level_configs.size():
			var taunt_level_config: Dictionary = level_configs[taunt_level_index]
			var taunt_enemy_types := _get_level_enemy_types(taunt_level_config)
			if not taunt_enemy_types.has("taunt"):
				taunt_enemy_types.append("taunt")
			taunt_level_config["enemy_types"] = taunt_enemy_types
			level_configs[taunt_level_index] = taunt_level_config


func _get_level_enemy_types(config: Dictionary) -> Array[String]:
	var normalized_types: Array[String] = []
	var raw_enemy_types = config.get("enemy_types", [DEFAULT_ENEMY_TYPE_ID])
	if raw_enemy_types is Array:
		for raw_type in raw_enemy_types:
			if str(raw_type).strip_edges().is_empty():
				continue
			var type_id := _sanitize_enemy_type_id(raw_type)
			if not type_id.is_empty() and not normalized_types.has(type_id):
				normalized_types.append(type_id)

	if normalized_types.is_empty():
		normalized_types.append(DEFAULT_ENEMY_TYPE_ID)

	return normalized_types


func _sanitize_enemy_type_id(raw_type: Variant) -> String:
	var type_id := str(raw_type).strip_edges()
	if enemy_type_configs.has(type_id):
		return type_id
	return DEFAULT_ENEMY_TYPE_ID


func _get_level_map_size(config: Dictionary) -> Vector2i:
	return Vector2i(
		_sanitize_level_int(config.get("cols", BASE_GRID_COLS), BASE_GRID_COLS, BASE_GRID_COLS, MAX_LEVEL_GRID_COLS),
		_sanitize_level_int(config.get("rows", BASE_GRID_ROWS), BASE_GRID_ROWS, BASE_GRID_ROWS, MAX_LEVEL_GRID_ROWS)
	)


func _get_level_theme(config: Dictionary) -> Dictionary:
	var sanitized_theme: Dictionary = {}
	var raw_theme = config.get("theme", {})
	if not raw_theme is Dictionary:
		return sanitized_theme

	for key in THEME_COLOR_KEYS:
		var value = raw_theme.get(key)
		if value is Color:
			sanitized_theme[key] = value

	return sanitized_theme


func _get_level_resources(config: Dictionary) -> Dictionary:
	return {
		"start_gold": _sanitize_level_int(config.get("start_gold", INITIAL_GOLD), INITIAL_GOLD, 0, MAX_GOLD),
		"base_health": _sanitize_level_int(config.get("base_health", INITIAL_BASE_HEALTH), INITIAL_BASE_HEALTH, 1, MAX_LEVEL_BASE_HEALTH),
		"level_bonus_gold": _sanitize_level_int(config.get("level_bonus_gold", DEFAULT_LEVEL_BONUS_GOLD), DEFAULT_LEVEL_BONUS_GOLD, 0, MAX_LEVEL_BONUS_GOLD),
		"repair": _sanitize_level_int(config.get("repair", DEFAULT_LEVEL_REPAIR), DEFAULT_LEVEL_REPAIR, 0, MAX_LEVEL_REPAIR),
	}


func _get_level_wave_count(config: Dictionary) -> int:
	return _sanitize_level_int(config.get("waves", DEFAULT_LEVEL_WAVES), DEFAULT_LEVEL_WAVES, 1, MAX_LEVEL_WAVES)


func _sanitize_level_int(raw_value: Variant, default_value: int, min_value: int, max_value: int) -> int:
	if raw_value is int or raw_value is float:
		var value := int(round(float(raw_value)))
		return clampi(value, min_value, max_value)
	return clampi(default_value, min_value, max_value)


func _sanitize_saved_base_health(raw_value: Variant) -> int:
	return _sanitize_level_int(raw_value, INITIAL_BASE_HEALTH, 1, MAX_SAVED_BASE_HEALTH)


func _get_level_routes(config: Dictionary) -> Array[Array]:
	var normalized_routes: Array[Array] = []
	var raw_routes = config.get("routes", [])
	if not raw_routes is Array:
		return normalized_routes

	var map_size := _get_level_map_size(config)
	for raw_route in raw_routes:
		if not raw_route is Array:
			continue

		var route_points: Array[Vector2i] = []
		for raw_point in raw_route:
			var route_point := Vector2i.ZERO
			if raw_point is Vector2i:
				route_point = raw_point
			elif raw_point is Vector2:
				route_point = Vector2i(roundi(raw_point.x), roundi(raw_point.y))
			else:
				continue

			route_point = _clamp_route_grid_point(route_point, map_size)
			if route_points.is_empty() or route_points[route_points.size() - 1] != route_point:
				route_points.append(route_point)

		if route_points.size() >= 2:
			normalized_routes.append(route_points)

	return normalized_routes


func _clamp_route_grid_point(point: Vector2i, map_size: Vector2i) -> Vector2i:
	return Vector2i(
		clampi(point.x, 0, maxi(map_size.x - 1, 0)),
		clampi(point.y, 0, maxi(map_size.y - 1, 0))
	)


func _build_road_cells(waypoints: Array) -> Dictionary:
	var cells: Dictionary = {}
	for index in range(waypoints.size() - 1):
		var a: Vector2i = waypoints[index]
		var b: Vector2i = waypoints[index + 1]
		var x_step := signi(b.x - a.x)
		var y_step := signi(b.y - a.y)
		var current := a
		cells[_grid_key(current)] = current
		while current != b:
			if current.x != b.x:
				current.x += x_step
			elif current.y != b.y:
				current.y += y_step
			cells[_grid_key(current)] = current
	return cells


func _build_road_cells_for_routes(routes: Array) -> Dictionary:
	var cells: Dictionary = {}
	for route in routes:
		var route_cells := _build_road_cells(route)
		for key in route_cells.keys():
			cells[key] = route_cells[key]
	return cells


func _build_spawn_paths(routes: Array[Array]) -> Array[Array]:
	var paths: Array[Array] = []
	for route in routes:
		var path := _build_path_from_route(route)
		if path.size() >= 2:
			paths.append(path)
	return paths


func _build_spawn_path_lengths(paths: Array[Array]) -> Array[float]:
	var lengths: Array[float] = []
	for route_path in paths:
		lengths.append(_calculate_path_length(route_path))
	return lengths


func _calculate_path_length(points: Array) -> float:
	if points.size() < 2:
		return 1.0

	var length := 0.0
	for index in range(points.size() - 1):
		var current_point: Vector2 = points[index]
		var next_point: Vector2 = points[index + 1]
		length += current_point.distance_to(next_point)
	return maxf(length, 1.0)


func _build_path_from_route(route: Array) -> Array[Vector2]:
	var cells: Array[Vector2i] = []
	for index in range(route.size() - 1):
		var a: Vector2i = route[index]
		var b: Vector2i = route[index + 1]
		var x_step := signi(b.x - a.x)
		var y_step := signi(b.y - a.y)
		var current := a
		if cells.is_empty() or cells[cells.size() - 1] != current:
			cells.append(current)
		while current != b:
			if current.x != b.x:
				current.x += x_step
			elif current.y != b.y:
				current.y += y_step
			cells.append(current)

	var points: Array[Vector2] = []
	for cell in cells:
		points.append(_grid_to_center(cell))
	return points


func _find_path_on_road_grid(start: Vector2i, goal: Vector2i) -> Array[Vector2]:
	var frontier: Array[Vector2i] = [start]
	var came_from: Dictionary = {_grid_key(start): start}
	var dirs: Array[Vector2i] = [Vector2i.RIGHT, Vector2i.LEFT, Vector2i.DOWN, Vector2i.UP]
	var head := 0

	while head < frontier.size():
		var current := frontier[head]
		head += 1
		if current == goal:
			break

		for direction in dirs:
			var next := current + direction
			var key := _grid_key(next)
			if road_cells.has(key) and not came_from.has(key):
				frontier.append(next)
				came_from[key] = current

	var cells: Array[Vector2i] = []
	var cursor := goal
	if not came_from.has(_grid_key(goal)):
		cursor = start
	cells.append(cursor)
	while cursor != start:
		cursor = came_from[_grid_key(cursor)]
		cells.push_front(cursor)

	var points: Array[Vector2] = []
	for cell in cells:
		points.append(_grid_to_center(cell))
	return points


func _grid_to_center(cell: Vector2i) -> Vector2:
	return Vector2(float(cell.x * GRID_SIZE) + float(GRID_SIZE) * 0.5, float(PLAY_TOP + cell.y * GRID_SIZE) + float(GRID_SIZE) * 0.5)


func _grid_key(cell: Vector2i) -> String:
	return "%d:%d" % [cell.x, cell.y]


func _clear_towers() -> void:
	while not _tower_cache.is_empty():
		var tower := _tower_cache.pop_back() as Tower
		if is_instance_valid(tower):
			tower.queue_free()


func _clear_enemies_and_projectiles() -> void:
	_clear_reward_card_effect_state()
	while not _enemy_cache.is_empty():
		var enemy := _enemy_cache.pop_back() as Enemy
		if is_instance_valid(enemy):
			enemy.queue_free()

	while not _projectile_cache.is_empty():
		var projectile := _projectile_cache.pop_back() as Projectile
		if is_instance_valid(projectile):
			projectile.queue_free()

	if impact_layer != null:
		for effect in impact_layer.get_children():
			effect.queue_free()

	if particle_layer != null:
		for particle in particle_layer.get_children():
			particle.queue_free()
		_world_particle_ids.clear()
		_world_particle_count = 0

func _spawn_enemy(type_id: String, enemy_health: int, enemy_speed: float, reward: int, start_offset: float = 0.0, route_index: int = 0) -> Enemy:
	var safe_type_id := _sanitize_enemy_type_id(type_id)
	var type_config: Dictionary = enemy_type_configs.get(safe_type_id, enemy_type_configs[DEFAULT_ENEMY_TYPE_ID])
	var route_path: Array[Vector2] = _get_spawn_path(route_index)
	var enemy := Enemy.new()
	enemy.set_game(self)
	enemy.setup(route_path, enemy_health, enemy_speed, reward, type_config, _get_spawn_path_length(route_index))
	if start_offset != 0.0 and route_path.size() >= 2:
		var direction := (route_path[0] - route_path[1]).normalized()
		enemy.position = route_path[0] + direction * absf(start_offset)
	enemy.died.connect(_on_enemy_died)
	enemy.reached_end.connect(_on_enemy_reached_end)
	enemy_layer.add_child(enemy)
	var spawn_color: Color = type_config.get("color", Color(0.82, 0.18, 0.15))
	spawn_particle_burst(enemy.global_position, {
		"name": "EnemySpawnParticles",
		"amount": 16,
		"lifetime": 0.34,
		"emission_radius": 8.0,
		"velocity_min": 18.0,
		"velocity_max": 88.0,
		"scale_min": 0.8,
		"scale_max": 2.0,
		"gravity": Vector2(0.0, 100.0),
		"color": spawn_color.lightened(0.12),
	})
	register_enemy(enemy)
	return enemy


func _get_spawn_path(route_index: int) -> Array[Vector2]:
	if spawn_paths.is_empty():
		var default_path: Array[Vector2] = path_points.duplicate()
		return default_path
	var route_path: Array[Vector2] = spawn_paths[clampi(route_index, 0, spawn_paths.size() - 1)] as Array[Vector2]
	var route_snapshot: Array[Vector2] = route_path.duplicate()
	return route_snapshot


func _get_spawn_path_length(route_index: int) -> float:
	if spawn_path_lengths.is_empty():
		return 1.0
	return spawn_path_lengths[clampi(route_index, 0, spawn_path_lengths.size() - 1)]


func _on_console_command_submitted(command: String) -> void:
	var response := _execute_console_command(command)
	if not response.is_empty():
		ui.write_console_line(response)


func _execute_console_command(command: String) -> String:
	var parts := command.strip_edges().split(" ", false)
	if parts.is_empty():
		return ""

	var action := parts[0].to_lower()
	match action:
		"help", "?":
			return _get_console_help()
		"start":
			if not has_game_started:
				_on_game_start_pressed()
				return _get_console_game_started_response_text()
			return _get_console_game_already_started_response_text()
		"wave":
			if not has_game_started:
				_on_game_start_pressed()
			_on_start_wave_pressed()
			return _get_console_wave_requested_response_text()
		"level":
			var target_level := clampi(_read_int(parts, 1, current_level_index + 1) - 1, 0, level_configs.size() - 1)
			_load_level(target_level, true)
			return _format_console_level_loaded_response_text(target_level + 1)
		"next":
			is_level_complete = true
			_on_next_level_pressed()
			return _get_console_next_level_requested_response_text()
		"gold":
			var amount := _read_int(parts, 1, 100)
			add_gold(amount)
			set_message(_format_console_gold_added_message_text(amount))
			return _format_console_gold_added_response_text(amount, gold)
		"setgold":
			gold = clampi(_read_int(parts, 1, gold), 0, MAX_GOLD)
			set_message(_format_console_gold_set_message_text(gold))
			_refresh_ui()
			return _format_console_gold_set_response_text(gold)
		"damage":
			var damage_amount: int = maxi(_read_int(parts, 1, 1), 0)
			_apply_base_damage(damage_amount)
			return _format_console_base_health_response_text(base_health, max_base_health)
		"heal":
			var heal_amount: int = maxi(_read_int(parts, 1, 5), 0)
			base_health = mini(base_health + heal_amount, max_base_health)
			set_message(_format_console_base_healed_message_text(heal_amount))
			_refresh_ui()
			return _format_console_base_health_response_text(base_health, max_base_health)
		"basehp":
			base_health = clampi(_read_int(parts, 1, base_health), 0, max_base_health)
			if base_health <= 0:
				_defeat()
			else:
				set_message(_get_console_base_health_set_message_text())
				_refresh_ui()
			return _format_console_base_health_response_text(base_health, max_base_health)
		"spawn":
			var count := clampi(_read_int(parts, 1, 1), 1, 50)
			var type_id := _sanitize_enemy_type_id(str(parts[2]) if parts.size() > 2 else DEFAULT_ENEMY_TYPE_ID)
			var type_name := _get_enemy_type_display_name(type_id)
			var route_index := clampi(_read_int(parts, 3, 1) - 1, 0, maxi(spawn_paths.size() - 1, 0))
			var wave_index := wave_manager.current_wave
			if not has_game_started:
				_on_game_start_pressed()
			for index in range(count):
				var stats := wave_manager.get_enemy_stats(type_id, wave_index, index)
				var selected_route := route_index if parts.size() > 3 else index % maxi(spawn_paths.size(), 1)
				_spawn_enemy(type_id, stats.health, stats.speed, stats.reward, float(index) * -28.0, selected_route)
			set_message(_format_console_enemy_spawned_message_text(count, type_name))
			_refresh_ui()
			return _format_console_enemy_spawned_response_text(count, type_name)
		"clear":
			_clear_enemies_and_projectiles()
			set_message(_get_console_enemies_cleared_message_text())
			_check_level_complete()
			_refresh_ui()
			return _get_console_clear_response_text()
		"card":
			var card_id := str(parts[1]).to_lower() if parts.size() > 1 else ""
			var debug_card := _make_debug_reward_card(card_id)
			_add_card_to_hand_or_pending(debug_card)
			_refresh_ui()
			return _format_console_reward_card_created_response_text(_get_reward_card_display_name(debug_card))
		"usecard":
			if _card_hand.is_empty():
				return _get_console_no_stored_card_response_text()
			var use_index := _card_hand.size() - 1
			var use_card := _card_hand[use_index]
			var use_position := _find_best_missile_target(_get_console_card_auto_use_radius(use_card))
			if use_position == Vector2.INF:
				use_position = get_map_center_position()
			if _apply_reward_card(use_card, use_position):
				_card_hand.remove_at(use_index)
				ui.update_card_hand(_card_hand, _pending_reward_card, not _pending_reward_card.is_empty())
				_refresh_ui()
				return _get_console_card_used_response_text()
			_refresh_ui()
			return _get_console_card_unavailable_response_text()
		"victory":
			if not has_game_started:
				_on_game_start_pressed()
			_clear_enemies_and_projectiles()
			current_level_index = level_configs.size() - 1
			wave_manager.current_wave = wave_manager.total_waves
			wave_manager.stop()
			_victory()
			return _get_console_victory_triggered_response_text()
		"defeat":
			if not has_game_started:
				_on_game_start_pressed()
			_defeat()
			return _get_console_defeat_triggered_response_text()
		"restart":
			get_tree().reload_current_scene()
			return _get_console_reload_response_text()
		"status":
			return _format_console_status_response_text(
				current_level_index + 1,
				level_configs.size(),
				gold,
				base_health,
				max_base_health,
				wave_manager.current_wave,
				wave_manager.total_waves,
				get_active_enemy_count(),
				_auto_waves_enabled,
				_intermission_timer if _intermission_active else 0.0,
				is_game_over
			)
		_:
			return _format_console_unknown_command_response_text(action)


func _get_console_help() -> String:
	return "\n".join([
		"可用命令：",
		"start：进入游戏",
		"wave：开始下一波",
		"level <关卡>：载入指定关卡",
		"next：进入下一关",
		"gold [数量] / setgold <数量>：增加或设置金币",
		"damage [数量] / heal [数量] / basehp <数值>：测试基地生命",
		"spawn [数量] [敌人类型] [路线]：生成敌人",
		"clear：清空敌人和子弹",
		"card [类型] / usecard：创建或使用测试卡牌",
		"victory / defeat：触发胜利或失败动画",
		"restart / status：重载场景或查看当前状态",
		"卡牌类型：boost（超频）、range（射程）、rate（急速）、heal（维修）、missile（导弹）、cryo（冷冻）、firestorm（火焰）、freeze（冻结）、risk（补给）、fortify（加固）、gold（军费）、bait（诱饵）、spikes（尖刺）、magnet（磁铁）、warp（裂隙）、swap（调度）、overload（透支）、panic（紧急）、bounty（悬赏）、reroll（改签）",
	])


func _format_console_bool(value: bool) -> String:
	return CONSOLE_TRUE_TEXT if value else CONSOLE_FALSE_TEXT


func _get_enemy_type_display_name(type_id: String) -> String:
	var safe_type_id := _sanitize_enemy_type_id(type_id)
	var type_config: Dictionary = enemy_type_configs.get(safe_type_id, enemy_type_configs.get(DEFAULT_ENEMY_TYPE_ID, {}))
	return _get_enemy_type_config_display_name(type_config)


func _get_enemy_type_config_display_name(type_config: Dictionary) -> String:
	var display_name := str(type_config.get("name", "")).strip_edges()
	return display_name if not display_name.is_empty() else _get_default_enemy_type_display_name()


func _make_debug_reward_card(card_id: String) -> Dictionary:
	match card_id:
		"boost", "tower", "tower_boost":
			return {
				"id": "tower_boost",
				"name": "调试超频",
				"type_label": "增益",
				"description": "所有已建防御塔在10秒内伤害提高25%。",
				"multiplier": 1.25,
				"duration": 10.0,
			}
		"range", "range_boost":
			return {
				"id": "range_boost",
				"name": "调试中继",
				"type_label": "增益",
				"description": "所有已建防御塔在12秒内射程提高18%。",
				"multiplier": 1.18,
				"duration": 12.0,
			}
		"rate", "fire", "fire_rate", "fire_rate_boost":
			return {
				"id": "fire_rate_boost",
				"name": "调试急速",
				"type_label": "增益",
				"description": "所有已建防御塔在8秒内攻击速度提高35%。",
				"multiplier": 1.35,
				"duration": 8.0,
			}
		"heal":
			return {
				"id": "heal",
				"name": "调试维修",
				"type_label": "治疗",
				"description": "恢复6点基地生命值。",
				"amount": 6,
			}
		"missile", "attack":
			return {
				"id": "missile",
				"name": "调试导弹",
				"type_label": "攻击",
				"description": "打击最密集的敌人区域。",
				"damage": MISSILE_CARD_DEFAULT_DAMAGE,
				"radius": MISSILE_CARD_DEFAULT_RADIUS,
			}
		"cryo", "slow":
			return {
				"id": "cryo",
				"name": "调试冷冻",
				"type_label": "控制",
				"description": "对目标区域敌人造成伤害并减速。",
				"damage": CRYO_CARD_DEFAULT_DAMAGE,
				"radius": CRYO_CARD_DEFAULT_RADIUS,
				"slow_multiplier": CRYO_CARD_DEFAULT_SLOW_MULTIPLIER,
				"duration": CRYO_CARD_DEFAULT_DURATION,
			}
		"firestorm", "flame":
			return _get_reward_card_definition("firestorm").duplicate(true)
		"freeze", "global_freeze":
			return _get_reward_card_definition("global_freeze").duplicate(true)
		"risk", "risky", "risky_cache":
			return _get_reward_card_definition("risky_cache").duplicate(true)
		"fortify", "defense":
			return {
				"id": "fortify",
				"name": "调试加固",
				"type_label": "防御",
				"description": "提高基地生命上限并修复基地。",
				"max_hp": 2,
				"heal": 4,
			}
		"gold":
			return {
				"id": "gold",
				"name": "调试军费",
				"type_label": "资源",
				"description": "获得85金币。",
				"amount": 85,
			}
		"bait", "beacon", "bait_beacon":
			return _get_reward_card_definition("bait_beacon").duplicate(true)
		"spikes", "road_spikes", "trap":
			return _get_reward_card_definition("road_spikes").duplicate(true)
		"magnet", "coin_magnet":
			return _get_reward_card_definition("coin_magnet").duplicate(true)
		"warp", "time_warp":
			return _get_reward_card_definition("time_warp").duplicate(true)
		"swap", "tower_swap":
			return _get_reward_card_definition("tower_swap").duplicate(true)
		"overload", "overload_debt":
			return _get_reward_card_definition("overload_debt").duplicate(true)
		"panic", "panic_button":
			return _get_reward_card_definition("panic_button").duplicate(true)
		"bounty", "bounty_mark":
			return _get_reward_card_definition("bounty_mark").duplicate(true)
		"reroll", "reroll_cache":
			return _get_reward_card_definition("reroll_cache").duplicate(true)
		_:
			return _get_reward_card_definition(DEFAULT_REWARD_CARD_ID).duplicate(true)


func _apply_base_damage(amount: int) -> void:
	if amount <= 0:
		return

	base_health -= amount
	_base_hit_flash = 0.35
	spawn_base_hit_particles(get_base_position())
	_queue_world_redraw()
	if base_health <= 0:
		_defeat()
	else:
		set_message(_format_console_base_damaged_message_text(amount))
		_refresh_ui()


func _read_int(parts: PackedStringArray, index: int, default_value: int) -> int:
	if index >= parts.size() or not parts[index].is_valid_int():
		return default_value
	return parts[index].to_int()
