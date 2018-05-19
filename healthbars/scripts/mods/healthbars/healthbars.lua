local mod = get_mod("Healthbars")
--[[ 
	Healthbars
		- Shows healthbars for all or specific enemies
	
	Author: grasmann
	Version: 1.3.0
--]]

-- ##### ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗ #############################################
-- ##### ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝ #############################################
-- ##### ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗ #############################################
-- ##### ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║ #############################################
-- ##### ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║ #############################################
-- ##### ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝ #############################################
local mod_data = {}
mod_data.name = "Healthbars" -- Readable mod name
mod_data.description = "Shows healthbars for all or specific enemies." -- Readable mod description
mod_data.is_togglable = true -- If the mod can be enabled/disabled
mod_data.is_mutator = false -- If the mod is mutator
mod_data.options_widgets = {
	{
		["setting_name"] = "position",
		["widget_type"] = "dropdown",
		["text"] = "Position",
		["tooltip"] = "Position",
			 "Switch position of the enemy health bars.",
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
		["tooltip"] = "Mode",
			"Switch mode for the enemy health bars.",
			"",
			"-- All --",
			"Create health bars for all wounded enemies.",
			"",
			"-- SPECIALS ONLY --",
			"Create health bars for specials only.",
			"",
			"-- BOSSES ONLY --",
			"Create health bars only for bosses.",
			"",
			"-- CUSTOM --",
			"Choose which enemies should have a health bar.",
		["options"] = {
			{--[[1]] text = "All", value = 2},
			{--[[2]] text = "Specials", value = 3}, 
			{--[[3]] text = "Ogre", value = 4},
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
				["text"] = "Slave Rat",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "clan_rat",
				["widget_type"] = "checkbox",
				["text"] = "Clan Rat",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "stormvermin",
				["widget_type"] = "checkbox",
				["text"] = "Stormvermin",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "runner",
				["widget_type"] = "checkbox",
				["text"] = "Gutter Runner",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "gunner",
				["widget_type"] = "checkbox",
				["text"] = "Ratling Gunner",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "packmaster",
				["widget_type"] = "checkbox",
				["text"] = "Packmaster",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "gas_rat",
				["widget_type"] = "checkbox",
				["text"] = "Globadier",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "sack_rat",
				["widget_type"] = "checkbox",
				["text"] = "Sack Rat",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "ogre",
				["widget_type"] = "checkbox",
				["text"] = "Rat Ogre",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "champion",
				["widget_type"] = "checkbox",
				["text"] = "Stormvermin Champion",
				["default_value"] = false,
			},
			-- VT2
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "plague_monk",
				["widget_type"] = "checkbox",
				["text"] = "Plague Monk",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "warpfire_thrower",
				["widget_type"] = "checkbox",
				["text"] = "Warpfire Thrower",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "stormfiend",
				["widget_type"] = "checkbox",
				["text"] = "Stormfiend",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "stormfiend_warlord",
				["widget_type"] = "checkbox",
				["text"] = "Stormvermin Warlord",
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
				["setting_name"] = "chaos_vortex_sorcerer",
				["widget_type"] = "checkbox",
				["text"] = "Chaos Vortex Sorcerer",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "chaos_plague_sorcerer",
				["widget_type"] = "checkbox",
				["text"] = "Chaos Plague Sorcerer",
				["default_value"] = false,
			},
			{
				["show_widget_condition"] = {4},
				["setting_name"] = "chaos_fanatic",
				["widget_type"] = "checkbox",
				["text"] = "Chaos Fanatic",
				["default_value"] = false,
			},
		},
	},
	{
		["setting_name"] = "toggle_mod",
		["widget_type"] = "keybind",
		["text"] = "Toggle",
		["tooltip"] = "Toggle healthbars on / off.",
		["default_value"] = {},
		["action"] = "toggle_mod"
	},
}

