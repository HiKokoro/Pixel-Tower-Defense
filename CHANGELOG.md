# 更新日志

本文档从 `ver0.0.0` 作为项目最开始的版本号，按修改量、影响范围和重要性整理截至目前的主要更新。

## 版本号规则

- `ver0.x.0`：玩家能明显感知的系统、玩法、画面、关卡、经济或战斗表现更新。
- `ver0.x.y`：同一主题下的修复、数值微调、代码整理、文案整理、备份检查点或测试补强。
- 多个连续小修复如果都服务同一个大主题，保留在同一个 `ver0.x.y` 段内；如果形成新的可见玩法/画面体验，则提升到新的 `ver0.x.0`。
- 当前仍处于原型阶段，因此暂不进入 `ver1.0.0`。

---

## ver0.0.0 - 初始状态

- 项目尚未形成完整可运行的 2D 塔防原型。
- 需求目标确定为 Godot 4.x / GDScript / 无外部插件资源的 2D 平面塔防游戏。

## ver0.1.0 - 基础塔防原型

- 创建 Godot 项目结构和主场景。
- 实现固定路线地图、敌人沿路径移动、金币、生命值、波次系统。
- 实现基础防御塔、自动索敌、发射子弹、敌人受伤死亡、击杀奖励。
- 实现胜利和失败判定。
- 创建基础 UI：金币、生命、波次、开始下一波、建造塔、提示信息。

## ver0.1.1 - 建塔交互修复

- 修复左键无法正常放置防御塔的问题。
- 调整建造模式、有效格检测、路径占用检测和已有塔占用检测。
- 增强金币不足、无效格等提示反馈。

## ver0.2.0 - 开始界面与基地系统

- 增加开始界面。
- 增加地图终点基地表现。
- 将玩家生命值语义调整为基地血量。
- 敌人到达终点后攻击基地，基地血量归零触发失败。
- 增加基地受击反馈和失败流程。

## ver0.3.0 - 调试控制台与测试能力

- 增加游戏内调试控制台。
- 支持通过控制台测试金币、敌人生成、清场、胜利、失败、卡牌等功能。
- 增加控制台 Tab 补全。
- 新增控制台说明文档。
- 增加逻辑冒烟测试，用于验证核心玩法、控制台和关卡流程。

## ver0.4.0 - 多关卡与多路线系统

- 增加选关界面。
- 增加至少 10 个关卡。
- 后续关卡拥有更大地图、更复杂路线和更多刷怪点。
- 修复多路线交叉后敌人实际只走一条路线的问题。
- 每条刷怪路线独立缓存，敌人按指定路线移动。
- 关卡推进后敌人类型逐步增加。

## ver0.5.0 - UI 与视觉体验升级

- 优化开始界面、选关界面和界面切换动画。
- 优化整体 UI 风格，使其更接近完整游戏界面。
- 优化塔和敌人的外观设计，不再只用颜色区分。
- 增加像素风格方向的视觉设定。
- 编写 `IMAGE2_PROMPTS.txt`，用于生成外部图片元素提示词。

## ver0.5.1 - enemy1 动画敌人接入

- 使用 `enemy1` 文件夹中的 4 帧图片替换红色基础敌人。
- 实现基础敌人的行走帧动画。
- 保留其他敌人类型的程序绘制外观。

## ver0.6.0 - 卡牌系统原型

- 增加波次奖励卡牌。
- 手牌上限设为 5 张。
- 手牌以卡牌样式展示，并采用花状堆叠布局。
- 鼠标悬停显示卡牌增益信息。
- 拖拽卡牌到区域释放效果。
- 支持全局增益卡、区域攻击卡、治疗、金币等卡牌。
- 修复新卡进入手牌后变成 `?` 的卡牌归一化问题。

## ver0.6.1 - 手牌交互修复

- 修复卡牌无法拖拽的问题。
- 移除难看的灰色 card 背景区域。
- 改善卡牌拖拽、回弹、使用和丢弃动画。

## ver0.7.0 - 摄像机、暂停与地图浏览

- 增加 `Ctrl + 鼠标滚轮` 调整视图缩放。
- 缩放下限支持看到地图全貌。
- 增加鼠标拖动地图查看功能。
- 增加 `ESC` 暂停与暂停菜单。
- 暂停时禁用卡牌使用、建塔等操作。

## ver0.8.0 - 塔升级与关卡经济调整

- 后续关卡初始金币按难度提升。
- 优化炮塔升级效果，使不同塔升级后有更明显的能力变化。
- 增加塔升级后的外观变化。
- 调整速射塔、重炮塔、狙击塔的升级特性。

## ver0.9.0 - 性能优化与稳定性修复

- 增加性能基准测试脚本。
- 第 10 关高压测试场景：48 座塔、180 个敌人、240 帧采样。
- 优化地图静态绘制缓存、敌人/塔/子弹缓存、粒子数量缓存。
- 优化波次敌人属性缓存，减少重复字典分配。
- 修复塔缓存已释放敌人目标导致运行时报错的问题。
- 修复基地被静态地图层遮挡的问题。

## ver0.10.0 - 手牌、卡牌经济与新卡规则

- 手牌界面支持收起，避免遮挡塔放置。
- 手牌展开时显示垃圾桶图形，可将卡牌出售换金币。
- 满手牌时，新卡进入限时待处理状态。
- 玩家可以选择丢弃旧卡保留新卡，或直接放弃新卡。
- 新卡待处理期间，禁止先使用或出售旧卡来绕过手牌上限。
- 待处理新卡超时后自动丢弃。
- 新增清波金币奖励。
- 新增概率卡牌：低概率高收益，高概率低收益并附带轻微负面。

## ver0.11.0 - 新卡牌与范围预览

- 新增 `全屏火焰` 卡牌，对全地图敌人造成伤害。
- 新增 `冻结全屏` 卡牌，对全地图敌人造成伤害并大幅减速。
- 范围攻击卡牌拖出时显示打击范围，而不是只显示卡牌本体。
- 控制台补全支持新卡牌参数。

## ver0.12.0 - 塔分类、新塔与战斗特性扩展

- 塔按类型分类为武器塔、增益塔。
- 建塔栏展开时按分类展示，收起后显示简易图标塔栏。
- 新增散弹塔：多弹丸、扇形攻击。
- 新增增幅塔：叠加到已有塔上，强化当前塔能力。
- 每座塔只能叠加一层增益塔。
- 狙击塔子弹增加穿透能力。
- 重炮塔默认具备范围攻击。
- 卡牌临时增益外观改为独立脉冲/角标效果，避免和升级外观混淆。
- 建造模式下右键改为取消放置。

---

## ver0.13.0 - 战斗表现、解锁规则与手牌抽屉修复

- 修复选中炮塔后的射程显示，使其与建造预览一致，统一为圆形范围。
- 修复狙击塔子弹穿透逻辑，命中后会沿原方向继续飞行并穿透后续敌人。
- 范围攻击卡牌拖动时隐藏卡牌本体，改为显示圆形打击范围预览。
- 在每个刷怪点绘制入口门，强化敌人出现位置的视觉识别。
- 提高后续波次刷怪密度，让重炮塔范围伤害更容易体现。
- 第 3、6、9、10 关加入精英怪；精英怪死亡后爆炸并眩晕附近炮塔。
- 选关界面改为只允许选择已经通关解锁的关卡。
- 炮塔类型随关卡逐步解锁，第一关不再开放全部塔。
- 修复散弹塔表现，弹丸按扇形方向散射。
- 手牌区开始界面隐藏；游戏内可展开/收起，收起后滑到屏幕右侧并显示当前手牌数量。
- 扩充逻辑烟雾测试，覆盖关卡锁定、塔解锁、范围卡预览、精英怪接入等逻辑。
- 性能基准更新为第 10 关 48 塔、180 敌人，平均帧耗约 6.945 ms，结果 PASS。

验证：
- Godot 4.7 脚本语法检查通过。
- `tests/LogicSmokeTest.gd` 通过。
- `tests/PerformanceBenchmark.gd` 通过。
- 主场景短启动检查通过。

---

## ver0.13.1 - 美术绘制内容清单文档

- 新增 `docs/ART_DRAWING_SPEC.md`。
- 系统整理当前项目所有需要绘制的内容，包括敌人、炮塔、子弹、地图背景、路线、刷怪门、主基地、主界面、选关界面、HUD、按钮、卡牌背景、卡牌图标、暂停菜单、调试控制台和特效反馈。
- 为每类敌人和炮塔补充形状、颜色、尺寸、动画和状态表现要求。
- 为卡牌系统补充手牌展开/收起、卡牌背景类型、当前卡牌列表和拖拽状态绘制要求。
- 补充后续外部图片资源化时可使用的资产命名规范和绘制优先级。

验证：
- 文档为纯说明文件，本次未运行 Godot 自动化测试。

---

## ver0.13.2 - 建塔详细栏横向滚动修复

- 修复建造详细页面横向空间不足时，后面的炮塔按钮无法显示的问题。
- 为展开状态的建塔详细栏增加横向 `ScrollContainer`，可通过底部滚动条查看所有炮塔。
- 保留收起状态的简易图标建塔栏，不影响原有展开/收起动画。
- 增加逻辑烟雾测试，验证展开建塔栏位于横向滚动容器内。

验证：
- Godot 4.7 脚本语法检查通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.3 - 子弹直线弹道修复

- 修复子弹会持续追踪敌人的错误逻辑。
- 子弹现在只在发射瞬间确定方向，之后沿直线飞行。
- 炮塔发射的所有子弹显式使用固定方向弹道，包括基础塔、速射塔、散弹塔、重炮塔和狙击塔。
- 优化直线弹道命中检测，使用上一帧到当前帧的线段检测，减少高速子弹穿过敌人的漏判。
- 增加逻辑烟雾测试，验证子弹发射后目标移动时不会继续追踪。

验证：
- Godot 4.7 脚本语法检查通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.4 - 项目代码备份

- 新增 `.backup` 备份目录。
- 将当前项目必要文件复制到时间戳子目录中，包含项目配置、场景、脚本、测试、文档、更新日志和当前运行依赖的 `enemy1` 动画素材。
- 备份排除 Godot 可执行文件、`.godot` 导入缓存、`.git` 仓库数据和其他运行缓存。

验证：
- 备份文件数量与预期文件数量一致。

---

## ver0.13.5 - 英文逻辑审计与中文显示文案修正

- 创建 `.backup/backup_goal_20260704_010256`，在继续长期重构目标前备份当前关键项目文件。
- 审计 `scripts/` 与 `tests/` 中非字符串、非注释部分的非 ASCII 内容，确认当前代码逻辑命名、函数名、变量名和字典键保持英文。
- 修正玩家可见英文文案：
  - 选关锁定提示由 `LOCKED` 改为 `未解锁`。
  - 选关锁定 tooltip 改为中文。
  - 炮塔未解锁 tooltip 改为中文。
  - 关卡未解锁消息改为中文。
  - 炮塔未解锁消息改为中文。
  - 手牌收起标签由 `Card` 改为 `卡牌`。
  - `Tower` 默认显示名 fallback 由 `Basic Tower` 改为 `基础塔`。

验证：
- Godot 4.7 脚本语法检查通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.6 - 开始界面与选关界面像素战术背景优化

- 创建 `.backup/backup_ui_20260704_010615`，在 UI 美化前备份当前关键项目文件。
- 新增 UI 战术背景绘制辅助逻辑，用 Godot 内置 `ColorRect` 组合生成像素网格、角标、路线预览、刷怪门剪影和基地剪影。
- 开始界面加入战术地图背景与简化路线/基地视觉信号，强化第一屏的游戏主题感。
- 选关界面加入低干扰战术网格背景，保留关卡卡片可读性。
- 优化锁定关卡按钮的视觉反馈：禁用时降低透明度并改回普通鼠标指针，已解锁关卡显示可点击指针。
- 为所有 `_make_button` 创建的按钮设置点击指针，改善页面交互反馈。
- 增加逻辑烟雾测试，验证开始界面和选关界面均包含战术像素背景。
- 审计本轮新增代码，确认非显示字符串的代码逻辑仍保持英文。

验证：
- Godot 4.7 脚本语法检查通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.7 - 选关滚动与代码备份检查点

- 创建 `.backup/backup_code_20260704_011202`，复制当前必要项目文件，包含 `project.godot`、`scenes/`、`scripts/`、`tests/`、`docs/`、`enemy1/` 和 `CHANGELOG.md`。
- 选关界面的关卡卡片已放入垂直 `ScrollContainer`，后续增加更多关卡时不会挤出面板区域。
- 增加逻辑冒烟测试，验证选关卡片位于滚动容器中，并且支持垂直滚动。
- 本轮备份排除 Godot 可执行文件、`.godot` 导入缓存、`.git` 仓库数据和已有 `.backup` 目录，避免备份体积无意义膨胀。

验证：
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.8 - 收起建塔栏横向滚动修复

- 创建 `.backup/backup_compact_build_scroll_20260704_011356`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 将收起后的简易建塔图标栏放入独立的横向 `ScrollContainer`。
- 修复后续塔类型继续增加时，收起状态下图标按钮可能溢出底部面板的问题。
- 更新建塔栏展开/收起动画逻辑，让展开列表和收起图标栏分别对自己的滚动容器做淡入淡出。
- 增加逻辑冒烟测试，验证收起建塔栏位于横向滚动容器中，并且启用横向滚动。

验证：
- Godot 4.7 脚本语法检查通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.9 - 玩家可见英文残留修正

- 创建 `.backup/backup_display_text_cn_20260704_011552`，备份本轮改动相关的 `GameUI.gd`、`Tower.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 将炮塔升级预览中的 `Lv` 改为中文“等级”，减少玩家界面的英文缩写残留。
- 将建塔按钮 tooltip 中的攻击间隔单位由 `s` 改为“秒”。
- 增加逻辑冒烟测试，验证建塔 tooltip 使用中文秒单位，并验证升级预览使用中文等级文本。
- 本轮只调整玩家可见显示字符串，代码变量、函数和逻辑键继续保持英文。

验证：
- Godot 4.7 脚本语法检查通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.10 - 代码逻辑英文审计测试

- 创建 `.backup/backup_code_style_audit_20260704_011744`，备份本轮改动前的 `tests/` 和 `CHANGELOG.md`。
- 新增 `tests/CodeStyleAuditTest.gd`，自动扫描 `scripts/` 下的 GDScript 文件。
- 审计规则：中文字符只能出现在字符串或注释内；如果中文出现在代码逻辑、变量名、函数名或非显示配置键位置，测试会失败并输出文件行号。
- 该测试将“代码逻辑保持英文，显示字符串允许中文”的要求固化为可重复运行的验证项，减少后续重构回退。

验证：
- `tests/CodeStyleAuditTest.gd` Godot 4.7 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.11 - 新卡倒计时单位中文化

- 创建 `.backup/backup_pending_timer_cn_20260704_012000`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 将手牌满时的新卡处理倒计时由 `自动放弃 12s` 改为 `自动放弃 12秒`。
- 增加逻辑冒烟测试，验证新卡待处理倒计时使用中文“秒”单位，并且不再显示 `s`。
- 本轮只调整玩家可见显示字符串，不改变卡牌保留、丢弃、自动放弃的业务逻辑。

验证：
- Godot 4.7 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.12 - 新卡满手牌弹窗交互优化

- 创建 `.backup/backup_pending_card_panel_ui_20260704_012157`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 移除满手牌新卡弹窗中永远禁用的“保留新卡”按钮，避免玩家误以为可以直接点击保留。
- 新增非按钮提示“点旧卡替换”，明确保留新卡的实际操作方式。
- 将“放弃”按钮改为“放弃新卡”，让唯一可点击操作语义更明确。
- 更新弹窗说明文案为“点击一张旧卡替换，或直接放弃新卡”。
- 增加逻辑冒烟测试，验证弹窗提示和放弃按钮状态。

验证：
- Godot 4.7 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.13 - 快捷键提示中文化

- 创建 `.backup/backup_hotkey_text_cn_20260704_012356`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 暂停菜单提示由 `按 ESC 或点击继续返回战场` 改为 `按 Esc 键或点击继续返回战场`。
- 控制台标题中的 `Enter 执行` 改为 `回车执行`，`Tab 补全` 改为 `Tab键补全`。
- 控制台初始提示中的 `按 Tab 自动补全` 改为 `按 Tab 键自动补全`。
- 为暂停提示和控制台标题新增可测试标签引用，并增加逻辑冒烟测试防止回退。

验证：
- Godot 4.7 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.14 - 控制台帮助与补全反馈中文化

- 创建 `.backup/backup_console_text_cn_20260704_012626`，备份本轮改动相关的 `GameUI.gd`、`Main.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 将控制台补全失败输出由 `No completion for:` 改为 `没有可补全项：`。
- 将多候选补全输出由 `Matches:` 改为 `可选补全：`。
- 将 `help` 命令输出从单行英文命令列表改为多行中文说明，保留实际命令名以便输入。
- 将未知命令提示改为“输入 help 查看可用命令”。
- 新增 `last_console_line` 缓存，让控制台输出可被稳定测试。
- 增加逻辑冒烟测试，验证补全反馈、帮助文本和未知命令提示均为中文说明。

验证：
- Godot 4.7 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.15 - 控制台状态布尔值中文化

- 创建 `.backup/backup_console_status_cn_20260704_012906`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 新增 `_format_console_bool()`，统一将控制台可见布尔值显示为“是/否”。
- 将 `status` 命令中的自动波次状态和游戏结束状态由 `true/false` 改为“是/否”。
- 增加逻辑冒烟测试，验证 `status` 输出不再暴露英文布尔字面量。

验证：
- Godot 4.7 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.16 - 建塔栏图标中文化

- 创建 `.backup/backup_tower_icons_cn_20260704_013106`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 将紧凑建塔栏中的塔图标由英文字母改为中文单字：
  - 基础塔：`B` -> `基`
  - 速射塔：`R` -> `速`
  - 散弹塔：`S` -> `散`
  - 重炮塔：`C` -> `炮`
  - 狙击塔：`N` -> `狙`
  - 增幅塔：`+` -> `增`
- 增加逻辑冒烟测试，验证紧凑建塔栏不再使用英文字符作为塔图标。

验证：
- Godot 4.7 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.17 - 货币文本与卡牌图标中文化

- 创建 `.backup/backup_currency_card_icons_cn_20260704_013329`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 将建塔按钮价格由 `$50` 一类格式改为 `50金`。
- 将紧凑建塔栏 tooltip、炮塔升级按钮和炮塔出售按钮中的 `$` 改为“金币”。
- 将手牌出售区的 `$` 图标改为“金”。
- 将卡牌图标从英文缩写改为中文单字：
  - `DMG` -> `攻`
  - `RNG` -> `射`
  - `SPD` -> `速`
  - `HP` -> `疗`
  - `AOE` -> `爆`
  - `ICE` -> `冻`
  - `FIRE` -> `火`
  - `FRZ` -> `冰`
  - `RISK` -> `赌`
  - `DEF` -> `盾`
  - `$` -> `金`
- 增加逻辑冒烟测试，验证建塔、升级、出售和卡牌图标不再使用英文货币符号或英文缩写。

验证：
- Godot 4.7 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.18 - 必要代码文件备份

- 创建 `.backup/backup_required_code_20260704_013705`，备份当前项目运行和开发相关文件。
- 备份范围包含：
  - `project.godot`
  - `scenes/`
  - `scripts/`
  - `tests/`
  - `docs/`
  - `enemy1/`
  - `CHANGELOG.md`
- 未复制 Godot 可执行文件、`.godot` 缓存、`.git` 仓库数据和已有 `.backup` 历史备份，避免备份体积膨胀。

验证：
- 已确认备份目录创建成功。
- 已确认备份目录中包含主场景、脚本、测试、文档和 `enemy1` 四帧图片资源。

---

## ver0.13.19 - 控制台数值返回文本中文句式化

- 创建 `.backup/backup_console_numeric_text_cn_20260704_013802`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 将 `gold` 控制台命令返回从 `金币 += 数值 -> 当前值` 改为“金币增加X，当前Y。”。
- 将 `setgold` 控制台命令返回从 `金币 = 数值` 改为“金币已设置为X。”。
- 将 `damage`、`heal`、`basehp` 控制台命令返回从 `基地生命 = 当前/上限` 改为“基地生命：当前/上限”。
- 增加逻辑冒烟测试，防止这些玩家可见控制台文本再次暴露 `+=`、`->` 或赋值式显示格式。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.20 - 控制台状态输出句式化

- 创建 `.backup/backup_console_status_sentence_cn_20260704_014034`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 将 `status` 控制台命令返回从 `关卡=... 自动=... 游戏结束=...` 的键值调试格式改为中文状态句式。
- 保留 `status` 命令名本身为英文，符合控制台输入逻辑仍使用英文命令的规则。
- 增加逻辑冒烟测试，验证状态输出包含中文句式、中文布尔值，并防止 `自动=`、`游戏结束=` 或 `true/false` 回退。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.21 - 控制台刷怪输出中文敌人名

- 创建 `.backup/backup_console_spawn_enemy_name_cn_20260704_014237`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 新增 `_get_enemy_type_display_name()`，通过敌人配置把内部敌人 id 转成中文显示名。
- 将 `spawn` 控制台命令的提示和返回从 `runner/shield` 等内部 id 改为“疾行者”“护盾兵”等中文敌人名。
- 保留 `spawn 3 runner`、`spawn 1 shield 3` 等英文命令参数，避免破坏控制台输入逻辑。
- 增加逻辑冒烟测试，验证刷怪返回不再暴露内部敌人 id。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.22 - 敌人显示名默认值中文化

- 创建 `.backup/backup_enemy_fallback_name_cn_20260704_014507`，备份本轮改动相关的 `Enemy.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 将 `Enemy.gd` 中敌人显示名默认值从 `Grunt` 改为“步兵”。
- 将敌人配置缺少 `name` 时的 fallback 从 `Grunt` 改为“步兵”，避免异常配置下暴露英文显示名。
- 增加逻辑冒烟测试，验证空敌人配置仍会得到中文显示名。

验证：
- Godot 4.7 `Enemy.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.23 - 关卡进入横幅中文展示优化

- 创建 `.backup/backup_level_banner_title_cn_20260704_014705`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 将关卡进入横幅标题从 `关卡 03 / 10` 调整为“第03关 / 共10关”。
- 让选关进入游戏时的横幅更接近自然中文 UI 文案，减少数据式展示感。
- 更新逻辑冒烟测试，验证关卡进入横幅使用新的中文格式。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.24 - 控制台卡牌帮助中文说明

- 创建 `.backup/backup_console_card_help_cn_20260704_014904`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 将控制台 `help` 中的卡牌类型说明从纯英文参数列表改为“英文参数（中文含义）”格式。
- 保留 `boost`、`range`、`firestorm` 等英文参数，确保调试命令和 Tab 补全逻辑不受影响。
- 增加逻辑冒烟测试，验证帮助文本包含中文卡牌含义，并防止回退为纯英文参数列表。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.25 - 建塔菜单展开按钮文案优化

- 创建 `.backup/backup_build_toggle_label_cn_20260704_015122`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 将建塔菜单按钮从 `防御塔 - / 防御塔 +` 改为“收起建塔 / 展开建塔”。
- 让按钮文字直接表达点击后的动作，减少符号状态带来的理解成本。
- 增加逻辑冒烟测试，验证建塔菜单展开和收起时按钮文字、详细列表与紧凑列表的可见性同步正确。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.26 - 手牌展开按钮文案与折叠宽度优化

- 创建 `.backup/backup_card_hand_toggle_label_cn_20260704_015326`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 将手牌区域按钮从“收起 / 展开”改为“收起手牌 / 展开手牌”。
- 将手牌折叠态宽度从 44 像素调整为 76 像素，让“展开手牌”文字不会被挤压，同时仍保持贴右侧的低遮挡形态。
- 同步调整折叠态手牌标题和按钮尺寸，减少文字溢出风险。
- 增加逻辑冒烟测试，验证手牌展开、折叠两种状态的按钮文字和折叠宽度。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.27 - 结束界面操作按钮补全

- 创建 `.backup/backup_end_overlay_actions_20260704_015612`，备份本轮改动相关的 `GameUI.gd`、`Main.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 为胜利/失败结束界面新增“重新开始本关”和“返回开始界面”按钮。
- 新增结束界面按钮信号 `end_restart_pressed`、`end_main_menu_pressed`，由 `Main.gd` 统一处理实际流程。
- 将原暂停菜单的重开/返回逻辑拆出为 `_restart_current_level()` 和 `_return_to_start_screen()`，暂停菜单与结束界面共用同一套页面切换逻辑。
- 增加逻辑冒烟测试，验证胜利界面可以重开并隐藏结束界面，失败界面可以返回开始界面。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.28 - 单关通关面板下一关入口

- 创建 `.backup/backup_level_clear_next_action_20260704_015939`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 为单关通关面板新增“进入下一关”按钮，直接复用现有 `next_level_pressed` 信号。
- 将通关提示从短暂自动淡出的横幅改为保留面板，直到玩家进入下一关或关卡被重新加载时隐藏。
- 调整通关面板高度、鼠标拦截和入场起点，保证新增按钮可点击且入场动画不会露出残边。
- 增加逻辑冒烟测试，验证通关面板提供明确下一关入口，点击后能加载第 2 关并隐藏通关面板。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.29 - 炮塔详情面板关闭按钮

- 创建 `.backup/backup_tower_panel_close_20260704_020307`，备份本轮改动相关的 `GameUI.gd`、`Main.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 为炮塔详情面板新增“关闭”按钮。
- 新增 `tower_panel_close_pressed` 信号，并由 `Main.gd` 统一清除当前选中炮塔、隐藏详情面板。
- 增加逻辑冒烟测试，验证点击关闭后详情面板隐藏，并且 `BuildManager.selected_tower` 被清空。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.30 - 必要代码文件备份

- 创建 `.backup/backup_required_code_20260704_020615`，备份当前项目必要代码与运行资源。
- 备份范围包含：
  - `project.godot`
  - `scenes/`
  - `scripts/`
  - `tests/`
  - `docs/`
  - `enemy1/`
  - `CHANGELOG.md`
- 未复制 Godot 可执行文件、`.godot` 导入缓存、`.git` 仓库数据和已有 `.backup` 历史备份。

验证：
- 已确认备份目录创建成功。
- 已确认备份目录内共有 30 个文件。

---

## ver0.13.31 - 炮塔详情面板动画优化

- 创建 `.backup/backup_tower_panel_animation_20260704_021000`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 炮塔详情面板从直接显示/隐藏改为轻微滑入和淡入淡出动画。
- 新增独立的炮塔面板 tween，避免刷新同一座塔信息时反复重启动画。
- 关闭面板时先清除选中炮塔，再在动画结束后隐藏面板，保留交互语义不变。
- 增加逻辑冒烟测试，验证关闭动画期间面板保持可见，动画结束后隐藏并完成淡出。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.32 - 禁用按钮鼠标反馈统一

- 创建 `.backup/backup_disabled_button_cursor_20260704_021400`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 新增 `_set_button_enabled()`，统一处理按钮 `disabled` 状态和鼠标指针形态。
- 顶部“开始波次”“建塔”“下一关”按钮在不可用时显示普通箭头，可用时显示手形指针。
- 建塔详细按钮和收起图标按钮也同步使用该逻辑；未解锁或全局禁用时不再显示可点击手形指针。
- 增加逻辑冒烟测试，验证开始前、进入游戏后、建塔禁用、已解锁塔和未解锁塔的鼠标指针反馈。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.33 - 通关面板下一关按钮状态同步

- 创建 `.backup/backup_level_clear_next_state_20260704_022100`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 将通关面板中的“进入下一关”按钮接入 `set_next_level_enabled()`。
- 顶部“下一关”和通关面板“进入下一关”现在共享同一套启用/禁用状态与鼠标指针反馈。
- 进入下一关后，通关面板按钮会同步恢复为禁用状态，避免隐藏面板内残留可点击状态。
- 增加逻辑冒烟测试，验证开局、通关后、进入下一关后的按钮可用性和鼠标指针状态。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.34 - 暂停菜单淡出动画

- 创建 `.backup/backup_pause_overlay_fade_20260704_022800`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 为暂停菜单隐藏流程新增短淡出动画，不再从显示状态直接硬切隐藏。
- 新增 `_pause_overlay_tween`，暂停菜单显示和隐藏时会先终止旧 tween，避免快速按 Esc 时动画状态叠加。
- 淡出 tween 使用 `TWEEN_PAUSE_PROCESS`，确保场景树暂停/恢复边界下动画仍可正常完成。
- 增加逻辑冒烟测试，验证恢复游戏时暂停菜单先保持可见进行淡出，淡出后隐藏且透明度归零。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.35 - 调试控制台淡入淡出动画

- 创建 `.backup/backup_console_panel_fade_20260704_023600`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 为调试控制台新增淡入淡出动画，不再直接硬切显示/隐藏。
- 新增 `_console_visible_requested`，将控制台“逻辑打开状态”和面板节点“动画可见状态”分离。
- 新增 `_console_panel_tween`，打开或关闭控制台时会终止旧 tween，避免快速切换造成透明度和可见性错乱。
- 控制台关闭后立即释放输入焦点，淡出结束后再隐藏面板节点。
- 增加逻辑冒烟测试，验证控制台打开淡入、关闭期间保持节点可见、关闭后隐藏且透明度归零。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.36 - 结束界面隐藏状态复位

- 创建 `.backup/backup_end_overlay_state_reset_20260704_024300`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 优化 `hide_end_overlay()`，隐藏结束界面时同步重置透明度、标题缩放、入场动画状态和动画计时。
- 修复在胜利/失败入场动画尚未结束时立刻重开或返回开始界面后，隐藏的结束界面可能残留中间动画状态的问题。
- 增加逻辑冒烟测试，验证结束界面重开和返回开始界面后，结束层隐藏、透明度归零、标题缩放复位。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.37 - 通关面板隐藏状态复位

- 创建 `.backup/backup_level_clear_panel_reset_20260704_025000`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 优化 `hide_level_clear()`，隐藏通关面板时同步重置面板位置和透明度。
- 修复通关面板入场动画尚未完全结束时进入下一关，隐藏面板可能保留中间位置或透明度的问题。
- 增加逻辑冒烟测试，验证进入下一关后通关面板隐藏、回到屏幕外初始位置，并且透明度归零。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.38 - 关卡进入横幅隐藏状态复位

- 创建 `.backup/backup_level_intro_reset_20260704_025700`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 新增 `hide_level_intro()`，统一停止关卡进入横幅 tween，并重置横幅可见性、位置和透明度。
- `show_start_screen()` 现在会主动清理关卡进入横幅，避免返回开始界面时横幅残留在开始界面上层。
- 关卡横幅自动播放结束后也会回到屏幕外初始位置并归零透明度。
- 增加逻辑冒烟测试，验证返回开始界面时关卡横幅隐藏、回到屏幕外初始位置，并且透明度归零。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.39 - 手牌详情面板收起状态清理

- 创建 `.backup/backup_card_detail_collapse_reset_20260704_030400`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 优化 `_refresh_card_hand()`，刷新或收起手牌时会同步隐藏卡牌详情面板。
- 修复鼠标悬停卡牌显示详情后立刻收起手牌，旧卡牌详情可能残留在屏幕上的问题。
- 增加逻辑冒烟测试，验证悬停卡牌会显示详情，收起手牌后卡牌控件和详情面板都会隐藏。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.40 - 禁用手牌拖拽状态清理

