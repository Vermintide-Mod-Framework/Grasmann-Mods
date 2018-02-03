local mod = get_mod("ShowDamage")
--[[ 
	Show Damage
		- Shows damage / healing in chat and as floating numbers.
	
	Author: grasmann
	Version: 1.2.0
--]]

-- ##### ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗ #############################################
-- ##### ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝ #############################################
-- ##### ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗ #############################################
-- ##### ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║ #############################################
-- ##### ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║ #############################################
-- ##### ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝ #############################################
local options_widgets = {
	{
		["setting_name"] = "chat_output",
		--["widget_type"] = "stepper",
		["widget_type"] = "checkbox",
		["text"] = "Chat Output",
		["tooltip"] = "Chat Output\n" ..
			"Show damage information in chat.",
		-- ["options"] = {
			-- {text = "Off", value = false},
			-- {text = "On", value = true},
		-- },
		["default_value"] = false,
		["sub_widgets"] = {
			["setting_name"] = "mode",
			--["widget_type"] = "dropdown",
			["widget_type"] = "stepper",
			["text"] = "Mode",
			["tooltip"] = "Mode\n" ..
				"Switch mode for the player damage output.\n\n" ..
				"-- DEFAULT --\nShows damage, hit zone and kill confirmation.\n\n" ..
				"-- KILLS --\nShows the default message but only on kills.\n\n" ..
				"-- SIMPLE KILLS --\nShows a simple message on a kill.",
			["options"] = {
				--{ text = Localize("vmf_text_core_off"), value = 1 },
				{text = "Default", value = 2},
				{text = "Kills", value = 3},
				{text = "Simple Kills", value = 4},
			},
			["default_value"] = 2,
			["sub_widgets"] = {
				{
					["show_widget_condition"] = {1, 2, 3},
					["setting_name"] = "system_chat",
					["widget_type"] = "stepper",
					["text"] = "Use System Chat",
					["tooltip"] = "Use System Chat\n" ..
						"Uses the system chat instead of normal chat.",
					["options"] = {
						{text = "Off", value = false},
						{text = "On", value = true},
					},
					["default_value"] = true,
				},
				{
					["show_widget_condition"] = {1, 2},
					["setting_name"] = "hit_zone",
					["widget_type"] = "stepper",
					["text"] = "Show Hit Zone",
					["tooltip"] = "Show Hit Zone\n" ..
						"Will show the hit zone in output.",
					["options"] = {
						{text = "Off", value = false},
						{text = "On", value = true},
					},
					["default_value"] = true,
				},
				{
					["show_widget_condition"] = {1},
					["setting_name"] = "kill",
					["widget_type"] = "stepper",
					["text"] = "Show Kill Indicator",
					["tooltip"] = "Show Kill Indicator\n" ..
						"Will show an indication in output if hit was a kill.",
					["options"] = {
						{text = "Off", value = false},
						{text = "On", value = true},
					},
					["default_value"] = true,
				},
				{
					["show_widget_condition"] = {1, 2, 3},
					["setting_name"] = "send_chat",
					["widget_type"] = "stepper",
					["text"] = "Share to others",
					["tooltip"] = "Share to others\n" ..
						"Will send the damage messages to the chat for all to read.",
					["options"] = {
						{text = "Off", value = false},
						{text = "On", value = true},
					},
					["default_value"] = false,
				},
				{
					["show_widget_condition"] = {1, 2, 3},
					["setting_name"] = "damage_source",
					--["widget_type"] = "dropdown",
					["widget_type"] = "stepper",
					["text"] = "Source",
					["tooltip"] = "Show Player Damage Source\n" ..
						"Switch source for the player damage output.\n\n" ..
						"-- OFF --\nNo messages will be posted.\n\n" ..
						"-- ME ONLY --\nOnly show damage messages for yourself.\n\n" ..
						"-- ALL --\nShows damage messages for all players, including bots.\n\n" ..
						"-- CUSTOM --\nChoose the players you want to see damage messages of.\n\n",
					["options"] = {
						{text = "Me Only", value = 1},
						{text = "All", value = 2},
						{text = "Custom", value = 3},
					},
					["default_value"] = 1,
					["sub_widgets"] = {
						{
							["show_widget_condition"] = {3},
							["setting_name"] = "chat_player_1",
							["widget_type"] = "checkbox",
							["text"] = "N/A",
							["default_value"] = false,
						},
						{
							["show_widget_condition"] = {3},
							["setting_name"] = "chat_player_2",
							["widget_type"] = "checkbox",
							["text"] = "N/A",
							["default_value"] = false,
						},
						{
							["show_widget_condition"] = {3},
							["setting_name"] = "chat_player_3",
							["widget_type"] = "checkbox",
							["text"] = "N/A",
							["default_value"] = false,
						},
						{
							["show_widget_condition"] = {3},
							["setting_name"] = "chat_player_4",
							["widget_type"] = "checkbox",
							["text"] = "N/A",
							["default_value"] = false,
						},
					},
				},
			},
		},
	},
	{
		["setting_name"] = "floating_numbers",
		--["widget_type"] = "stepper",
		["widget_type"] = "checkbox",
		["text"] = "Floating Damage Numbers",
		["tooltip"] = "Floating Damage Numbers\n" ..
			"Switch floating damage numbers on / off.",
		-- ["options"] = {
			-- {text = "Off", value = false},
			-- {text = "On", value = true},
		-- },
		["default_value"] = true,
		["sub_widgets"] = {
			{
				--["show_widget_condition"] = {2},
				["setting_name"] = "floating_numbers_source",
				--["widget_type"] = "dropdown",
				["widget_type"] = "stepper",
				["text"] = "Source",
				["tooltip"] = "Show Player Damage Source\n" ..
					"Switch source for the player damage output.\n\n" ..
					"-- OFF --\nNo messages will be posted.\n\n" ..
					"-- ME ONLY --\nOnly show damage messages for yourself.\n\n" ..
					"-- ALL --\nShows damage messages for all players, including bots.\n\n" ..
					"-- CUSTOM --\nChoose the players you want to see damage messages of.\n\n",
				["options"] = {
					{text = "Me Only", value = 1},
					{text = "All", value = 2},
					{text = "Custom", value = 3},
				},
				["default_value"] = 2,
				["sub_widgets"] = {
					{
						["show_widget_condition"] = {3},
						["setting_name"] = "floating_numbers_player_1",
						["widget_type"] = "checkbox",
						["text"] = "N/A",
						["default_value"] = false,
					},
					{
						["show_widget_condition"] = {3},
						["setting_name"] = "floating_numbers_player_2",
						["widget_type"] = "checkbox",
						["text"] = "N/A",
						["default_value"] = false,
					},
					{
						["show_widget_condition"] = {3},
						["setting_name"] = "floating_numbers_player_3",
						["widget_type"] = "checkbox",
						["text"] = "N/A",
						["default_value"] = false,
					},
					{
						["show_widget_condition"] = {3},
						["setting_name"] = "floating_numbers_player_4",
						["widget_type"] = "checkbox",
						["text"] = "N/A",
						["default_value"] = false,
					},
				},
			},
		},
	},
}