-- ##### ██████╗  █████╗ ████████╗ █████╗ #############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################
mod.VERY_FAR = 50
local SIZE = {
	Default = {17*0.9, 7*0.9},
	Special = {17*1.4, 7*1.4},
	Ogre = {17*1.8, 7*1.8},
}
mod.enemie_settings = {
	default = {
		offset = 1.5,
		size = SIZE.Default,
		special = false,
		setting = "NONE",
	},
	skaven_slave = {
		offset = 3,
		size = SIZE.Default,
		special = false,
		setting = "slave_rat",
	},
	skaven_clan_rat = {
		offset = 3,
		size = SIZE.Default,
		special = false,
		setting = "clan_rat",
	},
	skaven_storm_vermin = {
		offset = 4,
		size = SIZE.Special,
		special = true,
		setting = "stormvermin",
	},
	skaven_storm_vermin_commander = {
		offset = 4,
		size = SIZE.Special,
		special = true,
		setting = "stormvermin",
	},
	skaven_gutter_runner = {
		offset = 3,
		size = SIZE.Special,
		special = true,
		setting = "runner",
	},
	skaven_ratling_gunner = {
		offset = 4,
		size = SIZE.Special,
		special = true,
		setting = "gunner",
	},
	skaven_pack_master = {
		offset = 4,
		size = SIZE.Special,
		special = true,
		setting = "packmaster",
	},
	skaven_poison_wind_globadier = {
		offset = 3.5,
		size = SIZE.Special,
		special = true,
		setting = "gas_rat",
	},
	skaven_rat_ogre = {
		offset = 5.5,
		size = SIZE.Ogre,
		special = true,
		boss = true,
		setting = "ogre",
	},
	skaven_loot_rat = {
		offset = 4,
		size = SIZE.Ogre,
		special = true,
		setting = "sack_rat",
	},
	critter_pig = {
		offset = 2.5,
		size = SIZE.Special,
		special = false,
		setting = "NONE",
	},
	critter_rat = {
		offset = 0.5,
		size = SIZE.Special,
		special = false,
		setting = "NONE",
	},
	skaven_grey_seer = {
		offset = 3.5,
		size = SIZE.Ogre,
		special = true,
		boss = true,
		setting = "NONE",
	},
	skaven_storm_vermin_champion = {
		offset = 5.5,
		size = SIZE.Ogre,
		special = true,
		boss = true,
		setting = "champion",
	},
	-- VT2
	skaven_dummy_slave = {
		offset = 3,
		size = SIZE.Default,
		special = false,
		setting = "slave_rat",
	},
	skaven_dummy_clan_rat = {
		offset = 3,
		size = SIZE.Default,
		special = false,
		setting = "clan_rat",
	},
	skaven_clan_rat_tutorial = {
		offset = 3,
		size = SIZE.Default,
		special = false,
		setting = "clan_rat",
	},
	skaven_clan_rat_with_shield = {
		offset = 3,
		size = SIZE.Default,
		special = false,
		setting = "clan_rat",
	},
	skaven_storm_vermin_with_shield = {
		offset = 4,
		size = SIZE.Special,
		special = true,
		setting = "stormvermin",
	},
	skaven_plague_monk = {
		offset = 4,
		size = SIZE.Special,
		special = true,
		setting = "plague_monk",
	},
	skaven_warpfire_thrower = {
		offset = 4,
		size = SIZE.Special,
		special = true,
		setting = "warpfire_thrower",
	},
	skaven_stormfiend = {
		offset = 5.5,
		size = SIZE.Ogre,
		special = true,
		boss = true,
		setting = "stormfiend",
	},
	skaven_stormfiend_boss = {
		offset = 5.5,
		size = SIZE.Ogre,
		special = true,
		boss = true,
		setting = "stormfiend",
	},
	skaven_stormfiend_demo = {
		offset = 5.5,
		size = SIZE.Ogre,
		special = true,
		boss = true,
		setting = "stormfiend",
	},
	skaven_storm_vermin_warlord = {
		offset = 5.5,
		size = SIZE.Ogre,
		special = true,
		boss = true,
		setting = "stormfiend_warlord",
	},
	-- Chaos
	chaos_warrior = {
		offset = 4,
		size = SIZE.Default,
		special = true,
		setting = "chaos_warrior",
	},
	chaos_exalted_champion = {
		offset = 5,
		size = SIZE.Ogre,
		special = true,
		setting = "chaos_exalted_champion",
	},
	chaos_exalted_champion_warcamp = {
		offset = 5,
		size = SIZE.Ogre,
		special = true,
		setting = "chaos_exalted_champion",
	},
	chaos_exalted_champion_norsca = {
		offset = 5,
		size = SIZE.Ogre,
		special = true,
		setting = "chaos_exalted_champion",
	},
	chaos_marauder = {
		offset = 4,
		size = SIZE.Default,
		special = true,
		setting = "chaos_marauder",
	},
	chaos_marauder_tutorial = {
		offset = 4,
		size = SIZE.Default,
		special = true,
		setting = "chaos_marauder",
	},
	chaos_marauder_with_shield = {
		offset = 4,
		size = SIZE.Default,
		special = true,
		setting = "chaos_marauder",
	},
	chaos_berzerker = {
		offset = 4,
		size = SIZE.Special,
		special = true,
		setting = "chaos_berzerker",
	},
	chaos_raider = {
		offset = 4,
		size = SIZE.Special,
		special = true,
		setting = "chaos_raider",
	},
	chaos_raider_tutorial = {
		offset = 4,
		size = SIZE.Special,
		special = true,
		setting = "chaos_raider",
	},
	chaos_dummy_sorcerer = {
		offset = 5,
		size = SIZE.Special,
		special = true,
		setting = "chaos_vortex_sorcerer",
	},
	chaos_vortex_sorcerer = {
		offset = 5,
		size = SIZE.Special,
		special = true,
		setting = "chaos_vortex_sorcerer",
	},
	chaos_plague_sorcerer = {
		offset = 5,
		size = SIZE.Special,
		special = true,
		setting = "chaos_plague_sorcerer",
	},
	chaos_spawn = {
		offset = 5.5,
		size = SIZE.Ogre,
		special = true,
		boss = true,
		setting = "stormfiend_warlord",
	},
	chaos_spawn_exalted_champion_norsca = {
		offset = 5.5,
		size = SIZE.Ogre,
		special = true,
		boss = true,
		setting = "stormfiend_warlord",
	},
	chaos_fanatic = {
		offset = 4,
		size = SIZE.Default,
		special = true,
		setting = "chaos_fanatic",
	},
	chaos_troll = {
		offset = 5.5,
		size = SIZE.Ogre,
		special = true,
		boss = true,
		setting = "stormfiend_warlord",
	},
	chaos_dummy_troll = {
		offset = 5.5,
		size = SIZE.Ogre,
		special = true,
		boss = true,
		setting = "stormfiend_warlord",
	},
	chaos_zombie = {
		offset = 4,
		size = SIZE.Default,
		special = true,
		setting = "chaos_zombie",
	},
	chaos_corruptor_sorcerer = {
		offset = 5,
		size = SIZE.Special,
		special = true,
		setting = "chaos_plague_sorcerer",
	},
	chaos_exalted_sorcerer = {
		offset = 5,
		size = SIZE.Special,
		special = true,
		setting = "chaos_vortex_sorcerer",
	},
	chaos_tentacle_sorcerer = {
		offset = 5,
		size = SIZE.Special,
		special = true,
		setting = "chaos_vortex_sorcerer",
	},
	chaos_tentacle = {
		offset = 3,
		size = SIZE.Default,
		special = false,
		setting = "chaos_tentacle",
	},
	chaos_vortex = {
		offset = 3,
		size = SIZE.Default,
		special = false,
		setting = "chaos_tentacle",
	},
	chaos_plague_wave_spawner = {
		offset = 3,
		size = SIZE.Default,
		special = false,
		setting = "chaos_tentacle",
	},
}
mod_permanent_units = mod_permanent_units or {}

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
	Add a health bar to all units
