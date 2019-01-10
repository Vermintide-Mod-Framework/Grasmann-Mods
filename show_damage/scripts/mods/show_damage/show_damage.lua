local mod = get_mod("ShowDamage")
--[[
	Show Damage
		- Shows damage / healing in chat and as floating numbers.

	Author: grasmann
	Version: 2.1.0
--]]

-- ##### ███████╗██╗  ██╗████████╗███████╗███╗   ██╗███████╗██╗ ██████╗ ███╗   ██╗ ####################################
-- ##### ██╔════╝╚██╗██╔╝╚══██╔══╝██╔════╝████╗  ██║██╔════╝██║██╔═══██╗████╗  ██║ ####################################
-- ##### █████╗   ╚███╔╝    ██║   █████╗  ██╔██╗ ██║███████╗██║██║   ██║██╔██╗ ██║ ####################################
-- ##### ██╔══╝   ██╔██╗    ██║   ██╔══╝  ██║╚██╗██║╚════██║██║██║   ██║██║╚██╗██║ ####################################
-- ##### ███████╗██╔╝ ██╗   ██║   ███████╗██║ ╚████║███████║██║╚██████╔╝██║ ╚████║ ####################################
-- ##### ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ####################################
--[[
	Catch option menu being opened
--]]
mod.get_time = function(self)
	return Managers.time and Managers.time:time("game") or 0
end
--[[
	Update player names when option menu is open
--]]
mod:hook(VMFOptionsView, "update", function(func, self, ...)
	if mod:get_time() > mod.players.updated + mod.players.interval then
		mod.players.updated = mod:get_time()
		mod.players.set_names()
	end
	func(self, ...)
end)
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
		-- VT2
		--"skaven_dummy_slave",
		--"skaven_dummy_clan_rat",
		--"skaven_clan_rat_tutorial",
		--"skaven_clan_rat_with_shield",
		"skaven_storm_vermin_with_shield",
		"skaven_storm_vermin_warlord",
		"skaven_plague_monk",
		"skaven_warpfire_thrower",
		"skaven_stormfiend",
		"skaven_stormfiend_boss",
		"skaven_stormfiend_demo",
		-- Chaos
		"chaos_warrior",
		"chaos_exalted_champion",
		"chaos_exalted_champion_warcamp",
		"chaos_exalted_champion_norsca",
		--"chaos_marauder",
		--"chaos_marauder_tutorial",
		--"chaos_marauder_with_shield",
		"chaos_berzerker",
		"chaos_raider",
		"chaos_raider_tutorial",
		--"chaos_zombie",
		"chaos_dummy_sorcerer",
		"chaos_vortex_sorcerer",
		"chaos_plague_sorcerer",
		"chaos_corruptor_sorcerer",
		"chaos_exalted_sorcerer",
		"chaos_tentacle_sorcerer",
		"chaos_fanatic",
		"chaos_troll",
		"chaos_dummy_troll",
		"chaos_tentacle",
		"chaos_vortex",
		--"chaos_plague_wave_spawner",
		"chaos_spawn",
		"chaos_spawn_exalted_champion_norsca",
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
		-- VT2
		skaven_dummy_slave = "Slave Rat",
		skaven_dummy_clan_rat = "Clan Rat",
		skaven_clan_rat_tutorial = "Clan Rat",
		skaven_clan_rat_with_shield = "Clan Rat",
		skaven_storm_vermin_with_shield = "Stormvermin",
		skaven_plague_monk = "Plague Monk",
		skaven_warpfire_thrower = "Warpfire Thrower",
		skaven_stormfiend = "Stormfiend",
		skaven_stormfiend_boss = "Stormfiend",
		skaven_stormfiend_demo = "Stormfiend",
		skaven_storm_vermin_warlord = "Stormvermin Warlord",
		-- Chaos
		chaos_warrior = "Chaos Warrior",
		chaos_exalted_champion = "Chaos Exalted Champion",
		chaos_exalted_champion_warcamp = "Chaos Exalted Champion",
		chaos_exalted_champion_norsca = "Chaos Exalted Champion",
		chaos_marauder = "Chaos Marauder",
		chaos_marauder_tutorial = "Chaos Marauder",
		chaos_marauder_with_shield = "Chaos Marauder",
		chaos_berzerker = "Chaos Berzerker",
		chaos_raider = "Chaos Raider",
		chaos_raider_tutorial = "Chaos Raider",
		chaos_zombie = "Chaos Zombie",
		chaos_dummy_sorcerer = "Sorcerer",
		chaos_vortex_sorcerer = "Vortex Sorcerer",
		chaos_plague_sorcerer = "Plague Sorcerer",
		chaos_corruptor_sorcerer = "Corruptor Sorcerer",
		chaos_exalted_sorcerer = "Exalted Sorcerer",
		chaos_tentacle_sorcerer = "Tentacle Sorcerer",
		chaos_fanatic = "Chaos Fanatic",
		chaos_troll = "Troll",
		chaos_dummy_troll = "Troll",
		chaos_tentacle = "Tentacle",
		chaos_vortex = "Vortex",
		chaos_plague_wave_spawner = "Plague Wave Spawner",
		chaos_spawn = "Chaos Spawn",
		chaos_spawn_exalted_champion_norsca = "Chaos Spawn",
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
		default = 1.5,
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
		-- VT2
		skaven_dummy_slave = 1,
		skaven_dummy_clan_rat = 1,
		skaven_clan_rat_tutorial = 1,
		skaven_clan_rat_with_shield = 1,
		skaven_storm_vermin_with_shield = 1,
		skaven_plague_monk = 1,
		skaven_warpfire_thrower = 1,
		skaven_stormfiend = 2,
		skaven_stormfiend_boss = 2,
		skaven_stormfiend_demo = 2,
		skaven_storm_vermin_warlord = 2,
		-- Chaos
		chaos_warrior = 1.5,
		chaos_exalted_champion = 1.5,
		chaos_exalted_champion_warcamp = 1.5,
		chaos_exalted_champion_norsca = 1.5,
		chaos_marauder = 1.5,
		chaos_marauder_tutorial = 1.5,
		chaos_marauder_with_shield = 1.5,
		chaos_berzerker = 1.5,
		chaos_raider = 1.5,
		chaos_raider_tutorial = 1.5,
		chaos_zombie = 1.5,
		chaos_dummy_sorcerer = 1.5,
		chaos_vortex_sorcerer = 1.5,
		chaos_plague_sorcerer = 1.5,
		chaos_corruptor_sorcerer = 1.5,
		chaos_exalted_sorcerer = 1.5,
		chaos_tentacle_sorcerer = 1.5,
		chaos_fanatic = 1.5,
		chaos_troll = 2,
		chaos_dummy_troll = 2,
		chaos_tentacle = 1,
		chaos_vortex = 1,
		chaos_plague_wave_spawner = 1,
		chaos_spawn = 2,
		chaos_spawn_exalted_champion_norsca = 2,
		player = 1.5,
	},
}
mod.console = {}

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
	Add unit to process