-- ##### ███████╗██╗  ██╗████████╗███████╗███╗   ██╗███████╗██╗ ██████╗ ███╗   ██╗ ####################################
-- ##### ██╔════╝╚██╗██╔╝╚══██╔══╝██╔════╝████╗  ██║██╔════╝██║██╔═══██╗████╗  ██║ ####################################
-- ##### █████╗   ╚███╔╝    ██║   █████╗  ██╔██╗ ██║███████╗██║██║   ██║██╔██╗ ██║ ####################################
-- ##### ██╔══╝   ██╔██╗    ██║   ██╔══╝  ██║╚██╗██║╚════██║██║██║   ██║██║╚██╗██║ ####################################
-- ##### ███████╗██╔╝ ██╗   ██║   ███████╗██║ ╚████║███████║██║╚██████╔╝██║ ╚████║ ####################################
-- ##### ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ####################################
--[[
	Replace the text of an initialized option widget
--]]
mod.update_setting_text = function(self, setting_name, text)
	local ingame_ui_exists, ingame_ui = pcall(function () return Managers.player.network_manager.matchmaking_manager.matchmaking_ui.ingame_ui end)
	if ingame_ui_exists then
		local vmf_options_view = ingame_ui.views["vmf_options_view"]
		if vmf_options_view then
			local searched_widget = nil
			
			for _, mod_widgets in ipairs(vmf_options_view.settings_list_widgets) do
				if mod_widgets[1].content.mod_name == self._name then
					for _, widget in ipairs(mod_widgets) do
						if widget.content.setting_name == setting_name then
							-- do your thing
							searched_widget = widget
						end
					end
				end
			end
			
			if searched_widget then
				searched_widget.content.text = text
			end
		end
	end