--]]
mod.add_health_bar_all = function(self, unit)
	if not table.contains(mod_permanent_units, unit) then
		local tutorial_system = Managers.state.entity:system("tutorial_system")
		if tutorial_system and tutorial_system.tutorial_ui then
			tutorial_system.tutorial_ui:add_health_bar(unit)
			mod_permanent_units[unit] = unit
		end
	end
end
--[[
	Add a health bar only to special units
--]]
mod.add_health_bar_specials = function(self, unit, enemie_setting)
	if enemie_setting.special then self:add_health_bar_all(unit) end
end
--[[
	Add a health bar only to custom units
--]]
mod.add_health_bar_custom = function(self, unit, enemie_setting)
	if self:get(enemie_setting.setting) then self:add_health_bar_all(unit) end
end
--[[
	Add a health bar only to ogres
--]]
mod.add_health_bar_bosses = function(self, unit, enemie_setting)
	-- if enemie_setting.name == "skaven_rat_ogre" 
	-- or enemie_setting.name == "skaven_storm_vermin_champion" then
	if enemie_setting.boss then
		self:add_health_bar_all(unit)
	end
end
--[[
	Add a health bar to the specified unit
--]]
mod.add_health_bar = function(self, unit, enemie_setting)		
	if self:get("mode") == 2 then
		self:add_health_bar_all(unit)
	elseif self:get("mode") == 3 then
		self:add_health_bar_specials(unit, enemie_setting)
	elseif self:get("mode") == 4 then
		self:add_health_bar_bosses(unit, enemie_setting)
	elseif self:get("mode") == 5 then
		self:add_health_bar_custom(unit, enemie_setting)
	end
