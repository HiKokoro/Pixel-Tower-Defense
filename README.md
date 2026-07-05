# Pixel Tower Defense

A Godot 4.7 2D pixel-style tower defense prototype.

## Overview

Pixel Tower Defense is a curriculum-design tower defense project built with GDScript. The game focuses on a complete playable prototype: build towers, defend the base, survive enemy waves, unlock later levels, and use reward cards to react to battlefield pressure.

## Features

- 2D tower defense gameplay built in Godot.
- Dynamic maps and enemy paths generated from script-defined level data.
- Multiple tower types:
  - Basic Tower
  - Rapid Tower
  - Shotgun Tower
  - Cannon Tower
  - Sniper Tower
  - Amplifier Tower
- Multiple enemy types:
  - Grunt
  - Runner
  - Brute
  - Shield
  - Taunt Fortress
  - Elite Bomber
- Wave-based progression with multi-route levels.
- Reward-card system with drag-and-drop card usage.
- Start screen, level selection, pause menu, update announcement panel, and debug console.
- Script-driven visuals using Godot drawing APIs and lightweight pixel-art assets.

## Requirements

- Godot 4.7 or newer is recommended.
- The project currently targets the compatibility renderer.

## How to Run

1. Open Godot.
2. Import or open this project folder.
3. Run the main scene:

```text
scenes/Main.tscn
```

Or run from command line with a local Godot executable:

```powershell
Godot_v4.7-stable_win64_console.exe --path .
```

## Useful Development Commands

Syntax-check a script:

```powershell
Godot_v4.7-stable_win64_console.exe --headless --path . --check-only --script res://scripts/Main.gd
```

Check project loading:

```powershell
Godot_v4.7-stable_win64_console.exe --headless --path . --quit
```

Run the code-style audit:

```powershell
Godot_v4.7-stable_win64_console.exe --headless --path . --script res://tests/CodeStyleAuditTest.gd
```

> Note: the full `LogicSmokeTest.gd` flow has previously been unstable in the current Godot 4.7 console environment, so prefer `--check-only` unless a full run is necessary.

## Repository Notes

The repository intentionally excludes local-only files such as:

- Godot editor cache: `.godot/`
- Local backups: `.backup/`
- Local engine binaries and zip archives
- Agent/editor state directories
- Temporary continuation notes
- Unused raw material folders

Runtime-critical assets that are referenced by the project, such as `enemy1/`, are kept in the repository.

## Project Structure

```text
project.godot
scenes/
  Main.tscn
scripts/
  Main.gd
  GameUI.gd
  BuildManager.gd
  WaveManager.gd
  Tower.gd
  Enemy.gd
  Projectile.gd
  ...
tests/
  CodeStyleAuditTest.gd
  LogicSmokeTest.gd
  PerformanceBenchmark.gd
docs/
  PROJECT_DEVELOPMENT_SPEC.md
  ART_DRAWING_SPEC.md
  CARD_STRENGTH_RULES.md
  DEBUG_CONSOLE.md
enemy1/
  walk1.png
  walk2.png
  walk3.png
  walk4.png
```

## License

No explicit license has been added yet.
---

# Pixel Tower Defense（像素塔防）

一个使用 Godot 4.7 制作的 2D 像素风塔防游戏原型。

## 项目简介

Pixel Tower Defense 是一个课程设计用塔防项目，主要使用 GDScript 开发。项目目标是实现一个可以直接游玩的完整原型：玩家可以建造防御塔、守护基地、抵御敌人波次、解锁后续关卡，并使用奖励卡牌应对战场压力。

## 功能特色

- 基于 Godot 的 2D 塔防玩法。
- 地图和敌人路径由脚本中的关卡数据动态生成。
- 多种防御塔：
  - 基础塔
  - 速射塔
  - 散弹塔
  - 重炮塔
  - 狙击塔
  - 增幅塔
- 多种敌人类型：
  - 步兵
  - 疾行者
  - 重甲兵
  - 护盾兵
  - 嘲讽堡垒
  - 精英爆破兵
- 波次推进与多路线关卡。
- 奖励卡牌系统，支持拖拽释放卡牌。
- 开始界面、选关界面、暂停菜单、更新公告面板和调试控制台。
- 主要视觉效果由 Godot 绘制 API 和轻量像素素材实现。

## 运行环境

- 推荐使用 Godot 4.7 或更新版本。
- 当前项目使用兼容渲染器。

## 如何运行

1. 打开 Godot。
2. 导入或打开本项目文件夹。
3. 运行主场景：

```text
scenes/Main.tscn
```

也可以在命令行中使用本地 Godot 可执行文件运行：

```powershell
Godot_v4.7-stable_win64_console.exe --path .
```

## 常用开发命令

检查单个脚本语法：

```powershell
Godot_v4.7-stable_win64_console.exe --headless --path . --check-only --script res://scripts/Main.gd
```

检查项目是否能正常加载：

```powershell
Godot_v4.7-stable_win64_console.exe --headless --path . --quit
```

运行代码风格审计：

```powershell
Godot_v4.7-stable_win64_console.exe --headless --path . --script res://tests/CodeStyleAuditTest.gd
```

> 注意：完整运行 `LogicSmokeTest.gd` 在当前 Godot 4.7 控制台环境中曾出现不稳定情况，因此除非必要，建议优先使用 `--check-only`。

## 仓库说明

仓库会刻意排除本地临时或非必要文件，例如：

- Godot 编辑器缓存：`.godot/`
- 本地备份：`.backup/`
- 本地 Godot 可执行文件和 zip 压缩包
- Agent / 编辑器状态目录
- 临时接手上下文文件
- 未使用的原始素材目录

项目运行实际引用的必要资源，例如 `enemy1/` 中的敌人行走图片，会保留在仓库中。

## 项目结构

```text
project.godot
scenes/
  Main.tscn
scripts/
  Main.gd
  GameUI.gd
  BuildManager.gd
  WaveManager.gd
  Tower.gd
  Enemy.gd
  Projectile.gd
  ...
tests/
  CodeStyleAuditTest.gd
  LogicSmokeTest.gd
  PerformanceBenchmark.gd
docs/
  PROJECT_DEVELOPMENT_SPEC.md
  ART_DRAWING_SPEC.md
  CARD_STRENGTH_RULES.md
  DEBUG_CONSOLE.md
enemy1/
  walk1.png
  walk2.png
  walk3.png
  walk4.png
```

## 许可证

暂未添加明确许可证。
