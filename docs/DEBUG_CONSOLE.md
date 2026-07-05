# Debug Console

运行游戏后，可以用调试控制台快速测试核心功能、胜利动画和失败动画。

## 打开方式

- `F1`：打开或关闭控制台。
- 反引号 `` ` ``：打开或关闭控制台。
- 控制台打开时，地图建造和选择输入会被拦截。
- 控制台打开时按 `ESC` 可以关闭控制台。

## 命令

```text
help
```

显示命令列表。

```text
start
```

跳过开始界面，进入游戏。

```text
wave
```

开始下一波敌人。如果还没进入游戏，会先自动开始游戏。

```text
gold [amount]
```

增加金币。默认增加 100。

示例：

```text
gold 500
```

```text
setgold <amount>
```

直接设置金币数量。

```text
damage [amount]
```

对主基地造成伤害。默认伤害为 1。基地血量归零会触发失败动画。

```text
heal [amount]
```

治疗主基地。默认治疗 5。

```text
basehp <amount>
```

直接设置主基地当前血量。设置为 0 会触发失败动画。

```text
maxhp <amount>
```

设置主基地最大血量。

```text
spawn [count] [type] [route]
```

可用类型：

- `grunt`
- `runner`
- `brute`
- `shield`

示例：

```text
spawn 5 runner
```

表示生成 5 个快速敌人。敌人的血量、速度和奖励会按当前关卡波次和敌人类型自动计算。

```text
spawn 3 shield 2
```

表示从第 2 条路线生成 3 个护盾敌人。`route` 从 1 开始计数；不填写时会在当前关卡的多条路线之间自动轮换。

```text
level <number>
```

直接切换到指定关卡。

```text
next
```

直接进入下一关。主要用于测试关卡切换。

```text
clear
```

清空当前敌人和子弹。

```text
victory
```

强制触发胜利状态和胜利动画。

```text
defeat
```

强制触发失败状态和失败动画。

```text
restart
```

重新加载当前场景。

```text
status
```

输出当前金币、基地血量、波次、敌人数量和游戏结束状态。