--]]
mod.add_unit = function(self, unit)
	if not self.chat:has_unit(unit) then
		self.chat.units[unit] = unit
	end
	local health_extension = ScriptUnit.has_extension(unit, "health_system")
	if not self.floating:has_unit(unit) and health_extension:is_alive(health_extension) then
		self.floating.units[unit] = {}
	end
end
--[[
	Create GUI
--]]
mod.gui = nil
mod.create_gui = function(self)
	local top_world = Managers.world:world("top_ingame_view")
	self.gui = World.create_screen_gui(top_world, "immediate", "material", "materials/fonts/gw_fonts", --"material", "materials/ui/ui_1080p_ingame_common",
		"material", "materials/show_damage/block", "material", "materials/show_damage/melee", "material", "materials/show_damage/ranged",
		"material", "materials/show_damage/health", "material", "materials/show_damage/poison", "material", "materials/show_damage/flame")
end
mod.destroy_gui = function(self)
	local top_world = Managers.world:world("top_ingame_view")
	World.destroy_gui(top_world, self.gui)
	self.gui = nil
end

mod.strings = {
	--[[
		Shorten string
	--]]
	shorten = function(str)
		if string.len(str) >= mod.chat.NAME_LENGTH then
			return string.sub(str, 1, mod.chat.NAME_LENGTH)
		end
		return str
	end,
	--[[
		Check if objects are strings
		Returns first string
	--]]
	check = function(strings, default)
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
	end,
}

mod.players = {
	interval = 3,
	updated = 0,
	--[[
		Get a generic character name
	--]]
	unit_name = function(unit_name)
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
	end,
	--[[
		Get player name from index
	--]]
	set_names = function()
		local player_manager = Managers.player
		local players = player_manager:human_and_bot_players()
		local i = 1
		for _, player in pairs(players) do
			local name = mod.strings.check({player._cached_name, mod.players.unit_name(player.player_name)}) or "N/A"
			mod:update_setting_text("chat_damage_player_"..tostring(i), name)
			mod:update_setting_text("chat_ammo_player_"..tostring(i), name)
			mod:update_setting_text("chat_heal_player_"..tostring(i), name)
			mod:update_setting_text("floating_numbers_player_"..tostring(i), name)
			mod:update_setting_text("floating_heal_player_"..tostring(i), name)
			mod:update_setting_text("floating_ammo_player_"..tostring(i), name)
			i = i + 1
		end
		for j = i, 4 do
			mod:update_setting_text("chat_damage_player_"..tostring(j), "N/A")
			mod:update_setting_text("chat_ammo_player_"..tostring(j), "N/A")
			mod:update_setting_text("chat_heal_player_"..tostring(j), "N/A")
			mod:update_setting_text("floating_numbers_player_"..tostring(j), "N/A")
			mod:update_setting_text("floating_heal_player_"..tostring(i), "N/A")
			mod:update_setting_text("floating_ammo_player_"..tostring(i), "N/A")
		end
	end,
	--[[
		Check if unit is player unit
	--]]
	is_player_unit = function(unit)
		return DamageUtils.is_player_unit(unit)
	end,
	--[[
		Get player from player unit
	--]]
	from_player_unit = function(player_unit)
		local player_manager = Managers.player
		local players = player_manager:human_and_bot_players()
		for _, player in pairs(players) do
			if player.player_unit == player_unit then
				return player
			end
		end
		return nil
	end,
	--[[
		Check if unit is local player
	--]]
	is_local_player = function(self, unit)
		local local_player = Managers.player:local_player()
		if unit == local_player.player_unit then
			return true
		end
		return false
	end,
}

-- ##### ███████╗██╗  ██╗██╗███████╗██╗     ██████╗ ███████╗ ##########################################################
-- ##### ██╔════╝██║  ██║██║██╔════╝██║     ██╔══██╗██╔════╝ ##########################################################
-- ##### ███████╗███████║██║█████╗  ██║     ██║  ██║███████╗ ##########################################################
-- ##### ╚════██║██╔══██║██║██╔══╝  ██║     ██║  ██║╚════██║ ##########################################################
-- ##### ███████║██║  ██║██║███████╗███████╗██████╔╝███████║ ##########################################################
-- ##### ╚══════╝╚═╝  ╚═╝╚═╝╚══════╝╚══════╝╚═════╝ ╚══════╝ ##########################################################
--[[
	Check if attacker in backstab relation
--]]
mod.check_backstab = function(self, attacker, target)
	if Unit.alive(attacker) and Unit.alive(target) then
		local ax, ay, az = Quaternion.to_euler_angles_xyz(Unit.world_rotation(attacker, 0))
		local tx, ty, tz = Quaternion.to_euler_angles_xyz(Unit.world_rotation(target, 0))
		local diff = tz - az
		if diff > -120 and diff < 120 then
			return true
		end
	end
	return false
end
--[[
	Check if a hit was blocked by a shield
--]]
mod.blocked_hit = function(self, attacker_unit, unit, hit_zone)
	if attacker_unit then
		local hit_zones = {"left_arm", "torso", "left_leg"}
		local more_rat_weapons = get_mod("MoreRatWeapons")
		if more_rat_weapons then
			hit_zones = more_rat_weapons.shield_data.hit_zones
			self.check_backstab = more_rat_weapons.check_backstab
		end

		if unit and Unit.has_data(unit, "breed") and ScriptUnit.has_extension(unit, "ai_inventory_system") then
			local inventory_extension = ScriptUnit.extension(unit, "ai_inventory_system")
			local inv_template = inventory_extension.inventory_configuration_name

			if inv_template == "sword_and_shield" and not inventory_extension.already_dropped_shield then
				if table.contains(hit_zones, hit_zone) and not self:check_backstab(attacker_unit, unit) then
					return true
				end
			end
		end
	end
	return false