end
--[[
	Remove a health bar from a unit
--]]
mod.remove_health_bar = function(self, unit)
	if table.contains(mod_permanent_units, unit) then
		local tutorial_system = Managers.state.entity:system("tutorial_system")
		if tutorial_system and tutorial_system.tutorial_ui then
			tutorial_system.tutorial_ui:remove_health_bar(unit)
			mod_permanent_units[unit] = nil
		end
	end
end
--[[
	Remove a health bar from a unit
--]]
mod.on_enemy_damage = function(self, health_extension)
	if self:get("mode") > 1 then
		if GenericHealthExtension.current_health(health_extension) > 0 then
			local unit = health_extension.unit
			local breed = Unit.get_data(unit, "breed")
			
			if breed and breed.name then
				local enemie_setting = self.enemie_settings[breed.name] or self.enemie_settings["default"]
				if not enemie_setting then
					mod:echo(tostring(breed.name).." missing!")
					enemie_setting = self.enemie_settings["default"]
				end
				if enemie_setting then
					enemie_setting.name = breed.name
				
					self:add_health_bar(unit, enemie_setting)
				else
					mod:echo(tostring(breed.name))
				end
			end
		else			
			self:remove_health_bar(health_extension.unit)
		end		
	else
		self:remove_health_bar(health_extension.unit)
	end
end
--[[
	Clean units in the health bar system
--]]
mod.clean_units = function(self, clean_all)
	for _, unit in pairs(mod_permanent_units) do
		if not Unit.alive(unit) or clean_all then
			self:remove_health_bar(unit)
		else
			local unit_pos = Unit.world_position(unit, 0)
			local local_player = Managers.player:local_player()
			local player_pos = Unit.world_position(local_player.player_unit, 0)
			
			local distance = Vector3.length(unit_pos - player_pos)
			
			if distance > self.VERY_FAR or self:obstructed_line_of_sight(local_player.player_unit, unit) then
				self:remove_health_bar(unit)
			end
		end
	end
end

-- #####  ██████╗ ███████╗███████╗███████╗███████╗████████╗ ###########################################################
-- ##### ██╔═══██╗██╔════╝██╔════╝██╔════╝██╔════╝╚══██╔══╝ ###########################################################
-- ##### ██║   ██║█████╗  █████╗  ███████╗█████╗     ██║    ###########################################################
-- ##### ██║   ██║██╔══╝  ██╔══╝  ╚════██║██╔══╝     ██║    ###########################################################
-- ##### ╚██████╔╝██║     ██║     ███████║███████╗   ██║    ###########################################################
-- #####  ╚═════╝ ╚═╝     ╚═╝     ╚══════╝╚══════╝   ╚═╝    ###########################################################
--[[
	Set sizes for all health bars
--]]
mod.set_sizes = function(self, tutorial_ui)
	for _, unit in pairs(mod_permanent_units) do
		local breed = Unit.get_data(unit, "breed")
		
		if breed and breed.name then
			local enemie_setting = self.enemie_settings[breed.name] or self.enemie_settings["default"]
			
			self:set_size(unit, tutorial_ui, enemie_setting)
		end
	end
