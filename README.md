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