end

-- ##### ███████╗██╗      ██████╗  █████╗ ████████╗██╗███╗   ██╗ ██████╗  #############################################
-- ##### ██╔════╝██║     ██╔═══██╗██╔══██╗╚══██╔══╝██║████╗  ██║██╔════╝  #############################################
-- ##### █████╗  ██║     ██║   ██║███████║   ██║   ██║██╔██╗ ██║██║  ███╗ #############################################
-- ##### ██╔══╝  ██║     ██║   ██║██╔══██║   ██║   ██║██║╚██╗██║██║   ██║ #############################################
-- ##### ██║     ███████╗╚██████╔╝██║  ██║   ██║   ██║██║ ╚████║╚██████╔╝ #############################################
-- ##### ╚═╝     ╚══════╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝  #############################################

local function inOutQuad(t, b, c, d)
	t = t / d * 2
	if t < 1 then
		return c / 2 * math.pow(t, 2) + b
	else
		return -c / 2 * ((t - 1) * (t - 3) - 1) + b
	end
end

mod.floating = {
	corpses = {},
	units = {},
	delete = {},
	fade_time = 2,
	pop_time = 0.5,
	definition = {
		-- Data
		damage = 0,
		color = nil,
		timer = 0,
		blocked = false,
		icon = "",
		pop = 0,
		-- Movement
		position = nil,
		horizontal_random = 0,
		horizontal = 0,
		vertical_random = 0,
		vertical = 0,
		-- Font
		font_name,
		font_material,
		font_size,
	},
	horizontal_min = -100,
	horizontal_max = 100,
	vertical_min = 50,
	vertical_max = 100,
	--[[
		Floating number fonts
	--]]
	fonts = function(self, size)
		if size == nil then size = 20 end
		if mod:get("floating_numbers_render") == 1 then		
			if size >= 32 then
				return "gw_head_32", "materials/fonts/gw_head_32", size
			else
				return "gw_head_20", "materials/fonts/gw_head_32", size
			end
		else
			if size > 32 then
				return "gw_body_20", "materials/fonts/gw_body_64", size
			else
				return "gw_body_20", "materials/fonts/gw_body_32", size
			end
		end
	end,
	--[[
		Show heal number
	--]]
	trigger_heal = function(self, attacker_unit, unit, healed)
		--mod:add_unit(unit)
		-- local color = {255, 56, 255, 56}
		if mod:get("floating_heal_source") == 1 then
			self:local_player(attacker_unit, unit, false, healed.amount, healed, nil, "", false)
		elseif mod:get("floating_heal_source") == 2 then
			self:all(attacker_unit, unit, false, healed.amount, healed, nil, "", false)
		elseif mod:get("floating_heal_source") == 3 then
			self:custom(attacker_unit, unit, false, healed.amount, healed, nil, "", false)
		end
	end,
	--[[
		Show ammo number
	--]]
	trigger_ammo = function(self, attacker_unit, unit, ammo)
		--mod:add_unit(unit)
		-- local color = {255, 255, 255, 0}
		if mod:get("floating_ammo_source") == 1 then
			self:local_player(attacker_unit, unit, false, ammo.amount, nil, ammo, "", false)
		elseif mod:get("floating_ammo_source") == 2 then
			self:all(attacker_unit, unit, false, ammo.amount, nil, ammo, "", false)
		elseif mod:get("floating_ammo_source") == 3 then
			self:custom(attacker_unit, unit, false, ammo.amount, nil, ammo, "", false)
		end
	end,
	--[[
		Post message for local player
	--]]
	local_player = function(self, attacker_unit, unit, dead, damage_amount, healed, ammo, hit_zone_name, blocked, poison, burn)
		local local_player = Managers.player:local_player()
		if attacker_unit == local_player.player_unit and (not self.corpses[unit]) then
			self.units[unit][#self.units[unit]+1] = self:new(unit, dead, damage_amount, healed, ammo, hit_zone_name, blocked, poison, burn)
		end
	end,
	--[[
		Post message for every player
	--]]
	all = function(self, attacker_unit, unit, dead, damage_amount, healed, ammo, hit_zone_name, blocked, poison, burn)
		if mod.players.is_player_unit(attacker_unit) and (not self.corpses[unit]) then
			self.units[unit][#self.units[unit]+1] = self:new(unit, dead, damage_amount, healed, ammo, hit_zone_name, blocked, poison, burn)
		end
	end,
	--[[
		Post message for custom chosen player
	--]]
	custom = function(self, attacker_unit, unit, dead, damage_amount, healed, ammo, hit_zone_name, blocked, poison, burn)
		if mod.players.is_player_unit(attacker_unit) then
			local player_manager = Managers.player
			local players = player_manager:human_and_bot_players()
			local i = 1
			for _, p in pairs(players) do
				local setting = "floating_numbers_player_"..tostring(i)
				if healed then
					setting = "floating_heal_player_"..tostring(i)
				elseif ammo then
					setting = "floating_ammo_player_"..tostring(i)
				end
				if mod:get(setting) then
					if attacker_unit == p.player_unit and (not self.corpses[unit]) then

						self.units[unit][#self.units[unit]+1] = self:new(unit, dead, damage_amount, healed, ammo, hit_zone_name, blocked, poison, burn)
					end
				end
				i = i + 1
			end
		end
	end,
	--[[
		Check if unit present in floating numbers system
	--]]
	has_unit = function(self, unit)
		return self.units[unit] ~= nil
	end,
	--[[
		Create new number entry
	--]]
	new = function(self, unit, dead, damage, healed, ammo, hit_zone_name, blocked, poison, burn)
		local unit_dmg = table.clone(self.definition)
		-- Data
		--unit_dmg.position = Vector3Aux.box(nil, position)
		unit_dmg.position = Vector3Aux.box(nil, Unit.world_position(unit, 0))
		unit_dmg.damage = damage or 0

		local color = {255, 255, 255, 255}
		if poison then
			color = {255, 128, 0, 128}
		elseif burn then
			color = {255, 255, 165, 0}
		elseif blocked then
			color = {255, 127, 127, 127}
		elseif dead then
			color = {255, 255, 56, 56}
		elseif hit_zone_name == "head" or hit_zone_name == "neck" then
			color = {255, 255, 127, 127}
		elseif healed then
			color = {255, 56, 255, 56}
		elseif ammo then
			color = {255, 255, 255, 0}
		end
		unit_dmg.color = color

		unit_dmg.timer = mod:get_time()
		unit_dmg.blocked = blocked
		-- Movement
		unit_dmg.horizontal_random = math.random(self.horizontal_min, self.horizontal_max)
		unit_dmg.vertical_random = math.random(self.vertical_min, self.vertical_max)
		-- Fonts
		local font_name, font_material, font_size = self:fonts(30)
		-- if damage_type == "shot_sniper" then
			-- --unit_dmg.icon = "ranged"
		-- else
			-- --unit_dmg.icon = "melee"
		-- end
		if hit_zone_name == "head" or hit_zone_name == "neck" then
			font_name, font_material, font_size = self:fonts(45)
			if mod:get("floating_icons_headshot") then
				unit_dmg.icon = "melee"
				unit_dmg.pop = 2
			end
		elseif poison then
			font_name, font_material, font_size = self:fonts(20)
			if mod:get("floating_icons_poison") then
				unit_dmg.icon = "poison"
				unit_dmg.pop = 1
			end
		elseif burn then
			font_name, font_material, font_size = self:fonts(20)
			if mod:get("floating_icons_burn") then
				unit_dmg.icon = "flame"
				unit_dmg.pop = 1
			end
		elseif blocked then
			font_name, font_material, font_size = self:fonts(20)
			if mod:get("floating_icons_block") then
				unit_dmg.icon = "block"
				unit_dmg.pop = 1
			end
		elseif healed or ammo then
			font_name, font_material, font_size = self:fonts(60)
			if ammo then
				if mod:get("floating_icons_ammo") then
					unit_dmg.icon = "ranged"
					unit_dmg.pop = 2
				end
			elseif healed then
				if mod:get("floating_icons_heal") then
					unit_dmg.icon = "health"
					unit_dmg.pop = 2
				end
			end
		end
		unit_dmg.font_name = font_name
		unit_dmg.font_material = font_material
		font_size = font_size * mod:get("floating_numbers_size")
		unit_dmg.font_size = font_size

		return unit_dmg
	end,
	--[[
		Post message for player in filter file
	--]]
	handle = function(self, unit, biggest_hit, parameters)
	
		if self and unit and Unit.alive(unit) and not self:has_unit(unit) then
			mod:add_unit(unit)
		end

		if mod:get("floating_numbers") and self:has_unit(unit) then
			--local breed_data = Unit.get_data(unit, "breed")
			local attacker_unit = biggest_hit[DamageDataIndex.ATTACKER]
			local damage_amount = biggest_hit[DamageDataIndex.DAMAGE_AMOUNT]
			local hit_zone_name = biggest_hit[DamageDataIndex.HIT_ZONE]
			local damage_type = biggest_hit[DamageDataIndex.DAMAGE_TYPE]
			local dead = parameters.death
			local blocked = mod:blocked_hit(attacker_unit, unit, hit_zone_name) or damage_amount <= 0
			local poison = damage_type == "arrow_poison" or damage_type == "arrow_poison_dot"
			local burn = damage_type == "burn" or damage_type == "burninating" or damage_type == "fire_grenade_glance"
			local healed = parameters.healed
			local ammo = parameters.ammo

			-- Heal number
			if healed and mod:get("floating_heal") then
				if mod.players:is_local_player(attacker_unit) then
					self:trigger_heal(attacker_unit, unit, healed)
				else
					self:trigger_heal(attacker_unit, attacker_unit, healed)
				end
			end

			-- Ammo number
			if ammo and mod:get("floating_ammo") then
				if mod.players:is_local_player(attacker_unit) then
					self:trigger_ammo(attacker_unit, unit, ammo)
				else
					self:trigger_ammo(attacker_unit, attacker_unit, ammo)
				end
			end

			--if breed_data and
			if mod:get("floating_damage_numbers") and not healed and not ammo then
				if mod:get("floating_numbers_source") == 1 then
					self:local_player(attacker_unit, unit, dead, damage_amount, nil, nil, hit_zone_name, blocked, poison, burn)
				elseif mod:get("floating_numbers_source") == 2 then
					self:all(attacker_unit, unit, dead, damage_amount, nil, nil, hit_zone_name, blocked, poison, burn)
				elseif mod:get("floating_numbers_source") == 3 then
					self:custom(attacker_unit, unit, dead, damage_amount, nil, nil, hit_zone_name, blocked, poison, burn)
				end
			end

			if dead then
				self.corpses[unit] = true
				self.delete[unit] = unit
			end
		end
	end,
	--[[
		Render floating numbers
	--]]
	render = function(self, unit)
		if self.units[unit] ~= nil then
			if #self.units[unit] > 0 then
				local breed = Unit.get_data(unit, "breed")
				local offset = breed and breed.name and mod.enemies.offsets[breed.name] or mod.enemies.offsets.default
				local player = Managers.player:local_player()
				local world = Managers.world:world("level_world")
				local viewport = ScriptWorld.viewport(world, player.viewport_name)
				local camera = ScriptViewport.camera(viewport)
				local scale = UIResolutionScale()

				local index = 1
				for _, unit_dmg in pairs(self.units[unit]) do
					if mod:get_time() - unit_dmg.timer < self.fade_time then

						local damage = ""
						if unit_dmg.damage > 0 or unit_dmg.blocked then

							-- If damage is a integer
							if unit_dmg.damage > 0 and unit_dmg.damage == math.floor(unit_dmg.damage) then
								damage = tostring(unit_dmg.damage)
							elseif unit_dmg.damage > 0 then -- else we want the number with the 2 digits behind the dot
								damage = string.format("%.2f", unit_dmg.damage)
							end
							-- if unit_dmg.blocked then
								-- damage = "Blocked"
							-- end

							local life = (mod:get_time() - unit_dmg.timer) / self.fade_time
							local alpha = life*2
							if not mod:get("floating_numbers_fade") then
								alpha = 1
							end
							if alpha > 1 then alpha = 2 - alpha end
							local color = Color(unit_dmg.color[1] * alpha, unit_dmg.color[2], unit_dmg.color[3], unit_dmg.color[4])
							local black = Color(255 * (alpha/2), 0, 0, 0)
							local position = Unit.world_position(unit, 0)
							--local position = Vector3Aux.unbox(unit_dmg.position)
							position[3] = position[3] + offset
							local position2d, depth = Camera.world_to_screen(camera, position)
							local player_pos = ScriptCamera.position(camera)

							-- local local_player = Managers.player:local_player()
							-- local player_pos = local_player and Unit.local_position(local_player.player_unit, 0) or Vector3(0, 0, 0)

							-- local player_pos = Unit.local_position(player.player_unit, 0)
							local distance = Vector3.distance(player_pos, position) / 5
							--mod:echo("distance: "..tostring(distance))
							local horizontal = unit_dmg.horizontal_random / distance
							local vertical = unit_dmg.vertical_random / distance
							local x = inOutQuad(life, 0, horizontal, 1)
							local y = inOutQuad((life*2)-1, 0, -vertical, 1)
							local offset_vis = {x, y + vertical}
							local border = 1

							local size_pop_multiplier = 1
							if mod:get("floating_numbers_pop") then
								size_pop_multiplier = life*6
								if size_pop_multiplier > 1 then size_pop_multiplier = 2 - size_pop_multiplier end
								size_pop_multiplier = (size_pop_multiplier + 1) * unit_dmg.pop
								if size_pop_multiplier < 1 then size_pop_multiplier = 1 end
							end

							if depth < 1 or mod.players:is_local_player(unit) then
								-- local ingame_ui_exists, ingame_ui = pcall(function () return Managers.player.network_manager.matchmaking_manager.matchmaking_ui.ingame_ui end)
								-- if ingame_ui_exists then
									-- local ui_renderer = ingame_ui.ui_top_renderer
									-- if ui_renderer then
										mod:pcall(function()
											local font_size = (unit_dmg.font_size * size_pop_multiplier) * scale
											Gui.text(mod.gui, damage, unit_dmg.font_material, font_size, unit_dmg.font_name, Vector2(position2d[1]+border+offset_vis[1], position2d[2]-border+offset_vis[2]), black)
											Gui.text(mod.gui, damage, unit_dmg.font_material, font_size, unit_dmg.font_name, Vector2(position2d[1]+border+offset_vis[1], position2d[2]+border+offset_vis[2]), black)
											Gui.text(mod.gui, damage, unit_dmg.font_material, font_size, unit_dmg.font_name, Vector2(position2d[1]-border+offset_vis[1], position2d[2]-border+offset_vis[2]), black)
											Gui.text(mod.gui, damage, unit_dmg.font_material, font_size, unit_dmg.font_name, Vector2(position2d[1]-border+offset_vis[1], position2d[2]+border+offset_vis[2]), black)
											Gui.text(mod.gui, damage, unit_dmg.font_material, font_size, unit_dmg.font_name, Vector2(position2d[1]+offset_vis[1], position2d[2]+offset_vis[2]), color)
											-- local width, height, min = ui_renderer:text_size(damage, unit_dmg.font_material, font_size)
											if unit_dmg.icon ~= "" then
												local width = ((64 * mod:get("floating_numbers_size")) * scale) * size_pop_multiplier
												local height = ((64 * mod:get("floating_numbers_size")) * scale) * size_pop_multiplier
												local icon_offset = {0, 0}
												local icon_size = Vector2(width, height)

												if unit_dmg.damage > 0 then
													local min, max, caret = Gui.text_extents(mod.gui, damage, unit_dmg.font_material, font_size)
													local inv_scaling = RESOLUTION_LOOKUP.inv_scale
													local t_width = (max.x - min.x)*inv_scaling
													local t_height = ((max.y - min.y)*inv_scaling) * 0.75
													icon_size = Vector2(t_height, t_height)
													icon_offset = {t_width * scale, 0}
												end

												--local icon_pos = Vector2(position2d[1]+offset_vis[1]+icon_offset[1], position2d[2]+offset_vis[2]+icon_offset[2]) --Vector3(position2d[1]+icon_offset[1], position2d[2]+icon_offset[2], 0)
												Gui.bitmap(mod.gui, unit_dmg.icon, Vector2(position2d[1]+border+offset_vis[1]+icon_offset[1], position2d[2]-border+offset_vis[2]+icon_offset[2]), icon_size, black)
												Gui.bitmap(mod.gui, unit_dmg.icon, Vector2(position2d[1]+border+offset_vis[1]+icon_offset[1], position2d[2]+border+offset_vis[2]+icon_offset[2]), icon_size, black)
												Gui.bitmap(mod.gui, unit_dmg.icon, Vector2(position2d[1]-border+offset_vis[1]+icon_offset[1], position2d[2]-border+offset_vis[2]+icon_offset[2]), icon_size, black)
												Gui.bitmap(mod.gui, unit_dmg.icon, Vector2(position2d[1]-border+offset_vis[1]+icon_offset[1], position2d[2]+border+offset_vis[2]+icon_offset[2]), icon_size, black)
												Gui.bitmap(mod.gui, unit_dmg.icon, Vector2(position2d[1]+offset_vis[1]+icon_offset[1], position2d[2]+offset_vis[2]+icon_offset[2]), icon_size, color)
											end
										end)
									-- end
								-- end
							end
						end
					else
						table.remove(self.units[unit], index)
					end
					index = index + 1
				end
			else
				if table.contains(self.delete, unit) then
					self.units[unit] = nil
					self.corpses[unit] = nil
					self.delete[unit] = nil
				end
			end
		end
	end,
	legacy_render = function(self, unit)
		if self.units[unit] ~= nil then
			if #self.units[unit] > 0 then
				local breed = Unit.get_data(unit, "breed") or { name = "player" } -- no breed means player
				local offset = breed and breed.name and mod.enemies.offsets[breed.name] or mod.enemies.offsets.default
				local player = Managers.player:local_player()
				local world = Managers.world:world("level_world")
				local viewport = ScriptWorld.viewport(world, player.viewport_name)
				local camera = ScriptViewport.camera(viewport)

				--local color = Color(255, 255, 255, 255)
				local font, font_material, font_size = self:fonts(30)
				local scale = UIResolutionScale()

				-- local enemy_pos = Unit.world_position(unit, 0)
				-- local dmg_pos = Vector3(enemy_pos[1], enemy_pos[2], enemy_pos[3] + offset)
				-- local hp_bar_pos_2d = Camera.world_to_screen(camera, dmg_pos)

				--EchoConsole(string.format("x=%i;y=%i", hp_bar_pos_2d[1], hp_bar_pos_2d[2]))
				local index = 1
				local visibility_offset = 0
				for _, unit_dmg in pairs(self.units[unit]) do
					if mod:get_time() - unit_dmg.timer < self.fade_time then
						if unit_dmg.damage > 0 then
							local damage = tostring(unit_dmg.damage)
							local life = (mod:get_time() - unit_dmg.timer) / self.fade_time
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
							local font_size = unit_dmg.font_size < 30 and 20 or 30
							local scaled_font_size = (unit_dmg.healed or unit_dmg.ammo) and font_size*1.3 or (unit_dmg.ff or unit_dmg.received_dmg) and font_size*1.4 or font_size
							if depth < 1 then	
								Gui.text(mod.gui, damage, font_material, scaled_font_size, font, Vector2(position2d[1]+2 + offset_vis[1], position2d[2]-2 + offset_vis[2] + offset_height), black)
								Gui.text(mod.gui, damage, font_material, scaled_font_size, font, Vector2(position2d[1]+2 + offset_vis[1], position2d[2]+2 + offset_vis[2] + offset_height), black)
								Gui.text(mod.gui, damage, font_material, scaled_font_size, font, Vector2(position2d[1]-2 + offset_vis[1], position2d[2]-2 + offset_vis[2] + offset_height), black)
								Gui.text(mod.gui, damage, font_material, scaled_font_size, font, Vector2(position2d[1]-2 + offset_vis[1], position2d[2]+2 + offset_vis[2] + offset_height), black)
								Gui.text(mod.gui, damage, font_material, scaled_font_size, font, Vector2(position2d[1] + offset_vis[1], position2d[2] + offset_vis[2] + offset_height), color)

								visibility_offset = visibility_offset + 1
								if visibility_offset > 4 then visibility_offset = 0 end
							end
						end
					else
						table.remove(self.units[unit], index)
					end
					index = index + 1
				end
			else
				if table.contains(self.delete, unit) then
					self.units[unit] = nil
					self.corpses[unit] = nil
					self.delete[unit] = nil
				end
			end
		end
	end,
}

-- #####  ██████╗██╗  ██╗ █████╗ ████████╗ ############################################################################
-- ##### ██╔════╝██║  ██║██╔══██╗╚══██╔══╝ ############################################################################
-- ##### ██║     ███████║███████║   ██║    ############################################################################
-- ##### ██║     ██╔══██║██╔══██║   ██║    ############################################################################
-- ##### ╚██████╗██║  ██║██║  ██║   ██║    ############################################################################
-- #####  ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ############################################################################
mod.chat = {
	units = {},
	NAME_LENGTH = 20,
	--[[
		Post healed message
	--]]
	trigger_heal = function(self, attacker_unit, healed)
		if mod:get("chat_heal_source") == 1 then
			self:local_player(attacker_unit, nil, nil, false, nil, healed)
		elseif mod:get("chat_heal_source") == 2 then
			self:all(attacker_unit, nil, nil, false, nil, healed)
		elseif mod:get("chat_heal_source") == 3 then
			self:custom(attacker_unit, nil, nil, false, nil, healed)
		end
	end,
	--[[
		Post ammo message
	--]]
	trigger_ammo = function(self, attacker_unit, ammo)
		if mod:get("chat_ammo_source") == 1 then
			self:local_player(attacker_unit, nil, nil, false, nil, nil, ammo)
		elseif mod:get("chat_ammo_source") == 2 then
			self:all(attacker_unit, nil, nil, false, nil, nil, ammo)
		elseif mod:get("chat_ammo_source") == 3 then
			self:custom(attacker_unit, nil, nil, false, nil, nil, ammo)
		end
	end,
	--[[
		Handle a hit reaction chat output
	--]]
	handle = function(self, unit, biggest_hit, parameters)
		--if mod:get("chat_mode") > 1 and table.has_item2(mod.chat.units, unit) then
		if mod:get("chat_output") and self:has_unit(unit) then

			-- Get data
			local breed_data = Unit.get_data(unit, "breed")
			local attacker_unit = biggest_hit[DamageDataIndex.ATTACKER]
			local damage_amount = biggest_hit[DamageDataIndex.DAMAGE_AMOUNT]
			local hit_zone_name = biggest_hit[DamageDataIndex.HIT_ZONE]
			local unit_is_dead = parameters.death
			local healed = parameters.healed
			local ammo = parameters.ammo

			-- Post option specific message
			if mod:get("chat_mode") == 4 then
				hit_zone_name = nil
			end

			if healed and mod:get("chat_heal") then
				self:trigger_heal(attacker_unit, healed)
			end
			if ammo and mod:get("chat_ammo") then
				self:trigger_ammo(attacker_unit, ammo)
			end

			if breed_data and mod:get("chat_damage") then
				if mod:get("chat_damage_source") == 1 and (mod:get("chat_mode") == 2 or unit_is_dead) then
					self:local_player(attacker_unit, damage_amount, hit_zone_name, unit_is_dead, breed_data.name)
				elseif mod:get("chat_damage_source") == 2 and (mod:get("chat_mode") == 2 or unit_is_dead) then
					self:all(attacker_unit, damage_amount, hit_zone_name, unit_is_dead, breed_data.name)
				elseif mod:get("chat_damage_source") == 3 and (mod:get("chat_mode") == 2 or unit_is_dead) then
					self:custom(attacker_unit, damage_amount, hit_zone_name, unit_is_dead, breed_data.name)
				end
			end

			-- If unit dead remove from system
			if unit_is_dead then
				--self.units[unit] = nil
			end

		end
	end,
	--[[
		Check if unit present in floating numbers system
	--]]
	has_unit = function(self, unit)
		return self.units[unit] ~= nil
	end,
	--[[
		Post message for local player
	--]]
	local_player = function(self, attacker_unit, damage_amount, hit_zone, dead, breed, healed, ammo)
		local local_player = Managers.player:local_player()
		if attacker_unit == local_player.player_unit then
			local name = mod.strings.check({local_player._cached_name, mod.players.unit_name(local_player.player_name)})
			self:post(name, damage_amount, hit_zone, dead, breed, healed, ammo)
		end
	end,
	--[[
		Post message for every player
	--]]
	all = function(self, attacker_unit, damage_amount, hit_zone, dead, breed, healed, ammo)
		if mod.players.is_player_unit(attacker_unit) then
			local player = mod.players.from_player_unit(attacker_unit)
			local name = mod.strings.check({player._cached_name, mod.players.unit_name(player.player_name)})
			self:post(name, damage_amount, hit_zone, dead, breed, healed, ammo)
		end
	end,
	--[[
		Post message for custom chosen player
	--]]
	custom = function(self, attacker_unit, damage_amount, hit_zone, dead, breed, healed, ammo)
		if mod.players.is_player_unit(attacker_unit) then
			local player_manager = Managers.player
			local players = player_manager:human_and_bot_players()
			local player = mod.players.from_player_unit(attacker_unit)
			local name = mod.strings.check({player._cached_name, mod.players.unit_name(player.player_name)})
			local i = 1
			for _, p in pairs(players) do
				if mod:get("chat_damage_player_"..tostring(i)) then
					if attacker_unit == p.player_unit then
						self:post(name, damage_amount, hit_zone, dead, breed, healed, ammo)
					end
				end
				i = i + 1
			end
		end
	end,
	--[[
		Generic post message
	--]]
	post = function(self, name, damage, hit_zone, dead, breed, healed, ammo)
		-- local onlysend = false
		local breed_name = mod.enemies.breed_names[breed]
		local hit_zone_name = mod.enemies.hit_zones[hit_zone]
		--local message = string.format("%s %i dmg", name, damage)
		local message = string.format("%s", name)

		-- Hit / Kill
		if dead then
			message = string.format("%s killed", message)
		elseif damage then
			message = string.format("%s hit", message)
		end

		-- Damage
		if damage ~= nil then
			message = string.format("%s ( %i )", message, damage)
		end

		-- Breed
		if breed_name ~= nil then
			--if table.has_item2(mod.enemies.specials, breed) then
			if table.contains(mod.enemies.specials, breed) then
				message = string.format("%s a ~ %s ~", message, breed_name)
			else
				message = string.format("%s a %s", message, breed_name)
			end
		elseif damage then
			message = string.format("%s an enemy", message)
		end

		-- Add hitzone
		if mod:get("chat_hit_zone") and hit_zone_name ~= nil then
			message = string.format("%s ( %s )", message, hit_zone_name)
		end

		-- Add kill indicator
		if mod:get("chat_kill") and dead then
			message = string.format("%s ( Kill )", message)
		end

		if healed then
			message = string.format("%s restored %i health", message, healed.amount)
		end

		if ammo then
			message = string.format("%s retrieved %i ammo", message, ammo.amount)
		end

		-- -- Try console output
		-- if mod.console.post(name, damage, hit_zone_name, dead, breed) then
			-- onlysend = true
		-- end

		-- mod.chat.send(message, onlysend)
		mod:echo(message)
	end,
}

-- ##### ██████╗ ██╗   ██╗███████╗███████╗███████╗ ####################################################################
-- ##### ██╔══██╗██║   ██║██╔════╝██╔════╝██╔════╝ ####################################################################
-- ##### ██████╔╝██║   ██║█████╗  █████╗  ███████╗ ####################################################################
-- ##### ██╔══██╗██║   ██║██╔══╝  ██╔══╝  ╚════██║ ####################################################################
-- ##### ██████╔╝╚██████╔╝██║     ██║     ███████║ ####################################################################
-- ##### ╚═════╝  ╚═════╝ ╚═╝     ╚═╝     ╚══════╝ ####################################################################
--[[
	Hook apply_buffs_to_value
--]]
mod:hook(BuffExtension, "apply_buffs_to_value", function(func, self, value, stat_buff)
	local amount, procced, parent_id = func(self, value, stat_buff)
	local always_proc = StatBuffApplicationMethods[stat_buff] ~= "proc"

	if procced and (stat_buff == StatBuffIndex.HEAL_PROC or
					stat_buff == StatBuffIndex.LIGHT_HEAL_PROC or
					stat_buff == StatBuffIndex.HEAVY_HEAL_PROC or
					stat_buff == StatBuffIndex.HEAL_ON_KILL) or
					(stat_buff == StatBuffIndex.HEALING_RECEIVED and always_proc) then
		local biggest_hit = {}
		biggest_hit[DamageDataIndex.ATTACKER] = (VT1 and mod.attacker_hook_data) or self._unit
		biggest_hit[DamageDataIndex.DAMAGE_AMOUNT] = amount
		biggest_hit[DamageDataIndex.HIT_ZONE] = nil
		mod.floating:handle(mod.floating_unit_hook_data, biggest_hit, {healed = {amount = amount}})
		mod.chat:handle(mod.floating_unit_hook_data, biggest_hit, {healed = {amount = amount}})
	end
	return amount, procced, parent_id
end)
mod:hook_disable(BuffExtension, "apply_buffs_to_value")
--[[
	Hook ammo buff on kill
--]]
mod:hook(GenericAmmoUserExtension, "add_ammo_to_reserve", function(func, self, amount)
	if amount then
		local biggest_hit = {}
		biggest_hit[DamageDataIndex.ATTACKER] = (VT1 and mod.attacker_hook_data) or self.owner_unit
		biggest_hit[DamageDataIndex.DAMAGE_AMOUNT] = amount
		biggest_hit[DamageDataIndex.HIT_ZONE] = nil
		mod.floating:handle(mod.floating_unit_hook_data, biggest_hit, {ammo = {amount = amount}})
		mod.chat:handle(mod.floating_unit_hook_data, biggest_hit, {ammo = {amount = amount}})
	end

	return func(self, amount)
end)
mod:hook_disable(GenericAmmoUserExtension, "add_ammo_to_reserve")
--[[
	Hook buff on attack
--]]
mod:hook(DamageUtils, "buff_on_attack", function(func, unit, hit_unit, ...)
	--info to carry in buff extension hook
	mod.attacker_hook_data = unit
	mod.floating_unit_hook_data = hit_unit
	mod:hook_enable(BuffExtension, "apply_buffs_to_value")

	local value = func(unit, hit_unit, ...)

	mod:hook_disable(BuffExtension, "apply_buffs_to_value")
	mod.floating_unit_hook_data = nil
	mod.attacker_hook_data = nil

	return value
end)

--[[
	Hook buff on kill
--]]
local DeathReactions_start_hook = function(func, unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)
	--info to carry in buff extension hooks
	mod.floating_unit_hook_data = unit
	mod.attacker_hook_data = VT1 and killing_blow[DamageDataIndex.ATTACKER]

	-- Health and mmo buffs
	mod:hook_enable(BuffExtension, "apply_buffs_to_value")
	mod:hook_enable(GenericAmmoUserExtension, "add_ammo_to_reserve")

	-- Execute orginal function
	-- cached_wall_nail_data doesn't exist in VT2, so it will be discarded
	local return_val_1, return_val_2 = func(unit, dt, context, t, killing_blow, is_server, cached_wall_nail_data)

	-- Restore functions
	mod:hook_disable(BuffExtension, "apply_buffs_to_value")
	mod:hook_disable(GenericAmmoUserExtension, "add_ammo_to_reserve")
	mod.floating_unit_hook_data = nil
	mod.attacker_hook_data = nil

	mod.floating.corpses[unit] = true
	mod.chat.units[unit] = nil

	return return_val_1, return_val_2
end

--[[
	Hook all breed templates
--]]
for breed_name, template in pairs(DeathReactions.templates) do
	if template.unit and template.husk and template.unit.start and template.husk.start then
		mod:hook(template.unit, "start", DeathReactions_start_hook)
		mod:hook(template.husk, "start", DeathReactions_start_hook)
	end
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################
--[[
	Update - Add units to system if alive
--]]
mod:hook(GenericHitReactionExtension, "update", function(func, self, unit, input, dt, context, t, ...)

	-- Add new units to process
	--if mod:is_enabled() and self.health_extension:is_alive() then
	if not mod.floating:has_unit(unit) then
		mod:add_unit(unit)
	end

	-- Render damages
	if mod:get("floating_numbers_render") == 1 then
		mod.floating:render(unit)
	else
		mod.floating:legacy_render(unit)
	end

	-- Original function
	func(self, unit, input, dt, context, t, ...)

end)
--[[
	Execute Effect - Post message and remove unit from system
--]]
mod:hook_safe(GenericHitReactionExtension, "_execute_effect", function(self, unit, effect_template_, biggest_hit, parameters)

	-- Chat output
	if mod:is_enabled() then
		mod.chat:handle(unit, biggest_hit, parameters)
	else
		if parameters.death then
			mod.chat.units[unit] = nil
		end
	end

	-- Floating numbers
	if mod:is_enabled() then
		local health_extension = self.health_extension
		local damages, num_damages = health_extension.recent_damages(health_extension)

		local damage_total = 0
		local stride = DamageDataIndex.STRIDE

		for i = 1, num_damages, stride do
			damage_total = damage_total + damages[(i + DamageDataIndex.DAMAGE_AMOUNT) - 1]
		end

		biggest_hit[DamageDataIndex.DAMAGE_AMOUNT] = damage_total
		mod.floating:handle(unit, biggest_hit, parameters)
	else
		if parameters.death then
			mod.floating.corpses[unit] = true
		end
	end

end)
if not VT1 then
	--[[
		TrainingDummyHealthExtension - Compitibility for training dummies
	--]]
	mod:hook_safe(TrainingDummyHealthExtension, "add_damage", function(self, attacker_unit, damage_amount, hit_zone_name, damage_type)

		-- Data
		local unit = self.unit
		local biggest_hit = {
			damage_amount,
			damage_type,
			attacker_unit,
			hit_zone_name,
		}
		local parameters = {}

		-- Add unit
		mod:add_unit(unit)

		-- Chat output
		if mod:is_enabled() then
			mod.chat:handle(unit, biggest_hit, parameters)
		end

		-- Floating numbers
		if mod:is_enabled() then
			mod.floating:handle(unit, biggest_hit, parameters)
		end

	end)
	--[[
		Disable default numbers
	--]]
	mod:hook(DamageNumbersUI, "event_add_damage_number", function(func, ...)
		if not mod:get("disable_default_numbers") then
			func(...)
		end
	end)
end

-- ##### ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗ #########################################################
-- ##### ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝ #########################################################
-- ##### █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗ #########################################################
-- ##### ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║ #########################################################
-- ##### ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║ #########################################################
-- ##### ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ #########################################################
--[[
	Mod Setting changed
--]]
mod.on_setting_changed = function(setting_name)
end
--[[
	Mod Suspended
--]]
mod.on_disabled = function(initial_call)
	mod:hook_enable(GenericHitReactionExtension, "update")
	mod:hook_enable(GenericHitReactionExtension, "_execute_effect")
end
--[[
	Mod Unsuspended
--]]
mod.on_enabled = function(initial_call)
end
--[[
	Mod Update - create gui
--]]
mod.update = function(dt)
	if not mod.gui and Managers.world:world("top_ingame_view") then
		mod:create_gui()
	end
end
--[[
	Delete gui on unload
--]]
mod.on_unload = function(exit_game)
	if mod.gui and Managers.world:world("top_ingame_view") then
		mod:destroy_gui()
	end
end