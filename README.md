# NPC Robbery System

Immersive NPC robbery system with eye contact detection and randomized outcomes

## Features

- Eye contact detection for initiating robberies
- Randomized success/failure outcomes
- Configurable cooldown periods
- Performance-optimized NPC scanning

## Requirements

- FiveM server with ESX framework
- MySQL database

## Installation

1. Download the script files
2. Place them in your FiveM server's resources folder
3. Add `start npc_robbery` to your server.cfg
4. Import the database.sql file into your MySQL database

## Usage

The system will automatically detect when players make eye contact with configured NPC models. After maintaining eye contact for the configured time, a robbery attempt will be made with randomized success.

## Configuration

Edit the config.lua file to adjust:

- Robbery cooldown time
- Reward amount range
- Eye contact duration
- NPC models to target

## Generated with EnderDevelopment

This plugin was generated in minutes with [EnderDevelopment](https://enderdevelopment.com) — the AI platform that turns your ideas into working Minecraft plugins, Discord bots and FiveM scripts.

**Want your own?** [Generate this project on EnderDevelopment](https://dash.enderdevelopment.com?utm_source=github&utm_medium=readme&utm_campaign=npc-robbery-system&utm_content=bottom) — describe it in one sentence and get the full source code.