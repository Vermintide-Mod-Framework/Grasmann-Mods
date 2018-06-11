local mod = get_mod("Healthbars")

local mod_data = {}
mod_data.name = "Healthbars" -- Readable mod name
mod_data.description = mod:localize("mod_description") -- Readable mod description
mod_data.is_togglable = true -- If the mod can be enabled/disabled
mod_data.is_mutator = false -- If the mod is mutator
mod_data.options_widgets = {
	{
		["setting_name"] = "position",
		["widget_type"] = "dropdown",
		["text"] = "Position",
		["tooltip"] = "Switch position of the enemy health bars.",
		["options"] = {
			{text = "Bottom", value = 1},
			{text = "Top", value = 2}
		},
		["default_value"] = 2,
	},
	{
		["setting_name"] = "mode",
		["widget_type"] = "dropdown",
		["text"] = "Mode",
		["tooltip"] = "Switch mode for the enemy health bars.\n\n"..
			"-- All --\n"..
			"Create health bars for all wounded enemies.\n\n"..
			"-- SPECIALS ONLY --\n"..
			"Create health bars for specials only.\n\n"..
			"-- BOSSES ONLY --\n"..
			"Create health bars only for bosses.\n\n"..
			"-- CUSTOM --\n"..
			"Choose which enemies should have a health bar.",
		["options"] = {
			{--[[1]] text = "All", value = 2},
			{--[[2]] text = "Specials", value = 3}, 
			{--[[3]] text = "Bosses", value = 4},
			{--[[4]] text = "Custom", value = 5},
		},
		["default_value"] = 2,
		["sub_widgets"] = {
			{
				["show_widget_condition"] = {1, 2, 3, 4},
				["setting_name"] = "toggle_mode",
				["widget_type"] = "keybind",
				["text"] = "Switch",
				["tooltip"] = "Switch healthbar mode.",
				["default_value"] = {},
				["action"] = "toggle_mode"
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "slave_rat",
				["widget_type"] = "checkbox",
				["text"] = "Skaven Slave Rat",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "clan_rat",
				["widget_type"] = "checkbox",
				["text"] = "Skaven Clan Rat",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "stormvermin",
				["widget_type"] = "checkbox",
				["text"] = "Skaven Stormvermin",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "runner",
				["widget_type"] = "checkbox",
				["text"] = "Skaven Gutter Runner",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "gunner",
				["widget_type"] = "checkbox",
				["text"] = "Skaven Ratling Gunner",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "packmaster",
				["widget_type"] = "checkbox",
				["text"] = "Skaven Packmaster",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "gas_rat",
				["widget_type"] = "checkbox",
				["text"] = "Skaven Globadier",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "sack_rat",
				["widget_type"] = "checkbox",
				["text"] = "Skaven Sack Rat",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "ogre",
				["widget_type"] = "checkbox",
				["text"] = "Skaven Rat Ogre",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "champion",
				["widget_type"] = "checkbox",
				["text"] = "Skaven Stormvermin Champion",
				["default_value"] = false,
			},
			-- VT2
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "plague_monk",
				["widget_type"] = "checkbox",
				["text"] = "Skaven Plague Monk",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "warpfire_thrower",
				["widget_type"] = "checkbox",
				["text"] = "Skaven Warpfire Thrower",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "stormfiend",
				["widget_type"] = "checkbox",
				["text"] = "Skaven Stormfiend",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "stormfiend_warlord",
				["widget_type"] = "checkbox",
				["text"] = "Skaven Stormvermin Warlord",
				["default_value"] = false,
			},
			-- Chaos
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "chaos_warrior",
				["widget_type"] = "checkbox",
				["text"] = "Chaos Warrior",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "chaos_exalted_champion",
				["widget_type"] = "checkbox",
				["text"] = "Chaos Exalted Champion",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "chaos_marauder",
				["widget_type"] = "checkbox",
				["text"] = "Chaos Marauder",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "chaos_berzerker",
				["widget_type"] = "checkbox",
				["text"] = "Chaos Berzerker",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "chaos_raider",
				["widget_type"] = "checkbox",
				["text"] = "Chaos Raider",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "chaos_zombie",
				["widget_type"] = "checkbox",
				["text"] = "Chaos Zombie",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "chaos_fanatic",
				["widget_type"] = "checkbox",
				["text"] = "Chaos Fanatic",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "chaos_exalted_sorcerer",
				["widget_type"] = "checkbox",
				["text"] = "Chaos Exalted Sorcerer",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "chaos_vortex_sorcerer",
				["widget_type"] = "checkbox",
				["text"] = "Chaos Vortex Sorcerer",
				["default_value"] = false,
			},
			-- {
				-- ["show_widget_condition"] = {4},
				-- ["setting_name"] = "vortex",
				-- ["widget_type"] = "checkbox",
				-- ["text"] = "Chaos Vortex",
				-- ["default_value"] = false,
			-- },
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "chaos_plague_sorcerer",
				["widget_type"] = "checkbox",
				["text"] = "Chaos Plague Sorcerer",
				["default_value"] = false,
			},
			-- {
				-- ["show_widget_condition"] = {4},
				-- ["setting_name"] = "chaos_plague_wave_spawner",
				-- ["widget_type"] = "checkbox",
				-- ["text"] = "Chaos Plague Wave Spawner",
				-- ["default_value"] = false,
			-- },
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "chaos_corruptor_sorcerer",
				["widget_type"] = "checkbox",
				["text"] = "Chaos Corruptor Sorcerer",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "chaos_spawn",
				["widget_type"] = "checkbox",
				["text"] = "Chaos Spawn",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "chaos_spawn_exalted_champion_norsca",
				["widget_type"] = "checkbox",
				["text"] = "Chaos Spawn Exalted Champion",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "chaos_troll",
				["widget_type"] = "checkbox",
				["text"] = "Chaos Troll",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "chaos_tentacle_sorcerer",
				["widget_type"] = "checkbox",
				["text"] = "Chaos Tentacle Sorcerer",
				["default_value"] = false,
			},
			-- {
				-- ["show_widget_condition"] = {4},
				-- ["setting_name"] = "chaos_tentacle",
				-- ["widget_type"] = "checkbox",
				-- ["text"] = "Chaos Tentacle",
				-- ["default_value"] = false,
			-- },
		},
	},
	{
		["setting_name"] = "toggle_mod",
		["widget_type"] = "keybind",
		["text"] = "Toggle",
		["tooltip"] = "Toggle healthbars on / off.",
		["default_value"] = {},
		["action"] = "toggle_mod_state"
	},
}

return mod_data