end

-- ##### ██████╗  █████╗ ████████╗ █████╗ #############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################
mod.t = 0
mod.chat = {
	units = {},
	NAME_LENGTH = 20,
}
mod.floating = {
	corpses = {},
	units = {},
	delete = {},
	fade_time = 2,
	definition = {
		position = nil,
		damage = 0,
		color = nil,
		timer = 0,
		widget = nil,
	},
	widget = {
		scenegraph_id = "charge_bar",
		element = {
			passes = {
				{
					pass_type = "rounded_background",
					style_id = "indicator"
				},
			},
		},
		content = {},
		style = {
			indicator = {
				offset = { 230, -45 },
				size = { 48, 48 },
				corner_radius = 24,
			},
		},
	},
}
mod.enemies = {
	specials = {
		"skaven_storm_vermin",
		"skaven_storm_vermin_commander",
		"skaven_loot_rat",
		"skaven_rat_ogre",
		"skaven_gutter_runner",
		"skaven_poison_wind_globadier",
		"skaven_pack_master",
		"skaven_ratling_gunner",
		"skaven_grey_seer",
		"skaven_storm_vermin_champion",
	},
	breed_names = {
		skaven_slave = "Slave Rat",
		skaven_storm_vermin = "Stormvermin",
		skaven_storm_vermin_commander = "Stormvermin",
		skaven_clan_rat = "Clan Rat",
		skaven_loot_rat = "Loot Rat",
		skaven_rat_ogre = "Rat Ogre",
		skaven_gutter_runner = "Gutter Runner",
		skaven_poison_wind_globadier = "Globadier",
		skaven_pack_master = "Pack Master",
		skaven_ratling_gunner = "Ratling Gunner",
		skaven_grey_seer = "Grey Seer",
		critter_pig = "Pig",
		critter_rat = "Rat",
		skaven_storm_vermin_champion = "Stormvermin Champion",
	},
	hit_zones = {
		full = "",
		head = "Head",
		right_arm = "R. Arm",
		left_arm = "L. Arm",
		torso = "Torso",
		right_leg = "R. Leg",
		left_leg = "L. Leg",
		tail = "Tail",
		neck = "Neck",
	},
	offsets = {
		default = 1,
		skaven_slave = 1,
		skaven_clan_rat = 1,
		skaven_storm_vermin = 1,
		skaven_storm_vermin_commander = 1,
		skaven_gutter_runner = 1,
		skaven_ratling_gunner = 1,
		skaven_pack_master = 1,
		skaven_poison_wind_globadier = 1,
		skaven_rat_ogre = 2,
		skaven_loot_rat = 1,
		skaven_grey_seer = 2,
		critter_pig = 0.5,
		critter_rat = 0,
		skaven_storm_vermin_champion = 2,
	},
}
mod.players = {}
mod.strings = {}
mod.console = {}

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
	Get a generic character name