end
--[[
	Set size of units health bar
--]]
mod.set_size = function(self, unit, tutorial_ui, enemie_setting)
	for _, health_bar in pairs(tutorial_ui.health_bars) do
		if health_bar.unit == unit then
			local texture_bg = health_bar.widget.style.texture_bg
			texture_bg.size[2] = enemie_setting.size[1]
			local texture_fg = health_bar.widget.style.texture_fg
			texture_fg.size[2] = enemie_setting.size[2]
			return true
		end
	end
	return false
end
--[[
	Set offset for all health bars
--]]
mod.set_offsets = function(self, tutorial_ui)
	if self:get("position") ~= nil
	and self:get("position") == 2 then
		for _, unit in pairs(mod_permanent_units) do
			local breed = Unit.get_data(unit, "breed")
		
			if breed and breed.name then
				local enemie_setting = self.enemie_settings[breed.name] or self.enemie_settings["default"]
			
				self:set_offset(unit, tutorial_ui, enemie_setting)
			end
		end
	end
end
--[[
	Set offset for units health bar
--]]
mod.set_offset = function(self, unit, tutorial_ui, enemie_setting)
	local player = Managers.player:local_player()
	local world = tutorial_ui.world_manager:world("level_world")
	local viewport = ScriptWorld.viewport(world, player.viewport_name)
	local camera = ScriptViewport.camera(viewport)	
	
	for _, health_bar in pairs(tutorial_ui.health_bars) do
		if health_bar.unit == unit then
			-- Enemy position
			local enemy_pos = Unit.world_position(unit, 0)
			--local x1, y1 = tutorial_ui:convert_world_to_screen_position(camera, enemy_pos)
			local enemy_pos_2d = Camera.world_to_screen(camera, enemy_pos)
			-- Health bar position
			local hp_bar_pos = Vector3(enemy_pos[1], enemy_pos[2], enemy_pos[3] + enemie_setting.offset)
			--local x2, y2 = tutorial_ui:convert_world_to_screen_position(camera, hp_bar_pos)
			local hp_bar_pos_2d = Camera.world_to_screen(camera, hp_bar_pos)
			-- Difference
			--local diff = y2 - y1
			local diff = hp_bar_pos_2d[2] - enemy_pos_2d[2]
			-- Change offsets
			local scale = UIResolutionScale()
			diff = (diff / 2) * (2 - scale)
			--EchoConsole(scale)
			local texture_bg = health_bar.widget.style.texture_bg
			texture_bg.offset[2] = diff - texture_bg.size[2]/2
			local texture_fg = health_bar.widget.style.texture_fg
			texture_fg.offset[2] = diff - texture_fg.size[2]/2
			
			return true
		end
	end
	return false
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################
--[[
	GenericHealthExtension Add damage hook
--]]
mod:hook("GenericHealthExtension.add_damage", function(func, self, ...)
	func(self, ...)
	mod:on_enemy_damage(self)
end)
--[[
	GenericHealthExtension Set damage hook
--]]
mod:hook("GenericHealthExtension.set_current_damage", function(func, self, ...)
	func(self, ...)
	mod:on_enemy_damage(self)
end)
--[[
	RatOgreHealthExtension Add ogre damage hook
--]]
mod:hook("RatOgreHealthExtension.add_damage", function(func, self, ...)
	func(self, ...)
	mod:on_enemy_damage(self)
end)
--[[
	RatOgreHealthExtension Set ogre damage hook
--]]
mod:hook("RatOgreHealthExtension.set_current_damage", function(func, self, ...)
	func(self, ...)
	mod:on_enemy_damage(self)
end)
--[[
	Check units before updating health bars
	Necessary fix to avoid rare crashes
--]]
mod:hook("TutorialUI.update_health_bars", function(func, tutorial_ui, ...)
	if mod:get("mode") then
		mod:clean_units()
		mod:set_sizes(tutorial_ui)
		mod:set_offsets(tutorial_ui)
		
		--safe_pcall(func, tutorial_ui, ...)
		func(tutorial_ui, ...)
	else
		func(tutorial_ui, ...)
	end
end)
--[[
	Remove health bar from gutter runner when he's vanishing
--]]
mod:hook("BTSelector_gutter_runner.run", function(func, self, unit, blackboard, ...)
	--func(self, unit, blackboard, ...)
	local result, evaluate = func(self, unit, blackboard, ...)
	local child_running = self.current_running_child(self, blackboard)
	local node_ninja_vanish = self._children[5]
	if node_ninja_vanish == child_running then
		mod:remove_health_bar(unit)		
	end
	return result, evaluate
end)

