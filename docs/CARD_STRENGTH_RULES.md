# 卡牌强度与倍率规则说明

本文档说明当前奖励卡牌的颜色强度、倍率抽取和数值缩放规则。对应实现主要在 `scripts/Main.gd` 的 `_make_reward_card()`、`_roll_reward_card_strength()`、`_normalize_reward_card()` 和 `_apply_reward_card_rarity_power()`。

## 核心规则

奖励卡池保持为 20 种基础卡牌。抽到卡牌时，不会把同一种卡展开成多个卡牌类型。

卡牌分为两类：

- 随机强度卡：卡牌带有倍率、概率、收益系数、减速倍率、牵引强度等字段时，抽到后会随机决定白色、蓝色、紫色、金色、红色强度档。
- 固定强度卡：卡牌没有上述可浮动字段时，不随机强度，保留卡牌定义里写死的颜色档。

注意：固定强度卡虽然不随机颜色，但仍会按自身颜色档进行一次数值缩放。例如“轨道导弹”固定为紫色，所以不会抽成白色或金色，但紫色本身仍会提高伤害和范围。

## 颜色档倍率

| 颜色 | rarity | 强度倍率 |
| --- | --- | ---: |
| 白色 | `white` | 1.00 |
| 蓝色 | `blue` | 1.15 |
| 紫色 | `purple` | 1.35 |
| 金色 | `gold` | 1.60 |
| 红色 | `red` | 1.90 |

UI 会用该颜色显示卡牌边框、标题、图标、类型标签和详情标题。

## 随机强度概率

只有随机强度卡会走这个概率。基础概率会随当前关卡和波次略微偏向高等级。

当前加成公式：

```gdscript
level_bonus = clamp(current_level_index * 0.008 + max(wave - 1, 0) * 0.004, 0.0, 0.12)
```

抽取阈值：

| 条件 | 结果 |
| --- | --- |
| `roll < 0.42 - level_bonus` | 白色 |
| `roll < 0.72 - level_bonus * 0.45` | 蓝色 |
| `roll < 0.91 - level_bonus * 0.2` | 紫色 |
| `roll < 0.985` | 金色 |
| 其他 | 红色 |

第 1 关第 1 波时，基础概率约为：

| 颜色 | 概率 |
| --- | ---: |
| 白色 | 42.0% |
| 蓝色 | 30.0% |
| 紫色 | 19.0% |
| 金色 | 7.5% |
| 红色 | 1.5% |

越靠后的关卡和波次，白色概率会下降，蓝色和紫色的区间会略微变化，高档卡更容易出现。红色仍然保持稀有。

## 字段缩放规则

卡牌进入手牌或使用前会经过 `_normalize_reward_card()`。如果还没有缩放过，会根据 `rarity` 调用 `_apply_reward_card_rarity_power()`。

整数数值直接乘以强度倍率，并四舍五入，最低为 1：

```text
damage, amount, heal, panic_heal, max_hp, jackpot_gold, fallback_gold, bonus_gold, charges
```

持续时间温和成长：

```text
duration *= 1.0 + (power - 1.0) * 0.45
```

范围温和成长：

```text
radius *= 1.0 + (power - 1.0) * 0.25
```

增益倍率只放大“超过 1 的部分”：

```text
multiplier = 1.0 + (base_multiplier - 1.0) * power
damage_multiplier = 1.0 + (base_multiplier - 1.0) * power
fire_rate_multiplier = 1.0 + (base_multiplier - 1.0) * power
```

概率和收益比例直接乘以强度倍率，并限制在 0 到 0.95：

```text
bonus_ratio, jackpot_chance
```

牵引强度直接乘以强度倍率：

```text
strength
```

减速倍率越低越强，按以下方式强化，并限制在 0.12 到 1.0：

```text
slow_multiplier = 1.0 - (1.0 - base_multiplier) * power
```

## 当前 20 张卡牌强度分类

| 卡牌 | 类型 | 当前规则 | 基础颜色 | 关键字段 |
| --- | --- | --- | --- | --- |
| 超频核心 | 增益 | 随机强度 | 蓝色 | `multiplier`, `duration` |
| 战地维修 | 治疗 | 固定强度 | 白色 | `amount` |
| 轨道导弹 | 攻击 | 固定强度 | 紫色 | `damage`, `radius` |
| 紧急军费 | 资源 | 固定强度 | 白色 | `amount` |
| 信号中继 | 增益 | 随机强度 | 蓝色 | `multiplier`, `duration` |
| 急速协议 | 增益 | 随机强度 | 紫色 | `multiplier`, `duration` |
| 冷冻地雷 | 控制 | 随机强度 | 蓝色 | `damage`, `radius`, `slow_multiplier`, `duration` |
| 基地加固 | 防御 | 固定强度 | 紫色 | `max_hp`, `heal` |
| 全屏火焰 | 攻击 | 固定强度 | 金色 | `damage`, `radius` |
| 冻结全屏 | 控制 | 随机强度 | 金色 | `damage`, `radius`, `slow_multiplier`, `duration` |
| 不稳定补给 | 概率 | 随机强度 | 红色 | `jackpot_chance`, `jackpot_gold`, `fallback_gold` |
| 诱饵信标 | 操控 | 随机强度 | 蓝色 | `radius`, `duration`, `strength` |
| 尖刺路障 | 陷阱 | 随机强度 | 白色 | `damage`, `radius`, `charges`, `slow_multiplier`, `duration` |
| 战利品磁铁 | 资源 | 随机强度 | 蓝色 | `bonus_ratio`, `duration` |
| 时间裂隙 | 风险 | 随机强度 | 紫色 | `radius`, `slow_multiplier`, `haste_multiplier`, `duration` |
| 塔位调度 | 战术 | 随机强度 | 蓝色 | `radius`, `damage_multiplier`, `fire_rate_multiplier`, `duration` |
| 透支超频 | 风险 | 随机强度 | 红色 | `damage_multiplier`, `fire_rate_multiplier`, `duration` |
| 紧急按钮 | 救急 | 随机强度 | 金色 | `heal`, `panic_heal`, `slow_multiplier`, `duration` |
| 悬赏标记 | 资源 | 固定强度 | 紫色 | `radius`, `bonus_gold` |
| 战术改签 | 手牌 | 固定强度 | 金色 | `sell_value` |

## 设计意图

随机强度卡用于制造“同一种卡有强弱版本”的抽卡体验，适合增益、控制、概率和收益类效果。

固定强度卡用于保持效果识别清晰，避免直接伤害、治疗、一次性资源、换牌等卡牌因为倍率浮动导致战斗节奏过度不可控。

如果后续新增卡牌，建议先判断它是否包含可浮动的核心系数：

- 有倍率、概率、收益比例、减速倍率、牵引强度：通常加入随机强度。
- 只有单次固定效果：通常保留固定强度。