- 创建 `.backup/backup_card_hand_disable_drag_cleanup_20260704_031100`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 优化 `set_card_hand_available(false)`，禁用手牌时直接清理拖拽状态，不再对即将释放的卡牌控件播放回弹 tween。
- 修复手牌区域被禁用时，活动拖拽控件、打击范围预览或手牌可见状态可能残留的问题。
- 增加逻辑冒烟测试，验证禁用手牌会清理活动拖拽、已渲染卡牌、手牌区域和范围预览。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.41 - 必要代码快照备份

- 创建 `.backup/necessary_code_snapshot_20260704_023253`，集中备份当前可运行项目所需文件。
- 备份内容包含 `project.godot`、`CHANGELOG.md`、`scenes/`、`scripts/`、`tests/`、`docs/` 和 `enemy1/`。
- 备份时排除 Godot 可执行文件、`.godot` 缓存、`.git` 仓库数据和其他非必要运行缓存，避免备份体积过大。

验证：
- 已确认快照目录存在。
- 已确认快照中包含 30 个文件。

---

## ver0.13.42 - 开始界面动画复位

- 创建 `.backup/backup_start_screen_tween_reset_20260704_023439`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 优化 `show_start_screen()`，显示开始界面前会先停止正在运行的开始/选关界面切换动画。
- 修复选关界面打开动画中途被开始界面复位打断时，旧 tween 可能继续改写开始页或选关页位置、透明度、可见状态的问题。
- 增加逻辑冒烟测试，验证开始界面复位后开始页可见、位置和透明度恢复，选关页隐藏并回到屏幕外初始位置。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.43 - 结束界面前景残留清理

- 创建 `.backup/backup_end_overlay_ui_cleanup_20260704_023732`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 新增 `hide_tower_panel(immediate)`，允许整页状态切换时直接停止塔详情动画并复位塔详情面板。
- 优化 `show_end_overlay()`，胜利/失败界面出现时会禁用手牌并即时隐藏塔详情面板，避免拖拽卡牌、范围预览或塔详情残留在结束界面上方。
- 优化 `show_start_screen()`，返回开始界面时也会即时隐藏塔详情面板。
- 增加逻辑冒烟测试，验证失败界面会清理已打开的塔详情面板、活动卡牌拖拽、手牌区域和范围卡预览。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.44 - 结束界面控制台遮挡清理

- 创建 `.backup/backup_end_overlay_console_cleanup_20260704_023957`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 扩展 `set_console_visible(visible, animated)`，保留普通控制台开关的淡入淡出，同时支持无动画即时显示/隐藏。
- 优化 `show_end_overlay()`，胜利/失败界面出现时会即时关闭控制台，避免控制台 `z_index` 高于结束界面导致胜败动画被遮挡。
- 增加逻辑冒烟测试，验证控制台打开时触发失败动画，会自动关闭控制台并显示结束界面。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.45 - 开始界面控制台复位

- 创建 `.backup/backup_start_screen_console_cleanup_20260704_024215`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 优化 `show_start_screen()`，返回或复位开始界面时会无动画关闭控制台。
- 修复控制台打开时触发开始界面复位，控制台可能保持在高层级并遮挡开始菜单的问题。
- 增加逻辑冒烟测试，验证开始界面复位会关闭已打开的控制台，并恢复开始页/选关页状态。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.46 - 暂停层整页切换清理

- 创建 `.backup/backup_pause_overlay_page_cleanup_20260704_024435`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 扩展 `hide_pause_menu(immediate)`，保留普通恢复游戏时的暂停菜单淡出动画，同时支持整页切换时即时隐藏。
- 优化 `show_start_screen()` 和 `show_end_overlay()`，开始界面复位、胜利/失败界面出现时会即时关闭暂停层。
- 修复暂停菜单 `z_index` 高于结束界面，可能在暂停状态触发胜利/失败时短暂遮挡结束动画的问题。
- 增加逻辑冒烟测试，验证返回开始界面会立即隐藏暂停菜单；暂停状态下触发失败界面会同时清理暂停层、控制台、塔详情和卡牌拖拽预览。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.47 - 建塔面板快速切换收口

- 创建 `.backup/backup_build_panel_rapid_toggle_20260704_024729`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 新增 `_apply_build_panel_final_state()`，统一收口建塔面板展开/收起后的尺寸、位置、可见性和透明度。
- 优化 `_set_build_panel_expanded()`，动画完成回调会校验当前目标状态，避免快速连续点击时旧动画结果覆盖新状态。
- 修复建塔面板快速展开/收起后，详细列表和简易图标列表可能残留错误可见性或半透明状态的问题。
- 增加逻辑冒烟测试，验证快速连续切换后，建塔面板会稳定停在最终展开或收起状态。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.48 - 手牌布局动画收口

- 创建 `.backup/backup_card_hand_layout_tween_cleanup_20260704_024955`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 新增 `_get_card_hand_target_position()`、`_get_card_hand_target_size()` 和 `_apply_card_hand_zone_final_state()`，统一收口手牌区域展开/收起后的几何状态。
- 优化 `_on_card_hand_toggle_pressed()`，移除重复启动布局动画的调用，让手牌刷新只走一个布局入口。
- 优化 `set_card_hand_available(false)`，禁用手牌时会停止正在运行的手牌布局 tween，并复位到收起后的隐藏状态。
- 增加逻辑冒烟测试，验证快速连续切换手牌后会稳定停在最终展开或收起状态；禁用手牌会停止布局 tween、清理拖拽并复位手牌区域。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.49 - 屏幕切换最终态收口

- 创建 `.backup/backup_screen_transition_final_state_20260704_025303`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 新增 `_apply_start_screen_final_state()`、`_apply_level_select_final_state()` 和 `_apply_gameplay_screen_final_state()`，统一收口开始页、选关页和进入游戏后的可见性、位置和透明度。
- 优化选关页打开、选关页关闭和进入游戏动画完成回调，动画结束后会显式写入最终屏幕状态。
- 修复快速打开/关闭选关页后，开始页或选关页可能停留在中间位置或中间透明度的问题。
- 增加逻辑冒烟测试，验证选关页打开后最终位置/透明度正确，快速打开/关闭后能稳定回到开始页状态。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.50 - 通关面板最终态收口

- 创建 `.backup/backup_level_clear_final_state_20260704_025538`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 新增 `_apply_level_clear_final_state()`，统一收口通关面板显示/隐藏后的可见性、位置和透明度。
- 优化 `show_level_clear()`，通关面板入场动画完成后会显式写入最终位置和完全不透明状态。
- 优化 `hide_level_clear()`，隐藏通关面板时复用统一最终态入口。
- 增加逻辑冒烟测试，验证通关面板动画结束后稳定停在最终位置并恢复完全不透明。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.51 - 子弹非追踪弹道收口

- 创建 `.backup/backup_projectile_non_homing_20260704_025945`，备份本轮改动相关的 `Projectile.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 优化 `Projectile.gd`，移除 `_process()` 中残留的追踪目标移动分支，让所有子弹统一按发射瞬间的固定方向飞行。
- 移除未使用的 `_find_next_pierce_target()`，避免穿透逻辑被误接回追踪式选敌流程。
- 保留旧参数兼容现有调用，但不再允许其改变弹道行为，降低后续误改成追踪弹的风险。
- 增加逻辑冒烟测试，即使旧的 `fixed_direction` 标记被外部改动，子弹也不会转向追踪移动后的目标。

验证：
- Godot 4.7 `Projectile.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.52 - 子弹固定弹道状态清理

- 创建 `.backup/backup_projectile_state_cleanup_20260704_030151`，备份本轮改动相关的 `Projectile.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 移除 `Projectile.gd` 中误导性的公开 `fixed_direction` 状态，避免后续代码误以为子弹仍支持追踪/直线模式切换。
- 保留 `setup()` 中旧的固定弹道参数位置，兼容现有调用，但参数不再改变子弹行为。
- 调整逻辑冒烟测试，直接通过旧参数传入 `false`，验证旧调用方式也不会让子弹恢复追踪目标。

验证：
- Godot 4.7 `Projectile.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.53 - 子弹线性弹道命名收口