-- ##### ███████╗██╗  ██╗████████╗███████╗███╗   ██╗██████╗  ##########################################################
-- ##### ██╔════╝╚██╗██╔╝╚══██╔══╝██╔════╝████╗  ██║██╔══██╗ ##########################################################
-- ##### █████╗   ╚███╔╝    ██║   █████╗  ██╔██╗ ██║██║  ██║ ##########################################################
-- ##### ██╔══╝   ██╔██╗    ██║   ██╔══╝  ██║╚██╗██║██║  ██║ ##########################################################
-- ##### ███████╗██╔╝ ██╗   ██║   ███████╗██║ ╚████║██████╔╝ ##########################################################
-- ##### ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═══╝╚═════╝  ##########################################################
--[[
	UI definitions
--]]
mod.ui = {
	item_definitions = {
		scenegraph_id = "health_bar_",
		content = {
			texture_fg = "objective_hp_bar_fg_2",
			texture_bg = "objective_hp_bar_bg_2",
		},
		style = {
			texture_bg = {
				scenegraph_id = "health_bar_",
				offset = {-73.5, 0, 1},
				size = {147, 17},
				color= {255, 255, 255, 255},
			},
			texture_fg = {
				scenegraph_id = "health_bar_",
				offset = {-68.5, 5, 1},
				size = {137, 7},
				color = {255, 255, 255, 255},
			},
		},
		element = {
			passes = {
				{
					texture_id = "texture_bg",
					style_id = "texture_bg",
					pass_type = "texture",
				},
				{
					texture_id = "texture_fg",
					style_id = "texture_fg",
					pass_type = "texture",
				},
			},
		},
	},

	item_scene_graph = {
		size = {137, 7},
		parent = "screen_fit",
		position = {0, 0, 1},
	}
}
--[[
	Create healthbar widgets
--]]
mod.create_extra_health_bars = function(self, total)
	local script = package.loaded["scripts/ui/views/tutorial_ui_definitions"]
	local scenegraph = nil
	
	-- 1.4.3 and beta check
	if script.floating_icons_scene_graph then
		scenegraph = script.floating_icons_scene_graph
	else
		scenegraph = script.scenegraph
	end
	
	script.health_bar_definitions = {}
	
	
	for x = 1, total do
		local name = "health_bar_" .. tostring(x)
		
		-- definitions
		self.ui.item_definitions.scenegraph_id = name
		self.ui.item_definitions.style.texture_bg.scenegraph_id = name
		self.ui.item_definitions.style.texture_fg.scenegraph_id = name
		
		script.health_bar_definitions[x] = table.clone(self.ui.item_definitions)
		
		scenegraph[name] = table.clone(self.ui.item_scene_graph)
	end

	script.NUMBER_OF_HEALTH_BARS = total
end