--]]
mod.players.unit_name = function(unit_name)
	if unit_name == "empire_soldier" then
		return "Empire Soldier"
	elseif unit_name == "witch_hunter" then
		return "Witch Hunter"
	elseif unit_name == "bright_wizard" then
		return "Bright Wizard"
	elseif unit_name == "dwarf_ranger" then
		return "Dwarf Ranger"
	elseif unit_name == "wood_elf" then
		return "Waywatcher"
	end
	return nil
end
--[[
	Get player name from index
--]]
mod.players.set_names = function()
	local player_manager = Managers.player
	local players = player_manager:human_and_bot_players()
	local i = 1
	for _, player in pairs(players) do
		local name = mod.strings.check({player._cached_name, mod.players.unit_name(player.player_name)}) or "N/A"
		mod:update_setting_text("chat_player_"..tostring(i), name)
		mod:update_setting_text("floating_numbers_player_"..tostring(i), name)
		i = i + 1
	end
end
--[[
	Shorten string
--]]
mod.strings.shorten = function(str)
	if string.len(str) >= mod.chat.NAME_LENGTH then
		return string.sub(str, 1, mod.chat.NAME_LENGTH)
	end
	return str
end
--[[
	Check if objects are strings
	Returns first string
--]]
mod.strings.check = function(strings, default)
	if type(strings) == "table" then
		for _, str in pairs(strings) do
			if type(str) == "string" and Utf8.valid(str) then
				return mod.strings.shorten(str)
			end
		end
	elseif type(strings) == "string" and Utf8.valid(strings) then
		return mod.strings.shorten(strings)
	end
	if type(default) == "string" and Utf8.valid(default) then
		return mod.strings.shorten(default)
	end
	return "N/A"
end
--[[
	Check if unit is player unit
--]]
mod.players.is_player_unit = function(unit)
	return DamageUtils.is_player_unit(unit)
end
--[[
	Get player from player unit
--]]
mod.players.from_player_unit = function(player_unit)
	local player_manager = Managers.player
	local players = player_manager:human_and_bot_players()
	for _, player in pairs(players) do
		if player.player_unit == player_unit then
			return player
		end
	end
	return nil
end
--[[
	Add unit to process
--]]
mod.add_unit = function(self, unit)
	-- if not table.has_item2(mod.chat.units, unit) then
		-- if self.health_extension.is_alive(self.health_extension) then
			-- mod.chat.units[unit] = unit
		-- end
	-- end
	if not mod.floating.has_unit(unit) then
		if self.health_extension.is_alive(self.health_extension) then
			mod.floating.units[unit] = {}
		end
	end
end

-- ##### ███████╗██╗      ██████╗  █████╗ ████████╗██╗███╗   ██╗ ██████╗  #############################################
-- ##### ██╔════╝██║     ██╔═══██╗██╔══██╗╚══██╔══╝██║████╗  ██║██╔════╝  #############################################
-- ##### █████╗  ██║     ██║   ██║███████║   ██║   ██║██╔██╗ ██║██║  ███╗ #############################################
-- ##### ██╔══╝  ██║     ██║   ██║██╔══██║   ██║   ██║██║╚██╗██║██║   ██║ #############################################
-- ##### ██║     ███████╗╚██████╔╝██║  ██║   ██║   ██║██║ ╚████║╚██████╔╝ #############################################
-- ##### ╚═╝     ╚══════╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝  #############################################
--[[
	Post message for player in filter file
--]]
mod.floating.handle = function(self, unit, biggest_hit, parameters)
	local healed = parameters.healed
	local ammo = parameters.ammo
	
	--EchoConsole("healed = " .. tostring(healed))
	
	if mod:get("floating_numbers") and mod.floating.has_unit(unit) then
		local breed_data = Unit.get_data(unit, "breed")
		local attacker_unit = biggest_hit[DamageDataIndex.ATTACKER]
		local damage_amount = biggest_hit[DamageDataIndex.DAMAGE_AMOUNT]
		local hit_zone_name = biggest_hit[DamageDataIndex.HIT_ZONE]
		local unit_is_dead = parameters.death
		
		if breed_data then
			if mod:get("floating_numbers_source") == 1 then
				mod.floating.local_player(attacker_unit, unit, damage_amount, unit_is_dead, breed_data.name, healed, ammo)
			elseif mod:get("floating_numbers_source") == 2 then
				mod.floating.all(attacker_unit, unit, damage_amount, unit_is_dead, breed_data.name, healed, ammo)
			elseif mod:get("floating_numbers_source") == 3 then
				mod.floating.custom(attacker_unit, unit, damage_amount, unit_is_dead, breed_data.name, healed, ammo)
			end
		end
		
		local health_extension = self and self.health_extension
		if not health_extension and ScriptUnit.has_extension(unit, "health_system") then
			health_extension =  ScriptUnit.extension(unit, "health_system")
		end

		if not health_extension:is_alive() then
			mod.floating.delete[unit] = unit
		end
	end