- 创建 `.backup/backup_projectile_linear_naming_20260704_030402`，备份本轮改动相关的 `Projectile.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 将 `Projectile.gd` 内部的 `_process_fixed_direction()` 重命名为 `_process_linear_motion()`，让函数名直接表达“线性飞行”行为。
- 将 `_find_fixed_direction_hit()` 重命名为 `_find_linear_motion_hit()`，统一命中检测的线性弹道语义。
- 将旧兼容参数改名为 `_legacy_motion_flag`，脚本代码中不再残留 `fixed_direction` 命名，降低旧追踪模式概念继续扩散的风险。
- 扫描 `scripts/*.gd` 和 `tests/*.gd`，确认不再存在 `fixed_direction`、`_process_fixed_direction()`、`_find_fixed_direction_hit()` 或 `projectile_fixed_direction` 残留。

验证：
- Godot 4.7 `Projectile.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.54 - 代码风格审计覆盖测试脚本

- 创建 `.backup/backup_code_style_audit_tests_20260704_030632`，备份本轮改动相关的 `CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 将 `tests/CodeStyleAuditTest.gd` 的审计范围从单一 `res://scripts` 扩展为 `res://scripts` 和 `res://tests`。
- 新增审计自检断言，确认审计同时覆盖游戏脚本和测试脚本，避免后续测试辅助逻辑中出现中文逻辑标识而漏检。
- 保留现有规则：中文允许出现在显示字符串和注释中，但不允许出现在逻辑代码区域。

验证：
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过，并确认覆盖 `scripts` 与 `tests`。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.55 - 代码风格审计规则自测

- 创建 `.backup/backup_code_style_audit_self_tests_20260704_030818`，备份本轮改动相关的 `CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `tests/CodeStyleAuditTest.gd` 中新增 `_run_scanner_self_tests()`，让审计器先验证自己的解析规则，再扫描项目文件。
- 增加规则自测：允许中文显示字符串、中文注释、单引号中文字符串和带转义引号的中文字符串。
- 增加规则自测：禁止中文变量名和中文函数名，锁定“逻辑标识英文、显示文本中文”的边界。

验证：
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过，并输出 6 条审计规则自测 PASS。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.56 - 满级升级按钮交互状态修复

- 创建 `.backup/backup_upgrade_button_cursor_20260704_031145`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 优化 `GameUI.gd` 的塔详情面板，升级按钮启用/禁用统一走 `_set_button_enabled()`，同步 `disabled` 状态和鼠标光标。
- 修复塔满级后升级按钮虽然禁用，但鼠标仍可能显示可点击手型的问题。
- 增加逻辑冒烟测试，验证可升级塔显示手型光标，满级塔升级按钮禁用后恢复普通箭头光标。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.57 - 顶部下一关按钮初始光标修复

- 创建 `.backup/backup_next_level_button_cursor_20260704_031400`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 优化 `GameUI.gd` 初始化流程，顶部“下一关”按钮创建后统一走 `_set_button_enabled(next_level_button, false)`。
- 修复游戏启动时顶部“下一关”按钮虽然禁用，但鼠标可能仍显示可点击手型的问题。
- 增加逻辑冒烟测试，验证顶部“下一关”按钮在未通关前禁用，并使用普通箭头光标。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.58 - 选关卡片按钮状态入口统一

- 创建 `.backup/backup_level_button_state_helper_20260704_031723`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 优化 `GameUI.gd` 的选关按钮刷新逻辑，已解锁/未解锁状态统一走 `_set_button_enabled()`。
- 移除选关按钮刷新里的重复光标赋值，减少以后新增按钮状态时遗漏鼠标光标同步的风险。
- 增加逻辑冒烟测试，验证已解锁选关卡片使用手型光标，未解锁选关卡片使用普通箭头光标。
- 扫描确认 `GameUI.gd` 中只有 `_set_button_enabled()` 内部直接写入 `button.disabled`。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.59 - 通关面板下一关按钮初始化修复

- 创建 `.backup/backup_level_clear_next_initial_state_20260704_031914`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 优化 `GameUI.gd` 的通关面板创建流程，“进入下一关”按钮创建后立即走 `_set_button_enabled(level_clear_next_button, false)`。
- 修复独立初始化 `GameUI.setup()` 时，通关面板“进入下一关”按钮在主场景刷新前短暂保持可点击手型的问题。
- 增加逻辑冒烟测试，直接实例化 `GameUI` 并调用 `setup()`，验证通关面板下一关按钮初始为禁用状态且使用普通箭头光标。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.60 - 独立 UI 初始化按钮状态收口

- 创建 `.backup/backup_ui_standalone_initial_buttons_20260704_032122`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 优化 `GameUI.gd` 的独立初始化状态，`start_wave_button` 和 `build_tower_button` 创建后立即设置为禁用状态和普通箭头光标。
- 在建塔详细选项和简易选项创建完成后调用 `_apply_tower_button_states()`，让独立 `GameUI.setup()` 不依赖主场景刷新也能禁用塔选项。
- 扩展逻辑冒烟测试，使用带塔配置的独立 `GameUI.setup()` 验证开始波次、建塔菜单、详细塔选项、简易塔选项和通关下一关按钮的初始禁用状态。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.61 - 移除旧建塔信号残留

- 创建 `.backup/backup_remove_legacy_build_signal_20260704_032337`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 移除 `GameUI.gd` 中已经无引用的 `build_tower_pressed` 信号。
- 移除旧回调 `_on_build_tower_pressed()`，当前建塔流程只保留“展开/收起建塔菜单”和具体塔类型选择入口。
- 扫描确认 `scripts/*.gd` 和 `tests/*.gd` 中不再存在 `build_tower_pressed` 或 `_on_build_tower_pressed` 残留。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.62 - 创建必要代码快照

- 创建 `.backup/necessary_code_snapshot_20260704_032630`，备份当前项目必要文件。
- 备份内容包括 `project.godot`、`CHANGELOG.md`、`scenes/`、`scripts/`、`tests/`、`docs/` 和 `enemy1/`。
- 本次只创建恢复快照并记录日志，没有改动游戏逻辑。

验证：
- 未运行 Godot 验证；本次未修改游戏脚本或场景逻辑。

---

## ver0.13.63 - 移除旧卡牌点击使用入口

- 创建 `.backup/backup_remove_legacy_reward_card_use_20260704_033000`，备份本轮改动相关的 `GameUI.gd`、`Main.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 移除 `GameUI.gd` 中已经无 UI 接入的 `reward_card_used` 信号。
- 移除旧奖励卡面板变量、`show_reward_card()`、`hide_reward_card()` 和 `_on_reward_card_use_pressed()`，卡牌流程统一保留为当前的拖拽、丢弃、出售入口。
- 移除 `Main.gd` 中旧信号连接和 `_on_reward_card_used()` 回调，避免“直接使用最后一张卡”的隐藏路径绕过当前拖拽交互。
- 扩展逻辑冒烟测试，验证 UI 和主场景不再暴露旧的点击使用卡牌入口。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.64 - 清理投射物初始化旧参数

- 创建 `.backup/backup_projectile_setup_signature_cleanup_20260704_033500`，备份本轮改动相关的 `Projectile.gd`、`Tower.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 移除 `Projectile.setup()` 中旧的 `_legacy_motion_flag` 占位参数，投射物初始化接口只保留线性弹道实际需要的目标、伤害、速度、溅射、穿透、初始方向和最大飞行距离。
- 更新 `Tower.gd` 发射逻辑，去掉旧布尔占位，直接传入有效射程作为最大飞行距离。
- 更新逻辑冒烟测试，验证最大飞行距离仍能通过新签名设置，并继续验证子弹发射后不会追踪移动目标。
- 扩展代码风格审计，对 `res://scripts` 运行时代码禁止 `_legacy_motion_flag` 回流。

验证：
- Godot 4.7 `Projectile.gd` 脚本语法检查通过。
- Godot 4.7 `Tower.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.65 - 卡牌拖拽详情面板收口

- 创建 `.backup/backup_card_drag_detail_panel_cleanup_20260704_034000`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 优化 `GameUI.gd` 的卡牌拖拽逻辑，拖拽开始后立即隐藏卡牌详情面板，避免范围攻击卡拖出时同时显示卡牌详情和打击范围。
- 保留悬停查看卡牌详情的行为，拖拽阶段只显示拖拽卡牌或范围预览。
- 扩展逻辑冒烟测试，验证范围攻击卡拖拽时隐藏卡片本体、显示圆形范围预览，并保持详情面板隐藏。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.66 - 移除旧卡牌消费动画入口

- 创建 `.backup/backup_remove_unused_card_animation_entry_20260704_034500`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 移除 `GameUI.gd` 中已经无调用方的 `animate_card_consumed()` 和 `_play_card_used_animation()`。
- 卡牌使用和出售后的 UI 刷新统一走 `consume_card_and_refresh()`，减少卡牌动画入口分叉。
- 扩展逻辑冒烟测试，验证 UI 不再暴露旧的独立卡牌消费动画入口。
- 扩展代码风格审计，对 `res://scripts` 运行时代码禁止旧动画方法名回流。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.67 - 主场景静态地图绘制收口

- 创建 `.backup/backup_remove_legacy_main_map_draw_20260704_035000`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 移除 `Main.gd` 中已经由 `MapRenderer.gd` 接管的旧 `_draw_ground_tiles()`、`_draw_grid()` 和 `_draw_path()`。
- 移除仅供旧路径绘制使用的 `_parse_grid_key()`。
- 主场景 `_draw()` 现在只负责基地和导弹动态特效，静态地图绘制统一由 `MapRenderer` 的缓存绘制逻辑负责。
- 扩展逻辑冒烟测试，验证主场景不再暴露旧静态地图绘制入口。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.68 - 主场景地图颜色常量收口

- 创建 `.backup/backup_main_map_color_constants_cleanup_20260704_035500`，备份本轮改动相关的 `Main.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 移除 `Main.gd` 中旧静态地图绘制遗留的 `COL_*` 地图颜色常量。
- 地图背景、地块、网格、道路和水面颜色常量继续由 `MapRenderer.gd` 持有，主场景只保留基地动态绘制所需的主题颜色读取。
- 扩展代码风格审计，禁止 `Main.gd` 重新持有 `MapRenderer` 负责的静态地图颜色常量。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.69 - 主场景无引用地图常量清理

- 创建 `.backup/backup_main_unused_map_constants_20260704_040000`，备份本轮改动相关的 `Main.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 移除 `Main.gd` 中已经无引用的 `MAP_WIDTH`、`PLAY_BOTTOM` 和 `PATH_WIDTH`。
- 保留仍被摄像机、网格和关卡尺寸逻辑使用的 `MAP_HEIGHT`、`GRID_SIZE`、`PLAY_TOP` 等常量。
- 扩展代码风格审计，禁止 `Main.gd` 重新引入这三个旧静态地图常量。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.70 - 必要项目文件快照备份

- 创建 `.backup/code_snapshot_20260704_034449`，集中备份当前可运行项目所需的代码、场景、测试、文档和本地敌人动画资源。
- 备份范围包含 `project.godot`、`CHANGELOG.md`、`scenes/`、`scripts/`、`tests/`、`docs/` 和 `enemy1/`。
- 未备份 Godot 可执行文件和 `.godot/` 编辑器缓存，避免把大体积二进制和可再生成缓存混入代码快照。

验证：
- 已确认备份目录中存在上述文件副本。
- 本版本仅做快照和日志记录，未改动游戏运行逻辑。

---

## ver0.13.71 - 活跃敌人计数状态收口

- 创建 `.backup/backup_active_enemy_count_cleanup_20260704_034554`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 移除 `Main.gd` 中重复维护的 `_active_enemies` 字段。
- 新增 `get_active_enemy_count()`，敌人数量统一由 `_enemy_cache.size()` 派生。
- 敌人生成、死亡、到达基地和清场流程不再额外维护第二份计数，降低波次结算和控制台状态不同步的风险。
- 调整逻辑冒烟测试，测试用敌人也通过 `register_enemy()` 进入统一缓存流程。
- 扩展代码风格审计，禁止 `Main.gd` 重新引入旧的 `_active_enemies` 状态字段。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.72 - 核心运行时主场景引用类型化

- 创建 `.backup/backup_main_reference_typing_20260704_034907`，备份本轮改动相关的 `Main.gd`、`BuildManager.gd`、`Tower.gd`、`WaveManager.gd`、`MapRenderer.gd` 和 `CHANGELOG.md`。
- 将 `BuildManager.gd`、`Tower.gd`、`WaveManager.gd`、`MapRenderer.gd` 中的 `game` 引用显式标注为 `Main`。
- 将上述脚本的 `setup(game_ref, ...)` 参数同步标注为 `setup(game_ref: Main, ...)`，让误传非主场景对象时更早暴露。
- 尝试将 `Main.gd` 的 `map_layer` 标注为 `MapRenderer` 时，Godot 4.7 当前脚本解析无法稳定识别该全局类型；已恢复为 `Node2D`，保留可运行兼容性。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `BuildManager.gd` 脚本语法检查通过。
- Godot 4.7 `Tower.gd` 脚本语法检查通过。
- Godot 4.7 `WaveManager.gd` 脚本语法检查通过。
- Godot 4.7 `MapRenderer.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.73 - 波次敌人类型配置规范化

- 创建 `.backup/backup_wave_enemy_type_normalization_20260704_035153`，备份本轮改动相关的 `WaveManager.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 将 `WaveManager.gd` 的 `enemy_types` 从弱类型数组收口为 `Array[String]`。
- 新增 `_normalize_enemy_types()`，在波次 setup 时清理空敌人类型、统一转为字符串 id，并在配置为空时回退到 `grunt`。
- 移除波次选怪时的临时空数组兜底，让敌人类型列表在进入运行期前保持稳定。
- 扩展逻辑冒烟测试，覆盖空敌人类型回退、路线数量下限和混合配置规范化。
- 扩展代码风格审计，禁止 `WaveManager.gd` 重新使用弱类型敌人数组或直接复制原始配置数组。

验证：
- Godot 4.7 `WaveManager.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.74 - 防御塔详情面板显示有效战斗数值

- 创建 `.backup/backup_tower_panel_effective_stats_20260704_035518`，备份本轮改动相关的 `Tower.gd`、`GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 在 `Tower.gd` 新增 `get_effective_damage()`，对外提供已计入增益倍率的当前伤害值。
- `GameUI.gd` 的防御塔详情面板改为显示 `get_effective_damage()` 和 `get_effective_range()`，让卡牌增益、增幅塔和临时强化后的数值能直接反映在界面中。
- 扩展逻辑冒烟测试，验证防御塔受到伤害和射程增益后，详情面板显示提升后的有效数值。

验证：
- Godot 4.7 `Tower.gd` 脚本语法检查通过。
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.75 - 已选防御塔面板自动刷新

- 创建 `.backup/backup_selected_tower_panel_refresh_20260704_035732`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 在 `Main.gd` 新增 `_refresh_selected_tower_panel()`，主循环中仅在防御塔面板可见且存在有效选中塔时刷新详情。
- 刷新仍走 `GameUI.show_tower_panel()` 的文本缓存判断，避免每帧重复写 UI 文本。
- 扩展逻辑冒烟测试，验证防御塔临时伤害增益和射程增益自然过期后，详情面板会自动回落到当前有效数值。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.76 - 防御塔详情面板显示有效攻击间隔

- 创建 `.backup/backup_tower_panel_attack_interval_20260704_035954`，备份本轮改动相关的 `Tower.gd`、`GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 在 `Tower.gd` 新增 `get_effective_attack_interval()`，统一返回已计入急速增益后的当前攻击间隔。
- 防御塔开火冷却改为复用 `get_effective_attack_interval()`，避免攻击间隔公式在多个位置重复。
- `GameUI.gd` 的防御塔详情面板新增“间隔”显示，并加高面板与信息标签、下移升级/出售按钮，减少多行信息拥挤。
- 扩展逻辑冒烟测试，验证急速增益后面板显示更短的有效攻击间隔，并在增益过期后自动回落。

验证：
- Godot 4.7 `Tower.gd` 脚本语法检查通过。
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.77 - 建造菜单塔数值提示统一

- 创建 `.backup/backup_build_tooltip_stat_consistency_20260704_040449`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 在 `GameUI.gd` 新增 `_format_tower_config_stats()`，统一生成建造菜单塔数值提示文本。
- 详细建塔按钮和折叠图标按钮现在复用同一套“伤害 / 射程 / 间隔”提示格式。
- 折叠状态下的图标按钮 tooltip 增加核心塔数值，玩家不展开建塔面板也能快速比较塔能力。
- 扩展逻辑冒烟测试，验证折叠建塔 tooltip 显示伤害、射程和本地化秒数。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.78 - 增益塔建造信息改为增幅展示

- 创建 `.backup/backup_build_tooltip_stat_consistency_20260704_040449`，继续使用本轮建造菜单信息一致性备份。
- 在 `GameUI.gd` 新增 `_format_tower_button_text()` 和 `_format_multiplier_bonus()`，把武器塔与增益塔的建造显示分开格式化。
- 增益塔不再显示误导性的 `伤0 / 射0`，改为显示 `伤+35% / 射+18%` 这类增幅信息。
- 增益塔折叠图标 tooltip 改为显示“伤害增幅 / 射程增幅”，和实际叠加效果一致。
- 扩展逻辑冒烟测试，验证增益塔按钮不再展示零武器数值，并展示增幅加成。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.79 - 必要代码文件快照备份

- 创建 `.backup/necessary_code_snapshot_20260704_041018`，复制当前项目可运行和继续开发所需的必要文件。
- 备份范围包含 `project.godot`、`scenes/`、`scripts/`、`tests/`、`docs/`、`enemy1/` 和 `CHANGELOG.md`。
- 未复制 Godot 可执行文件、`.godot` 导入缓存、`.git` 仓库数据和已有 `.backup` 历史快照，避免备份体积膨胀。

验证：
- 本版本只创建文件快照并更新日志，未修改游戏运行逻辑。

---

## ver0.13.80 - 建造菜单增益塔判断收口

- 创建 `.backup/backup_support_tower_config_helper_20260704_041332`，备份本轮改动相关的 `GameUI.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `GameUI.gd` 新增 `TOWER_CATEGORY_SUPPORT`、`TOWER_CATEGORY_WEAPON` 和 `_is_support_tower_config()`。
- 建塔按钮文本和 tooltip 统一复用 `_is_support_tower_config()` 判断增益塔，减少分类逻辑重复。
- 扩展代码风格审计，禁止旧的内联增益塔配置判断重新回流。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.81 - 建造管理器增益塔判断收口

- 创建 `.backup/backup_build_manager_support_helper_20260704_041553`，备份本轮改动相关的 `BuildManager.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `BuildManager.gd` 新增 `TOWER_CATEGORY_SUPPORT`、`TOWER_CATEGORY_WEAPON` 和 `_is_support_build_selected()`。
- 增益塔放置、错误检测和建造预览统一复用 `_is_support_build_selected()`，减少裸字符串分类判断重复。
- 扩展代码风格审计，禁止旧的建造管理器增益塔内联判断回流。

验证：
- Godot 4.7 `BuildManager.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.82 - 关卡敌人类型配置规范化

- 创建 `.backup/backup_main_level_enemy_type_normalization_20260704_041808`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `Main.gd` 新增 `DEFAULT_ENEMY_TYPE_ID`、`ELITE_ENEMY_TYPE_ID` 和 `_get_level_enemy_types()`。
- 关卡加载时先将 `enemy_types` 清理为 `Array[String]`，再传给 `WaveManager`，避免空值、重复值或非字符串值直接进入波次逻辑。
- 精英怪注入也复用 `_get_level_enemy_types()`，保证后续手动改关卡配置时仍能保持敌人类型列表稳定。
- 扩展逻辑冒烟测试，验证关卡敌人类型会去空、去重、转字符串，并在为空时回退到步兵。
- 扩展代码风格审计，禁止旧的原始 `enemy_types` 配置读取方式回流。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.83 - 关卡路线配置规范化

- 创建 `.backup/backup_main_level_route_normalization_20260704_042052`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `Main.gd` 新增 `_get_level_routes()`，统一清理关卡 `routes` 配置。
- 关卡加载时先规范化路线，再同时用于道路缓存和刷怪路径生成，减少两套路径数据不一致的风险。
- `_get_level_routes()` 会跳过无效路线和少于两个点的路线，并支持将 `Vector2` 点转换为 `Vector2i` 格子点。
- 扩展逻辑冒烟测试，验证无效路线会被丢弃、合法路线会保留、`Vector2` 路线点会转为格子坐标。
- 扩展代码风格审计，禁止旧的原始 `routes` 配置读取方式回流。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.84 - 关卡地图尺寸配置规范化

- 创建 `.backup/backup_main_level_map_size_helper_20260704_042337`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `Main.gd` 新增 `_get_level_map_size()`，统一读取并规范化关卡 `cols` 与 `rows`。
- 关卡加载时通过 `_get_level_map_size()` 设置 `map_cols` 和 `map_rows`，避免异常配置生成过小或无效地图。
- 扩展逻辑冒烟测试，验证非法地图尺寸会回退到基础网格，合法大地图尺寸会保留。
- 扩展代码风格审计，禁止旧的地图尺寸直接读取方式回流。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.85 - 关卡资源配置规范化

- 创建 `.backup/backup_main_level_resource_helper_20260704_042632`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `Main.gd` 新增 `DEFAULT_LEVEL_BONUS_GOLD`、`DEFAULT_LEVEL_REPAIR` 和 `_get_level_resources()`。
- 关卡加载时通过 `_get_level_resources()` 统一读取初始金币、基地生命、过关奖励金币和关卡修复量。
- 资源配置会被规范化：初始金币、过关奖励金币和修复量不低于 0，基地生命不低于 1。
- 扩展逻辑冒烟测试，验证合法资源配置会保留，异常资源配置会被钳制到安全范围。
- 扩展代码风格审计，禁止旧的关卡资源直接读取方式回流。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.86 - 关卡波次数配置规范化

- 创建 `.backup/backup_main_level_wave_count_helper_20260704_042922`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `Main.gd` 新增 `DEFAULT_LEVEL_WAVES` 和 `_get_level_wave_count()`。
- 关卡加载时通过 `_get_level_wave_count()` 设置 `WaveManager` 的总波次数，避免异常配置生成 0 波或负数波次。
- 扩展逻辑冒烟测试，验证合法波次数会保留，异常波次数会被钳制到至少 1。
- 扩展代码风格审计，禁止旧的波次数直接读取方式回流。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.87 - 关卡主题配置规范化

- 创建 `.backup/backup_main_level_theme_helper_20260704_043147`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `Main.gd` 新增 `THEME_COLOR_KEYS` 和 `_get_level_theme()`。
- 关卡加载时通过 `_get_level_theme()` 设置 `scene_theme`，只保留已知主题键和合法 `Color` 值。
- 非字典主题配置会被忽略，未知主题键和非颜色值会被过滤，减少地图与基地绘制时的坏类型风险。
- 扩展逻辑冒烟测试，验证合法主题颜色会保留，非法或未知主题项会被丢弃。
- 扩展代码风格审计，禁止旧的原始主题字典复制方式回流。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.88 - 关卡显示名称入口收口

- 创建 `.backup/backup_main_level_display_helper_20260704_043449`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `Main.gd` 新增 `_get_level_display_name()`、`_get_current_level_display_name()`、`_set_current_level_message()` 和 `_show_current_level_intro()`。
- 开始游戏、选关、下一关、重开关卡和通关面板统一复用关卡显示名称 helper，减少 UI 标题/提示文案读取逻辑重复。
- 关卡名称会去除首尾空格，空名称回退为“未命名关卡”。
- 扩展逻辑冒烟测试，验证关卡显示名称 trim 和中文 fallback。
- 扩展代码风格审计，禁止旧的关卡名称直接拼接方式回流。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.89 - 必要项目文件快照备份

- 创建 `.backup/necessary_code_20260704_043808`，用于保存当前可运行项目的必要轻量文件。
- 备份内容包含 `project.godot`、`scenes/`、`scripts/`、`tests/`、`docs/`、`enemy1/` 和 `CHANGELOG.md`。
- 未复制 Godot 可执行文件、`.godot` 缓存目录和 `.git` 仓库数据，避免备份体积过大且减少无关文件干扰。

验证：
- 已确认 `.backup/necessary_code_20260704_043808` 存在。
- 已确认备份目录内包含 30 个文件。

---

## ver0.13.90 - 建塔 UI 塔配置显示入口收口

- 创建 `.backup/backup_gameui_tower_display_helpers_20260704_044040`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `GameUI.gd` 新增 `_get_tower_display_name()` 和 `_get_tower_category_label()`。
- 建塔详细按钮、分类标签和收起后的简易按钮 tooltip 统一使用塔显示 helper。
- 塔名称和分类标签会去除首尾空格，空值分别回退为“防御塔”和“武器塔”。
- 扩展逻辑冒烟测试，验证塔名称与分类标签的 trim 和中文 fallback。
- 扩展代码风格审计，禁止旧的建塔 UI 名称/分类直读方式回流。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.91 - 主流程塔与卡牌显示名称入口收口

- 创建 `.backup/backup_main_display_name_helpers_20260704_044520`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `Main.gd` 新增 `_get_tower_type_display_name()` 和 `_get_reward_card_display_name()`。
- 塔未解锁提示统一使用塔显示名称 helper，空名称回退为“防御塔”。
- 奖励卡获得、存入、手牌已满、丢弃保留和调试创建提示统一使用奖励卡显示名称 helper。
- 奖励卡显示名称会先经过现有卡牌归一化逻辑，仅传入 `id` 的卡牌也会解析到默认中文名称。
- 扩展逻辑冒烟测试，验证塔和奖励卡显示名称 trim、中文 fallback，以及按卡牌 `id` 解析默认中文名称。
- 扩展代码风格审计，禁止旧的主流程塔/卡牌显示名称直读方式回流。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.92 - 关卡选择与手牌 UI 显示入口收口

- 创建 `.backup/backup_gameui_card_level_display_helpers_20260704_045000`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `GameUI.gd` 新增 `_format_level_select_button_text()`、`_get_level_config_display_name()`、`_get_level_config_description()`、`_get_card_display_name()`、`_get_card_type_label()` 和 `_get_card_description()`。
- 选关卡片文本统一由 helper 格式化，关卡空名称回退为“未知关卡”，描述会去除首尾空格。
- 手牌卡片标题、类型、tooltip、悬停详情和新卡待处理标题统一使用卡牌显示 helper。
- 卡牌空名称和空类型均回退为“卡牌”，描述会去除首尾空格。
- 扩展逻辑冒烟测试，覆盖关卡选择文本格式化、卡牌名称/类型/描述 trim 和中文 fallback。
- 扩展代码风格审计，禁止旧的关卡选择与手牌 UI 字段直读方式回流。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.93 - 实体显示名称入口收口

- 创建 `.backup/backup_entity_display_name_helpers_20260704_045450`，备份本轮改动相关的 `BuildManager.gd`、`Tower.gd`、`Enemy.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `BuildManager.gd` 新增 `_get_tower_display_name()`，建造提示使用统一的塔显示名称 helper，空名称回退为“防御塔”。
- 在 `Tower.gd` 新增 `_get_tower_display_name()` 和 `_get_augmentation_display_name()`，塔本体名称与增益塔名称统一做 trim 和中文 fallback。
- 在 `Enemy.gd` 新增 `_get_enemy_display_name()`，敌人显示名称统一做 trim，空名称回退为“步兵”。
- 扩展逻辑冒烟测试，覆盖建造管理器、炮塔、增益塔和敌人显示名称 helper 的 trim 与中文 fallback。
- 扩展代码风格审计，禁止旧的实体显示名称直读默认值写法回流。

验证：
- Godot 4.7 `BuildManager.gd` 脚本语法检查通过。
- Godot 4.7 `Tower.gd` 脚本语法检查通过。
- Godot 4.7 `Enemy.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.94 - 控制台敌人类型显示名称入口收口

- 创建 `.backup/backup_main_enemy_type_display_helper_20260704_050025`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `Main.gd` 新增 `DEFAULT_ENEMY_TYPE_DISPLAY_NAME` 和 `_get_enemy_type_config_display_name()`。
- 控制台 `spawn` 命令的敌人类型显示名称统一通过 helper 读取，名称会去除首尾空格，空名称回退为“敌人”。
- 保留 `_get_enemy_type_display_name()` 作为按敌人类型 id 解析中文名称的入口，避免控制台提示暴露内部英文 id。
- 扩展逻辑冒烟测试，覆盖敌人类型显示名称 trim、中文 fallback，以及 `runner` id 解析为“疾行者”。
- 扩展代码风格审计，禁止旧的敌人类型显示名称直读默认值写法回流。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.95 - 紧凑建塔图标显示入口收口

- 创建 `.backup/backup_gameui_tower_icon_helper_20260704_050610`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `GameUI.gd` 新增 `DEFAULT_TOWER_ICON_TEXT`、`_get_tower_icon_text()` 和 `_has_ascii_letter()`。
- 收起建塔菜单中的紧凑塔按钮图标统一通过 helper 生成，优先使用配置图标，空图标时从中文塔名取首字。
- 如果配置图标或 fallback 图标包含英文字母，会回退为“塔”，避免紧凑建塔栏重新出现英文缩写。
- 扩展逻辑冒烟测试，覆盖图标 trim、中文塔名 fallback，以及英文图标/英文名称回退中文“塔”。
- 扩展代码风格审计，禁止旧的 `config.get("icon", type_id...)` 紧凑图标直读方式回流。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.96 - 粒子内部节点命名入口收口

- 创建 `.backup/backup_particle_burst_node_name_helper_20260704_051120`，备份本轮改动相关的 `ParticleBurst.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `ParticleBurst.gd` 新增 `DEFAULT_PARTICLE_NODE_NAME`、`_get_particle_node_name()` 和 `_is_ascii_identifier_text()`。
- 粒子节点内部名称不再直接读取 `config.name`，而是统一经过 helper 规范化。
- 合法英文逻辑名会去除首尾空格后保留；空名称或非 ASCII 名称会回退为 `ParticleBurst`，避免内部节点名混入中文显示文本。
- 扩展逻辑冒烟测试，覆盖英文粒子节点名 trim 和中文节点名 fallback。
- 扩展代码风格审计，禁止旧的粒子节点名直读方式回流。

验证：
- Godot 4.7 `ParticleBurst.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.97 - 未知卡牌图标中文 fallback

- 创建 `.backup/backup_card_unknown_icon_fallback_20260704_051640`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `GameUI.gd` 新增 `DEFAULT_CARD_ICON_TEXT`。
- 未知卡牌图标 fallback 从 `?` 改为“卡”，避免手牌中再次出现问号卡牌。
- 调整逻辑冒烟测试，确认 `card_id` 别名会解析为明确图标“攻”，未知卡牌会显示中文 fallback“卡”。
- 扩展代码风格审计，禁止 `GameUI.gd` 中重新出现 `return "?"` 作为图标 fallback。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.98 - 顶部状态栏文本格式化入口收口

- 创建 `.backup/backup_gameui_status_text_helpers_20260704_052030`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `GameUI.gd` 新增 `_format_gold_status_text()`、`_format_base_health_status_text()`、`_format_level_status_text()` 和 `_format_wave_status_text()`。
- `update_status()` 不再直接拼接金币、基地、关卡和波次文案，统一通过状态文本 helper 生成。
- 扩展逻辑冒烟测试，覆盖四类顶部状态文本的中文格式。
- 扩展代码风格审计，禁止 `update_status()` 中重新出现状态栏文案直写。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.13.99 - 面板切换与手牌标签文本入口收口

- 创建 `.backup/backup_gameui_toggle_label_helpers_20260704_052600`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `GameUI.gd` 新增 `_get_build_panel_toggle_text()`、`_get_card_hand_toggle_text()` 和 `_format_card_hand_label_text()`。
- 建塔面板展开/收起按钮、手牌展开/收起按钮、手牌数量与丢弃模式提示统一改为通过 helper 生成显示文本。
- 扩展逻辑冒烟测试，覆盖建塔面板按钮、手牌按钮、展开/收起手牌数量和丢弃提示文本。
- 扩展代码风格审计，禁止这些 UI 文案重新回到零散直写。

验证：
- Godot 4.7 `CodeStyleAuditTest.gd` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 通过。

---

## ver0.14.0 - 必要代码文件快照备份

- 创建 `.backup/necessary_code_snapshot_20260704_050813`，复制当前必要项目文件。
- 本次快照包含 `project.godot`、`CHANGELOG.md`、`scenes/`、`scripts/`、`tests/`、`docs/` 和 `enemy1/`。
- 本次快照不包含 Godot 可执行文件、`.godot` 导入缓存、`.git` 仓库数据和历史 `.backup` 内容，避免备份体积膨胀。

验证：
- 已核对 `.backup/necessary_code_snapshot_20260704_050813` 文件清单。
- Godot 4.7 `CodeStyleAuditTest.gd` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 通过。

---

## ver0.14.1 - 塔详情面板文本入口收口

- 创建 `.backup/backup_tower_panel_text_helpers_20260704_051020`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `GameUI.gd` 新增 `_format_tower_panel_info_text()`、`_get_tower_upgrade_button_text()`、`_is_tower_upgrade_button_disabled()` 和 `_format_tower_sell_button_text()`。
- `show_tower_panel()` 不再直接拼接塔等级、伤害、射程、间隔、升级费用、满级状态和出售返还文案，统一通过 helper 获取显示文本和按钮状态。
- 扩展逻辑冒烟测试，覆盖塔详情文本、升级按钮、满级按钮状态和出售按钮文本。
- 扩展代码风格审计，禁止旧的塔面板文案拼接形式回流。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.2 - 关卡提示与通关面板文本入口收口

- 创建 `.backup/backup_level_ui_text_helpers_20260704_052025`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `GameUI.gd` 新增 `_format_level_intro_title_text()`、`_format_level_clear_console_text()`、`_get_level_clear_title_text()`、`_format_level_clear_subtitle_text()` 和 `_get_level_clear_next_button_text()`。
- 关卡进入横幅、通关控制台提示、通关面板标题/副标题和“进入下一关”按钮文本统一改为通过 helper 生成。
- 扩展逻辑冒烟测试，覆盖关卡编号补零、通关控制台行、通关标题、副标题和下一关按钮文本。
- 扩展代码风格审计，禁止旧的关卡 UI 文案直写形式回流。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.3 - 待处理卡牌面板文本入口收口

- 创建 `.backup/backup_pending_card_text_helpers_20260704_053015`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `GameUI.gd` 新增 `_get_card_sell_zone_icon_text()`、`_get_pending_card_keep_hint_text()`、`_get_pending_card_reject_button_text()`、`_format_pending_card_title_text()`、`_get_pending_card_description_text()`、`_get_hand_card_hint_text()` 和 `_format_pending_card_timer_text()`。
- 手牌出售区图标、满手牌替换提示、放弃新卡按钮、新卡标题/说明、手牌拖拽/丢弃提示和自动放弃倒计时统一改为通过 helper 生成。
- 扩展逻辑冒烟测试，覆盖新卡待处理面板、拖拽/丢弃提示和倒计时负值钳制。
- 扩展代码风格审计，禁止旧的待处理卡牌 UI 文案直写形式回流。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.4 - 主流程状态消息入口收口

- 创建 `.backup/backup_main_status_message_helpers_20260704_054030`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `Main.gd` 新增一组状态消息 helper，覆盖当前关卡、锁关、开波、塔解锁、暂停/继续、重开、返回开始界面、出怪完成、金币奖励、基地受击、精英眩晕、关卡完成、波间倒计时和自动开波提示。
- 主流程中的对应 `_message` 赋值不再直接拼接中文显示文本，统一改为调用英文命名 helper。
- 扩展逻辑冒烟测试，直接覆盖这些 helper 的中文输出格式。
- 扩展代码风格审计，禁止这批旧的 `_message = "..."` 直写形式回流。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.5 - 奖励卡牌消息入口收口

- 创建 `.backup/backup_main_reward_card_message_helpers_20260704_055100`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `Main.gd` 新增奖励卡牌消息 helper，覆盖奖励卡牌控制台提示、存入手牌、满手牌保留提示、待处理卡牌阻塞、替换/放弃/超时、出售卡牌和全部卡牌效果反馈。
- 奖励卡牌流程中的对应 `_message` 与控制台行不再直接拼接中文显示文本，统一改为调用英文命名 helper。
- 扩展逻辑冒烟测试，直接覆盖奖励卡牌消息 helper 的中文输出格式。
- 扩展代码风格审计，禁止这批旧的卡牌消息直写形式回流。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.6 - 胜利失败结束状态文本入口收口

- 创建 `.backup/backup_main_end_state_text_helpers_20260704_060420`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `Main.gd` 新增 `_get_victory_message_text()`、`_get_victory_title_text()`、`_get_victory_subtitle_text()`、`_get_defeat_message_text()`、`_get_defeat_title_text()` 和 `_get_defeat_subtitle_text()`。
- 胜利/失败流程中的状态提示、结束覆盖层标题和副标题不再直接写中文文本，统一通过 helper 获取。
- 扩展逻辑冒烟测试，覆盖胜利和失败结束状态文本 helper 输出。
- 扩展代码风格审计，禁止旧的胜利/失败状态和覆盖层文本直写形式回流。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.7 - 必要代码文件快照备份

- 创建 `.backup/necessary_code_snapshot_20260704_053154`，用于保存当前可运行项目状态的必要文件。
- 本次快照包含 `project.godot`、`scenes/`、`scripts/`、`tests/`、`docs/`、`enemy1/` 和 `CHANGELOG.md`。
- 本轮未修改游戏逻辑、UI 逻辑或测试代码，仅建立恢复点。

验证：
- 已确认备份目录创建完成。
- 本次为文件快照操作，未运行 Godot 脚本验证。

---

## ver0.14.8 - 控制台命令文本入口收口

- 创建 `.backup/backup_main_console_command_helpers_20260704_053246`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `Main.gd` 新增控制台命令响应 helper，覆盖开始游戏、开波、载入关卡、下一关、金币、基地生命、生成敌人、清场、测试卡牌、胜利/失败动画、重载、状态和未知命令文本。
- `_execute_console_command()` 不再直接拼接这批中文显示文本，命令分支只保留流程控制和状态变更。
- `_apply_base_damage()` 的控制台调试受击提示也改为调用英文命名 helper。
- 扩展逻辑冒烟测试，直接覆盖控制台响应 helper 的中文输出格式。
- 扩展代码风格审计，禁止旧的控制台动态拼接和 `set_message()` 直写形式回流。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.9 - 建造管理提示文本入口收口

- 创建 `.backup/backup_build_manager_message_helpers_20260704_053656`，备份本轮改动相关的 `BuildManager.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `BuildManager.gd` 新增建造、取消、增益叠加、建造成功、升级、出售和建造失败原因 helper。
- 建造、升级、出售流程不再直接向 `game.set_message()` 写入这批中文显示文本，改为调用英文命名 helper。
- `_selected_tower_name` 初始值改为复用 `DEFAULT_TOWER_DISPLAY_NAME`，避免同一默认显示文本重复散落。
- 扩展逻辑冒烟测试，覆盖 `BuildManager` 提示文本 helper 的中文输出格式。
- 扩展代码风格审计，禁止旧的建造管理提示直写形式回流。

验证：
- Godot 4.7 `BuildManager.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.10 - 炮塔升级特性文本入口收口

- 创建 `.backup/backup_tower_trait_text_helpers_20260704_054010`，备份本轮改动相关的 `Tower.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `Tower.gd` 新增升级预览、基础特性、各塔升级特性和增益特性行 helper。
- `get_upgrade_preview()` 不再直接按塔类型拼接中文预览文本，改为通过英文命名 helper 获取升级特性名并格式化。
- 各塔升级分支中的 `level_trait` 不再直接写中文特性描述，改为调用对应 helper。
- 增益塔叠加的特性行改为通过 `_format_augmentation_trait_line_text()` 生成。
- 扩展逻辑冒烟测试，覆盖塔升级预览、基础特性、升级特性和增益特性文本 helper。
- 扩展代码风格审计，禁止旧的塔升级/特性文本直写形式回流。

验证：
- Godot 4.7 `Tower.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.11 - 敌人默认显示名入口收口

- 创建 `.backup/backup_enemy_display_default_helper_20260704_054346`，备份本轮改动相关的 `Enemy.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `Enemy.gd` 新增 `_get_default_enemy_display_name()`，用于统一返回敌人默认显示名。
- `enemy_name` 的初始值不再直接写中文显示文本，改为调用英文命名 helper。
- 扩展逻辑冒烟测试，覆盖敌人默认显示名 helper。
- 扩展代码风格审计，禁止旧的 `enemy_name` 中文直写初始化回流。

验证：
- Godot 4.7 `Enemy.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.12 - 固定界面文本入口收口

- 创建 `.backup/backup_gameui_static_screen_text_helpers_20260704_054538`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `GameUI.gd` 新增开始界面、选关界面、暂停菜单、结束菜单和控制台固定文案 helper。
- 开始标题/副标题、开始游戏、选择关卡、选关标题/副标题/返回按钮不再直接写在 UI 创建逻辑中。
- 暂停菜单标题、提示、继续/重开/返回开始界面按钮改为通过 helper 获取显示文本。
- 结束菜单重开和返回开始界面按钮、控制台标题、输入框占位符和初始提示行改为通过 helper 获取显示文本。
- 扩展逻辑冒烟测试，覆盖这些固定界面文本 helper。
- 扩展代码风格审计，禁止旧的固定界面文本直写形式回流。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.13 - 动态 UI 文本入口收口

- 创建 `.backup/backup_gameui_dynamic_text_helpers_20260704_054859`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `GameUI.gd` 新增锁关按钮、锁关提示、塔解锁 tooltip、紧凑塔 tooltip、武器/增益塔统计文本、武器/增益塔按钮文本和控制台补全提示 helper。
- 选关锁定状态不再直接拼接 `未解锁` 与前置关卡 tooltip，改为调用英文命名 helper。
- 塔按钮解锁提示、详细/紧凑建塔按钮统计文案不再直接散落在按钮创建和状态刷新逻辑中。
- 控制台 Tab 补全的“没有可补全项”和“可选补全”提示改为通过 helper 输出。
- 扩展逻辑冒烟测试，覆盖这些动态 UI 文本 helper。
- 扩展代码风格审计，禁止旧的动态 UI 文本直写形式回流。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.14 - 卡牌图标文本入口收口

- 创建 `.backup/backup_gameui_card_icon_text_helpers_20260704_055230`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `GameUI.gd` 新增各类卡牌图标文本 helper，覆盖伤害、射程、攻速、治疗、导弹、冷冻、全屏火焰、冻结全屏、概率补给、基地加固和金币卡牌。
- `_card_icon()` 不再直接在类型分支中返回中文图标字，改为调用英文命名 helper。
- 扩展逻辑冒烟测试，覆盖卡牌图标 helper 的中文输出。
- 扩展代码风格审计，禁止旧的卡牌图标直写返回形式回流。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.15 - 必要代码快照备份

- 创建 `.backup/necessary_code_snapshot_20260704_055500`，备份当前可运行项目所需的必要文件。
- 快照包含 `scripts`、`scenes`、`tests`、`docs`、`enemy1`、`project.godot` 和 `CHANGELOG.md`。
- 未复制旧 `.backup`、`.godot` 缓存、`.git` 和 Godot 可执行文件，避免备份膨胀。

验证：
- 已确认快照目录创建成功。
- 已确认快照中包含脚本、场景、测试、文档、enemy1 动画帧和项目配置文件。

---

## ver0.14.16 - 主要 UI 操作文本入口收口

- 创建 `.backup/backup_gameui_action_text_helpers_20260704_055617`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `GameUI.gd` 新增开始波次、下一关、塔面板关闭、升级占位、出售占位和建造栏标题文本 helper。
- 顶部 HUD 按钮、塔详情面板初始按钮和建造栏标题不再直接在 UI 创建逻辑中写中文显示文本。
- 扩展逻辑冒烟测试，覆盖这些新增 UI 操作文本 helper。
- 扩展代码风格审计，禁止旧的按钮/标题直写形式回流。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.17 - 炮塔默认显示名入口收口

- 创建 `.backup/backup_tower_default_display_helpers_20260704_055826`，备份本轮改动相关的 `Tower.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `Tower.gd` 新增 `_get_default_tower_display_name()` 与 `_get_default_augmentation_display_name()`。
- `display_name` 字段不再直接用中文初始化，改为通过英文命名 helper 获取默认显示名。
- 炮塔名和增幅塔名 fallback 不再直接返回默认常量，统一通过 helper 输出。
- 扩展逻辑冒烟测试，覆盖默认塔名、默认增幅塔名和字段初始化路径。
- 扩展代码风格审计，禁止旧的 `display_name` 中文直写初始化和默认名直返形式回流。

验证：
- Godot 4.7 `Tower.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.18 - 主状态初始提示入口收口

- 创建 `.backup/backup_main_initial_message_helper_20260704_060038`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- `Main.gd` 的 `_message` 字段不再直接用中文提示初始化，改为调用 `_get_start_screen_message_text()`。
- 扩展逻辑冒烟测试，用未入树的 `Main.new()` 探针验证初始 `_message` 与开始提示 helper 保持一致。
- 扩展代码风格审计，禁止旧的 `_message` 中文直写初始化回流。
- 过程中曾用已入树场景实例断言初始 `_message`，该断言会被 `_ready()` 后的状态刷新影响；已改为未入树实例探针，避免测试位置误判。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.19 - 建造管理默认显示名入口收口

- 创建 `.backup/backup_build_manager_default_display_helper_20260704_060324`，备份本轮改动相关的 `BuildManager.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `BuildManager.gd` 新增 `_get_default_tower_display_name()`，统一输出建造管理默认塔名。
- `_selected_tower_name` 字段不再直接使用默认显示名常量初始化，改为调用英文命名 helper。
- `_get_tower_display_name()` 的空名称 fallback 不再直接返回默认常量，统一通过 helper 输出。
- 扩展逻辑冒烟测试，覆盖默认塔名 helper 与 `_selected_tower_name` 初始化路径。
- 扩展代码风格审计，禁止旧的默认塔名常量直初始化和 fallback 直返形式回流。

验证：
- Godot 4.7 `BuildManager.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.20 - 主逻辑默认显示名入口收口

- 创建 `.backup/backup_main_default_display_helpers_20260704_060554`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `Main.gd` 新增默认关卡名、默认塔名、默认奖励卡牌名和默认敌人类型名 helper。
- `_get_level_display_name()`、`_get_tower_type_display_name()`、`_get_reward_card_display_name()` 和 `_get_enemy_type_config_display_name()` 的 fallback 不再直接返回中文文本或默认常量，统一通过英文命名 helper 输出。
- 扩展逻辑冒烟测试，覆盖四类默认显示名 helper。
- 扩展代码风格审计，禁止旧的默认显示名直返形式回流。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.21 - GameUI 默认显示文本入口收口

- 创建 `.backup/backup_gameui_default_display_helpers_20260704_060830`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `GameUI.gd` 新增默认塔名、塔类别、塔图标、关卡名、卡牌名、卡牌类型和卡牌图标 helper。
- 塔、关卡、卡牌相关 UI fallback 不再直接返回默认常量，统一通过英文命名 helper 输出。
- 未知卡牌图标 fallback 从直接返回默认常量改为调用 `_get_default_card_icon_text()`。
- 扩展逻辑冒烟测试，覆盖新增默认显示文本 helper。
- 扩展代码风格审计，禁止旧的默认文本/图标直返形式回流。
- 过程中风格审计曾误伤 `_get_default_card_icon_text()` helper 本身；已将禁止项收窄到旧的 `_card_icon()` 分支直返形式。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.22 - 必要代码文件备份

- 按用户要求创建 `.backup/necessary_code_backup_20260704_061315`。
- 备份范围包含 `project.godot`、`scenes/`、`scripts/`、`tests/` 和 `CHANGELOG.md` 等当前项目运行与验证所需文件。
- 本次未改动游戏逻辑，仅做维护性备份记录。

验证：
- 已确认备份目录内共有 22 个文件。

---

## ver0.14.23 - 塔特性显示文本常量化

- 创建 `.backup/backup_tower_trait_text_helpers_20260704_061407`，备份本轮改动相关的 `Tower.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `Tower.gd` 将默认特性、满级提示、各塔升级特性名和基础特性文本迁移到英文命名的显示文本常量。
- 塔特性 helper 不再在函数体内创建中文临时变量，统一返回对应显示文本常量。
- 扩展代码风格审计，禁止塔特性文本旧的中文临时变量写法回流。
- 本轮未改动炮塔战斗数值、目标选择、升级效果或 UI 行为。

验证：
- Godot 4.7 `Tower.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.24 - 建造错误提示文本常量化

- 创建 `.backup/backup_build_manager_error_text_constants_20260704_061639`，备份本轮改动相关的 `BuildManager.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `BuildManager.gd` 新增英文命名的建造错误提示显示文本常量。
- 建造金币不足、地图外、增益塔目标、增益层已满、格子占用和道路阻挡等错误 helper 不再创建中文 `error_text` 临时变量。
- 扩展代码风格审计，禁止建造错误提示旧的中文临时变量写法回流。
- 本轮未改动建造判定顺序、扣费逻辑、选塔逻辑或 UI 交互。

验证：
- Godot 4.7 `BuildManager.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.25 - GameUI 卡牌图标文本常量化

- 创建 `.backup/backup_gameui_card_icon_constants_20260704_061845`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `GameUI.gd` 新增伤害、射程、攻速、治疗、导弹、冷冻、全屏火焰、全屏冻结、概率补给、基地加固和金币卡牌的图标显示文本常量。
- 卡牌图标 helper 不再创建中文 `icon_text` 临时变量，统一返回英文命名的显示文本常量。
- 扩展代码风格审计，禁止卡牌图标旧的中文临时变量写法回流。
- 本轮未改动卡牌拖拽、使用、出售、替换或动画逻辑。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.26 - BuildManager 操作消息文本常量化

- 创建 `.backup/backup_build_manager_message_text_constants_20260704_062113`，备份本轮改动相关的 `BuildManager.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `BuildManager.gd` 新增建造模式、取消建造、增益叠加、建造成功、未选择塔、满级、升级金币不足、升级成功和出售成功的英文命名显示文本常量。
- 建造、升级和出售相关消息 helper 不再直接返回中文字符串或中文格式模板，统一返回对应常量或常量格式化结果。
- 扩展代码风格审计，禁止 BuildManager 操作消息 helper 旧的直接返回中文文本写法回流。
- 本轮未改动建造判定、扣费、升级、出售、选塔或 UI 交互逻辑。

验证：
- Godot 4.7 `BuildManager.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.27 - GameUI 基础 HUD 与按钮文本常量化

- 创建 `.backup/backup_gameui_hud_button_text_constants_20260704_062349`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `GameUI.gd` 新增金币、基地生命、关卡、波次状态文本模板，以及开始波次、下一关、关闭、升级、出售、建造、建塔展开/收起和手牌展开/收起等英文命名显示文本常量。
- 基础 HUD 与按钮文本 helper 不再直接返回中文字符串或中文格式模板，统一返回对应常量或常量格式化结果。
- 扩展代码风格审计，禁止 GameUI 基础 HUD 与按钮文本 helper 旧的直接返回中文文本写法回流。
- 本轮未改动 UI 布局、动画、按钮连接、状态刷新或卡牌交互逻辑。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.28 - GameUI 静态界面文本常量化

- 创建 `.backup/backup_gameui_static_screen_text_constants_20260704_062637`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `GameUI.gd` 新增开始界面、选关界面、结束菜单、暂停菜单和调试控制台的英文命名显示文本常量。
- 静态界面文本 helper 不再直接返回中文字符串，统一返回对应常量。
- 扩展代码风格审计，禁止这些静态界面文本 helper 旧的直接返回中文文本写法回流。
- 本轮未改动界面构建结构、动画、按钮连接、控制台逻辑或游戏流程。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.29 - GameUI 手牌与面板文本常量化

- 创建 `.backup/backup_gameui_panel_completion_text_constants_20260704_062919`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `GameUI.gd` 新增手牌数量、手牌丢弃提示、锁定关卡、塔解锁提示、塔按钮统计、控制台补全提示、塔面板信息、升级/出售按钮和关卡完成文本的英文命名显示文本常量。
- 手牌、塔面板、塔按钮、控制台补全和关卡完成相关 helper 不再直接创建或返回中文字符串模板，统一使用常量或常量格式化结果。
- 扩展代码风格审计，禁止这些 helper 旧的直接中文文本写法回流。
- 本轮未改动 UI 节点结构、动画、按钮连接、手牌交互、塔升级/出售逻辑或关卡完成流程。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.30 - GameUI 待处理卡牌文本常量化

- 创建 `.backup/backup_gameui_pending_card_text_constants_20260704_063234`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `GameUI.gd` 新增关卡完成下一关按钮、卡牌出售区图标、待处理卡牌保留/放弃提示、待处理卡牌标题/说明、手牌拖拽/丢弃提示和自动放弃倒计时的英文命名显示文本常量。
- 待处理卡牌与关卡完成按钮相关 helper 不再直接返回中文字符串，统一返回对应常量或常量格式化结果。
- 扩展代码风格审计，禁止这些 helper 旧的直接中文文本写法回流。
- 本轮未改动待处理卡牌替换、放弃、出售、拖拽、倒计时或关卡完成按钮逻辑。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.14.31 - GameUI 选关卡片模板常量化

- 创建 `.backup/backup_gameui_level_card_template_20260704_063519`，备份本轮改动相关的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `GameUI.gd` 新增 `LEVEL_SELECT_CARD_TEMPLATE`，统一管理选关卡片的关卡编号、波次、路线数和描述文本模板。
- `_format_level_select_button_text()` 不再直接返回中文格式模板，改为使用英文命名显示文本常量。
- 扩展代码风格审计，禁止选关卡片旧的直接中文模板写法回流。
- 本轮未改动选关列表生成、解锁判断、按钮状态、滚动容器或选关动画逻辑。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。
- `GameUI.gd` 已无 `return "中文..."` 或 `var ... := "中文..."` 形式的直接中文文本命中。

---

## ver0.14.32 - Main 状态与控制台消息文本常量化

- 创建 `.backup/backup_main_status_message_constants_20260704_063821`，备份本轮改动相关的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `Main.gd` 新增关卡状态、波次状态、暂停/恢复、奖励卡牌、范围卡、胜利失败和控制台返回文本的英文命名显示文本常量。
- 主流程状态消息、卡牌效果消息、胜利失败覆盖层文本和控制台响应 helper 不再直接返回中文字符串或中文格式模板，统一使用常量或常量格式化结果。
- 扩展代码风格审计，禁止 `Main.gd` 中旧的中文消息直写形式回流。
- 本轮未改动关卡流程、波次生成、卡牌效果、胜负判定或控制台命令逻辑。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。
- `Main.gd` 已无 `return "中文..."` 或 `var ... := "中文..."` 形式的直接中文文本命中。

---

## ver0.14.33 - Tower 升级说明文本常量化

- 创建 `.backup/backup_tower_upgrade_text_constants_20260704_084449`，备份本轮改动相关的 `Tower.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 在 `Tower.gd` 新增升级预览、增幅说明和各类炮塔升级特性说明的英文命名显示文本常量。
- 炮塔升级预览、增幅层说明、基础塔、速射塔、散弹塔、重炮塔和狙击塔升级特性 helper 不再直接返回中文字符串模板。
- 扩展逻辑冒烟测试，验证这些升级说明 helper 的玩家可见输出保持不变。
- 扩展代码风格审计，禁止这些旧的中文模板直返写法回流。
- 本轮未改动炮塔伤害、射程、攻速、弹丸、穿透、溅射或升级数值逻辑。

验证：
- Godot 4.7 `Tower.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。
- `scripts/` 已无 `return "中文..."` 或 `var ... := "中文..."` 形式的直接中文文本命中。

---

## ver0.15.0 - 炮塔特性视觉表现增强

- 创建 `.backup/backup_tower_effects_20260704_085233`，备份本轮改动相关的 `Tower.gd`、`Projectile.gd`、`Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 新增 `scripts/ImpactEffect.gd`，用 Godot 内置绘制实现短时战斗视觉效果。
- 子弹新增视觉类型配置，基础塔、速射塔、散弹塔、重炮塔和狙击塔发射的子弹拥有不同弹体、拖尾和命中特效。
- 重炮命中时显示与实际溅射半径一致的圆形冲击波，并保留更强的爆炸粒子反馈。
- 散弹塔开火时显示与实际散射角一致的扇形效果，并保留多弹丸直线弹道。
- 速射塔、狙击塔和基础塔补充各自的枪口/命中反馈；各类塔升级后的塔身绘制差异更明显。
- 扩展逻辑冒烟测试，覆盖效果节点自清理、重炮范围视觉半径、散弹扇形角度和塔/子弹视觉类型。
- 本轮未改动炮塔伤害、射程、攻速、弹丸数量、穿透、溅射或升级数值逻辑。

验证：
- Godot 4.7 `ImpactEffect.gd` 脚本语法检查通过。
- Godot 4.7 `Projectile.gd` 脚本语法检查通过。
- Godot 4.7 `Tower.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.15.1 - 散弹塔方向弹道修复

- 创建 `.backup/backup_shotgun_projectile_spread_20260704_104912`，备份本轮改动相关的 `Tower.gd`、`Projectile.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 修复塔发射子弹时仍把当前索敌目标传入每颗子弹的问题。
- 子弹现在由炮塔在开火瞬间确定方向；散弹塔每颗弹丸按配置散射角生成独立直线方向，初始不携带索敌目标。
- 保留子弹命中检测：子弹飞行中只根据线段碰撞找到实际命中的敌人，不主动追踪炮塔索敌目标。
- 扩展逻辑冒烟测试，验证散弹塔一次开火生成多颗弹丸、弹丸初始无目标，并且方向覆盖配置散射角两侧。
- 本轮未改动散弹塔伤害、攻速、射程、弹丸数量或升级数值。

验证：
- Godot 4.7 `Tower.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.15.2 - 散弹散射、狙击穿透与重炮描述修正

- 创建 `.backup/backup_projectile_spread_sniper_desc_20260704_110607`，备份本轮改动相关的 `Tower.gd`、`Projectile.gd`、`Main.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 提高散弹塔基础和升级后的散射角，让弹丸扇形发散更明显。
- 缩小散弹弹丸碰撞半径，减少所有弹丸看起来都吸向同一目标的观感。
- 狙击弹不再按炮塔射程清理，改为离开当前相机可见屏幕后消失。
- 狙击弹穿透期间继续造成伤害，每次命中后后续伤害按比例递减。
- 修改重炮二级升级说明：重炮基础形态已经自带范围伤害，二级描述改为强化爆破半径和溅射伤害。
- 扩展逻辑冒烟测试，覆盖散弹更大散射角、狙击弹屏幕外清理、狙击穿透伤害递减和重炮说明文本。

验证：
- Godot 4.7 `Projectile.gd` 脚本语法检查通过。
- Godot 4.7 `Tower.gd` 脚本语法检查通过。
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.15.3 - 狙击塔远距离弹速提升

- 创建 `.backup/backup_sniper_projectile_speed_20260704_111849`，备份本轮改动相关的 `Main.gd`、`Tower.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 将狙击塔基础子弹速度从 `520.0` 提高到 `960.0`，让远距离目标更容易在直线弹道下被命中。
- 提高狙击塔 2 级和 3 级升级带来的弹速增量，使升级后的远距离命中稳定性继续增强。
- 保持狙击塔伤害、射程、攻击间隔、穿透和斩杀逻辑不变，本轮只调整弹速相关数值。
- 扩展逻辑冒烟测试，覆盖狙击塔基础弹速和满级弹速下限，避免后续数值回退。
验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `Tower.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.16.0 - 手牌卡牌扩展到20种

- 创建 `.backup/backup_fun_card_pool_20_20260704_171942`，备份本轮改动相关的 `Main.gd`、`GameUI.gd`、`Enemy.gd`、`BuildManager.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 将奖励卡牌池从 11 种扩展到 20 种，新增诱饵信标、尖刺路障、战利品磁铁、时间裂隙、塔位调度、透支超频、紧急按钮、悬赏标记和战术改签。
- 新增敌人临时吸引与任意速度倍率效果，用于诱饵、时间裂隙、尖刺和紧急按钮等趣味卡牌。
- 新增尖刺陷阱、击杀金币磁铁、透支超频负债阶段、悬赏目标奖励和手牌改签逻辑。
- 同步卡牌 UI 图标、颜色、范围预览、控制台 `card` 参数、Tab 补全和 `help` 中文说明。
- 将升级粒子标记为重要反馈，避免新增卡牌粒子较多时关键升级反馈被普通粒子上限吞掉。
- 扩展逻辑冒烟测试，覆盖 20 张卡牌数量、唯一 ID、新卡图标、调试卡创建、控制台补全和新增趣味卡核心效果。
验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `Enemy.gd` 脚本语法检查通过。
- Godot 4.7 `BuildManager.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.16.1 - 卡牌效果稀有度分级

- 创建 `.backup/backup_card_rarity_tiers_20260704_173816`，备份本轮改动相关的 `Main.gd`、`GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 奖励卡牌新增白色、蓝色、紫色、金色、红色五档效果等级；等级越高，伤害、金币、治疗、持续时间、范围和控制强度按规则增强。
- 手牌卡牌 UI 使用稀有度颜色强化边框、标题、图标、类型标签和详情标题，并在类型标签与详情说明中显示对应的“白色/蓝色/紫色/金色/红色效果”。
- 扩展逻辑冒烟测试，覆盖 20 张卡牌的稀有度合法性、稀有度颜色/文字 helper，以及高稀有度卡牌数值放大规则。
- 修复一次 Godot 测试中可能触发“引用了不能为 read 的内存”的崩溃风险：导弹卡稀有度放大后会直接击杀测试敌人，旧断言继续读取已释放敌人；现在测试敌人生命值提高，并只验证其受伤而不访问已释放对象。
- 清理本轮调试用的临时 `RarityCrashProbe.gd` 和 `logic_rarity_test_output.txt`，避免后续导入或测试受到过期探针影响。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过，未再复现内存 read 崩溃。

---

## ver0.16.2 - 抽卡时决定倍率强度颜色

- 创建 `.backup/backup_card_rarity_variants_20260704_183800`，备份本轮改动相关的 `Main.gd`、`GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 保持奖励卡牌池为 20 种基础卡，不再把同一种卡展开成多个重复 ID 的稀有度版本。
- 抽到带倍率、减速倍率、概率、收益系数或牵引强度的卡牌时，才随机决定白色、蓝色、紫色、金色、红色强度档，并把该档位写入卡牌的 `rarity` 与 `strength_multiplier`。
- 固定效果卡牌不做抽取时倍率浮动，例如导弹、治疗、金币、基地加固、全屏火焰等仍按它们自身效果强度保留单一颜色档。
- 概率和收益类字段现在会随强度档缩放并做上限保护，避免高档概率卡超过合理概率区间。
- 扩展逻辑冒烟测试，验证卡池仍为 20 种、ID 唯一、倍率类卡会抽强度、固定效果卡不会抽强度，以及抽到后的颜色档合法。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.16.3 - 卡牌强度倍率规则文档

- 创建 `.backup/backup_card_strength_doc_20260704_211200`，备份本轮文档相关的 `Main.gd` 和 `CHANGELOG.md`。
- 新增 `docs/CARD_STRENGTH_RULES.md`，说明当前卡牌强度档、颜色倍率、抽卡概率、字段缩放公式和 20 张卡牌的随机/固定强度分类。
- 文档明确区分“随机强度卡”和“固定强度卡”：随机强度卡在抽到时决定颜色档，固定强度卡不随机颜色但仍按自身颜色档缩放数值。
- 本轮只新增说明文档和更新日志，未改动游戏运行逻辑。

验证：
- 已确认 `docs/CARD_STRENGTH_RULES.md` 创建成功。

---

## ver0.17.0 - 玩家更新公告系统

- 创建 `.backup/backup_player_update_announcements_20260704_213000`，备份本轮改动相关的 `Main.gd`、`GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 新增 `scripts/UpdateAnnouncements.gd`，用面向玩家的语言维护最近 5 条大更新公告；小修复内容合并进相近的大更新，不直接把开发日志细节展示给玩家。
- 开始界面新增“更新公告”按钮，玩家可以打开独立公告界面查看最近 5 条大更新。
- 首次打开新版本时，如果本地还没有读过最新公告，会自动弹出“本次更新”弹窗。
- 关闭首次公告后，会把最新公告 ID 保存到 `user://announcement_state.cfg`，同一版本后续启动不再重复弹出。
- 公告弹窗和历史界面使用现有像素战术 UI 风格，并带有简短淡入动画和粒子反馈。
- 扩展逻辑冒烟测试，覆盖公告数据数量、开始界面入口、首次公告弹窗、历史公告界面和关闭流程。

验证：
- Godot 4.7 `UpdateAnnouncements.gd` 脚本语法检查通过。
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 通过。

---

## ver0.18.0 - 关卡开局存档与继续游戏

- 创建 `.backup/backup_level_start_save_20260704_223000`，备份本轮改动前的 `Main.gd`、`GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 新增 `user://level_start_save.cfg` 关卡开局存档，记录最近一次开始关卡时的关卡编号、已解锁关卡、金币、基地血量和基地血量上限。
- 开始游戏、选关进入、通关进入下一关、暂停菜单重开本关时，都会刷新“继续游戏”使用的关卡开局状态。
- 开始界面新增“继续游戏”按钮；没有存档时按钮禁用，有存档时可直接回到上一次开始关卡的开局状态。
- 如果玩家已经有更靠后的继续存档，又从更早关卡开始，会先弹出覆盖提醒，确认后才会覆盖继续存档。
- 暂停菜单中返回开始界面时新增离开提醒，告诉玩家可以从本关开局状态继续，避免误以为会保存战斗中途状态。
- 扩展逻辑冒烟测试，覆盖继续按钮状态、关卡开局存档写入、继续读取、覆盖提醒、暂停离开提醒和下一关存档刷新。
验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本语法检查通过。
- `tests/CodeStyleAuditTest.gd` 通过。
- `tests/LogicSmokeTest.gd` 本轮未完成：运行完整冒烟测试时 Godot 4.7 控制台进程在本机触发“引用了不能为 read 的内存”崩溃；已停止继续启动 Godot，并清理残留 Godot 进程与临时测试输出文件。
---

## ver0.19.0 - 稀有度卡面精致度分层

- 创建 `.backup/backup_card_rarity_face_design_20260704_220600`，备份本轮改动前的 `GameUI.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 卡牌 UI 新增统一的稀有度卡面样式入口：确定卡牌稀有度后，直接调用对应的卡面样式配置。
- 白色、蓝色、紫色、金色、红色卡面现在不只改变字体颜色，还会按稀有度生成不同精致度的边框、顶部稀有条、内底纹、标题底板、光泽、角标、能量线和徽点。
- 高稀有度卡牌拥有更厚边框、更多装饰线和更多徽点；红色卡牌作为最高档拥有最强的卡面识别度。
- 扩展逻辑冒烟测试，覆盖稀有度卡面细节分数递增，以及红色卡牌实际生成最高级装饰节点。
验证：
- 本轮未启动 Godot 运行测试，避免再次触发本机 Godot 4.7 “引用了不能为 read 的内存”崩溃。
- 已完成静态检查：无残留 Godot 进程，无临时测试输出文件。
---

## ver0.20.0 - 2D 战场层次与深度优化

- 创建 `.backup/backup_layer_depth_20260704_220256`，备份本轮改动前的核心脚本和更新日志。
- 在 `Main.gd` 中新增统一世界层级常量，并显式创建地图、世界装饰、炮塔、敌人、子弹、命中特效、粒子、世界覆盖和建造预览层，避免继续依赖节点添加顺序决定显示前后。
- 新增 `scripts/WorldDecalRenderer.gd`，把基地、基地受击闪光和道路尖刺陷阱从根节点绘制中拆到低层世界装饰层。
- 新增 `scripts/WorldOverlayRenderer.gd`，把导弹、冻结、火焰风暴、诱饵、时间裂隙等卡牌范围反馈拆到高层世界覆盖层。
- 炮塔、敌人和弹丸新增俯视角接地阴影；出怪门和基地增加底部阴影、高光和受击反馈，让 2D 场景更有前后层次。
- 炮口火光、散弹扇形、狙击轨迹、重炮爆炸等短时战斗反馈改为进入独立 `ImpactLayer`，保证它们显示在子弹和敌人之上。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“战场层次更清楚了”的面向玩家公告，并设为首次打开弹窗的最新版本。
- 扩展 `LogicSmokeTest.gd`，验证新世界图层存在、层级顺序固定，以及重炮/散弹特效进入新的命中特效层。

验证：
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
- 已完成静态代码检查与测试断言更新。
- 完整 `tests/LogicSmokeTest.gd` 本轮尝试运行但 70 秒未返回，已中止并清理残留 Godot 进程；没有看到新的解析报错输出。
---

## ver0.20.1 - 世界绘制死代码清理

- 创建 `.backup/backup_code_cleanup_20260704_221417`，备份本轮清理前的 `Main.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 删除 `Main.gd` 中上一轮层级拆分后残留的空 `_draw()`、旧基地绘制、旧道路尖刺绘制和旧卡牌范围绘制函数。
- 世界低层装饰继续由 `WorldDecalRenderer.gd` 管理，卡牌范围覆盖继续由 `WorldOverlayRenderer.gd` 管理，避免同一视觉效果存在两套入口。
- 扩展 `LogicSmokeTest.gd`，明确断言 `Main` 不再保留这些旧绘制 helper，防止后续回流。

验证：
- Godot 4.7 `GameUI.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.20.2 - 范围特效状态写入收拢

- 创建 `.backup/backup_two_round_cleanup_20260704_221703`，备份本轮两次优化前的 `Main.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 在 `Main.gd` 新增 `_show_world_area_effect()`，统一设置世界范围特效的位置、半径、主色、强调色、持续时间和重绘请求。
- 导弹、冻结、火焰风暴、全屏冻结、诱饵信标、道路尖刺和时间裂隙卡牌不再各自重复写入同一组 `_missile_effect_*` 与 `_world_effect_*` 字段。
- 本轮只整理代码结构，不改变卡牌伤害、控制、粒子数量或显示颜色。

验证：
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.20.3 - 世界层创建流程收拢

- 在 `Main.gd` 新增 `_create_world_layer()`，统一创建可暂停的 `Node2D` 世界层，并设置名称与 `z_index`。
- `TowerLayer`、`EnemyLayer`、`ProjectileLayer`、`ImpactLayer` 和 `ParticleLayer` 改为通过同一个 helper 创建，减少重复样板代码。
- 保留现有图层顺序和测试断言不变，确保地图、装饰、炮塔、敌人、子弹、命中特效、粒子和覆盖层的前后关系不变。

验证：
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.21.0 - 敌潮密度与数量提升

- 创建 `.backup/backup_enemy_density_20260704_223907`，备份本轮调参前的 `WaveManager.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 在 `WaveManager.gd` 中把刷怪数量和刷怪间隔改为命名常量，方便后续继续调平衡。
- 每波基础敌人数量从旧公式的 10 个提高到 12 个，每波增长从 3 个提高到 4 个。
- 后续关卡和多路线关卡会追加更多敌人，多刷怪点地图会更容易形成密集敌潮。
- 刷怪间隔略微缩短，且会随波次、关卡和路线数下降；最低间隔从 0.32 秒调整到 0.26 秒。
- 本轮不改变敌人血量、速度、击杀奖励、基地伤害或精英怪规则。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“敌潮更密集了”的玩法公告。
- 扩展 `LogicSmokeTest.gd`，验证多路线、后期波次和后期关卡会得到更高数量与更短间隔。

验证：
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.21.1 - 敌潮密度继续加压

- 创建 `.backup/backup_enemy_density_followup_20260704_2248`，备份本轮调参前的 `WaveManager.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 在 `WaveManager.gd` 中继续适当提高刷怪数量：基础敌人从 12 提到 13，每波增长从 4 提到 5。
- 后续关卡成长加成从每两关 +2 提到 +3，多路线额外加成从每条额外路线 +2 提到 +3，让多刷怪点地图更快形成敌潮。
- 刷怪间隔从 0.52 秒降到 0.50 秒，并提高波次、关卡、路线数带来的间隔压缩；最低间隔从 0.26 秒降到 0.23 秒。
- 本轮仍不改变敌人血量、速度、奖励、基地伤害、精英怪规则或炮塔数值，避免一次性把难度抬得过猛。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“敌潮继续加压”的最新玩法公告。
- 更新 `LogicSmokeTest.gd` 的密度断言，保护多路线首波、后期关卡和后期波次的数量/间隔规则。

验证：
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.22.0 - 事件特效差异化

- 创建 `.backup/backup_vfx_differentiation_20260704_2305`，备份本轮改动前的 `GameUI.gd`、`Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 在 `GameUI.gd` 中保留统一 `_spawn_ui_particles()` 入口，但新增按事件名套用的粒子配置：胜利、失败、关卡完成、关卡进入、卡牌使用、卡牌丢弃、暂停、确认弹窗和开始游戏不再只靠颜色区分。
- 胜利弹窗粒子改为向上扩散并略带上浮；失败弹窗粒子改为向下坠落并带更强重力；关卡完成弹窗改为轻量上升的庆祝反馈。
- 卡牌使用保持短促爆发，卡牌丢弃改为下坠，暂停菜单改为低速漂浮，确认弹窗改为窄角度警示反馈。
- 在 `Main.gd` 中新增 `spawn_level_clear_particles()`，关卡完成时基地附近不再复用普通范围爆散，而是使用独立的上升庆祝粒子。
- 胜利和失败的世界层全屏粒子拆分为 `VictoryScreenParticles` 与 `DefeatScreenParticles`，方向、寿命、重力、数量和尺度都不同。
- `spawn_area_particles()` 新增可选语义名，并为精英怪眩晕、炮塔增益、范围增益、攻速增益、治疗、导弹、冰冻、火焰风暴、全屏冻结、诱饵、尖刺、金币磁铁、时间裂隙、塔位调度、过载、紧急按钮、悬赏、开箱成功、基地加固和重抽卡牌分别配置不同粒子表现。
- 导弹粒子更像爆炸冲击，冰冻粒子更慢更轻，火焰风暴改为下落打击，金币类粒子上浮，尖刺类粒子变成短促下坠碎屑。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“特效更分得清了”的画面更新公告。
- 扩展 `LogicSmokeTest.gd`，验证 UI 事件粒子配置复用缓存但按事件产生不同方向、重力和时长；同时验证关卡完成、胜利、失败、导弹、冰冻、火焰风暴、金币和尖刺世界粒子的独立命名与配置差异。

验证：
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.23.0 - 后期金币曲线再平衡

- 创建 `.backup/backup_reward_curve_rebalance_20260704_2325`，备份本轮改动前的 `WaveManager.gd`、`Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 削弱击杀奖励成长：基础击杀奖励从 `10 + wave / 2` 调整为 `9 + wave / 4`，后期单只怪物金币增长更慢。
- 削弱同波密集刷怪奖励：同一波内的出怪序号奖励从每 8 只 `+1` 调整为每 20 只 `+1`，并封顶为 `+2`，避免怪物密度提升后金币同步暴涨。
- 提高波末金币奖励：从 `12 + 关卡 * 3 + 波次 * 2` 调整为 `18 + 关卡 * 5 + 波次 * 5 + 额外路线 * 4`。
- 估算结果：第 10 关总击杀金币约从 `11910` 降到 `8593`，击杀经济约减少 `27.9%`；波末金币约从 `500` 提到 `1025`；总常规经济约从 `12410` 降到 `9618`，整体约减少 `22.5%`。
- 设计目标是让后期资金不再主要来自“怪越多越暴富”，而是更多来自每波结束后的稳定结算。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“后期金币更克制了”的玩法公告。
- 扩展 `LogicSmokeTest.gd`，验证密集刷怪奖励延后、封顶，以及高关卡多路线波末金币补偿。

验证：
- Godot 4.7 `WaveManager.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.24.0 - 多门刷怪、金币上限与范围卡修复

- 创建 `.backup/backup_balance_card_spawn_20260704_2345`，备份本轮改动前的 `Main.gd`、`GameUI.gd`、`WaveManager.gd`、`Enemy.gd`、`Tower.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 金币新增硬上限 `5000`：击杀、波末、卡牌、卖卡、读档、控制台设置和关卡继承金币都会被限制到上限内。
- 继续削弱金币经济：击杀基础金币降到 `4`，波次成长放缓到每 8 波才增长，同波密集刷怪金币加成关闭；重甲、护盾、精英、嘲讽等高血量敌人的奖励倍率同步下调。
- 波末奖励也收紧为 `14 + 关卡 * 3 + 波次 * 3 + 额外路线 * 3`，保留稳定补给，但不再弥补出怪密度带来的所有击杀收入。
- 导弹卡基础伤害从 `90` 提到 `270`，全屏火焰基础伤害从 `45` 提到 `135`；调试导弹卡同步更新。
- 修复范围卡预览残留：波次开始和自动开波会主动取消卡牌拖拽，`cancel_card_drag()` 现在也会清理异常残留的范围预览圈。
- 后期新增嘲讽怪“嘲讽堡垒”：血厚、移速慢、奖励克制，会在第 6、8、9、10 关加入敌池；炮塔会优先攻击范围内的嘲讽怪。
- 多门刷怪逻辑改为每个刷怪门在同一出怪 tick 各刷一只敌人，总出怪数按门数增长，不再把同一批敌人平分给多个门导致单门密度下降。
- 建造展开面板加高，从 `96` 提到 `132`，位置上移，详细塔按钮加高，展开状态更醒目。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“后期节奏重新收紧”的玩法公告。
- 扩展 `LogicSmokeTest.gd`，覆盖金币上限、强化后的卡牌伤害、建造面板尺寸、范围预览清理、多门批量刷怪、奖励削弱、嘲讽怪配置和炮塔嘲讽索敌。

验证：
- Godot 4.7 `WaveManager.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `GameUI.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Enemy.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Tower.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.25.0 - 炮塔后座动画

- 创建 `.backup/backup_tower_recoil_20260705_0001`，备份本轮改动前的 `Tower.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 在 `Tower.gd` 新增炮塔开火后座状态：每次实际 `_fire_at()` 时触发一次，炮塔本体会沿炮口反方向短暂位移再回弹。
- 后座动画时间按当前有效攻击间隔计算，并设置最小/最大时长，确保急速增益后的炮塔回弹节奏仍能对上开火频率。
- 不同炮塔使用不同后座力度：急速塔更轻快，基础塔居中，狙击塔更干脆，散弹塔更明显，重炮塔最重。
- 绘制时只偏移炮塔本体、增益/升级标记和开火状态，选中射程圆仍固定在塔位中心，避免射程显示跟着抖动。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“炮塔开火更有力量了”的画面更新公告。
- 扩展 `LogicSmokeTest.gd`，覆盖后座触发、反方向位移、动画衰减、不同炮塔后座力度差异，以及攻速增益下的时长对齐。

验证：
- Godot 4.7 `Tower.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.25.1 - 版本编号规则整理

- 创建 `.backup/backup_version_renumber_20260705_0048`，备份本轮改动前的 `CHANGELOG.md` 和 `UpdateAnnouncements.gd`。
- 重新整理 `ver0.14.34` 之后的大更新编号：明显的玩法、系统、画面和战斗表现更新不再继续堆在 `ver0.14.x` 补丁号内。
- `炮塔特性视觉表现增强` 改为 `ver0.15.0`，其后散弹、狙击、重炮相关修复保留为 `ver0.15.x`。
- `手牌卡牌扩展到20种` 改为 `ver0.16.0`，卡牌稀有度、抽卡强度和倍率说明保留为 `ver0.16.x`。
- 玩家更新公告、关卡开局存档、稀有度卡面、战场层次、敌潮密度、事件特效、经济曲线、多门刷怪和炮塔后座分别提升为 `ver0.17.0` 到 `ver0.25.0`。
- 同步更新 `UpdateAnnouncements.gd` 中的公告版本号和最新公告 ID，当前玩家可见最新公告为 `ver0.25.0`。
- 更新本文档顶部的版本号规则，明确 `ver0.x.0` 与 `ver0.x.y` 的使用边界。

验证：
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
---

## ver0.26.0 - 重武器手感与弹道距离调整

- 创建 `.backup/backup_tower_balance_recoil_range_20260705_0105`，备份本轮改动前的 `Main.gd`、`Tower.gd`、`Projectile.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 优化重炮塔和狙击塔后座动画：新增按炮塔类型计算后座时长，重炮和狙击回弹更慢，后座距离也更明显；速射塔后座保持更轻快。
- 削弱速射塔升级伤害成长：2 级伤害增量从 `+3` 降到 `+2`，3 级追加增量从 `+5` 降到 `+3`，让速射塔更偏多弹幕压制而不是后期单发伤害暴涨。
- 增强重炮塔范围伤害：基础溅射半径从 `42` 提到 `56`，溅射伤害比例从 `0.40` 提到 `0.52`；2 级提升到 `74 / 0.62`，3 级提升到 `96 / 0.78`。
- 增加非狙击炮塔子弹有效距离：子弹最大飞行距离改为当前有效射程的 `1.35` 倍，减少边缘目标刚离开索敌范围后弹丸立刻消失的问题。
- 狙击弹仍沿用屏幕外清理逻辑，不被塔射程提前清除。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“重武器更重，弹道更远”的玩法公告，并设为最新公告 `ver0.26.0`。
- 扩展 `LogicSmokeTest.gd`，覆盖速射塔伤害成长削弱、重炮溅射范围/比例提高、非狙击弹丸飞行距离增加、狙击弹清理规则和重武器后座时长。

验证：
- Godot 4.7 `Tower.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Projectile.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.27.0 - 卡牌释放与弹窗特效分化

- 创建 `.backup/backup_effects_card_popup_20260705_0130`，备份本轮改动前的 `GameUI.gd`、`Main.gd`、`ImpactEffect.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- `GameUI.gd` 新增更新公告弹窗、公告历史、新卡待处理和卖卡的独立 UI 粒子 profile，不再落回默认 UI 粒子参数。
- 新卡待处理弹窗出现时会按卡牌稀有度生成一次专用揭示粒子，并用状态位避免每次刷新重复触发。
- 卖卡 UI 动画新增 `CardSellParticles`，金币上浮反馈和普通使用卡牌的 `CardConsumeParticles` 区分开。
- `Main.gd` 新增卡牌成功释放的统一收尾入口，UI 拖拽、控制台用卡和测试直接调用都会生成同一套释放特效。
- `ImpactEffect.gd` 新增多种卡牌世界释放 profile：攻击坠击、冻结晶环、增益脉冲、护盾框、金币上浮线、陷阱落刺、诱饵信标、时间裂隙和通用释放环。
- 攻击、控制、增益、资源、风险、陷阱、诱饵、时间裂隙等卡牌会按类型选择不同世界释放效果和粒子运动参数。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“卡牌和弹窗特效更分明了”的画面更新公告，并设为最新公告 `ver0.27.0`。
- 扩展 `LogicSmokeTest.gd`，覆盖 UI 弹窗 profile 差异、新卡待处理弹窗粒子、卡牌释放世界效果、攻击卡与冻结卡的不同 release profile。

验证：
- Godot 4.7 `GameUI.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `ImpactEffect.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.28.0 - 重武器手感与弹道再平衡

- 创建 `.backup/backup_tower_balance_recoil_20260705_0300`，备份本轮改动前的 `Tower.gd`、`Projectile.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`；后续同步配置与测试时追加 `.backup/backup_tower_balance_recoil_20260705_0315_checkpoint` 当前检查点，保存 `Main.gd` 和 `LogicSmokeTest.gd`。
- 进一步优化狙击塔和重炮塔后座动画：整体后座窗口从 `0.32` 秒上限提高到 `0.52` 秒，重炮和狙击使用更慢的回弹曲线，中段位移保留更久，开火更厚重。
- 速射塔升级伤害梯度继续下调：2 级伤害增量从 `+2` 降到 `+1`，3 级追加增量从 `+3` 降到 `+2`，让它更依赖多弹齐射和射速压制。
- 重炮塔溅射范围和边缘伤害加强：基础溅射从 `56 / 0.52` 提到 `76 / 0.68`，2 级从 `74 / 0.62` 提到 `96 / 0.78`，3 级从 `96 / 0.78` 提到 `128 / 0.88`。
- 非狙击炮塔子弹有效距离从当前射程的 `1.35` 倍提高到 `1.85` 倍；狙击弹的屏幕外清理边界从 `80` 提高到 `140`，减少远距离弹道过早消失。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“重炮更炸，狙击更稳”的玩法公告，并设为最新公告 `ver0.28.0`。
- 更新 `LogicSmokeTest.gd`，覆盖新的速射升级伤害、重炮溅射参数、长弹道距离和重炮慢回弹曲线。

验证：
- Godot 4.7 `Tower.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Projectile.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.29.0 - 交互与卡牌特效审计补强

- 创建 `.backup/backup_effects_interaction_audit_20260705_0335`，备份本轮改动前的 `Main.gd`、`BuildManager.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd` 和 `CHANGELOG.md`。
- 拆分仍然共用粒子参数的卡牌区域反馈：诱饵信标改为向外脉冲，时间裂隙改为横向旋转扭动，不再共用一套慢速环形粒子。
- 拆分调度、透支、紧急按钮和改签补给的区域粒子：调度偏横向转移，透支向下坠落，紧急按钮向上救急，改签向手牌方向回扫。
- 补强出售炮塔反馈的测试断言，确保出售会生成上浮金币粒子，并和建造碎屑、升级强化粒子区分开。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“卡牌和交互反馈更好认了”的画面更新公告，并设为最新公告 `ver0.29.0`。
- 扩展 `LogicSmokeTest.gd`，覆盖诱饵、时间裂隙、调度、透支、紧急按钮、改签补给和卖塔粒子的方向、重力、旋转或扩散参数。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `BuildManager.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.29.1 - 战斗特效生成代码质量修复

- 创建 `.backup/backup_code_audit_impact_effect_20260705_0348`，备份本轮改动前的 `ImpactEffect.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 修复 `ImpactEffect.spawn()` 每次生成冲击特效都 `load("res://scripts/ImpactEffect.gd").new()` 的低效写法，改为懒加载并缓存脚本资源后实例化，减少战斗、卡牌释放和 UI 特效密集时的重复资源加载。
- 扩展 `CodeStyleAuditTest.gd`，禁止 `ImpactEffect.gd` 回退到每次生成特效都动态加载自身脚本的模式。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“战斗特效生成更稳了”的修复优化公告，并设为最新公告 `ver0.29.1`。

验证：
- Godot 4.7 `ImpactEffect.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.29.2 - 关卡路线配置规范化补强

- 创建 `.backup/backup_code_audit_route_sanitize_20260705_0405`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 优化 `Main.gd` 的 `_get_level_routes()`：路线点会根据当前关卡地图尺寸钳制到有效格子范围内，避免错误配置生成地图外道路或刷怪路径。
- 路线规范化会移除相邻重复点；如果路线在清理后只剩一个点，会作为无效路线丢弃，避免后续生成零长度路径。
- 新增 `_clamp_route_grid_point()` helper，让路线边界处理集中在一个地方。
- 扩展 `LogicSmokeTest.gd`，覆盖越界路线点钳制、重复路线点清理和坍缩路线丢弃。
- 扩展 `CodeStyleAuditTest.gd`，禁止直接保存原始 route 点或未钳制的 Vector2 转换点，防止绕过路线规范化。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“关卡路线配置更稳了”的修复优化公告，并设为最新公告 `ver0.29.2`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.29.3 - UI 粒子配置生成职责拆分

- 创建 `.backup/backup_code_audit_ui_particle_profiles_20260705_0418`，备份本轮改动前的 `GameUI.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 重构 `GameUI.gd` 的 `_apply_ui_particle_profile()`：函数现在只负责清空并写入缓存字典，默认 UI 粒子参数由 `_get_base_ui_particle_config()` 生成，各特效差异参数由 `_get_ui_particle_profile_overrides()` 返回。
- 保持 `_ui_particle_config` 字典复用不变，避免频繁创建粒子配置缓存对象；同时减少一个超长副作用式函数继续膨胀的风险。
- 扩展 `CodeStyleAuditTest.gd`，禁止在 `GameUI.gd` 中重新使用 `_ui_particle_config.merge({` 直接堆叠 profile 数据，防止回退到难维护写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“界面特效代码更好维护了”的修复优化公告，并设为最新公告 `ver0.29.3`。

验证：
- Godot 4.7 `GameUI.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.29.4 - 卡牌塔增益遍历职责收敛

- 创建 `.backup/backup_code_audit_reward_tower_iteration_20260705_0432`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `Main.gd` 的 `_for_each_valid_active_tower()` helper，集中处理 active tower 的空引用和 `is_instance_valid()` 检查，并返回实际应用数量。
- `tower_boost`、`range_boost`、`fire_rate_boost` 和 `overload_debt` 卡牌复用该 helper，去掉重复的有效塔遍历和手动计数逻辑。
- 扩展 `LogicSmokeTest.gd`，覆盖有效塔遍历 helper 只产出 live tower，并返回实际应用数量。
- 扩展 `CodeStyleAuditTest.gd`，禁止塔增益卡重新使用 `var boosted := 0` 这种手写计数循环模式。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“卡牌增益代码更稳了”的修复优化公告，并设为最新公告 `ver0.29.4`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.29.5 - 区域卡牌成功收尾职责收敛

- 创建 `.backup/backup_code_audit_area_card_finish_20260705_0450`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `Main.gd` 的 `_finish_area_reward_card_success()` helper，统一处理区域卡牌成功后的世界范围特效、区域粒子、提示文本和卡牌释放收尾。
- `missile`、`cryo`、`firestorm`、`global_freeze`、`bait_beacon`、`road_spikes` 和 `time_warp` 改为复用该 helper，减少 `_apply_reward_card()` 内重复的成功收尾代码。
- `road_spikes` 的粒子半径改为显式使用卡牌 radius，不再依赖 `_show_world_area_effect()` 刚写入的内部 `_missile_effect_radius` 状态。
- 扩展 `LogicSmokeTest.gd`，覆盖尖刺卡粒子半径来自配置的行为。
- 扩展 `CodeStyleAuditTest.gd`，禁止区域卡牌重新手写 `_show_world_area_effect(center, radius...)` 模式，防止绕过统一 helper。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“区域卡牌代码更统一了”的修复优化公告，并设为最新公告 `ver0.29.5`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.30.0 - 重武器手感与弹道距离再平衡

- 创建 `.backup/backup_tower_heavy_balance_20260705_0156`，备份本轮改动前的 `Tower.gd`、`Projectile.gd`、`Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 优化重炮塔和狙击塔后座动画：最大回弹时长从 `0.52` 提高到 `0.68`，两类重武器的回弹倍率提高，并降低回弹曲线指数，让中段停留更明显，开火更有厚重感。
- 削弱速射塔升级伤害成长：二级不再增加单发伤害，三级只增加 `1` 点单发伤害，强度更集中在双联/三联弹幕和攻速节奏。
- 强化重炮塔范围伤害：基础溅射从 `76 / 0.68` 调整为 `92 / 0.78`，二级调整为 `118 / 0.86`，三级调整为 `154 / 0.96`，范围更大且边缘衰减更低。
- 增加弹丸有效距离：非狙击炮塔弹丸飞行距离从射程的 `1.85` 倍提高到 `2.35` 倍；狙击弹屏外清理余量从 `140` 提高到 `220`，穿透伤害衰减从 `0.72` 放宽到 `0.78`。
- 修正文案：重炮基础特性从“重弹单体打击”改为“重弹范围炮击”，避免和自带溅射机制冲突。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“重武器更沉，弹道更远”的玩法公告，并设为最新公告 `ver0.30.0`。

验证：
- Godot 4.7 `Tower.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Projectile.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.30.1 - 地图几何 helper 职责收敛

- 创建 `.backup/backup_code_audit_map_geometry_helpers_20260705_0201`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `Main.gd` 的 `get_map_pixel_size()`、`get_map_center_position()`、`get_camera_bounds_size()`、`get_camera_bounds_center()`、`get_map_max_dimension()` 和 `get_map_half_max_dimension()`，统一地图尺寸、中心和范围计算入口。
- `spawn_screen_particles()`、相机缩放/边界夹取、创建相机、全屏火焰、全屏冻结、卡牌释放位置/半径和控制台 `usecard` 回退位置改为复用这些 helper。
- 保留关卡加载时用 `MAP_HEIGHT` 做初始相机 Y 位置的现有行为，避免改变高地图进入关卡时的镜头起点。
- 扩展 `LogicSmokeTest.gd`，覆盖地图尺寸、地图中心、相机边界中心、最大尺寸和半最大尺寸 helper 的行为。
- 扩展 `CodeStyleAuditTest.gd`，禁止重新手写旧的地图中心和地图最大尺寸表达式。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“地图尺寸逻辑更稳了”的修复优化公告，并设为最新公告 `ver0.30.1`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.30.2 - 卡牌释放样式职责收敛

- 创建 `.backup/backup_code_audit_card_release_style_20260705_0205`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `Main.gd` 的 `_get_reward_card_release_style()`，统一返回卡牌释放特效需要的 profile、颜色、方向和时长。
- `_spawn_reward_card_release_effect()` 改为一次读取释放样式，并把同一套 profile/direction 传给释放粒子配置，避免特效和粒子分开维护导致表现不一致。
- 移除拆散的 `_get_reward_card_release_profile()`、`_get_reward_card_release_color()`、`_get_reward_card_release_direction()` 和 `_get_reward_card_release_duration()` 逻辑入口。
- 扩展 `LogicSmokeTest.gd`，覆盖攻击、冻结、金币和未知卡牌的释放样式，以及释放粒子读取共享样式的行为。
- 扩展 `CodeStyleAuditTest.gd`，禁止卡牌释放 profile、颜色、方向和时长重新拆成多个 helper。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“卡牌释放反馈更好维护了”的修复优化公告，并设为最新公告 `ver0.30.2`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.30.3 - 有效敌人遍历职责收敛

- 创建 `.backup/backup_code_audit_active_enemy_iteration_20260705_0208`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `Main.gd` 的 `_is_valid_active_enemy()`、`_collect_valid_active_enemies()` 和 `_collect_valid_active_enemies_in_radius()`，统一处理敌人非空、实例有效、未死亡、未到终点的筛选规则。
- `_find_best_missile_target()`、范围伤害、全屏伤害、范围减速、全屏减速、地刺陷阱、诱饵信标、时间裂隙和悬赏选怪改为复用共享敌人收集 helper。
- 保留范围伤害先收集目标再造成伤害的处理顺序，避免伤害过程中敌人状态变化影响遍历结果。
- 扩展 `LogicSmokeTest.gd`，覆盖有效敌人收集会排除死亡和到达终点敌人，范围收集会同时应用范围和有效状态过滤。
- 扩展 `CodeStyleAuditTest.gd`，禁止在 `Main.gd` 中重新手写重复的 active enemy 有效性判断。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“敌人筛选逻辑更稳了”的修复优化公告，并设为最新公告 `ver0.30.3`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.30.4 - 有效炮塔遍历职责收敛

- 创建 `.backup/backup_code_audit_active_tower_iteration_20260705_0212`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `Main.gd` 的 `_is_valid_active_tower()` 和 `_collect_valid_active_towers()`，统一处理炮塔非空和实例有效的筛选规则。
- `register_tower()`、`_for_each_valid_active_tower()`、精英怪死亡眩晕、透支卡负面阶段和 `_find_tower_near()` 改为复用共享炮塔有效性 helper。
- 扩展 `LogicSmokeTest.gd`，覆盖活跃炮塔收集和 valid tower iterator 的数量关系。
- 扩展 `CodeStyleAuditTest.gd`，禁止在 `Main.gd` 中重新手写重复的 active tower 有效性判断。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“炮塔筛选逻辑更统一了”的修复优化公告，并设为最新公告 `ver0.30.4`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.30.5 - 子弹目标有效性职责收敛

- 创建 `.backup/backup_code_audit_projectile_target_validation_20260705_0216`，备份本轮改动前的 `Projectile.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `Projectile.gd` 的 `_is_valid_enemy_target()`，统一处理子弹目标非空、实例有效、未死亡、未到终点的判断。
- 子弹直击、重炮溅射和线段命中扫描改为复用该 helper，避免穿透/溅射后续改动时漏掉无效目标过滤。
- 扩展 `LogicSmokeTest.gd`，覆盖子弹目标校验对 null、活敌人、死亡敌人和已到终点敌人的结果。
- 扩展 `CodeStyleAuditTest.gd`，禁止 `Projectile.gd` 重新手写直击、溅射和线段扫描的目标有效性判断。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“弹丸命中判断更稳了”的修复优化公告，并设为最新公告 `ver0.30.5`。

验证：
- Godot 4.7 `Projectile.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.30.6 - 炮塔索敌目标有效性职责收敛

- 创建 `.backup/backup_code_audit_tower_target_validation_20260705_0218`，备份本轮改动前的 `Tower.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `Tower.gd` 的 `_get_valid_enemy_target()`，统一处理炮塔目标实例有效、类型正确、未死亡、未到终点的判断。
- `_is_target_valid()`、`_find_target()` 和 `_get_attack_damage()` 改为复用该 helper，减少当前目标保持、自动索敌和狙击处决伤害读取之间的判断差异。
- 扩展 `LogicSmokeTest.gd`，覆盖炮塔目标 helper 对活敌人、死亡敌人、已到终点敌人和已释放敌人的处理。
- 扩展 `CodeStyleAuditTest.gd`，禁止 `Tower.gd` 重新手写目标死亡/到达终点判断和索敌扫描重复判断。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“炮塔索敌判断更稳了”的修复优化公告，并设为最新公告 `ver0.30.6`。

验证：
- Godot 4.7 `Tower.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.30.7 - 建造占位塔读取职责收敛

- 创建 `.backup/backup_code_audit_build_occupied_tower_20260705_0221`，备份本轮改动前的 `BuildManager.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `BuildManager.gd` 的 `_get_occupied_tower()`，统一读取指定格子上的炮塔，并在发现失效炮塔实例时清理旧占位。
- `try_build_at()`、`try_select_at()` 和 `get_build_error()` 改为复用该 helper，避免建造、选择和增益塔叠加各自直接读取 `_occupied_tiles`。
- 改善异常边界：如果某个塔节点已经失效但占位字典残留，该格子不再永久阻塞建造。
- 扩展 `LogicSmokeTest.gd`，覆盖失效占位塔会被 helper 清理，且不会继续阻塞有效建造格。
- 扩展 `CodeStyleAuditTest.gd`，禁止 `BuildManager.gd` 绕过 `_get_occupied_tower()` 直接读取格子上的塔或直接用 `_occupied_tiles.has()` 阻塞建造。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“建造占位逻辑更稳了”的修复优化公告，并设为最新公告 `ver0.30.7`。

验证：
- Godot 4.7 `BuildManager.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.31.0 - 重武器手感与弹丸距离强化

- 创建 `.backup/backup_tower_heavy_balance_20260705_022743`，备份本轮改动前的 `Tower.gd`、`Projectile.gd`、`Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 优化重炮塔和狙击塔后座动画：提高重武器后座时长上限、加长重炮/狙击回弹倍率，并降低回弹曲线幂值，让开火后的回座更慢、更有厚重感。
- 削弱速射塔伤害成长：速射塔 2 级和 3 级不再增加单发伤害，升级收益集中在双联、三联齐射和射击节奏上。
- 增强重炮塔范围特性：基础溅射半径从 `92` 提高到 `110`，基础溅射比例从 `0.78` 提高到 `0.86`；2 级溅射提高到 `142 / 0.92`，3 级提高到 `188 / 0.98`。
- 增加弹丸有效距离：非狙击炮塔弹丸有效距离倍率从 `2.35` 提高到 `3.10`；狙击弹离屏保留边距从 `220` 提高到 `360`，穿透后的伤害衰减从 `0.78` 放缓到 `0.84`。
- 扩展 `LogicSmokeTest.gd`，覆盖新的速射伤害成长、重炮溅射半径/衰减、重武器后座停留、弹丸飞行距离和狙击离屏规则。
- 扩展 `CodeStyleAuditTest.gd`，禁止关键战斗参数退回旧版本数值。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“重炮更炸，狙击更稳”的玩法更新公告，并设为最新公告 `ver0.31.0`。

验证：
- Godot 4.7 `Tower.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Projectile.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.31.1 - UI 按钮状态写入幂等化

- 创建 `.backup/backup_ui_button_idempotent_audit_20260705_023222`，备份本轮改动前的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 补齐按钮状态幂等优化的工程质量记录：`GameUI._set_button_enabled()` 会先判断禁用状态和鼠标指针是否已经一致，避免 UI 高频刷新时重复写入相同状态。
- 保留 `LogicSmokeTest.gd` 中已有的按钮重复启用/禁用覆盖，确认连续调用不会改变最终禁用状态和鼠标指针。
- 扩展 `CodeStyleAuditTest.gd`，禁止 `_set_button_enabled()` 退回到 `button.disabled = not enabled` 的直接重复写入方式。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“按钮状态刷新更轻了”的修复优化公告，并设为最新公告 `ver0.31.1`。

验证：
- Godot 4.7 `GameUI.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.31.2 - 更新公告最新编号来源收敛

- 创建 `.backup/backup_update_announcement_latest_id_20260705_023503`，备份本轮改动前的 `UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- `UpdateAnnouncements.get_latest_announcement_id()` 改为从最近公告列表的第一条读取最新编号，避免手写常量和实际展示公告首项不一致。
- 保留 `LATEST_ANNOUNCEMENT_FALLBACK_ID` 作为公告列表异常为空时的兜底编号。
- 新增玩家公告 `ver0.31.2`「更新公告入口更稳了」，说明本轮公告入口稳定性优化。
- 扩展 `LogicSmokeTest.gd`，验证最近公告非空、最多只暴露 5 条、最新公告 ID 必须等于最近公告第一条 ID，并将弹窗正文检查改为匹配最新公告 summary。
- 扩展 `CodeStyleAuditTest.gd`，禁止 `UpdateAnnouncements.gd` 退回到直接 `return LATEST_ANNOUNCEMENT_ID` 的重复来源写法。

验证：
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.31.3 - 活跃战斗缓存读取快照化

- 创建 `.backup/backup_active_cache_snapshot_getters_20260705_023842`，备份本轮改动前的 `Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- `Main.get_active_enemies()`、`Main.get_active_towers()` 和 `Main.get_active_projectiles()` 改为返回内部缓存数组的副本，避免外部调用者误清空或改写活跃敌人、炮塔、弹丸注册缓存。
- 扩展 `LogicSmokeTest.gd`，分别覆盖敌人、炮塔和弹丸 getter 的快照行为：清空返回数组不会改变内部缓存数量。
- 扩展 `CodeStyleAuditTest.gd`，禁止 `Main.gd` 的公开活跃对象 getter 退回到直接 `return _enemy_cache`、`return _tower_cache` 或 `return _projectile_cache`。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“战斗列表保护更稳了”的修复优化公告，并设为最新公告 `ver0.31.3`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.31.4 - 炮塔配置读取快照化

- 创建 `.backup/backup_tower_config_snapshot_getter_20260705_024304`，备份本轮改动前的 `Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- `Main.get_tower_config()` 改为返回塔配置字典的深拷贝，避免外部调用者误改 `tower_configs` 内部全局配置。
- 保持未知塔类型仍回退到基础塔配置，但返回值同样是独立快照。
- 扩展 `LogicSmokeTest.gd`，验证修改 `get_tower_config("basic")` 的返回字典不会改变后续 getter 结果和内部 `tower_configs` 表。
- 扩展 `CodeStyleAuditTest.gd`，禁止 `get_tower_config()` 退回到直接 `return tower_configs.get(type_id, tower_configs["basic"])`。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“炮塔配置保护更稳了”的修复优化公告，并设为最新公告 `ver0.31.4`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.31.5 - 关卡配置读取快照化

- 创建 `.backup/backup_level_config_snapshot_getter_20260705_024545`，备份本轮改动前的 `Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- `Main.get_current_level_config()` 改为返回当前关卡配置字典的深拷贝，避免外部调用者误改 `level_configs` 内部关卡配置。
- 扩展 `LogicSmokeTest.gd`，验证修改当前关卡配置快照的名称和嵌套路线数组不会改变内部 `level_configs` 表。
- 扩展 `CodeStyleAuditTest.gd`，禁止 `get_current_level_config()` 退回到直接 `return level_configs[current_level_index]`。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“关卡配置保护更稳了”的修复优化公告，并设为最新公告 `ver0.31.5`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.31.6 - 波次敌人数值缓存读取快照化

- 创建 `.backup/backup_wave_stat_cache_snapshots_20260705_024911`，备份本轮改动前的 `WaveManager.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- `WaveManager._get_enemy_wave_base_stats()` 命中缓存或新建缓存后，都返回基础数值字典副本，避免调用方误改 `_enemy_wave_stat_cache`。
- `WaveManager._get_enemy_stat_multipliers()` 命中缓存或新建缓存后，也返回倍率字典副本，避免调用方误改 `_enemy_stat_multipliers`。
- 扩展 `LogicSmokeTest.gd`，验证修改敌人倍率返回值和每波基础数值返回值不会污染后续缓存读取。
- 扩展 `CodeStyleAuditTest.gd`，禁止 `WaveManager.gd` 退回到直接返回 `_enemy_wave_stat_cache[cache_key]` 或 `_enemy_stat_multipliers[type_id]` 的可变缓存字典。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“波次敌人数值缓存更稳了”的修复优化公告，并设为最新公告 `ver0.31.6`。

验证：
- Godot 4.7 `WaveManager.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.31.7 - 敌人刷怪路线读取快照化

- 创建 `.backup/backup_spawn_path_snapshot_20260705_025223`，备份本轮改动前的 `Main.gd`、`Enemy.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- `Main._get_spawn_path()` 改为返回路线数组快照，避免调用方直接拿到 `path_points` 或 `spawn_paths` 内部数组。
- `Enemy.setup()` 改为复制传入路线，敌人实例不再和地图路线缓存共享同一个数组引用。
- 扩展 `LogicSmokeTest.gd`，验证指定路线刷怪仍使用相同路线内容，但敌人路线数组和地图路线缓存不再是同一引用，修改敌人路线不会污染地图路线。
- 扩展 `CodeStyleAuditTest.gd`，禁止 `_get_spawn_path()` 和 `Enemy.setup()` 退回到直接暴露或保存路线数组引用。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“敌人路线保护更稳了”的修复优化公告，并设为最新公告 `ver0.31.7`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Enemy.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.31.8 - 更新公告列表读取快照化

- 创建 `.backup/backup_update_announcements_snapshot_20260705_025729`，备份本轮改动前的 `UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- `UpdateAnnouncements.get_recent_announcements()` 改为通过 `_copy_recent_announcements()` 返回最近公告深拷贝，避免调用方误改公告字典或嵌套 bullets 数组。
- 新增玩家公告 `ver0.31.8`「公告列表保护更稳了」，说明本轮公告数据保护优化。
- 扩展 `LogicSmokeTest.gd`，验证修改返回公告的 summary 和 bullets 不会影响后续公告读取。
- 扩展 `CodeStyleAuditTest.gd`，禁止公告列表退回到 `return announcements.slice(0, MAX_PLAYER_ANNOUNCEMENTS)` 的浅切片返回方式。

验证：
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.31.9 - 敌人动画资源缓存读取快照化

- 创建 `.backup/backup_enemy_sprite_frames_snapshot_20260705_030035`，备份本轮改动前的 `Enemy.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- `Enemy._get_enemy1_sprite_frames()` 保留静态缓存用于避免重复加载图片，但返回时通过 `_copy_enemy1_sprite_frames()` 提供 `SpriteFrames` 副本。
- 扩展 `LogicSmokeTest.gd`，验证修改某个敌人的 walk 动画速度不会污染后续读取的敌人动画资源。
- 扩展 `CodeStyleAuditTest.gd`，禁止 `Enemy.gd` 退回到直接 `return _enemy1_sprite_frames_cache` 的可变资源返回方式。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“敌人动画资源保护更稳了”的修复优化公告，并设为最新公告 `ver0.31.9`。

验证：
- Godot 4.7 `Enemy.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.32.0 - 重火力手感与弹丸距离更新

- 创建 `.backup/backup_combat_weight_balance_20260705_030544`，备份本轮改动前的 `Tower.gd`、`Projectile.gd`、`Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 重炮塔和狙击塔的后坐回弹持续时间提高，并按当前开火间隔限制上限，避免动画和射击节奏脱节。
- 重炮塔基础、二级、三级溅射范围分别提高到 `132 / 168 / 224`，溅射伤害比例提高到 `0.94 / 0.98 / 1.00`。
- 非狙击炮塔弹丸有效距离倍率从 `3.10` 提高到 `3.75`，狙击弹丸屏幕外清理边界从 `360` 提高到 `520`。
- 速射塔升级后的攻速成长下调，保留双发、三发特色，但让后期总输出增长更平滑。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“重火力手感升级”的战斗更新公告，并设为最新公告 `ver0.32.0`。
- 扩展 `LogicSmokeTest.gd` 和 `CodeStyleAuditTest.gd`，覆盖新溅射数值、弹丸距离、重武器后坐和旧数值回退检查。

验证：
- Godot 4.7 `Tower.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Projectile.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.32.1 - 奖励卡牌定义读取快照化

- 创建 `.backup/backup_reward_card_definition_snapshot_20260705_030945`，备份本轮改动前的 `Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- `Main._get_reward_card_definition()` 改为返回奖励卡牌定义字典的深拷贝，避免调试、测试或后续功能误改卡牌定义数据。
- 扩展 `LogicSmokeTest.gd`，验证修改读取到的导弹卡牌定义不会污染下一次卡牌定义读取。
- 扩展 `CodeStyleAuditTest.gd`，禁止奖励卡牌定义 helper 退回到直接 `return reward_card`。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“卡牌数据读取更稳了”的修复优化公告，并设为最新公告 `ver0.32.1`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.32.2 - 关卡列表读取快照化

- 创建 `.backup/backup_level_config_list_snapshot_20260705_031248`，备份本轮改动前的 `Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 新增 `Main.get_level_configs()`，返回关卡配置列表和嵌套字典的深拷贝，避免 UI 或后续功能误改主关卡表。
- `Main._create_ui()` 改为向 `GameUI.setup()` 传入 `get_level_configs()` 的快照，而不是直接传入内部 `level_configs`。
- 扩展 `LogicSmokeTest.gd`，验证修改返回的关卡列表、关卡名称和嵌套路由不会污染内部关卡配置。
- 扩展 `CodeStyleAuditTest.gd`，禁止再次直接返回 `level_configs` 或将内部关卡列表直接传给 UI。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“选关数据更稳了”的修复优化公告，并设为最新公告 `ver0.32.2`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.32.3 - 代码审计多行规则生效

- 创建 `.backup/backup_code_style_multiline_scan_20260705_031633`，备份本轮改动前的 `CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- `CodeStyleAuditTest.gd` 保留逐行扫描普通禁止片段和中文逻辑标识符的方式。
- 新增多行禁止片段全文扫描，修复此前带换行的禁止规则无法被逐行扫描命中的问题。
- 增加审计脚本自测，验证普通 token 走单行检查，多行 token 走全文检查。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“测试检查更可靠了”的修复优化公告，并设为最新公告 `ver0.32.3`。

验证：
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.32.4 - 代码审计多行规则行号定位

- 创建 `.backup/backup_code_style_multiline_line_numbers_20260705_031913`，备份本轮改动前的 `CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- `CodeStyleAuditTest.gd` 的多行禁止片段命中后，现在会通过 `_get_token_start_line()` 报告起始行号，方便定位回退代码。
- 补充审计脚本自测，验证多行 token 能定位到正确起始行，缺失 token 会返回 `0`。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“测试报错更好定位了”的修复优化公告，并设为最新公告 `ver0.32.4`。

验证：
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.32.5 - 公告项目符号读取防御化

- 创建 `.backup/backup_update_announcement_bullets_20260705_033500`，备份本轮改动前的 `GameUI.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- `GameUI._format_update_announcement_body()` 改为通过 `_get_update_announcement_bullets()` 读取公告项目符号。
- 当公告 `bullets` 字段不是数组时，界面会保留摘要并忽略异常项目内容，避免错误配置影响公告弹窗。
- 扩展 `LogicSmokeTest.gd`，覆盖正常项目符号渲染和异常 `bullets` 忽略逻辑。
- 扩展 `CodeStyleAuditTest.gd`，禁止公告正文格式化逻辑退回到直接 `announcement.get("bullets", []) as Array`。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“公告内容更稳了”的修复优化公告，并设为最新公告 `ver0.32.5`。

验证：
- Godot 4.7 `GameUI.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.32.6 - 选关路线数量读取防御化

- 创建 `.backup/backup_level_select_route_count_20260705_034200`，备份本轮改动前的 `GameUI.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- `GameUI._format_level_select_button_text()` 改为通过 `_get_level_config_route_count()` 读取关卡路线数量。
- 当关卡 `routes` 字段不是数组时，选关卡片会安全显示为 `0条路线`，避免错误配置影响选关界面渲染。
- 扩展 `LogicSmokeTest.gd`，覆盖正常路线数量和异常 `routes` 配置的选关卡片显示。
- 扩展 `CodeStyleAuditTest.gd`，禁止选关卡片退回到直接 `config.get("routes", []) as Array` 计数。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“选关卡片更稳了”的修复优化公告，并设为最新公告 `ver0.32.6`。

验证：
- Godot 4.7 `GameUI.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.32.7 - 路刺命中状态读取防御化

- 创建 `.backup/backup_road_spike_hit_ids_20260705_035000`，备份本轮改动前的 `Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- `Main._update_road_spike_traps()` 改为通过 `_get_road_spike_trap_hit_ids()` 读取路刺陷阱命中记录。
- 当路刺陷阱 `hit_ids` 状态不是字典时，会安全回退为空记录，避免异常临时状态影响战斗刷新。
- 扩展 `LogicSmokeTest.gd`，覆盖正常命中记录保留和异常命中记录忽略逻辑。
- 扩展 `CodeStyleAuditTest.gd`，禁止路刺陷阱命中状态读取退回到直接 `trap.get("hit_ids", {}) as Dictionary`。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“陷阱状态更稳了”的修复优化公告，并设为最新公告 `ver0.32.7`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.32.8 - 路刺位置读取防御化

- 创建 `.backup/backup_road_spike_position_20260705_035700`，备份本轮改动前的 `Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- `Main._update_road_spike_traps()` 改为通过 `_get_road_spike_trap_position()` 读取路刺陷阱位置。
- 正常 `Vector2` 位置会原样保留，`Vector2i` 位置会转换为 `Vector2`，异常位置会安全回退到 `Vector2.ZERO`。
- 扩展 `LogicSmokeTest.gd`，覆盖正常位置、整数位置和异常位置三种读取路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止路刺陷阱位置读取退回到直接 `trap.get("position", Vector2.ZERO) as Vector2`。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“陷阱位置读取更稳了”的修复优化公告，并设为最新公告 `ver0.32.8`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.32.9 - 路刺半径读取防御化

- 创建 `.backup/backup_road_spike_radius_20260705_040500`，备份本轮改动前的 `Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 新增 `ROAD_SPIKE_DEFAULT_RADIUS`，集中管理路刺陷阱默认半径。
- `Main._update_road_spike_traps()` 改为通过 `_get_road_spike_trap_radius()` 读取运行期半径。
- 路刺卡牌部署和卡牌释放特效改为通过 `_get_road_spike_card_radius()` 读取卡牌半径。
- 当路刺半径为零、负数或异常类型时，会回退到默认半径，避免影响碰撞判定、范围特效和粒子参数。
- 扩展 `LogicSmokeTest.gd`，覆盖正常半径、零半径、负半径、异常半径和卡牌释放半径净化。
- 扩展 `CodeStyleAuditTest.gd`，禁止路刺半径读取退回到直接 `float(...get("radius"...))`。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“陷阱范围数据更稳了”的修复优化公告，并设为最新公告 `ver0.32.9`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.32.10 - 路刺伤害读取防御化

- 创建 `.backup/backup_road_spike_damage_20260705_041400`，备份本轮改动前的 `Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 新增 `ROAD_SPIKE_DEFAULT_DAMAGE`，集中管理路刺陷阱默认伤害。
- 路刺卡牌部署改为通过 `_get_road_spike_card_damage()` 读取卡牌伤害。
- `Main._update_road_spike_traps()` 改为通过 `_get_road_spike_trap_damage()` 读取运行期伤害。
- 当路刺伤害为零、负数或异常类型时，会回退到默认伤害，避免负伤害给敌人回血。
- 扩展 `LogicSmokeTest.gd`，覆盖正常伤害、小数伤害、零伤害、负伤害和异常伤害读取路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止路刺伤害读取退回到直接 `int(...get("damage"...))`。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“陷阱伤害更稳了”的修复优化公告，并设为最新公告 `ver0.32.10`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.32.11 - 路刺次数读取防御化

- 创建 `.backup/backup_road_spike_charges_20260705_042200`，备份本轮改动前的 `Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 新增 `ROAD_SPIKE_DEFAULT_CHARGES`，集中管理路刺陷阱默认触发次数。
- 路刺卡牌部署改为通过 `_get_road_spike_card_charges()` 读取卡牌次数。
- `Main._update_road_spike_traps()` 改为通过 `_get_road_spike_trap_charges()` 读取运行期次数。
- 当路刺次数为零、负数或异常类型时，会回退到默认次数，避免异常数据让陷阱立即失效。
- 扩展 `LogicSmokeTest.gd`，覆盖正常次数、小数次数、零次数、负次数和异常次数读取路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止路刺次数读取退回到直接 `int(...get("charges"...))`。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“陷阱次数更稳了”的修复优化公告，并设为最新公告 `ver0.32.11`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.32.12 - 路刺持续时间读取防御化

- 创建 `.backup/backup_road_spike_duration_20260705_043000`，备份本轮改动前的 `Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 新增 `ROAD_SPIKE_DEFAULT_DURATION`，集中管理路刺陷阱默认持续时间。
- 路刺卡牌部署改为通过 `_get_road_spike_card_duration()` 读取卡牌持续时间。
- `Main._update_road_spike_traps()` 改为通过 `_get_road_spike_trap_time()` 读取运行期剩余时间。
- 当路刺持续时间为零、负数或异常类型时，会回退到默认持续时间，避免异常数据让陷阱立即消失。
- 扩展 `LogicSmokeTest.gd`，覆盖正常持续时间、零持续时间、负持续时间和异常持续时间读取路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止路刺持续时间读取退回到直接 `float(...get("time"/"duration"...))`。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“陷阱持续时间更稳了”的修复优化公告，并设为最新公告 `ver0.32.12`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.32.13 - 路刺减速倍率读取防御化

- 创建 `.backup/backup_road_spike_slow_multiplier_20260705_043800`，备份本轮改动前的 `Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 新增 `ROAD_SPIKE_DEFAULT_SLOW_MULTIPLIER`，集中管理路刺陷阱默认减速倍率。
- 路刺卡牌部署改为通过 `_get_road_spike_card_slow_multiplier()` 读取卡牌减速倍率。
- `Main._update_road_spike_traps()` 改为通过 `_get_road_spike_trap_slow_multiplier()` 读取运行期减速倍率。
- 当路刺减速倍率为零、负数、大于 `1.0` 或异常类型时，会回退到默认减速倍率。
- 扩展 `LogicSmokeTest.gd`，覆盖正常倍率、零倍率、负倍率、过大倍率和异常倍率读取路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止路刺减速倍率读取退回到直接 `float(...get("slow_multiplier"...))`。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“陷阱减速数据更稳了”的修复优化公告，并设为最新公告 `ver0.32.13`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.33.0 - 重火力手感与弹丸距离再调整

- 创建 `.backup/backup_ver0_33_0_heavy_weapon_20260705`，备份本轮改动前的 `Tower.gd`、`Main.gd`、`Projectile.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 将重炮塔、狙击塔的后座回弹时间上限从 `1.08` 提升到 `1.36`，并放慢回弹曲线，让重武器开火后更有厚重感。
- 将非狙击塔弹丸有效距离倍率从 `3.75` 提升到 `4.80`，普通炮塔、速射塔、散弹塔和重炮塔的弹丸能飞得更远。
- 将狙击弹离屏保留距离从 `520` 提升到 `680`，穿透弹在离开可视战场后更晚清理。
- 削弱速射塔升级后的总伤害增长梯度：升级后仍会增加弹丸数量，但装填节奏不再继续加速，避免后期速射塔火力膨胀过快。
- 提升重炮塔基础溅射半径到 `150`，基础溅射伤害比例到 `0.98`。
- 提升重炮塔二级溅射半径到 `196`，三级溅射半径到 `260`，二级及以上溅射伤害不再明显衰减。
- 扩展 `LogicSmokeTest.gd`，更新弹丸距离、重炮溅射、速射成长、重武器后座和狙击离屏保留距离的断言。
- 扩展 `CodeStyleAuditTest.gd`，禁止上述重火力、溅射、速射和弹丸距离数值回退到旧版本。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“重炮和狙击更有分量了”的玩法优化公告，并设为最新公告 `ver0.33.0`。

验证：
- Godot 4.7 `Tower.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Projectile.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
- 未执行完整 `LogicSmokeTest.gd` 长流程实际运行；此前该类长时间 Godot 控制台测试出现过“内存不能为 read”的进程崩溃风险，本轮用 `--check-only` 与实际代码审计替代。
---

## ver0.33.1 - 战利品磁铁读取防御化

- 创建 `.backup/backup_coin_magnet_sanitizers_20260705`，备份本轮改动前的 `Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 新增 `COIN_MAGNET_DEFAULT_DURATION`、`COIN_MAGNET_DEFAULT_BONUS_RATIO` 和 `COIN_MAGNET_MAX_BONUS_RATIO`，集中管理战利品磁铁默认持续时间、默认收益倍率和倍率上限。
- 战利品磁铁卡牌定义改为引用默认常量，避免默认数值散落在配置里。
- 战利品磁铁释放逻辑改为通过 `_get_coin_magnet_card_duration()` 和 `_get_coin_magnet_card_bonus_ratio()` 读取卡牌数据。
- 当持续时间为零、负数或异常类型时，会回退到默认 `12` 秒。
- 当金币加成倍率为零、负数、超过 `2.0` 或异常类型时，会回退到默认 `45%`。
- 扩展 `LogicSmokeTest.gd`，覆盖正常值、零值、负数、过大倍率和异常类型读取路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止战利品磁铁释放逻辑退回到旧的直接字典读取写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“战利品磁铁更稳了”的修复优化公告，并设为最新公告 `ver0.33.1`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.33.2 - 时间裂隙读取防御化

- 创建 `.backup/backup_time_warp_sanitizers_20260705`，备份本轮改动前的 `Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 新增 `TIME_WARP_DEFAULT_RADIUS`、`TIME_WARP_DEFAULT_SLOW_MULTIPLIER`、`TIME_WARP_DEFAULT_HASTE_MULTIPLIER`、`TIME_WARP_MAX_HASTE_MULTIPLIER` 和 `TIME_WARP_DEFAULT_DURATION`，集中管理时间裂隙默认参数。
- 时间裂隙卡牌定义改为引用默认常量，避免默认数值散落在配置里。
- 时间裂隙释放逻辑改为通过 `_get_time_warp_card_radius()`、`_get_time_warp_card_slow_multiplier()`、`_get_time_warp_card_haste_multiplier()` 和 `_get_time_warp_card_duration()` 读取卡牌数据。
- 时间裂隙卡牌释放预览半径改为使用安全后的半径，避免异常半径影响拖拽范围显示。
- 当范围、持续时间、减速倍率或加速倍率为异常值时，会回退到默认参数。
- 扩展 `LogicSmokeTest.gd`，覆盖正常值、零值、负数、过大倍率和异常类型读取路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止时间裂隙释放逻辑退回到旧的直接字典读取写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“时间裂隙参数更稳了”的修复优化公告，并设为最新公告 `ver0.33.2`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.33.3 - 诱饵信标读取防御化

- 创建 `.backup/backup_bait_beacon_sanitizers_20260705`，备份本轮改动前的 `Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 新增 `BAIT_BEACON_DEFAULT_RADIUS`、`BAIT_BEACON_DEFAULT_DURATION`、`BAIT_BEACON_DEFAULT_STRENGTH` 和 `BAIT_BEACON_MAX_STRENGTH`，集中管理诱饵信标默认参数。
- 诱饵信标卡牌定义改为引用默认常量，避免默认数值散落在配置里。
- 诱饵信标释放逻辑改为通过 `_get_bait_beacon_card_radius()`、`_get_bait_beacon_card_duration()` 和 `_get_bait_beacon_card_strength()` 读取卡牌数据。
- 诱饵信标卡牌释放预览半径改为使用安全后的半径，避免异常半径影响拖拽范围显示。
- 当范围、持续时间或牵引强度为异常值时，会回退到默认参数。
- 扩展 `LogicSmokeTest.gd`，覆盖正常值、零值、负数、过大强度和异常类型读取路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止诱饵信标释放逻辑退回到旧的直接字典读取写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“诱饵信标更可靠了”的修复优化公告，并设为最新公告 `ver0.33.3`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.33.4 - 塔位调度读取防御化

- 创建 `.backup/backup_tower_swap_sanitizers_20260705`，备份本轮改动前的 `Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 新增 `TOWER_SWAP_DEFAULT_RADIUS`、`TOWER_SWAP_DEFAULT_DAMAGE_MULTIPLIER`、`TOWER_SWAP_DEFAULT_FIRE_RATE_MULTIPLIER`、`TOWER_SWAP_MAX_MULTIPLIER` 和 `TOWER_SWAP_DEFAULT_DURATION`，集中管理塔位调度默认参数。
- 塔位调度卡牌定义改为引用默认常量，避免默认数值散落在配置里。
- 塔位调度释放逻辑改为通过 `_get_tower_swap_card_radius()`、`_get_tower_swap_card_duration()`、`_get_tower_swap_card_damage_multiplier()` 和 `_get_tower_swap_card_fire_rate_multiplier()` 读取卡牌数据。
- 塔位调度卡牌释放预览半径改为使用安全后的半径，避免异常半径影响拖拽范围显示。
- 当选塔范围、持续时间、伤害倍率或攻速倍率为异常值时，会回退到默认参数。
- 扩展 `LogicSmokeTest.gd`，覆盖正常值、零值、负数、过大倍率和异常类型读取路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止塔位调度释放逻辑退回到旧的直接字典读取写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“塔位调度更稳了”的修复优化公告，并设为最新公告 `ver0.33.4`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.33.5 - 透支超频读取防御化

- 创建 `.backup/backup_overload_debt_sanitizers_20260705`，备份本轮改动前的 `Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 新增 `OVERLOAD_DEBT_DEFAULT_DAMAGE_MULTIPLIER`、`OVERLOAD_DEBT_DEFAULT_FIRE_RATE_MULTIPLIER`、`OVERLOAD_DEBT_MAX_MULTIPLIER`、`OVERLOAD_DEBT_DEFAULT_DURATION`、`OVERLOAD_DEBT_DEFAULT_DEBT_MULTIPLIER` 和 `OVERLOAD_DEBT_DEFAULT_DEBT_DURATION`，集中管理透支超频默认参数。
- 透支超频卡牌定义改为引用默认常量，避免默认数值散落在配置里。
- 透支超频释放逻辑改为通过 `_get_overload_debt_card_duration()`、`_get_overload_debt_card_damage_multiplier()`、`_get_overload_debt_card_fire_rate_multiplier()`、`_get_overload_debt_card_debt_multiplier()` 和 `_get_overload_debt_card_debt_duration()` 读取卡牌数据。
- 当爆发持续时间、伤害倍率、攻速倍率、债务倍率或债务持续时间为异常值时，会回退到默认参数。
- 扩展 `LogicSmokeTest.gd`，覆盖正常值、零值、负数、过大倍率和异常类型读取路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止透支超频释放逻辑退回到旧的直接字典读取写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“透支超频更稳了”的修复优化公告，并设为最新公告 `ver0.33.5`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.33.6 - 紧急按钮读取防御化

- 创建 `.backup/backup_panic_button_sanitizers_20260705`，备份本轮改动前的 `Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 新增 `PANIC_BUTTON_DEFAULT_LOW_HEALTH_RATIO`、`PANIC_BUTTON_DEFAULT_HEAL`、`PANIC_BUTTON_DEFAULT_PANIC_HEAL`、`PANIC_BUTTON_DEFAULT_SLOW_MULTIPLIER` 和 `PANIC_BUTTON_DEFAULT_DURATION`，集中管理紧急按钮默认参数。
- 紧急按钮卡牌定义改为引用默认常量，避免默认数值散落在配置里。
- 紧急按钮释放逻辑改为通过 `_get_panic_button_card_low_health_ratio()`、`_get_panic_button_card_heal()`、`_get_panic_button_card_panic_heal()`、`_get_panic_button_card_slow_multiplier()` 和 `_get_panic_button_card_duration()` 读取卡牌数据。
- 当低血判定、修复量、紧急修复量、减速倍率或持续时间为异常值时，会回退到默认参数。
- 扩展 `LogicSmokeTest.gd`，覆盖正常值、零值、负数、过大倍率和异常类型读取路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止紧急按钮释放逻辑退回到旧的直接字典读取写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“紧急按钮更稳了”的修复优化公告，并设为最新公告 `ver0.33.6`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.34.0 - 重火力与弹道距离再强化

- 创建 `.backup/backup_ver0_34_0_heavy_projectiles_20260705`，备份本轮改动前的 `Tower.gd`、`Main.gd`、`Projectile.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 优化重炮塔和狙击塔后座动画：后座最大窗口从 `1.36` 提高到 `1.64`，并进一步放慢重炮/狙击回弹曲线，让开火后的回座更沉。
- 削弱速射塔升级后的总输出增长：2 级和 3 级仍增加弹丸数量，但装填间隔分别改为 `* 1.18` 和 `* 1.12`，后期火力增长更平滑。
- 增强重炮塔范围伤害：基础溅射提高到 `176 / 1.00`，2 级提高到 `238 / 1.00`，3 级提高到 `316 / 1.00`，范围更大且不再明显衰减。
- 增加弹丸有效距离：非狙击炮塔弹丸有效距离倍率从 `4.80` 提高到 `6.00`；狙击弹离屏保留距离从 `680` 提高到 `860`。
- 扩展 `LogicSmokeTest.gd`，覆盖新的速射成长、重炮溅射范围、重武器后座停留、普通弹丸距离和狙击离屏距离。
- 扩展 `CodeStyleAuditTest.gd`，禁止关键战斗参数回退到 `ver0.33.0` 旧数值。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“重火力更压得住场了”的玩法优化公告，并设为最新公告 `ver0.34.0`。

验证：
- Godot 4.7 `Tower.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Projectile.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.34.1 - 悬赏标记读取防御化

- 创建 `.backup/backup_bounty_mark_sanitizers_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `BOUNTY_MARK_DEFAULT_RADIUS`、`BOUNTY_MARK_DEFAULT_BONUS_GOLD` 和 `BOUNTY_MARK_MAX_BONUS_GOLD`，集中管理悬赏标记默认范围、默认额外金币和奖励上限。
- 悬赏标记卡牌定义改为引用默认常量，避免默认数值散落在配置里。
- 悬赏标记释放逻辑改为通过 `_get_bounty_mark_card_radius()` 和 `_get_bounty_mark_card_bonus_gold()` 读取卡牌数据。
- 拖拽释放范围显示同步使用悬赏标记范围 helper，异常范围不会让预览和实际效果不一致。
- 当标记范围、额外金币为零、负数、异常类型或额外金币过大时，会回退到默认参数。
- 扩展 `LogicSmokeTest.gd`，覆盖正常值、零值、负数、异常类型、过大金币和释放范围读取路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止悬赏标记释放逻辑退回到旧的直接字典读取写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“悬赏标记更稳了”的修复优化公告，并设为最新公告 `ver0.34.1`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.34.2 - 不稳定补给读取防御化

- 创建 `.backup/backup_risky_cache_sanitizers_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `RISKY_CACHE_DEFAULT_JACKPOT_CHANCE`、`RISKY_CACHE_MAX_JACKPOT_CHANCE`、`RISKY_CACHE_DEFAULT_JACKPOT_GOLD`、`RISKY_CACHE_DEFAULT_FALLBACK_GOLD`、`RISKY_CACHE_MAX_GOLD_REWARD`、`RISKY_CACHE_DEFAULT_FALLBACK_DAMAGE` 和 `RISKY_CACHE_MAX_FALLBACK_DAMAGE`，集中管理不稳定补给默认参数和安全上限。
- 不稳定补给卡牌定义改为引用默认常量，避免默认数值散落在配置里。
- 不稳定补给释放逻辑改为通过 `_get_risky_cache_card_jackpot_chance()`、`_get_risky_cache_card_jackpot_gold()`、`_get_risky_cache_card_fallback_gold()` 和 `_get_risky_cache_card_fallback_damage()` 读取卡牌数据。
- 当中奖概率、金币收益或失败伤害为零、负数、异常类型或过大值时，会回退到默认参数。
- 扩展 `LogicSmokeTest.gd`，覆盖正常值、零值、负数、异常类型、过大金币、过大伤害和小数金币读取路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止不稳定补给释放逻辑退回到旧的直接字典读取写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“不稳定补给更可控了”的修复优化公告，并设为最新公告 `ver0.34.2`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.34.3 - 基地加固读取防御化

- 创建 `.backup/backup_fortify_sanitizers_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `FORTIFY_DEFAULT_MAX_HP_GAIN`、`FORTIFY_MAX_HP_GAIN_LIMIT`、`FORTIFY_DEFAULT_HEAL` 和 `FORTIFY_HEAL_LIMIT`，集中管理基地加固默认生命上限增量、默认修复量和安全上限。
- 基地加固卡牌定义改为引用默认常量，避免默认数值散落在配置里。
- 基地加固释放逻辑改为通过 `_get_fortify_card_max_hp_gain()` 和 `_get_fortify_card_heal()` 读取卡牌数据。
- 当生命上限增量或修复量为零、负数、异常类型或过大值时，会回退到默认参数。
- 扩展 `LogicSmokeTest.gd`，覆盖正常值、小数取整、零值、负数、异常类型和过大值读取路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止基地加固释放逻辑退回到旧的直接字典读取写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“基地加固更稳了”的修复优化公告，并设为最新公告 `ver0.34.3`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.34.4 - 紧急军费读取防御化

- 创建 `.backup/backup_gold_card_sanitizers_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `GOLD_CARD_DEFAULT_AMOUNT` 和 `GOLD_CARD_MAX_AMOUNT`，集中管理紧急军费默认金币和单卡金币上限。
- 紧急军费卡牌定义改为引用默认常量，避免默认金币数散落在配置里。
- 紧急军费释放逻辑改为通过 `_get_gold_card_amount()` 读取卡牌数据。
- 当金币数量为零、负数、异常类型或过大值时，会回退到默认参数。
- 扩展 `LogicSmokeTest.gd`，覆盖正常值、小数取整、零值、负数、异常类型和过大值读取路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止紧急军费释放逻辑退回到旧的直接字典读取写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“紧急军费更稳了”的修复优化公告，并设为最新公告 `ver0.34.4`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.34.5 - 战地维修读取防御化

- 创建 `.backup/backup_heal_card_sanitizers_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `HEAL_CARD_DEFAULT_AMOUNT` 和 `HEAL_CARD_MAX_AMOUNT`，集中管理战地维修默认修复量和单卡修复上限。
- 战地维修卡牌定义改为引用默认常量，避免默认修复量散落在配置里。
- 战地维修释放逻辑改为通过 `_get_heal_card_amount()` 读取卡牌数据。
- 当修复量为零、负数、异常类型或过大值时，会回退到默认参数。
- 扩展 `LogicSmokeTest.gd`，覆盖正常值、小数取整、零值、负数、异常类型和过大值读取路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止战地维修释放逻辑退回到旧的直接字典读取写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“战地维修更可靠了”的修复优化公告，并设为最新公告 `ver0.34.5`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.34.6 - 超频核心读取防御化

- 创建 `.backup/backup_tower_boost_sanitizers_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `TOWER_BOOST_DEFAULT_MULTIPLIER`、`TOWER_BOOST_MAX_MULTIPLIER`、`TOWER_BOOST_DEFAULT_DURATION` 和 `TOWER_BOOST_MAX_DURATION`，集中管理超频核心默认倍率、默认持续时间和安全上限。
- 超频核心卡牌定义改为引用默认常量，避免默认倍率和时间散落在配置里。
- 超频核心释放逻辑改为通过 `_get_tower_boost_card_multiplier()` 和 `_get_tower_boost_card_duration()` 读取卡牌数据。
- 当伤害倍率低于 1、过大、异常类型，或持续时间为零、负数、过长、异常类型时，会回退到默认参数。
- 扩展 `LogicSmokeTest.gd`，覆盖倍率和持续时间的正常值、零值、负数、异常类型和过大值读取路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止超频核心释放逻辑退回到旧的直接字典读取写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“超频核心更稳了”的修复优化公告，并设为最新公告 `ver0.34.6`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.35.0 - 重武器手感与弹丸距离强化

- 创建 `.backup/backup_ver0_35_0_heavy_weapon_feel_20260705`，备份本轮改动前的 `Tower.gd`、`Main.gd`、`Projectile.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 优化狙击塔和重炮塔后座动画：后座最大窗口从 `1.64` 提高到 `1.90`，并把重炮/狙击的后座持续倍率与回弹曲线提取为常量，回弹中段更慢、更沉。
- 削弱速射塔升级后的伤害增长梯度：2 级装填间隔倍率从 `1.18` 调整为 `1.30`，3 级从 `1.12` 调整为 `1.25`，保留弹丸数量成长但降低后期 DPS 暴涨。
- 增大重炮塔范围伤害：基础溅射半径从 `176` 提高到 `208`，2 级从 `238` 提高到 `286`，3 级从 `316` 提高到 `380`，溅射伤害继续保持低衰减。
- 增加所有炮塔子弹有效距离：非狙击炮塔弹丸有效距离倍率从 `6.00` 提高到 `7.25`；狙击弹离屏保留距离从 `860` 提高到 `1100`。
- 扩展 `LogicSmokeTest.gd`，覆盖新的速射成长、重炮溅射半径、重武器回弹停留、普通弹丸距离和狙击离屏距离阈值。
- 扩展 `CodeStyleAuditTest.gd`，禁止关键重武器数值回退到 `ver0.34.0` 旧参数。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“重炮和狙击更有重量了”的玩法优化公告，并设为最新公告 `ver0.35.0`。

验证：
- Godot 4.7 `Tower.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Projectile.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.35.1 - 射程与攻速增益读取防御化

- 创建 `.backup/backup_range_fire_rate_boost_sanitizers_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `RANGE_BOOST_DEFAULT_MULTIPLIER`、`RANGE_BOOST_MAX_MULTIPLIER`、`RANGE_BOOST_DEFAULT_DURATION`、`RANGE_BOOST_MAX_DURATION`、`FIRE_RATE_BOOST_DEFAULT_MULTIPLIER`、`FIRE_RATE_BOOST_MAX_MULTIPLIER`、`FIRE_RATE_BOOST_DEFAULT_DURATION` 和 `FIRE_RATE_BOOST_MAX_DURATION`，集中管理信号中继和急速协议的默认参数与安全上限。
- 信号中继、急速协议卡牌定义改为引用默认常量，避免默认倍率和持续时间散落在配置里。
- 信号中继释放逻辑改为通过 `_get_range_boost_card_multiplier()` 和 `_get_range_boost_card_duration()` 读取卡牌数据。
- 急速协议释放逻辑改为通过 `_get_fire_rate_boost_card_multiplier()` 和 `_get_fire_rate_boost_card_duration()` 读取卡牌数据。
- 当射程/攻速倍率低于 1、过大、异常类型，或持续时间为零、负数、过长、异常类型时，会回退到默认参数。
- 扩展 `LogicSmokeTest.gd`，覆盖射程/攻速增益倍率和持续时间的正常值、零值、负数、异常类型和过大值读取路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止射程/攻速增益释放逻辑退回到旧的直接字典读取写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“增益卡更稳了”的修复优化公告，并设为最新公告 `ver0.35.1`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.35.2 - 轨道导弹读取防御化

- 创建 `.backup/backup_missile_card_sanitizers_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `MISSILE_CARD_DEFAULT_DAMAGE`、`MISSILE_CARD_MAX_DAMAGE`、`MISSILE_CARD_DEFAULT_RADIUS` 和 `MISSILE_CARD_MAX_RADIUS`，集中管理轨道导弹默认伤害、默认半径和安全上限。
- 轨道导弹卡牌定义和调试控制台生成的导弹卡改为引用默认常量，避免默认伤害和半径散落在配置里。
- 轨道导弹释放逻辑改为通过 `_get_missile_card_damage()` 和 `_get_missile_card_radius()` 读取卡牌数据。
- 轨道导弹释放范围预览同步使用 `_get_missile_card_radius()`，异常半径不会导致预览和实际范围不一致。
- 修复缺失 `damage` 字段时会回退到旧版 `90` 伤害的问题，现在会回退到当前默认 `270` 伤害。
- 当轨道导弹伤害或半径为零、负数、异常类型或过大值时，会回退到默认参数。
- 扩展 `LogicSmokeTest.gd`，覆盖轨道导弹伤害和半径的正常值、缺失值、零值、负数、异常类型和过大值读取路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止轨道导弹释放逻辑退回到旧的直接字典读取写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“轨道导弹参数更稳了”的修复优化公告，并设为最新公告 `ver0.35.2`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.35.3 - 冷冻地雷读取防御化

- 创建 `.backup/backup_cryo_card_sanitizers_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `CRYO_CARD_DEFAULT_DAMAGE`、`CRYO_CARD_MAX_DAMAGE`、`CRYO_CARD_DEFAULT_RADIUS`、`CRYO_CARD_MAX_RADIUS`、`CRYO_CARD_DEFAULT_SLOW_MULTIPLIER`、`CRYO_CARD_DEFAULT_DURATION` 和 `CRYO_CARD_MAX_DURATION`，集中管理冷冻地雷默认参数和安全上限。
- 冷冻地雷卡牌定义和调试控制台生成的冷冻卡改为引用默认常量，避免默认伤害、半径、减速倍率和持续时间散落在配置里。
- 冷冻地雷释放逻辑改为通过 `_get_cryo_card_damage()`、`_get_cryo_card_radius()`、`_get_cryo_card_slow_multiplier()` 和 `_get_cryo_card_duration()` 读取卡牌数据。
- 冷冻地雷释放范围预览同步使用 `_get_cryo_card_radius()`，异常半径不会导致预览和实际范围不一致。
- 当冷冻地雷伤害、半径、减速倍率或持续时间为零、负数、异常类型或过大值时，会回退到默认参数。
- 扩展 `LogicSmokeTest.gd`，覆盖冷冻地雷伤害、半径、减速倍率和持续时间的正常值、缺失值、零值、负数、异常类型和过大值读取路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止冷冻地雷释放逻辑退回到旧的直接字典读取写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“冷冻地雷更稳了”的修复优化公告，并设为最新公告 `ver0.35.3`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.35.4 - 全屏范围卡读取防御化

- 创建 `.backup/backup_global_area_card_sanitizers_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `FIRESTORM_CARD_DEFAULT_DAMAGE`、`FIRESTORM_CARD_MAX_DAMAGE`、`FIRESTORM_CARD_DEFAULT_RADIUS`、`GLOBAL_FREEZE_CARD_DEFAULT_DAMAGE`、`GLOBAL_FREEZE_CARD_MAX_DAMAGE`、`GLOBAL_FREEZE_CARD_DEFAULT_RADIUS`、`GLOBAL_FREEZE_CARD_DEFAULT_SLOW_MULTIPLIER`、`GLOBAL_FREEZE_CARD_DEFAULT_DURATION` 和 `GLOBAL_FREEZE_CARD_MAX_DURATION`，集中管理全屏火焰和冻结全屏默认参数与安全上限。
- 全屏火焰、冻结全屏卡牌定义改为引用默认常量，避免默认伤害、半径、减速倍率和持续时间散落在配置里。
- 全屏火焰释放逻辑改为通过 `_get_firestorm_card_damage()` 读取伤害。
- 冻结全屏释放逻辑改为通过 `_get_global_freeze_card_damage()`、`_get_global_freeze_card_slow_multiplier()` 和 `_get_global_freeze_card_duration()` 读取卡牌数据。
- 修复全屏火焰缺失 `damage` 字段时会回退到旧版 `45` 伤害的问题，现在会回退到当前默认 `135` 伤害。
- 当全屏火焰伤害，或冻结全屏伤害、减速倍率、持续时间为零、负数、异常类型或过大值时，会回退到默认参数。
- 扩展 `LogicSmokeTest.gd`，覆盖全屏火焰和冻结全屏参数的正常值、缺失值、零值、负数、异常类型和过大值读取路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止全屏火焰和冻结全屏释放逻辑退回到旧的直接字典读取写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“全屏卡牌更稳了”的修复优化公告，并设为最新公告 `ver0.35.4`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.35.5 - 卡牌出售值读取防御化

- 创建 `.backup/backup_card_sell_value_sanitizer_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `REWARD_CARD_DEFAULT_SELL_VALUE` 和 `REWARD_CARD_MAX_SELL_VALUE`，集中管理卡牌默认出售金币和安全上限。
- 卡牌出售逻辑改为通过 `_get_reward_card_sell_value()` 读取出售值，避免直接 `int(sell_value)` 读取异常配置。
- 当卡牌出售值缺失、为零、负数、异常类型或过大值时，会回退到默认出售金币。
- 扩展 `LogicSmokeTest.gd`，覆盖卡牌出售值的正常值、小数取整、缺失值、零值、负数、异常类型和过大值读取路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止卡牌出售逻辑退回到旧的直接字典读取写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“卖卡收益更稳了”的修复优化公告，并设为最新公告 `ver0.35.5`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.35.6 - 尖刺路障参数上限防御化

- 创建 `.backup/backup_road_spike_limits_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `ROAD_SPIKE_MAX_RADIUS`、`ROAD_SPIKE_MAX_DAMAGE`、`ROAD_SPIKE_MAX_CHARGES` 和 `ROAD_SPIKE_MAX_DURATION`，为尖刺路障范围、伤害、触发次数和持续时间增加安全上限。
- 收紧 `_sanitize_road_spike_radius()`、`_sanitize_road_spike_damage()`、`_sanitize_road_spike_charges()` 和 `_sanitize_road_spike_duration()`，异常过大值会回退到默认参数。
- 尖刺路障释放范围预览继续使用清洗后的半径，过大半径不会导致预览和实际范围不一致。
- 扩展 `LogicSmokeTest.gd`，覆盖尖刺路障半径、伤害、触发次数、持续时间过大值回退路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止尖刺路障 sanitizer 退回到只判断 `> 0` 的旧写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“尖刺路障更可控了”的修复优化公告，并设为最新公告 `ver0.35.6`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.35.7 - 战利品磁铁持续时间上限防御化

- 创建 `.backup/backup_coin_magnet_duration_limit_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `COIN_MAGNET_MAX_DURATION`，为战利品磁铁持续时间增加安全上限。
- 收紧 `_sanitize_coin_magnet_duration()`，异常过长持续时间会回退到默认 `12` 秒。
- 战利品磁铁击杀金币加成倍率继续保留既有 `COIN_MAGNET_MAX_BONUS_RATIO` 上限。
- 扩展 `LogicSmokeTest.gd`，覆盖战利品磁铁持续时间过长值回退路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止战利品磁铁持续时间 sanitizer 退回到只判断 `> 0` 的旧写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“战利品磁铁更稳了”的修复优化公告，并设为最新公告 `ver0.35.7`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.35.8 - 时间裂隙范围与时长上限防御化

- 创建 `.backup/backup_time_warp_limits_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `TIME_WARP_MAX_RADIUS` 和 `TIME_WARP_MAX_DURATION`，为时间裂隙释放范围和持续时间增加安全上限。
- 收紧 `_sanitize_time_warp_radius()` 和 `_sanitize_time_warp_duration()`，异常过大范围或过长持续时间会回退到默认参数。
- 时间裂隙释放范围预览继续使用清洗后的半径，过大半径不会导致预览和实际范围不一致。
- 扩展 `LogicSmokeTest.gd`，覆盖时间裂隙半径过大和持续时间过长值回退路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止时间裂隙半径/持续时间 sanitizer 退回到只判断 `> 0` 的旧写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“时间裂隙更稳了”的修复优化公告，并设为最新公告 `ver0.35.8`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.36.0 - 重武器手感与弹丸距离再优化

- 创建 `.backup/backup_heavy_weapon_feel_20260705`，备份本轮改动前的 `Tower.gd`、`Projectile.gd`、`Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 优化重炮塔和狙击塔后座动画：提高后座位移上限，并进一步放慢回弹曲线，让开火后的重量感更明显。
- 削弱速射塔升级后的输出增长梯度：二级、三级仍增加弹丸数量，但装填间隔惩罚提高，避免后期 DPS 跳变过猛。
- 增大重炮塔溅射范围：基础/二级/三级半径调整为 `240 / 330 / 450`。
- 降低重炮溅射伤害衰减：溅射系数提高到 `1.08`，让范围伤害更稳定。
- 增加所有非狙击炮塔弹丸有效距离：距离倍率从 `7.25` 提高到 `9.00`。
- 增加狙击弹屏幕外保留距离：从 `1100` 提高到 `1400`，穿透弹更不容易提前消失。
- 扩展 `LogicSmokeTest.gd`，覆盖本轮速射成长、重炮范围/衰减、重武器后座和弹丸距离要求。
- 扩展 `CodeStyleAuditTest.gd`，禁止重炮、速射、弹丸距离和狙击弹清理距离退回旧数值。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“重武器更有压迫感了”的玩法优化公告，并设为最新公告 `ver0.36.0`。

验证：
- Godot 4.7 `Tower.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Projectile.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.36.1 - 诱饵信标范围与时长上限防御化

- 创建 `.backup/backup_bait_beacon_limits_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `BAIT_BEACON_MAX_RADIUS` 和 `BAIT_BEACON_MAX_DURATION`，为诱饵信标牵引范围和持续时间增加安全上限。
- 收紧 `_sanitize_bait_beacon_radius()` 和 `_sanitize_bait_beacon_duration()`，异常过大范围或过长持续时间会回退到默认参数。
- 诱饵信标释放范围预览继续使用清洗后的半径，过大半径不会导致预览和实际效果不一致。
- 扩展 `LogicSmokeTest.gd`，覆盖诱饵信标半径过大和持续时间过长值回退路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止诱饵信标半径/持续时间 sanitizer 退回到只判断 `> 0` 的旧写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“诱饵信标更稳了”的修复优化公告，并设为最新公告 `ver0.36.1`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.36.2 - 塔位调度范围与时长上限防御化

- 创建 `.backup/backup_tower_swap_limits_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `TOWER_SWAP_MAX_RADIUS` 和 `TOWER_SWAP_MAX_DURATION`，为塔位调度作用范围和持续时间增加安全上限。
- 收紧 `_sanitize_tower_swap_radius()` 和 `_sanitize_tower_swap_duration()`，异常过大范围或过长持续时间会回退到默认参数。
- 塔位调度释放范围预览继续使用清洗后的半径，过大半径不会导致预览和实际效果不一致。
- 扩展 `LogicSmokeTest.gd`，覆盖塔位调度半径过大和持续时间过长值回退路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止塔位调度半径/持续时间 sanitizer 退回到只判断 `> 0` 的旧写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“塔位调度更稳了”的修复优化公告，并设为最新公告 `ver0.36.2`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.36.3 - 透支超频时长上限防御化

- 创建 `.backup/backup_overload_debt_duration_limits_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `OVERLOAD_DEBT_MAX_DURATION`，为透支超频的爆发持续时间和后续降速持续时间增加统一安全上限。
- 收紧 `_sanitize_overload_debt_duration()`，异常过长持续时间会回退到对应默认参数。
- 扩展 `LogicSmokeTest.gd`，覆盖透支超频爆发时间过长和降速时间过长值回退路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止透支超频时长 sanitizer 退回到只判断 `> 0` 的旧写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“透支超频更可控了”的修复优化公告，并设为最新公告 `ver0.36.3`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.36.4 - 紧急按钮治疗与时长上限防御化

- 创建 `.backup/backup_panic_button_limits_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `PANIC_BUTTON_MAX_HEAL`、`PANIC_BUTTON_MAX_PANIC_HEAL` 和 `PANIC_BUTTON_MAX_DURATION`，为紧急按钮普通治疗、低血量紧急治疗和全屏缓冲持续时间增加安全上限。
- 收紧 `_sanitize_panic_button_heal()` 和 `_sanitize_panic_button_duration()`，异常过大治疗量或过长持续时间会回退到默认参数。
- 扩展 `LogicSmokeTest.gd`，覆盖紧急按钮普通治疗过大、紧急治疗过大和持续时间过长值回退路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止紧急按钮治疗量/持续时间 sanitizer 退回到只判断 `> 0` 的旧写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“紧急按钮更可靠了”的修复优化公告，并设为最新公告 `ver0.36.4`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.36.5 - 悬赏标记范围上限防御化

- 创建 `.backup/backup_bounty_mark_radius_limit_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `BOUNTY_MARK_MAX_RADIUS`，为悬赏标记搜索范围增加安全上限。
- 收紧 `_sanitize_bounty_mark_radius()`，异常过大范围会回退到默认参数。
- 悬赏标记释放范围预览继续使用清洗后的半径，过大半径不会导致预览和实际效果不一致。
- 扩展 `LogicSmokeTest.gd`，覆盖悬赏标记半径过大值回退路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止悬赏标记半径 sanitizer 退回到只判断 `> 0` 的旧写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“悬赏标记更稳了”的修复优化公告，并设为最新公告 `ver0.36.5`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.36.6 - 炮塔配置读取防御化

- 创建 `.backup/backup_tower_config_sanitizers_20260705`，备份本轮改动前的 `Tower.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增炮塔配置读取上限常量，覆盖成本、伤害、射程、攻击间隔、弹速、弹丸数、散射角、溅射半径、溅射系数和穿透数量。
- `Tower.setup()` 改为通过 `_get_positive_int_config()`、`_get_non_negative_int_config()`、`_get_positive_float_config()` 和 `_get_non_negative_float_config()` 读取数值配置。
- 异常、负数、零值或过大值不会直接进入炮塔实例，关键战斗字段会回退到安全默认值。
- 扩展 `LogicSmokeTest.gd`，覆盖异常炮塔配置和过大炮塔配置的回退路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止 `Tower.setup()` 退回到直接 `int/float(type_config.get(...))` 的旧写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“炮塔配置更安全了”的修复优化公告，并设为最新公告 `ver0.36.6`。

验证：
- Godot 4.7 `Tower.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.36.7 - 敌人配置读取防御化

- 创建 `.backup/backup_enemy_config_sanitizers_20260705`，备份本轮改动前的 `Enemy.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增敌人配置读取默认值和上限常量，覆盖生命、速度、击杀奖励、体积和基地伤害。
- `Enemy.setup()` 改为通过 `_sanitize_positive_int()`、`_sanitize_non_negative_int()` 和 `_sanitize_positive_float()` 读取关键数值。
- 异常、负数、零值或过大值不会直接进入敌人实例，关键字段会回退到安全默认值。
- 扩展 `LogicSmokeTest.gd`，覆盖异常敌人配置和过大敌人配置的回退路径。
- 扩展 `CodeStyleAuditTest.gd`，禁止 `Enemy.setup()` 退回到直接写入原始生命、速度、奖励、体积和基地伤害的旧写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“敌人配置更安全了”的修复优化公告，并设为最新公告 `ver0.36.7`。

验证：
- Godot 4.7 `Enemy.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.36.8 - 刷怪倍率读取防御化

- 创建 `.backup/backup_wave_enemy_multiplier_sanitizers_20260705`，备份本轮改动前的 `WaveManager.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增敌人波次倍率默认值和上限常量，覆盖生命倍率、速度倍率和击杀奖励倍率。
- `WaveManager._get_enemy_stat_multipliers()` 改为通过 `_sanitize_positive_multiplier()` 读取倍率，异常、零值、负数或过大值会回退到安全默认值。
- 新增 `_get_enemy_type_config()`，读取敌人类型配置时返回快照，避免波次缓存构建时直接持有 `Main.gd` 内部配置字典。
- 扩展 `LogicSmokeTest.gd`，覆盖异常倍率、过大倍率和敌人类型配置快照读取。
- 扩展 `CodeStyleAuditTest.gd`，禁止波次管理器退回到直接读取 `health_mul`、`speed_mul`、`reward_mul` 的旧写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“刷怪倍率更稳了”的修复优化公告，并设为最新公告 `ver0.36.8`。

验证：
- Godot 4.7 `WaveManager.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.36.9 - 关卡配置读取上限防御化

- 创建 `.backup/backup_level_config_limits_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增关卡配置上限常量，覆盖地图列数、地图行数、基地血量、关卡奖励金币、维修量和波次数。
- `_get_level_map_size()`、`_get_level_resources()` 和 `_get_level_wave_count()` 改为通过 `_sanitize_level_int()` 读取数值。
- 数字配置会被限制在合法上下限内；非数字配置会回退到默认值。
- 扩展 `LogicSmokeTest.gd`，覆盖超大地图、超大资源、超大波数和非数字配置回退。
- 扩展 `CodeStyleAuditTest.gd`，禁止关卡配置读取退回到只有下限、没有上限的旧写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“关卡配置更可靠了”的修复优化公告，并设为最新公告 `ver0.36.9`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.36.10 - 关卡起始存档读取防御化

- 创建 `.backup/backup_level_start_save_limits_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `MAX_SAVED_BASE_HEALTH`，为继续游戏存档中的基地生命上限增加安全边界。
- `_read_level_start_save()` 改为统一清洗关卡索引、最高解锁关卡、金币、基地生命和基地生命上限。
- `_save_level_start_state()` 写入存档前也会钳制当前运行状态，避免异常运行状态继续污染存档。
- 扩展 `LogicSmokeTest.gd`，覆盖被篡改的超大存档、非数字存档和保存时钳制。
- 扩展 `CodeStyleAuditTest.gd`，禁止继续游戏存档读取/写入退回到无上限旧写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“继续游戏更稳了”的修复优化公告，并设为最新公告 `ver0.36.10`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.36.11 - 敌人类型 ID 校验

- 创建 `.backup/backup_enemy_type_id_validation_20260705`，备份本轮改动前的 `Main.gd`、`WaveManager.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `Main._sanitize_enemy_type_id()`，敌人类型 ID 必须存在于 `enemy_type_configs`，否则回退到 `grunt`。
- `_get_level_enemy_types()` 会跳过空 ID，并把未知敌人类型回退为步兵，避免错误关卡配置进入波次系统。
- `WaveManager` 在 setup、统计查询、倍率缓存和波次属性缓存中统一使用清洗后的敌人类型 ID。
- 控制台 `spawn` 和直接刷怪入口会先清洗敌人类型，未知 ID 会生成步兵并显示“步兵”。
- 扩展 `LogicSmokeTest.gd`，覆盖关卡敌人类型清洗、波次统计清洗、缓存 key 清洗和控制台未知敌人刷怪回退。
- 扩展 `CodeStyleAuditTest.gd`，禁止关卡、波次和控制台刷怪退回到直接使用原始敌人类型 ID 的旧写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“敌人类型更可靠了”的修复优化公告，并设为最新公告 `ver0.36.11`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `WaveManager.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.36.12 - 炮塔类型 ID 校验

- 创建 `.backup/backup_tower_type_id_validation_20260705`，备份本轮改动前的 `Main.gd`、`BuildManager.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `Main._sanitize_tower_type_id()`，炮塔类型 ID 必须存在于 `tower_configs`，否则回退到 `basic`。
- `get_tower_config()`、`is_tower_type_unlocked()` 和 `_on_tower_build_requested()` 会先清洗炮塔类型 ID。
- `BuildManager.enter_build_mode()` 会保存清洗后的炮塔类型 ID，避免未知 ID 污染建造状态、预览缓存和实际建造。
- 扩展 `LogicSmokeTest.gd`，覆盖未知炮塔配置读取、显示名、解锁判断和建造模式回退。
- 扩展 `CodeStyleAuditTest.gd`，禁止主流程和建造管理器退回到直接使用原始炮塔类型 ID 的旧写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“建塔选择更稳了”的修复优化公告，并设为最新公告 `ver0.36.12`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `BuildManager.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.37.0 - 重武器厚重感与弹丸距离再强化

- 创建 `.backup/backup_heavy_weapon_balance_20260705`，备份本轮改动前的 `Tower.gd`、`Projectile.gd`、`Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 优化狙击塔和重炮塔开火动画：后座最大窗口从 `1.90` 提高到 `2.25`，重炮/狙击后座持续倍率提高，回弹曲线进一步放慢，开火后的重量感更明显。
- 削弱速射塔升级伤害增长梯度：2 级装填间隔倍率从 `1.42` 调整为 `1.55`，3 级从 `1.32` 调整为 `1.45`，保留双联/三联特色但降低后期输出跳变。
- 增强重炮塔范围伤害：基础爆炸半径从 `240` 提高到 `280`，2 级从 `330` 提高到 `390`，3 级从 `450` 提高到 `540`；溅射比例从 `1.08` 提高到 `1.16`，边缘目标更能吃到有效伤害。
- 增加弹丸有效距离：非狙击炮塔弹丸飞行距离倍率从 `9.00` 提高到 `11.00`；狙击弹离屏保留距离从 `1400` 提高到 `1800`。
- 扩展 `LogicSmokeTest.gd`，更新重炮范围、速射升级、后座厚重感、普通弹丸距离和狙击弹离屏保留距离的断言。
- 扩展 `CodeStyleAuditTest.gd`，禁止关键战斗手感数值退回到旧版本参数。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“重武器更沉，爆炸更大”的玩法优化公告，并设为最新公告 `ver0.37.0`。

验证：
- Godot 4.7 `Tower.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Projectile.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.37.1 - 奖励卡牌 ID 校验

- 创建 `.backup/backup_reward_card_id_validation_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `Main.DEFAULT_REWARD_CARD_ID` 和 `_sanitize_reward_card_id()`，奖励卡牌 ID 必须存在于奖励卡牌池，否则回退到默认奖励卡 `tower_boost`。
- `_normalize_reward_card()` 会先确认 `id` 或旧字段 `card_id` 是否为已知卡牌；未知 ID 不再保留原始名称、原始效果字段或未知 ID。
- `_get_reward_card_definition()` 支持通过别名读取卡牌定义，例如 `boost` 会解析为 `tower_boost`。
- 控制台 `card <类型>` 遇到未知卡牌类型时，会确定性创建默认奖励卡，不再按当前波次随机生成一张奖励卡。
- 扩展 `LogicSmokeTest.gd`，覆盖未知卡牌规范化、手牌存储、待处理新卡、旧 `card_id` 别名和控制台未知卡牌回退。
- 扩展 `CodeStyleAuditTest.gd`，禁止卡牌规范化和调试卡创建退回到保留未知 ID 的旧写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“奖励卡牌更稳了”的修复优化公告，并设为最新公告 `ver0.37.1`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.37.2 - 奖励卡牌字段清洗

- 创建 `.backup/backup_reward_card_field_sanitizers_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `_get_numeric_reward_card_field()` 和 `_restore_reward_card_default_field()`，奖励卡牌稀有度缩放前会先确认字段是否为数字。
- 已知卡牌如果带入异常的伤害、范围、倍率、持续时间等字段，会恢复为该卡牌定义中的默认字段后再参与稀有度缩放。
- 无关且异常的数字字段会在规范化时移除，避免坏数据污染手牌或后续效果。
- 扩展 `LogicSmokeTest.gd`，覆盖异常倍率、异常持续时间、异常伤害、异常范围和无关异常字段的恢复/移除。
- 扩展 `CodeStyleAuditTest.gd`，禁止奖励卡牌稀有度缩放退回到直接 `float(card[key])` 的旧写法。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“卡牌字段更可靠了”的修复优化公告，并设为最新公告 `ver0.37.2`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.37.3 - 已缩放奖励卡牌字段清洗

- 创建 `.backup/backup_reward_card_prescaled_field_sanitizers_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增奖励卡牌数字字段清单常量，统一维护整数、浮点、倍率、概率和减速字段。
- 新增 `_sanitize_reward_card_numeric_fields()`，奖励卡牌规范化时会先清洗数字字段，再判断 `_rarity_scaled` 是否需要继续缩放。
- 修复伪造或旧数据中 `_rarity_scaled = true` 时，异常字段可能跳过清洗的问题。
- 扩展 `LogicSmokeTest.gd`，覆盖已带内部缩放标记的卡牌仍会恢复异常倍率、异常持续时间并移除无关异常字段。
- 扩展 `CodeStyleAuditTest.gd`，禁止字段清洗重新放回 `_rarity_scaled` 判断之后。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“旧卡牌数据更稳了”的修复优化公告，并设为最新公告 `ver0.37.3`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.38.0 - 重武器动画与弹丸距离再平衡

- 创建 `.backup/backup_ver0_38_0_heavy_weapon_balance_20260705`，备份本轮改动前的 `Tower.gd`、`Projectile.gd`、`Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 优化狙击塔和重炮塔后座动画：后座最大窗口从 `2.25` 提高到 `2.70`，重炮/狙击后座持续倍率提高，回弹曲线进一步放慢，后座距离也更大。
- 削弱速射塔升级伤害成长：2 级装填倍率从 `1.55` 调整为 `1.70`，3 级从 `1.45` 调整为 `1.58`，保留双联/三联弹幕但压低后期输出跳变。
- 增强重炮范围表现：基础爆炸半径从 `280` 提高到 `330`，2 级从 `390` 提高到 `460`，3 级从 `540` 提高到 `640`；溅射比例从 `1.16` 提高到 `1.24`。
- 增加弹丸有效距离：非狙击炮塔弹丸距离倍率从 `11.00` 提高到 `13.00`，狙击弹离屏保留距离从 `1800` 提高到 `2200`。
- 扩展 `LogicSmokeTest.gd`，更新速射成长、重炮溅射、弹丸距离和重武器后座慢回弹断言。
- 扩展 `CodeStyleAuditTest.gd`，禁止关键战斗手感数值退回到 `ver0.37.0` 参数。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“重炮更炸，狙击更沉”的玩法优化公告，并设为最新公告 `ver0.38.0`。

验证：
- Godot 4.7 `Tower.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Projectile.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.38.1 - 奖励卡牌稀有度校验

- 创建 `.backup/backup_reward_card_rarity_sanitizer_20260705`，备份本轮改动前的 `Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `Main._sanitize_reward_card_rarity()` 和 `_is_valid_reward_card_rarity()`，奖励卡牌稀有度必须是白、蓝、紫、金、红之一。
- `_normalize_reward_card()` 会在数值字段清洗和稀有度缩放前写回合法稀有度；非法稀有度回退到该卡牌定义中的默认稀有度。
- `_get_reward_card_rarity_power()` 和 `_get_reward_card_rarity_color()` 会先清洗稀有度再匹配，避免调试数据或坏存档影响倍率和释放颜色。
- 扩展 `LogicSmokeTest.gd`，覆盖非法稀有度回退、大小写与空格清洗、合法稀有度覆盖保留，以及手牌/待处理新卡不保存非法稀有度。
- 扩展 `CodeStyleAuditTest.gd`，禁止卡牌规范化绕过稀有度清洗，禁止稀有度倍率和颜色退回到直接匹配原始字符串。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“卡牌稀有度更稳了”的修复优化公告，并设为最新公告 `ver0.38.1`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.38.2 - 波次设置边界校验

- 创建 `.backup/backup_wave_setup_sanitizers_20260705`，备份本轮改动前的 `WaveManager.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `WaveManager.DEFAULT_TOTAL_WAVES`、`MAX_TOTAL_WAVES`、`DEFAULT_ROUTE_COUNT` 和 `MAX_ROUTE_COUNT`，为波次管理器的入口参数提供明确边界。
- 新增 `_sanitize_total_waves()` 和 `_sanitize_route_count()`，`setup()` 会先清洗总波数和路线数再写入内部状态。
- 修复直接调用 `WaveManager.setup()` 时，负波数、过大波数或过大路线数可能污染刷怪状态的问题。
- 扩展 `LogicSmokeTest.gd`，覆盖有效波数/路线数保留、非法波数回退、过大波数回退和异常路线数回退。
- 扩展 `CodeStyleAuditTest.gd`，禁止波次设置退回到直接赋值 `total_waves` 或只用 `maxi()` 处理路线数。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“波次配置更安全了”的修复优化公告，并设为最新公告 `ver0.38.2`。

验证：
- Godot 4.7 `WaveManager.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.38.3 - 建造道路缓存清洗

- 创建 `.backup/backup_build_road_cell_sanitizer_20260705`，备份本轮改动前的 `BuildManager.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `BuildManager._sanitize_road_cells()` 和 `_get_valid_road_cell()`，建造管理器会先过滤道路格子缓存再用于建造阻挡。
- 道路缓存现在只保留 `Vector2i` 格子，并允许 `Vector2` 调试值转换为最近格子；非法值会被丢弃，重复格子会合并。
- `_road_cell_lookup` 改为从已清洗的格子键重建，避免未校验值再次被强制写入阻挡表。
- 扩展 `LogicSmokeTest.gd`，覆盖非法道路值丢弃、重复道路格合并、`Vector2` 转换和原关卡道路缓存恢复后仍能正常阻挡。
- 扩展 `CodeStyleAuditTest.gd`，禁止建造管理器退回到直接复制外部道路字典或未校验 `Vector2i` 赋值。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“建造阻挡更稳了”的修复优化公告，并设为最新公告 `ver0.38.3`。

验证：
- Godot 4.7 `BuildManager.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.38.4 - 地图道路绘制缓存清洗

- 创建 `.backup/backup_map_road_cell_sanitizer_20260705`，备份本轮改动前的 `MapRenderer.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `MapRenderer._get_sanitized_road_cells()` 和 `_get_valid_road_cell()`，地图渲染器会先过滤道路格子再生成道路绘制缓存。
- 道路绘制缓存现在只保留 `Vector2i` 格子，并允许 `Vector2` 调试值转换为最近格子；非法值会被丢弃，重复格子会合并。
- 道路边框、内层、亮部和暗部矩形缓存现在都基于已清洗的道路格子生成。
- 扩展 `LogicSmokeTest.gd`，覆盖地图渲染器丢弃非法道路值、合并重复道路格、转换 `Vector2`，以及恢复原关卡道路缓存后继续工作。
- 扩展 `CodeStyleAuditTest.gd`，禁止地图渲染器退回到直接强转 `game.road_cells` 或从未清洗道路数据生成绘制缓存。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“地图道路绘制更稳了”的修复优化公告，并设为最新公告 `ver0.38.4`。

验证：
- Godot 4.7 `MapRenderer.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.39.0 - 重武器动画与弹丸距离强化

- 创建 `.backup/backup_ver0_39_0_heavy_weapon_balance_20260705`，备份本轮改动前的 `Tower.gd`、`Projectile.gd`、`Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 优化狙击塔和重炮塔后座动画：后座最大窗口从 `2.70` 提高到 `3.10`，重炮/狙击后座持续倍率提高，并允许重武器按攻击间隔拥有更长的厚重回座窗口。
- 进一步放慢重炮和狙击的回弹曲线：重炮回弹幂值从 `0.016` 降到 `0.010`，狙击从 `0.022` 降到 `0.014`，中后段位移保留更久。
- 削弱速射塔升级伤害增长梯度：2 级装填倍率从 `1.70` 调整为 `1.82`，3 级从 `1.58` 调整为 `1.70`，保留双联/三联特色但降低后期输出跳变。
- 增大重炮塔范围伤害：基础爆炸半径从 `330` 提高到 `380`，2 级从 `460` 提高到 `540`，3 级从 `640` 提高到 `740`；溅射比例从 `1.24` 提高到 `1.32`。
- 增加所有炮塔子弹有效距离：非狙击炮塔弹丸距离倍率从 `13.00` 提高到 `15.50`，狙击弹离屏保留距离从 `2200` 提高到 `2600`。
- 扩展 `LogicSmokeTest.gd`，更新速射成长、重炮溅射、弹丸距离、狙击离屏距离和重武器慢回弹断言。
- 扩展 `CodeStyleAuditTest.gd`，禁止关键战斗手感数值退回到 `ver0.38.0` 参数。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“重炮更轰，狙击更沉”的玩法优化公告，并设为最新公告 `ver0.39.0`。

验证：
- Godot 4.7 `Tower.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Projectile.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.39.1 - 地图路线绘制缓存清洗

- 创建 `.backup/backup_ver0_39_1_map_route_path_sanitizer_20260705`，备份本轮改动前的 `MapRenderer.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `MapRenderer._get_sanitized_route_paths()`、`_get_sanitized_route_path()` 和 `_get_valid_route_point()`，地图渲染器会先过滤路线折线再生成路线绘制缓存。
- 路线绘制缓存现在只保留 `Vector2` / `Vector2i` 路线点，`Vector2i` 会转换为 `Vector2`；非法点会被丢弃。
- 少于两个有效点的路线不会进入 `_cached_route_paths`，避免坏数据影响道路中心线和出怪门绘制。
- 扩展 `LogicSmokeTest.gd`，覆盖非法路线点丢弃、`Vector2i` 路线点转换、单点路线丢弃和非数组路线值过滤。
- 扩展 `CodeStyleAuditTest.gd`，禁止地图渲染器退回到直接 `PackedVector2Array(route_path)`。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“地图路线绘制更稳了”的修复优化公告，并设为最新公告 `ver0.39.1`。

验证：
- Godot 4.7 `MapRenderer.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.39.2 - 渲染主题颜色读取保护

- 创建 `.backup/backup_ver0_39_2_theme_color_sanitizer_20260705`，备份本轮改动前的 `Main.gd`、`MapRenderer.gd`、`WorldDecalRenderer.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `Main._get_valid_theme_color()`，主逻辑读取 `scene_theme` 颜色时会先确认值是 `Color`，否则回退调用方默认色。
- 新增 `MapRenderer._get_valid_theme_color()`，地图背景、道路、网格和水面装饰主题色读取不再直接强转外部 Variant。
- 新增 `WorldDecalRenderer._get_valid_theme_color()`，基地主体、底座和发光色读取不再直接强转外部 Variant。
- 扩展 `LogicSmokeTest.gd`，覆盖坏主题值回退、合法主题色保留，以及主逻辑/地图层/基地装饰层一致的主题色保护。
- 扩展 `CodeStyleAuditTest.gd`，禁止 `Main.gd`、`MapRenderer.gd` 和 `WorldDecalRenderer.gd` 退回到 `scene_theme[key] as Color` 直转。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“地图配色更稳了”的修复优化公告，并设为最新公告 `ver0.39.2`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `MapRenderer.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `WorldDecalRenderer.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.39.3 - 道路尖刺装饰数据清洗

- 创建 `.backup/backup_ver0_39_3_road_spike_decal_sanitizer_20260705`，备份本轮改动前的 `WorldDecalRenderer.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `WorldDecalRenderer._get_road_spike_trap_draw_position()`，尖刺陷阱装饰绘制会先清洗位置，支持 `Vector2` 和 `Vector2i`，非法值回退到 `Vector2.ZERO`。
- 新增 `WorldDecalRenderer._get_road_spike_trap_draw_radius()`，绘制半径只接受有效数值并限制在道路尖刺上限内，非法值回退默认半径。
- 新增 `WorldDecalRenderer._get_road_spike_trap_draw_charges()`，绘制尖刺数量只接受有效正数；耗尽、过大或非法次数会返回 `0`，让装饰层跳过绘制。
- 扩展 `LogicSmokeTest.gd`，覆盖尖刺装饰位置、半径和次数的清洗行为。
- 扩展 `CodeStyleAuditTest.gd`，禁止 `WorldDecalRenderer.gd` 退回到直接读取 `trap.get("position")`、`radius` 或 `charges`。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“陷阱显示更稳了”的修复优化公告，并设为最新公告 `ver0.39.3`。

验证：
- Godot 4.7 `WorldDecalRenderer.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.39.4 - 粒子配置读取清洗

- 创建 `.backup/backup_ver0_39_4_particle_burst_sanitizer_20260705`，备份本轮改动前的 `ParticleBurst.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `ParticleBurst._get_config_int()` 和 `_get_config_float()`，粒子数量、寿命、爆发度、随机度、范围、速度、阻尼、缩放和层级都先经过类型与边界检查。
- 新增 `ParticleBurst._get_config_vector2()` 和 `_get_config_color()`，方向、重力和颜色只接受合法类型，`Vector2i` 会安全转换为 `Vector2`。
- 新增 `ParticleBurst._get_particle_process_mode()`，粒子进程模式只接受 Godot 合法枚举值，非法值回退为 `PROCESS_MODE_PAUSABLE`。
- 扩展 `LogicSmokeTest.gd`，覆盖坏粒子配置回退默认属性，以及 `Vector2i` 粒子向量配置转换。
- 扩展 `CodeStyleAuditTest.gd`，禁止 `ParticleBurst.gd` 退回到直接 `int(config.get())`、`float(config.get())` 或原始向量/颜色读取。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“粒子特效更稳了”的修复优化公告，并设为最新公告 `ver0.39.4`。

验证：
- Godot 4.7 `ParticleBurst.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.39.5 - 命中特效配置读取清洗

- 创建 `.backup/backup_ver0_39_5_impact_effect_sanitizer_20260705`，备份本轮改动前的 `ImpactEffect.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `ImpactEffect._get_effect_process_mode()` 和 `_get_effect_profile()`，短时特效的进程模式和视觉类型会先确认合法性。
- 新增 `ImpactEffect._get_config_int()`、`_get_config_float()`、`_get_config_vector2()` 和 `_get_config_color()`，特效颜色、范围、方向、持续时间、线宽、散射角和层级都先经过类型与边界检查。
- 未知特效类型会回退到基础命中特效，非法方向、颜色、范围或时长会回退默认值。
- 扩展 `LogicSmokeTest.gd`，覆盖坏命中特效配置回退默认属性，以及 `Vector2i` 特效方向配置转换。
- 扩展 `CodeStyleAuditTest.gd`，禁止 `ImpactEffect.gd` 退回到直接 `int(config.get())`、`float(config.get())` 或原始向量/颜色读取。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“命中特效更稳了”的修复优化公告，并设为最新公告 `ver0.39.5`。

验证：
- Godot 4.7 `ImpactEffect.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.40.0 - 重武器手感与弹丸距离再强化

- 创建 `.backup/backup_ver0_40_0_heavy_weapon_feel_20260705`，备份本轮改动前的 `Tower.gd`、`Projectile.gd`、`Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 优化狙击塔和重炮塔后座动画：后座最大窗口从 `3.10` 提高到 `3.80`，重炮/狙击后座持续倍率继续提高，重武器回座窗口从攻击间隔的 `1.22` 倍提高到 `1.38` 倍。
- 进一步放慢重炮和狙击的回弹曲线：重炮回弹幂值从 `0.010` 降到 `0.007`，狙击从 `0.014` 降到 `0.010`，中后段位移保留更久。
- 削弱速射塔升级伤害增长梯度：2 级装填倍率从 `1.82` 调整为 `1.95`，3 级从 `1.70` 调整为 `1.86`，保留双联/三联弹幕特色但降低后期输出跳变。
- 增大重炮塔范围伤害：基础爆炸半径从 `380` 提高到 `440`，2 级从 `540` 提高到 `650`，3 级从 `740` 提高到 `900`；溅射比例从 `1.32` 提高到 `1.42`。
- 增加所有炮塔子弹有效距离：非狙击炮塔弹丸距离倍率从 `15.50` 提高到 `19.00`，狙击弹离屏保留距离从 `2600` 提高到 `3400`。
- 扩展 `LogicSmokeTest.gd`，更新速射成长、重炮溅射、弹丸距离、狙击离屏距离和重武器慢回弹断言。
- 扩展 `CodeStyleAuditTest.gd`，禁止关键战斗手感数值退回到 `ver0.39.0` 参数。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“重炮更沉，子弹飞得更远”的玩法优化公告，并设为最新公告 `ver0.40.0`。

验证：
- Godot 4.7 `Tower.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Projectile.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.40.1 - 建造塔配置读取清洗

- 创建 `.backup/backup_ver0_40_1_build_config_sanitizer_20260705`，备份本轮改动前的 `BuildManager.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `BuildManager._get_selected_tower_cost()`、`_get_selected_tower_range()` 和 `_get_selected_tower_category()`，建造模式缓存塔配置前会先检查费用、射程和分类。
- 新增 `BuildManager._get_positive_int_config()` 和 `_get_non_negative_float_config()`，费用和建造预览射程会经过类型与边界保护。
- 建造分类现在只接受 `support`，其他未知或异常值统一回退为 `weapon`，避免坏配置误触发增益塔叠加规则。
- 扩展 `LogicSmokeTest.gd`，覆盖费用、射程、分类 helper 的正常值、非法值、过大值和坏类型回退，并模拟坏塔配置进入建造模式。
- 扩展 `CodeStyleAuditTest.gd`，禁止 `BuildManager.gd` 退回到直接 `int()` / `float()` / `str()` 读取选中塔配置。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“建塔预览更稳了”的修复优化公告，并设为最新公告 `ver0.40.1`。

验证：
- Godot 4.7 `BuildManager.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.40.2 - 增幅塔配置读取清洗

- 创建 `.backup/backup_ver0_40_2_tower_augmentation_sanitizer_20260705`，备份本轮改动前的 `Tower.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `Tower._get_augmentation_id()`，增幅塔 id 会先去除空白，空 id 会回退为 `amplifier`。
- 新增 `Tower._get_augmentation_multiplier()`，增幅倍率只接受 `1.0` 到 `5.0` 的合法数值，非法、过大或削弱型倍率会回退为 `1.0`。
- 新增 `Tower._get_augmentation_cost()`，增幅费用只接受非负且不过大的合法数值，避免负投资或异常出售返还。
- `Tower.apply_augmentation()` 改为使用已清洗的 id、伤害倍率、射程倍率和费用，再刷新射程、伤害和索敌缓存。
- 扩展 `LogicSmokeTest.gd`，覆盖正常增幅、空 id、削弱倍率、过大倍率、坏类型倍率、负费用和过大费用。
- 扩展 `CodeStyleAuditTest.gd`，禁止 `Tower.gd` 退回到直接 `str()` / `float()` / `int()` 读取增幅配置。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“增幅塔更稳了”的修复优化公告，并设为最新公告 `ver0.40.2`。

验证：
- Godot 4.7 `Tower.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.40.3 - 建塔面板塔配置读取清洗

- 创建 `.backup/backup_ver0_40_3_gameui_tower_config_sanitizer_20260705`，备份本轮改动前的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `GameUI._get_tower_config_cost()`、`_get_tower_config_damage()`、`_get_tower_config_range()` 和 `_get_tower_config_interval()`，建塔按钮和提示文本会先清洗塔费用、伤害、射程和攻击间隔。
- 新增 `GameUI._get_tower_config_multiplier()`，增幅塔按钮的伤害/射程增幅显示只接受合理倍率，非法或削弱型倍率回退为 `1.0`。
- 新增 `GameUI._get_tower_config_category()`、`_get_tower_config_unlock_level()` 和 `_get_tower_config_color()`，建塔面板的塔分类、解锁关卡和按钮颜色会先检查后使用。
- 建塔按钮、紧凑建塔按钮、tooltip 和支援塔/武器塔 stat 文本都改为使用清洗后的 UI 配置值。
- 扩展 `LogicSmokeTest.gd`，覆盖 UI 塔配置 helper 的正常值、非法值、过大值、坏类型、坏颜色和坏倍率。
- 扩展 `CodeStyleAuditTest.gd`，禁止 `GameUI.gd` 退回到直接 `int()` / `float()` 读取建塔面板数值配置，或直接把原始颜色传给按钮样式。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“建塔面板更稳了”的修复优化公告，并设为最新公告 `ver0.40.3`。

验证：
- Godot 4.7 `GameUI.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.40.4 - 卡牌稀有度卡面样式读取清洗

- 创建 `.backup/backup_ver0_40_4_gameui_card_face_sanitizer_20260705`，备份本轮改动前的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `GameUI._get_card_face_color()` 和 `_get_card_face_accent()`，卡牌卡面颜色只接受合法 `Color`，非法值会回退安全颜色。
- 新增 `GameUI._get_card_face_int()` 和 `_get_card_face_float()`，卡牌边框、轨道、角标、点缀、条纹高度和透明度会先经过类型与边界检查。
- `_card_face_style()`、`_make_card_control()`、`_add_card_face_background()`、`_add_card_face_rails()`、`_add_card_face_corner_marks()`、`_add_card_face_pips()` 和 `_get_card_rarity_face_detail_score()` 改为使用清洗后的卡面样式值。
- 扩展 `LogicSmokeTest.gd`，覆盖坏卡面颜色、边框、点缀、尺寸和透明度配置的 fallback 行为。
- 扩展 `CodeStyleAuditTest.gd`，禁止 `GameUI.gd` 退回到直接 `face_style[...] as Color`、`int(face_style[...])` 或 `float(face_style[...])` 读取卡面样式。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“卡牌外观更稳了”的修复优化公告，并设为最新公告 `ver0.40.4`。

验证：
- Godot 4.7 `GameUI.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.40.5 - 更新公告正文读取清洗

- 创建 `.backup/backup_ver0_40_5_gameui_announcement_sanitizer_20260705`，备份本轮改动前的 `GameUI.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd`、`UpdateAnnouncements.gd` 和 `CHANGELOG.md`。
- 新增 `GameUI._get_update_announcement_summary()` 和 `_get_update_announcement_text()`，更新公告正文摘要只接受合法字符串，坏类型会回退为空文本。
- 调整 `GameUI._get_update_announcement_bullets()`，公告条目只保留非空字符串，并会去除首尾空白；非数组、空字符串和坏类型条目会被忽略。
- `_format_update_announcement_body()` 改为只渲染清洗后的摘要和条目，避免异常调试数据混入玩家公告正文。
- 扩展 `LogicSmokeTest.gd`，覆盖坏 summary、混合类型 bullets、空 bullet 和可保留字符串 bullet。
- 扩展 `CodeStyleAuditTest.gd`，禁止 `GameUI.gd` 退回到直接读取 summary、复制原始 bullet 数组或直接 `str(bullet)` 渲染。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“更新公告更稳了”的修复优化公告，并设为最新公告 `ver0.40.5`。

验证：
- Godot 4.7 `GameUI.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
---

## ver0.41.0 - 重武器动画与弹丸距离优化

- 创建 `.backup/backup_ver0_41_0_heavy_projectile_tuning_20260705`，备份本轮改动前的 `Tower.gd`、`Projectile.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 优化狙击塔和重炮塔开火后座：延长重武器回弹窗口，并把回弹曲线改得更平滑，避免临近结束才突然跳回。
- 削弱速射塔升级后的伤害增长梯度：继续保持二级双发、三级三发的特色，但进一步增加升级后的装填时间，让后期总火力更平稳。
- 增强重炮塔范围打击：基础溅射半径提高到 `560`，二级提高到 `780`，三级提高到 `1050`；溅射伤害比例提高到 `1.55`，范围边缘伤害更可靠。
- 增加弹丸有效距离：非狙击炮塔弹丸有效飞行距离提高到射程的 `24` 倍；狙击弹离开视野后的保留距离提高到 `4600`。
- 非狙击穿透弹没有显式距离时，默认续航距离从 `280` 提高到 `420`。
- 更新 `LogicSmokeTest.gd`，覆盖新的速射成长、重炮溅射、重武器回弹曲线、弹丸飞行距离和狙击离屏距离。
- 更新 `CodeStyleAuditTest.gd`，禁止重炮范围、速射装填、弹丸距离和狙击离屏距离回退到旧版本数值。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“重炮轰得更远，狙击弹飞得更久”的玩法优化公告，并设为最新公告 `ver0.41.0`。

验证：
- Godot 4.7 `Tower.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Projectile.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
- 未运行完整 `LogicSmokeTest.gd` 实际测试；该测试在当前 Godot 4.7 控制台环境中已多次触发“内存不能为 read”崩溃风险，本轮只执行语法检查和稳定审计测试。
---

## ver0.41.1 - 继续游戏存档应用清洗

- 创建 `.backup/backup_ver0_41_1_save_apply_sanitizer_20260705`，备份本轮改动前的 `Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 新增 `Main._get_saved_level_index()`、`_get_saved_highest_unlocked_level_index()`、`_get_saved_gold()`、`_get_saved_max_base_health()` 和 `_get_saved_base_health()`，继续游戏在应用存档前会再次清洗关卡、解锁进度、金币和基地生命。
- `_should_warn_save_overwrite()` 改为使用清洗后的存档关卡，避免坏存档影响覆盖提示判断。
- `_load_level_start_save()` 改为通过统一 helper 应用存档字段，不再直接 `int(save_data.get(...))`。
- 扩展 `LogicSmokeTest.gd`，覆盖直接传入坏存档字典时的关卡、解锁进度、金币、基地生命和生命上限清洗。
- 扩展 `CodeStyleAuditTest.gd`，禁止继续游戏流程退回到直接读取并转换存档字段。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“继续游戏读档更稳了”的修复优化公告，并设为最新公告 `ver0.41.1`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
- 未运行完整 `LogicSmokeTest.gd` 实际测试；该测试在当前 Godot 4.7 控制台环境中已多次触发“内存不能为 read”崩溃风险，本轮只执行语法检查和稳定审计测试。
---

## ver0.42.0 - 重武器手感与弹道距离强化

- 创建 `.backup/backup_ver0_42_0_heavy_weapon_distance_tuning_20260705`，备份本轮改动前的 `Tower.gd`、`Projectile.gd`、`Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 优化狙击塔和重炮塔开火动画：进一步延长重武器后座窗口，并降低回弹曲线速度，让回弹更慢、更有厚重感。
- 削弱速射塔升级伤害增长梯度：二级、三级仍保持双发/三发特色，但升级后的装填间隔进一步拉长，避免后期火力增长过快。
- 增强重炮塔范围打击：基础溅射半径提高到 `680`，二级提高到 `940`，三级提高到 `1240`；溅射伤害比例提高到 `1.68`，范围边缘伤害衰减更弱。
- 增加所有炮塔弹丸有效距离：非狙击炮塔弹丸有效飞行距离提高到射程的 `30` 倍；非狙击穿透弹默认续航提高到 `560`；狙击弹离开视野后的保留距离提高到 `5800`。
- 更新 `LogicSmokeTest.gd`，覆盖新的速射升级曲线、重炮范围、重武器后座曲线、弹丸飞行距离和狙击离屏保留距离。
- 更新 `CodeStyleAuditTest.gd`，禁止重炮旧范围、旧溅射比例、旧速射装填、旧后座参数和旧弹丸距离回退。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“重炮更沉，弹道更远”的玩法公告，并设为最新公告 `ver0.42.0`。

验证：
- Godot 4.7 `Tower.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Projectile.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
- 未运行完整 `LogicSmokeTest.gd` 实际测试；该测试在当前 Godot 4.7 控制台环境中已多次触发“内存不能为 read”崩溃风险，本轮只执行语法检查和稳定审计测试。
---

## ver0.42.1 - 卡牌范围预览半径清洗

- 创建 `.backup/backup_ver0_42_1_card_preview_radius_sanitizer_20260705`，备份本轮改动前的 `GameUI.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 新增 `GameUI.CARD_AREA_PREVIEW_DEFAULT_RADIUS` 和 `CARD_AREA_PREVIEW_MAX_RADIUS`，为拖拽范围卡的预览圈提供统一安全边界。
- 新增 `GameUI._get_card_area_preview_radius()`，只接受合法正数半径；缺失、零、负数、过大值和坏类型会回退为默认范围。
- `_start_card_drag()` 改为使用清洗后的半径绘制 `card_area_preview`，避免异常卡牌数据把范围预览画坏。
- 扩展 `LogicSmokeTest.gd`，覆盖预览半径 helper 的有效值、缺失值、非法值和真实坏卡拖拽预览 fallback。
- 扩展 `CodeStyleAuditTest.gd`，禁止 `GameUI.gd` 回退到直接 `float(_hand_cards[index].get("radius", 92.0))` 读取范围预览半径。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“卡牌范围预览更稳了”的修复公告，并设为最新公告 `ver0.42.1`。

验证：
- Godot 4.7 `GameUI.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
- 未运行完整 `LogicSmokeTest.gd` 实际测试；该测试在当前 Godot 4.7 控制台环境中已多次触发“内存不能为 read”崩溃风险，本轮只执行语法检查和稳定审计测试。
---

## ver0.42.2 - 控制台用卡自动范围清洗

- 创建 `.backup/backup_ver0_42_2_console_usecard_radius_sanitizer_20260705`，备份本轮改动前的 `Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 新增 `Main._get_console_card_auto_use_radius()`，控制台 `usecard` 自动落点现在会先归一化卡牌，再使用现有卡牌范围 helper 获取安全半径。
- `usecard` 命令不再直接 `float(_card_hand[use_index].get("radius", 92.0))`，异常手牌半径不会绕过卡牌数值清洗。
- 扩展 `LogicSmokeTest.gd`，覆盖控制台自动用卡半径 helper 的有效值、坏类型 fallback，以及坏半径导弹卡通过 `usecard` 正常自动释放。
- 扩展 `CodeStyleAuditTest.gd`，禁止控制台 `usecard` 回退到直接读取并转换手牌半径。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“调试用卡更稳了”的修复公告，并设为最新公告 `ver0.42.2`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
- 未运行完整 `LogicSmokeTest.gd` 实际测试；该测试在当前 Godot 4.7 控制台环境中已多次触发“内存不能为 read”崩溃风险，本轮只执行语法检查和稳定审计测试。
---

## ver0.42.3 - 炮塔解锁等级清洗

- 创建 `.backup/backup_ver0_42_3_tower_unlock_sanitizer_20260705`，备份本轮改动前的 `Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 新增 `Main._get_tower_unlock_level()`，炮塔解锁等级会被限制到现有关卡范围内，非法、负数和坏类型会回退安全值。
- `is_tower_type_unlocked()` 改为使用清洗后的解锁等级，不再直接 `int(config.get("unlock_level", 0))`。
- 建塔锁定提示改为使用清洗后的解锁等级，异常配置不会让提示显示奇怪的关卡数字。
- 扩展 `LogicSmokeTest.gd`，覆盖炮塔解锁等级 helper 的有效值、负数、坏类型和过大值。
- 扩展 `CodeStyleAuditTest.gd`，禁止建塔解锁判断和锁定提示回退到直接读取 `unlock_level`。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“建塔解锁提示更稳了”的修复公告，并设为最新公告 `ver0.42.3`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
- 未运行完整 `LogicSmokeTest.gd` 实际测试；该测试在当前 Godot 4.7 控制台环境中已多次触发“内存不能为 read”崩溃风险，本轮只执行语法检查和稳定审计测试。
---

## ver0.42.4 - 选关波次数显示清洗

- 创建 `.backup/backup_ver0_42_4_gameui_level_wave_sanitizer_20260705`，备份本轮改动前的 `GameUI.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和 `CHANGELOG.md`。
- 新增 `GameUI.LEVEL_CONFIG_DEFAULT_WAVES` 和 `LEVEL_CONFIG_MAX_WAVES`，为选关卡片波次数显示提供统一安全边界。
- 新增 `GameUI._get_level_config_wave_count()`，只接受合理的数字波次数；缺失、负数、坏类型和过大值会回退默认显示。
- `_format_level_select_button_text()` 改为使用清洗后的波次数，不再直接 `int(config.get("waves", 0))`。
- 扩展 `LogicSmokeTest.gd`，覆盖选关波次数 helper 的有效值、缺失值、负数、坏类型和过大值。
- 扩展 `CodeStyleAuditTest.gd`，禁止选关卡片波次数回退到直接读取并转换配置字段。
- 更新玩家公告 `UpdateAnnouncements.gd`，新增“选关卡片显示更稳了”的修复公告，并设为最新公告 `ver0.42.4`。

验证：
- Godot 4.7 `GameUI.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本实际运行通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
- 未运行完整 `LogicSmokeTest.gd` 实际测试；该测试在当前 Godot 4.7 控制台环境中已多次触发“内存不能为 read”崩溃风险，本轮只执行语法检查和稳定审计测试。
---

## ver0.42.5 - 错误手感改动回滚

- 回滚误混入当前 goal 的炮塔手感与数值改动。
- 从 `.backup/backup_ver0_43_0_heavy_projectile_feel_20260705` 恢复 `Tower.gd`、`Projectile.gd`、`Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和本日志。
- 将错误的半成品状态另存到 `.backup/backup_revert_bad_ver0_43_0_partial_20260705`，方便后续追溯。
- 恢复后的关键值包括：重炮基础溅射 `680 / 1.68`，重炮二三级溅射 `940 / 1240`，普通弹丸距离倍率 `30.00`，狙击弹离屏保留距离 `5800`，最新玩家公告仍为 `ver0.42.4`。

验证：
- Godot 4.7 `Tower.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Projectile.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
- 未运行完整 `LogicSmokeTest.gd` 实际测试；该测试在当前 Godot 4.7 控制台环境中已多次触发“内存不能为 read”崩溃风险。

---

## ver0.42.6 - 炮塔战斗表现回退到 1:01 备份

- 创建 `.backup/backup_before_revert_tower_combat_to_0101_20260705`，备份回退前的 `Tower.gd`、`Projectile.gd`、`Main.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和本日志。
- 按用户指定的 `.backup/backup_tower_balance_recoil_range_20260705_0105` 恢复炮塔战斗表现相关代码。
- `Tower.gd` 回退到该备份版本：炮塔后座、开火特效、炮塔绘制、升级数值和重炮溅射逻辑恢复到 1:01 备份形态。
- `Projectile.gd` 回退到该备份版本：弹丸视觉、命中特效、狙击弹离屏清理距离、穿透衰减和非狙击穿透弹兜底距离恢复到 1:01 备份形态。
- `Main.gd` 仅回退炮塔基础配置中的重炮基础溅射：`splash_radius` 恢复为 `42.0`，`splash_ratio` 恢复为 `0.40`；未整块回退主流程、UI、关卡、存档和卡牌系统。
- `LogicSmokeTest.gd` 同步恢复到该备份版本，避免继续引用后续炮塔常量。
- `UpdateAnnouncements.gd` 新增“炮塔手感回到旧版”的玩家公告，并设为最新公告 `ver0.42.6`。

验证：
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Tower.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Projectile.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。
- `LogicSmokeTest.gd --check-only` 在当前 Godot 4.7 控制台环境中触发 signal 11 崩溃，未继续重复运行；这与此前记录的“内存不能为 read”风险一致。
- 未运行 `CodeStyleAuditTest.gd` 实际测试；当前炮塔代码按要求回退到旧备份形态，后续审计规则会把部分旧写法判为回退。

---

## ver0.42.7 - 炮塔战斗表现回退到 ver0.26 生效后

- 创建 `.backup/backup_before_revert_tower_combat_to_ver0_26_after_20260705`，备份本轮回退前的 `Tower.gd`、`Projectile.gd`、`Main.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd`、`CodeStyleAuditTest.gd` 和本日志。
- 按“1:01 后一个版本”的判断恢复炮塔表现：`Tower.gd` 和 `Projectile.gd` 使用 `.backup/backup_tower_balance_recoil_20260705_0300` 中的版本。
- `Main.gd` 仅同步炮塔基础配置中的重炮基础溅射到 ver0.26 生效后的数值：`splash_radius` 为 `56.0`，`splash_ratio` 为 `0.52`。
- 重炮二级溅射恢复为 `74.0 / 0.62`，三级溅射恢复为 `96.0 / 0.78`。
- 普通弹丸有效距离恢复为炮塔当前有效射程的 `1.35` 倍。
- `LogicSmokeTest.gd` 同步使用 `.backup/backup_effects_card_popup_20260705_0130` 中的测试脚本，保持与该炮塔版本一致。
- `UpdateAnnouncements.gd` 新增“炮塔回到旧版强化后”的玩家公告，并设为最新公告 `ver0.42.7`。

验证：
- Godot 4.7 `Tower.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Projectile.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `Main.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `CodeStyleAuditTest.gd` 脚本 `--check-only` 通过。
- Godot 4.7 `--headless --path . --quit` 项目解析通过。

---

## 当前验证状态

截至当前版本，最近几轮稳定执行并通过以下验证：

- Godot 4.7 控制台脚本检查。
- 代码逻辑英文审计测试。
- 主场景短启动测试。
- 性能基准测试。

说明：

- 完整 `LogicSmokeTest.gd` 实际运行在早期阶段曾用于覆盖核心玩法流程；但当前 Godot 4.7 控制台环境已多次出现“内存不能为 read”的崩溃风险，最近更新改为执行 `--check-only` 与稳定的 `CodeStyleAuditTest.gd` 实际运行。

最近一次性能基准：

- 场景：第 10 关。
- 压力：48 座塔、180 个敌人。
- 采样：240 帧。
- 平均帧时间：约 6.94 ms。
- 估算帧率：约 144 FPS。
- 结果：PASS。
---

## ver0.42.8 - 文件命名英文化整理

- 将仓库内追踪的更新日志文件重命名为 `CHANGELOG.md`。
- 将本地忽略的继续上下文文件重命名为 `NEXT_SESSION_CONTEXT.md`。
- 将本地忽略的素材目录重命名为 `raw_materials/`，并将其子目录统一为英文路径。
- 将本地忽略的素材压缩包重命名为 `raw_materials.zip`。
- 更新 `.gitignore`，继续排除本地素材、备份、上下文文件、Godot 可执行文件和压缩包。
- 更新 `README.md` 中的项目结构说明。
- 清理更新日志里的旧中文路径引用，让仓库可见文件名保持英文。

验证：
- 已确认 Git 追踪文件中没有非 ASCII 路径。
- 已确认顶层本地中文文件名已改为英文名称。

---

## ver0.42.9 - 弹窗回弹效果整理

- 将 UI 弹窗粒子替换为缩放淡入的回弹动画。
- 更新公告、公告历史、确认框、暂停菜单、关卡开场、关卡结算、控制台面板和待处理卡牌弹窗都改为更干净的 `TRANS_BACK` 回弹。
- 旧的 GameUI 弹窗粒子辅助函数只保留配置缓存，不再为弹窗创建粒子节点。
- 战斗和世界粒子效果保持不变。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本语法检查通过。
- Godot 4.7 项目无窗口解析通过。

---

## ver0.43.0 - 作战图鉴功能

- 主页新增“图鉴”入口。
- 新增作战图鉴面板，横向展示全部炮塔和怪物。
- 图鉴条目可点击查看详细属性、定位/功能说明和外形预览。
- `Main.gd` 通过安全复制的配置 getter 将炮塔、关卡和怪物配置传给 UI。
- 图鉴面板沿用当前干净的滑入和回弹 UI 风格，不使用弹窗粒子。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本语法检查通过。
- Godot 4.7 项目无窗口解析通过。

---

## ver0.43.1 - 图鉴外观与中文文案修复

- 移除图鉴中手写的临时炮塔/怪物图案，改用 `Tower.gd` 和 `Enemy.gd` 的实际外观逻辑，确保图鉴外观与游戏内对象一致。
- 修复图鉴详情中文说明被破坏成问号的问题。
- 增幅塔预览改用真实炮塔增幅层显示路径，不再单独画假图标。

验证：
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `UpdateAnnouncements.gd` 脚本语法检查通过。
- Godot 4.7 项目无窗口解析通过。

---

## ver0.43.2 - 图鉴怪物纯展示模式

- 为 `Enemy.gd` 增加图鉴专用纯展示模式。
- 图鉴怪物预览继续复用怪物自身外观和动画资源，但不会加入战斗分组、移动、攻击或触发玩法逻辑。
- 图鉴怪物预览不再绘制血条、减速圈、吸引/攻击等战斗状态表现。
- 图鉴炮塔和怪物预览尺寸改为按预览框自动缩放。

验证：
- Godot 4.7 `Enemy.gd` 脚本语法检查通过。
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `Main.gd` 脚本语法检查通过。

---

## ver0.43.3 - 冒烟测试与日志修正

- 将本轮更新日志继续保持中文记录，避免混入英文版本说明。
- 修正图鉴预览里的增幅塔判断：由外层统一使用 `_is_support_tower_config` 后传入预览控件，避免内部类重新写一套配置判断。
- 调整 `LogicSmokeTest.gd`：
  - 启动、通过、失败和超时输出改为中文。
  - 增加 150 秒内部超时和关卡开始存档恢复，避免冒烟测试静默挂死后污染本地存档。
  - 将弹窗相关断言同步为“回弹动画，不生成 UI 粒子”。
  - 对会被卡牌/陷阱击杀的测试怪物增加有效性判断，避免敌人已死亡后访问 `health` / `speed_multiplier` 直接中断测试。
  - 对失败结算前的拖拽卡牌准备增加保护，避免前置断言失败后数组越界中断测试。

验证：
- Godot 4.7 `Enemy.gd` 脚本语法检查通过。
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- 已实际运行 `LogicSmokeTest.gd`，结果为失败（退出码 1），不是跳过；当前仍有历史/现存失败项，主要集中在奖励卡牌回合发放、敌人类型规范化/缓存复用、更新公告文案和失败结算准备流程。
- 已实际运行 `CodeStyleAuditTest.gd`，结果为失败；当前仍有 `Projectile.gd` 目标校验和 `Tower.gd` 配置清洗/目标校验相关审计项未处理，本轮未顺手改战斗逻辑。

---

## ver0.43.4 - 64px 精细炮塔模型

- 将基础塔、速射塔、散弹塔、重炮塔、狙击塔和增幅塔的程序绘制升级为 64px 级别的精细像素模型。
- 炮塔仍由 `Tower.gd` 统一绘制，游戏内建塔和图鉴预览继续使用同一套真实外观，不再额外做一套假图标。
- 新增 64px 通用底座、重型底座、菱形底座、方向炮管、炮口和铆钉细节绘制 helper。
- 保留原有炮塔数值、射程、射速、索敌、弹道和升级逻辑，仅调整视觉表现。
- 改动前已建立 Git 备份点 `backup/pre-64px-tower-model-20260705`。

验证：
- Godot 4.7 `Tower.gd` 脚本语法检查通过。
- Godot 4.7 `GameUI.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- 已实际运行 `LogicSmokeTest.gd`，结果为失败（退出码 1），不是跳过；当前仍有历史/现存失败项，主要集中在关卡敌人类型规范化、更新公告文案、奖励卡牌发放/使用、敌人缓存复用和失败结算准备流程。


---

## ver0.43.5 - 冒烟测试退出稳定性修正

- 调整 `LogicSmokeTest.gd` 的收尾流程：失败或通过后不再同一帧直接退出，而是先恢复关卡开始存档，再延后两帧等待 Godot 清理 `queue_free` 队列，最后返回退出码。
- 该改动用于降低 Windows 下 Godot 4.7 `--script` 冒烟测试结束时出现原生访问冲突的概率，避免把脚本断言失败误表现为 Godot 崩溃。
- 不修改任何玩法、数值、UI 或战斗逻辑。

验证：
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。
- 已使用 `--display-driver headless --rendering-driver dummy --audio-driver Dummy` 实际运行 `LogicSmokeTest.gd`，进程正常返回退出码 1，没有在本机复现 native crash；当前失败仍是现有断言项。

---

## ver0.43.6 - 64px炮塔网格适配

- 将主逻辑、建造逻辑和地图渲染的单格尺寸统一从32px调整为64px。
- 建塔坐标换算、占用检测、道路格判定和预览框继续使用同一套网格常量，确保64px炮塔完整落在单个建造格内。
- 地图像素尺寸随关卡格数自动扩大，避免只放大炮塔外观却仍使用32px小格导致溢出。
- 为冒烟测试补充64px网格断言，防止后续再把建造格退回32px。

验证：
- Godot 4.7 `Main.gd` 脚本语法检查通过。
- Godot 4.7 `BuildManager.gd` 脚本语法检查通过。
- Godot 4.7 `MapRenderer.gd` 脚本语法检查通过。
- Godot 4.7 `LogicSmokeTest.gd` 脚本语法检查通过。`LogicSmokeTest.gd` 实际运行时新增的64px网格断言全部通过，进程正常返回退出码1；剩余失败仍为现有的更新公告、奖励卡牌、敌人缓存/规范化、失败结算准备等断言。
---

## ver0.43.7 - 冒烟测试断言与缓存修复

- 更新玩家公告首条，确保首次弹窗说明当前可见的64px格子适配改动。
- 修复奖励卡牌名称兜底逻辑：只有明确卡牌 ID 时才解析默认定义，空卡牌继续显示“卡牌”。
- 修复关卡敌人类型列表规范化过度兜底的问题，保留配置中的干净字符串 ID。
- 修复波次敌人数值缓存 getter 每次返回拷贝的问题，让重复读取复用缓存字典。
- 修复刷怪路线和敌人路径重复复制的问题，让敌人复用关卡缓存路线数组。
- 修复狙击弹在地图内但离开当前镜头时被误删的问题。
- 调整冒烟测试准备流程，避免手牌测试卡和关卡开始存档污染后续断言。

验证：
- Godot 4.7 `Main.gd`、`WaveManager.gd`、`Enemy.gd`、`Projectile.gd`、`UpdateAnnouncements.gd`、`LogicSmokeTest.gd` 脚本语法检查通过。
- 已实际运行 `LogicSmokeTest.gd`，结果通过（退出码0）。
- 已实际运行 `PerformanceBenchmark.gd`，结果通过（退出码0）：avg 6.897ms，p95 6.931ms，max 7.411ms，估算 145.0 FPS。