-- ##### ███████╗██╗ ██████╗ ██╗  ██╗████████╗ ########################################################################
-- ##### ██╔════╝██║██╔════╝ ██║  ██║╚══██╔══╝ ########################################################################
-- ##### ███████╗██║██║  ███╗███████║   ██║    ########################################################################
-- ##### ╚════██║██║██║   ██║██╔══██║   ██║    ########################################################################
-- ##### ███████║██║╚██████╔╝██║  ██║   ██║    ########################################################################
-- ##### ╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝    ########################################################################
--[[
	Check for obstruction of line of sight
	Note: Copied over from QoL
	Author: grimalackt?
--]]
mod.obstructed_line_of_sight = function(self, player_unit, target_unit)
	local INDEX_POSITION = 1
	local INDEX_DISTANCE = 2
	local INDEX_NORMAL = 3
	local INDEX_ACTOR = 4

	local pinged = ScriptUnit.has_extension(target_unit, "ping_system") and ScriptUnit.extension(target_unit, "ping_system"):pinged()
	if pinged then
		return false
	end

	local player_unit_pos = Unit.world_position(player_unit, 0)
	player_unit_pos.z = player_unit_pos.z + 1.5
	local target_unit_pos = Unit.world_position(target_unit, 0)
	target_unit_pos.z = target_unit_pos.z + 1.4

	local tutorial_system = Managers.state.entity:system("tutorial_system")
	local tutorial_ui = tutorial_system.tutorial_ui
	local world = tutorial_ui.world_manager:world("level_world")
	local physics_world = World.get_data(world, "physics_world")
	local max_distance = Vector3.length(target_unit_pos - player_unit_pos)
	
	if max_distance < 5 then
		return false
	end

	local direction = target_unit_pos - player_unit_pos
	local length = Vector3.length(direction)
	direction = Vector3.normalize(direction)
	local collision_filter = "filter_player_ray_projectile"

	PhysicsWorld.prepare_actors_for_raycast(physics_world, player_unit_pos, direction, 0.01, 10, max_distance*max_distance)

	local raycast_hits = PhysicsWorld.immediate_raycast(physics_world, player_unit_pos, direction, max_distance, "all", "collision_filter", collision_filter)

	if raycast_hits then
		local num_hits = #raycast_hits

		for i = 1, num_hits, 1 do
			local hit = raycast_hits[i]
			local hit_actor = hit[INDEX_ACTOR]
			local hit_unit = Actor.unit(hit_actor)

			if hit_unit == target_unit then
				return false
			elseif hit_unit ~= player_unit then
				local obstructed_by_static = Actor.is_static(hit_actor)

				if obstructed_by_static then
					return obstructed_by_static
				end
			end
		end
	end

	return false
end

-- ##### ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗ #########################################################
-- ##### ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝ #########################################################
-- ##### █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗ #########################################################
-- ##### ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║ #########################################################
-- ##### ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║ #########################################################
-- ##### ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ #########################################################
--[[
	Settings changed
--]]
mod.on_setting_changed = function(setting_name)
	if setting_name == "mode" then
		mod:clean_units(true)
	end
end
--[[
	Mod Suspended
--]]
mod.on_disabled = function(initial_call)
	mod:disable_all_hooks()
	mod:clean_units(true)
end
--[[
	Mod Unsuspended
--]]
mod.on_enabled = function(initial_call)
	mod:enable_all_hooks()
end

-- #####  █████╗  ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ######################################################
-- ##### ██╔══██╗██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ######################################################
-- ##### ███████║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ######################################################
-- ##### ██╔══██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ######################################################
-- ##### ██║  ██║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ######################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ######################################################
--[[
	Toggle mode
--]]
mod.toggle_mode = function()
	local mode = mod:get("mode")
	mode = mode + 1
	if mode > 5 then mode = 2 end
	mod:set("mode", mode, true)
end

-- ##### ███████╗████████╗ █████╗ ██████╗ ████████╗ ###################################################################
-- ##### ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝ ###################################################################
-- ##### ███████╗   ██║   ███████║██████╔╝   ██║    ###################################################################
-- ##### ╚════██║   ██║   ██╔══██║██╔══██╗   ██║    ###################################################################
-- ##### ███████║   ██║   ██║  ██║██║  ██║   ██║    ###################################################################
-- ##### ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ###################################################################
mod:create_extra_health_bars(30)
mod:initialize_data(mod_data)