end
--[[
	Post message for local player
--]]
mod.floating.local_player = function(attacker_unit, unit, damage_amount, dead, breed, healed, ammo)
	local local_player = Managers.player:local_player()
	if attacker_unit == local_player.player_unit and (not mod.floating.corpses[unit]) then
		local position = Unit.world_position(unit, 0)
		position[2] = position[2] + mod.enemies.offsets[breed]
		local color = {255, 255, 255, 255}
		
		if dead then
			color = {255, 255, 56, 56}
			mod.floating.corpses[unit] = true
		end
		if healed then color = {255, 56, 255, 56} end
		if ammo then color = {255, 255,255,0} end
		mod.floating.units[unit][#mod.floating.units[unit]+1] = mod.floating.new(position, damage_amount, color, healed, ammo)
	end
end
--[[
	Post message for every player
--]]
mod.floating.all = function(attacker_unit, unit, damage_amount, dead, breed, healed, ammo)
	if mod.players.is_player_unit(attacker_unit) and (not mod.floating.corpses[unit]) then
		local position = Unit.world_position(unit, 0)
		position[2] = position[2] + mod.enemies.offsets[breed]
		local color = {255, 255, 255, 255}
		
		if dead then
			color = {255, 255, 56, 56}
			mod.floating.corpses[unit] = true
		end
		
		if healed then color = {255, 56, 255, 56} end
		if ammo then color = {255, 255,255,0} end
		
		mod.floating.units[unit][#mod.floating.units[unit]+1] = mod.floating.new(position, damage_amount, color, healed, ammo)
	end
end
--[[
	Post message for custom chosen player
--]]
mod.floating.custom = function(attacker_unit, unit, damage_amount, dead, breed, healed, ammo)
	if mod.players.is_player_unit(attacker_unit) then			
		local player_manager = Managers.player
		local players = player_manager:human_and_bot_players()				
		local i = 1
		for _, p in pairs(players) do
			if mod:get("floating_numbers_player_"..tostring(i)) then
				if attacker_unit == p.player_unit and (not mod.floating.corpses[unit]) then
					local position = Unit.world_position(unit, 0)
					position[2] = position[2] + mod.enemies.offsets[breed]
					local color = {255, 255, 255, 255}
					
					if dead then
						color = {255, 255, 56, 56}
						mod.floating.corpses[unit] = true
					end
					
					if healed then color = {255, 56, 255, 56} end
					if ammo then color = {255, 255,255,0} end
					mod.floating.units[unit][#mod.floating.units[unit]+1] = mod.floating.new(position, damage_amount, color, healed, ammo)
				end
			end
			i = i + 1
		end
	end
end

mod.floating.has_unit = function(unit)
	return mod.floating.units[unit] ~= nil
end

mod.floating.new = function(position, damage, color, healed, ammo)
	local unit_dmg = table.clone(mod.floating.definition)
	unit_dmg.position = Vector3Aux.box(nil, position)
	unit_dmg.damage = damage or 0
	unit_dmg.color = color or {255, 255, 255, 255}
	unit_dmg.timer = mod.t
	unit_dmg.healed = healed
	unit_dmg.ammo = ammo
	
	return unit_dmg
end

mod:hook("DamageUtils.buff_on_attack", function(func, unit, hit_unit, ...)
	local func_apply_buffs_to_value = BuffExtension.apply_buffs_to_value
	
	BuffExtension.apply_buffs_to_value = function (self, value, stat_buff)
		local amount, procced, parent_id = func_apply_buffs_to_value(self, value, stat_buff)
		
		if procced and (stat_buff == StatBuffIndex.HEAL_PROC or stat_buff == StatBuffIndex.LIGHT_HEAL_PROC or stat_buff == StatBuffIndex.HEAVY_HEAL_PROC) then
			local biggest_hit = {}
			biggest_hit[DamageDataIndex.ATTACKER] = unit
			biggest_hit[DamageDataIndex.DAMAGE_AMOUNT] = amount
			biggest_hit[DamageDataIndex.HIT_ZONE] = nil
			mod.floating.handle(nil, hit_unit, biggest_hit, {healed = true})
		end
		return amount, procced, parent_id
	end

	local value = func(unit, hit_unit, ...)

	BuffExtension.apply_buffs_to_value = func_apply_buffs_to_value

	return value
end)

local function DeathReactions_start_hook(func, unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)
	-- Health buff
	local func_apply_buffs_to_value = BuffExtension.apply_buffs_to_value
	BuffExtension.apply_buffs_to_value = function (self, value, stat_buff)
		local amount, procced, parent_id = func_apply_buffs_to_value(self, value, stat_buff)
		
		if procced and stat_buff == StatBuffIndex.HEAL_ON_KILL then
			local biggest_hit = {}
			biggest_hit[DamageDataIndex.ATTACKER] = killing_blow[DamageDataIndex.ATTACKER]
			biggest_hit[DamageDataIndex.DAMAGE_AMOUNT] = amount
			biggest_hit[DamageDataIndex.HIT_ZONE] = nil
			mod.floating.handle(nil, unit, biggest_hit, {healed = true})
		end
		
		return amount, procced, parent_id
	end
	
	-- Ammo buff
	local func_add_ammo_to_reserve = GenericAmmoUserExtension.add_ammo_to_reserve
	GenericAmmoUserExtension.add_ammo_to_reserve = function (self, amount)
		if amount then
			local biggest_hit = {}
			biggest_hit[DamageDataIndex.ATTACKER] = killing_blow[DamageDataIndex.ATTACKER]
			biggest_hit[DamageDataIndex.DAMAGE_AMOUNT] = amount
			biggest_hit[DamageDataIndex.HIT_ZONE] = nil
			mod.floating.handle(nil, unit, biggest_hit, {ammo = true})
		end
		
		return func_add_ammo_to_reserve(self, amount)
	end
	
	-- Execute orginal function
	local return_val_1, return_val_2 = func(unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)

	-- Restore functions
	BuffExtension.apply_buffs_to_value = func_apply_buffs_to_value
	GenericAmmoUserExtension.add_ammo_to_reserve = func_add_ammo_to_reserve
	
	mod.floating.corpses[unit] = true

	return return_val_1, return_val_2
end

for breed_name, template in pairs(DeathReactions.templates) do
	if template.unit and template.husk and template.unit.start and template.husk.start then
		mod:hook("DeathReactions.templates."..breed_name..".unit.start", DeathReactions_start_hook)
		mod:hook("DeathReactions.templates."..breed_name..".husk.start", DeathReactions_start_hook)
	end
end

--[[
	Floating number fonts
--]]
mod.floating.fonts = function(size)
	-- Return font_group, font_path, font_size
	if size == nil then size = 20 end
	if size >= 32 then
		return "gw_head_32", "materials/fonts/gw_head_32", size
	else
		return "gw_head_20", "materials/fonts/gw_head_32", size
	end
end

local test = false
mod.floating.render = function(unit)
	if mod.floating.units[unit] ~= nil then
		if not test then
			table.dump(mod.floating.units, "mod.floating.units", 4)
			test = true
		end
		if #mod.floating.units[unit] > 0 then
			local breed = Unit.get_data(unit, "breed")
			local offset = breed.name and mod.enemies.offsets[breed.name] or mod.enemies.offsets.default
			local player = Managers.player:local_player()
			--local world = tutorial_ui.world_manager:world("level_world")
			local world = Managers.world:world("level_world")
			local viewport = ScriptWorld.viewport(world, player.viewport_name)
			local camera = ScriptViewport.camera(viewport)
			
			--local color = Color(255, 255, 255, 255)
			local font_name, font_material, font_size = mod.floating.fonts(30)
			local scale = UIResolutionScale()
			
			-- local enemy_pos = Unit.world_position(unit, 0)
			-- local dmg_pos = Vector3(enemy_pos[1], enemy_pos[2], enemy_pos[3] + offset)
			-- local hp_bar_pos_2d = Camera.world_to_screen(camera, dmg_pos)
			
			--EchoConsole(string.format("x=%i;y=%i", hp_bar_pos_2d[1], hp_bar_pos_2d[2]))
			
			local index = 1
			local visibility_offset = 0
			for _, unit_dmg in pairs(mod.floating.units[unit]) do
				if mod.t - unit_dmg.timer < mod.floating.fade_time then
					if unit_dmg.damage > 0 then
						local damage = ""
						-- If damage is a integer
						if unit_dmg.damage == math.floor(unit_dmg.damage) then
							damage = tostring(unit_dmg.damage)
						else -- else we want the number with the 2 digits behind the dot
							damage = string.format("%.2f", unit_dmg.damage)
						end
						-- if not unit_dmg.widget then
							-- unit_dmg.widget = UIWidget.init(mod.floating.widget)
						-- end
						
						local life = (mod.t - unit_dmg.timer) / mod.floating.fade_time
						local alpha = life*2
						if alpha > 1 then alpha = 2 - alpha end
						local color = Color(unit_dmg.color[1] * alpha, unit_dmg.color[2], unit_dmg.color[3], unit_dmg.color[4])
						local black = Color(255 * alpha, 0, 0, 0)
						--local position = Vector3Aux.unbox(unit_dmg.position)
						local position = Unit.world_position(unit, 0)
						position[3] = position[3] + offset
						local position2d, depth = Camera.world_to_screen(camera, position)
						local offset_height = (100 * scale) * life
						local offset_vis = {0, 0}
						if visibility_offset == 1 then
							offset_vis[2] = -50 * scale
						elseif visibility_offset == 2 then
							offset_vis[1] = -50 * scale
						elseif visibility_offset == 3 then
							offset_vis[2] = 50 * scale
						elseif visibility_offset == 4 then
							offset_vis[1] = 50 * scale
						end
						--local scaled_font_size = (unit_dmg.healed or unit_dmg.ammo) and font_size*1.3 or font_size
						if depth < 1 then
							local ingame_ui_exists, ingame_ui = pcall(function () return Managers.player.network_manager.matchmaking_manager.matchmaking_ui.ingame_ui end)
							if ingame_ui_exists then
								local ui_renderer = ingame_ui.ui_top_renderer
								if ui_renderer then
									--mod:echo(damage)
									--UIRenderer.begin_pass(ui_renderer, self.ui_scenegraph, input_service, dt, nil, self.render_settings)
									--UIRenderer.draw_widget(ui_renderer, unit_dmg.widget)
									mod:pcall(function()
										--UIRenderer.draw_text(ui_renderer, damage, font_material, font_size, font_name, position, color) --, retained_id, color_override)
										Gui.text(ui_renderer.gui, damage, font_material, font_size, font_name, Vector2(position2d[1]+2+offset_vis[1], position2d[2]-2+offset_vis[2]+offset_height), black)
										Gui.text(ui_renderer.gui, damage, font_material, font_size, font_name, Vector2(position2d[1]+2+offset_vis[1], position2d[2]+2+offset_vis[2]+offset_height), black)
										Gui.text(ui_renderer.gui, damage, font_material, font_size, font_name, Vector2(position2d[1]-2+offset_vis[1], position2d[2]-2+offset_vis[2]+offset_height), black)
										Gui.text(ui_renderer.gui, damage, font_material, font_size, font_name, Vector2(position2d[1]-2+offset_vis[1], position2d[2]+2+offset_vis[2]+offset_height), black)
										Gui.text(ui_renderer.gui, damage, font_material, font_size, font_name, Vector2(position2d[1]+offset_vis[1], position2d[2]+offset_vis[2]+offset_height), color)
									end)
									--local ui_position = UIScaleVectorToResolution(position)
									--Gui.text(ui_renderer.gui, damage, font_material, font_size, font_name, ui_position, color)
									--UIRenderer.end_pass(ui_renderer)
								end
							end
							-- Mods.gui.text(damage, position2d[1]+2 + offset_vis[1], position2d[2]-2 + offset_vis[2] + offset_height, 1, font_size, black, font)
							-- Mods.gui.text(damage, position2d[1]+2 + offset_vis[1], position2d[2]+2 + offset_vis[2] + offset_height, 1, font_size, black, font)
							-- Mods.gui.text(damage, position2d[1]-2 + offset_vis[1], position2d[2]-2 + offset_vis[2] + offset_height, 1, font_size, black, font)
							-- Mods.gui.text(damage, position2d[1]-2 + offset_vis[1], position2d[2]+2 + offset_vis[2] + offset_height, 1, font_size, black, font)
							-- Mods.gui.text(damage, position2d[1] + offset_vis[1], position2d[2] + offset_vis[2] + offset_height, 1, font_size, color, font)
							
							visibility_offset = visibility_offset + 1
							if visibility_offset > 4 then visibility_offset = 0 end
						end
					end
				else
					table.remove(mod.floating.units[unit], index)
				end
				index = index + 1
			end
		else
			if table.contains(mod.floating.delete, unit) then
				mod.floating.units[unit] = nil
				mod.floating.delete[unit] = nil
			end
		end
	end
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################
--[[
	Catch option menu being opened
--]]
mod:hook("VMFOptionsView.on_enter", function(func, self)
	mod.players.set_names()
	func(self)
end)

--[[
	Update - Add units to system if alive
--]]
mod:hook("GenericHitReactionExtension.update", function(func, self, unit, input, dt, context, t, ...)
	
	-- Save current time
	mod.t = t
	
	-- Add new units to process
	mod.add_unit(self, unit)
	
	-- Render damages
	mod.floating.render(unit)
	
	-- Original function
	func(self, unit, input, dt, context, t, ...)
	
end)

--[[
	Execute Effect - Post message and remove unit from system
--]]
mod:hook("GenericHitReactionExtension._execute_effect", function(func, self, unit, effect_template, biggest_hit, parameters)
	
	-- Original function
	func(self, unit, effect_template, biggest_hit, parameters)
	
	-- Chat output
	--mod.chat.handle(self, unit, biggest_hit, parameters)
	
	-- Floating numbers
	mod.floating.handle(self, unit, biggest_hit, parameters)
	
end)

-- ##### ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗ #########################################################
-- ##### ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝ #########################################################
-- ##### █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗ #########################################################
-- ##### ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║ #########################################################
-- ##### ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║ #########################################################
-- ##### ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ #########################################################
--[[
	Mod Setting changed
--]]
mod.setting_changed = function(setting_name)
end
--[[
	Mod Suspended
--]]
mod.suspended = function()
end
--[[
	Mod Unsuspended
--]]
mod.unsuspended = function()
end
--[[
	Mod Update
--]]
mod.update = function(dt)
end

mod:create_options(options_widgets, true, "Show Damage", "Mod description")