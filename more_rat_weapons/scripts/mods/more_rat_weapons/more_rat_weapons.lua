local mod = get_mod("MoreRatWeapons")
--[[ 
	More Rat Weapons
		- Unlocks shields for rats
		- Implements shield mechanics server-side; Only visual also possible
		- Triggers custom sounds and particle effects for shield hits
		- Unlocks player weapons for rats to use
	Issues:
		- ( Might be solved ) Unlocking of player weapons is disabled because it leads to crashes when packages are unloaded
	ToDo:
		- Network calls to trigger particle effects and shield drops
	
	Author: grasmann
	Version: 2.1.0
--]]

-- Global lists
more_rat_weapons_shielded_units = more_rat_weapons_shielded_units or {}
more_rat_weapons_ignored_units = more_rat_weapons_ignored_units or {}
more_rat_weapons_loading_packages = more_rat_weapons_loading_packages or {}
more_rat_weapons_loaded_packages = more_rat_weapons_loaded_packages or {}

-- ##### ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗ #############################################
-- ##### ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝ #############################################
-- ##### ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗ #############################################
-- ##### ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║ #############################################
-- ##### ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║ #############################################
-- ##### ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝ #############################################
local options_widgets = {
	{
		["setting_name"] = "slave_shield_chance",
		--["widget_type"] = "slider",
		["widget_type"] = "stepper",
		["text"] = "Slave Rat Shield Chance",
		["tooltip"] =  "Slave Rate Shield Chance [Server]\n" ..
			"Set the chance for slave rats to have shields.",
		--["range"] = {0, 100},
		["options"] = {
			{text = "Off", value = 0},
			{text = "Few", value = 25},
			{text = "Medium", value = 50},
			{text = "Many", value = 75},
			{text = "All", value = 100},
		},
		["default_value"] = 25,
	},
	{
		["setting_name"] = "clan_shield_chance",
		--["widget_type"] = "slider",
		["widget_type"] = "stepper",
		["text"] = "Clan Rat Shield Chance",
		["tooltip"] =  "Clan Rat Shield Chance [Server]\n" ..
			"Set the chance for clan rats to have shields.",
		--["range"] = {0, 100},
		["options"] = {
			{text = "Off", value = 0},
			{text = "Few", value = 25},
			{text = "Medium", value = 50},
			{text = "Many", value = 75},
			{text = "All", value = 100},
		},
		["default_value"] = 25,
	},
	{
		["setting_name"] = "storm_shield_chance",
		--["widget_type"] = "slider",
		["widget_type"] = "stepper",
		["text"] = "Stormvermin Shield Chance",
		["tooltip"] =  "Stormvermin Shield Chance [Server]\n" ..
			"Set the chance for stormvermin to have shields.",
		--["range"] = {0, 100},
		["options"] = {
			{text = "Off", value = 0},
			{text = "Few", value = 25},
			{text = "Medium", value = 50},
			{text = "Many", value = 75},
			{text = "All", value = 100},
		},
		["default_value"] = 25,
	},
	{
		["setting_name"] = "remove_running_attacks",
		["widget_type"] = "stepper",
		["text"] = "Remove Running Attacks",
		["tooltip"] =  "Remove Running Attacks [Server]\n" ..
			"Removes the running attacks from rats that still have their shield.",
		["options"] = {
			{text = "Off", value = false},
			{text = "On", value = true},
		},
		["default_value"] = true,
	},
	{
		["setting_name"] = "shield_mechanics",
		["widget_type"] = "stepper",
		["text"] = "Shield Mechanics",
		["tooltip"] =  "Shields Mechanics [Server]\n" ..
			"Rats can block attacks with their shields.",
		["options"] = {
			{text = "Off", value = false},
			{text = "On", value = true},
		},
		["default_value"] = false,
		["sub_widgets"] = {
			{
				["show_widget_condition"] = {2},
				["setting_name"] = "shield_type",
				["widget_type"] = "stepper",
				["text"] = "Shields Type",
				["tooltip"] =  "Shields Type [Server]\n" ..
					"Choose how the shields are implemented.\n\n" ..
					"--- Health ---\n" ..
					"Shields have a certain health depending on the difficulty\n\n" ..
					"--- Points ---\n" ..
					"Shields block a certain number of attacks depending on the difficulty\n\n" ..
					"--- Never Break ---\n" ..
					"Shields will never break",
				["options"] = {
					{text = "Health", value = 1},
					{text = "Points", value = 2},
					{text = "Never Break", value = 3},
				},
				["default_value"] = 1,
			},
			{
				["show_widget_condition"] = {2},
				["setting_name"] = "play_comments",
				["widget_type"] = "stepper",
				["text"] = "Play Armour Comments",
				["tooltip"] =  "Play Armour Comments [Server]\n" ..
					"Triggers comments about hitting armour on shield hits.",
				["options"] = {
					{text = "Off", value = false},
					{text = "On", value = true},
				},
				["default_value"] = true,
				["sub_widgets"] = {
					{
						["show_widget_condition"] = {2},
						["setting_name"] = "comment_pause",
						--["widget_type"] = "slider",
						["widget_type"] = "stepper",
						["text"] = "Pause Between Comments",
						["tooltip"] =  "Pause Between Comments [Server]\n" ..
							"Seconds between armour comments.",
						--["range"] = {10, 120},
						["options"] = {
							{text = "Very Short", value = 10},
							{text = "Short", value = 30},
							{text = "Medium", value = 60},
							{text = "Long", value = 90},
							{text = "Very Long", value = 120},
						},
						["default_value"] = 30,
					},
					{
						["show_widget_condition"] = {2},
						["setting_name"] = "comment_distance",
						--["widget_type"] = "slider",
						["widget_type"] = "stepper",
						["text"] = "Comment Distance",
						["tooltip"] =  "Comment Distance [Server]\n" ..
							"The maximum distance another hero can be away to comment.",
						--["range"] = {3, 30},
						["options"] = {
							{text = "Very Close", value = 3},
							{text = "Close", value = 8},
							{text = "Medium", value = 16},
							{text = "Far", value = 24},
							{text = "Very Far", value = 30},
						},
						["default_value"] = 10,
					},
				},
			},
			{
				["show_widget_condition"] = {2},
				["setting_name"] = "play_particle_effects",
				["widget_type"] = "stepper",
				["text"] = "Play Particle Effects",
				["tooltip"] =  "Play Particle Effects\n" ..
					"Triggers particle effects on shield hits.",
				["options"] = {
					{text = "Off", value = false},
					{text = "On", value = true},
				},
				["default_value"] = true,
			},
			{
				["show_widget_condition"] = {2},
				["setting_name"] = "play_shield_sounds",
				["widget_type"] = "stepper",
				["text"] = "Play Shield Sounds",
				["tooltip"] =  "Play Shield Sounds [Server]\n" ..
					"Triggers sound effects on shield hits.",
				["options"] = {
					{text = "Off", value = false},
					{text = "On", value = true},
				},
				["default_value"] = true,
			},
			{
				["show_widget_condition"] = {2},
				["setting_name"] = "drop_shields",
				["widget_type"] = "stepper",
				["text"] = "Physically Drop Shields",
				["tooltip"] =  "Physically Drop Shields\n" ..
					"Physically drop shields after the health is empty.",
				["options"] = {
					{text = "Off", value = false},
					{text = "On", value = true},
				},
				["default_value"] = true,
			},
		},
	},
	{
		["setting_name"] = "use_player_weapons",
		--["widget_type"] = "stepper",
		["widget_type"] = "checkbox",
		["text"] = "Rats Use Player Weapons",
		["tooltip"] =  "Rats Use Player Weapons [Local]\n" ..
			"Randomly give rats player weapons.",
		-- ["options"] = {
			-- {text = "Off", value = false},
			-- {text = "On", value = true},
		-- },
		["default_value"] = false,
		["sub_widgets"] = {
			{
				["setting_name"] = "player_weapons_count",
				["widget_type"] = "stepper",
				["text"] = "Weapon Count",
				["tooltip"] =  "Weapon Count [Local]\n" ..
					"How many player weapons should be loaded and used?\n\n" ..
					"--- Default ---\n" ..
					"17 Weapons and 4 Shields.\n" ..
					"--- More 1 ---\n" ..
					"34 Weapons and 10 Shields.\n" ..
					"--- More 2 ---\n" ..
					"49 Weapons and 10 Shields.\n" ..
					"--- More 3 ---\n" ..
					"64 Weapons and 10 Shields.\n" ..
					"--- More 4 ---\n" ..
					"77 Weapons and 10 Shields.\n" ..
					"--- More 5 ---\n" ..
					"90 Weapons and 10 Shields.\n" ..
					"--- More 6 ---\n" ..
					"101 Weapons and 10 Shields.\n",
				["value_type"] = "number",
				["options"] = {
					{text = "Default", value = 1},
					{text = "More 1", value = 2},
					{text = "More 2", value = 3},
					{text = "More 3", value = 4},
					{text = "More 4", value = 5},
					{text = "More 5", value = 6},
					{text = "More 6", value = 7},
				},
				["default_value"] = 1,
			},
		},
	},
}

-- ##### ██████╗  █████╗ ████████╗ █████╗ #############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################
mod.first_load_of_packages = false
--[[
	Shield data
--]]
mod.shield_data = {
	hit_zones = {"left_arm", "torso", "left_leg"},
	health = {1, 3, 6, 12, 20},
	points = {1, 2, 3, 4, 5},
	distance = {
		near = 4,
		medium = 12,
		far = 25,
	},
	sounds = {
		loud = {"shield_hit", "shield_hit_armour"},
		medium = {"fire_hit_armour", "stab_hit_armour", "slashing_hit_armour"},
		quiet = {"blunt_hit", "blunt_hit_armour"},
	},
	inventory_config = {
		skaven_slave = "slave_shield",
		skaven_clan_rat = "clan_shield",
		skaven_storm_vermin = "halberd_and_shield",
		skaven_storm_vermin_commander = "halberd_and_shield",
	},
}
--[[
	Dialog data
--]]
mod.dialogue = {
	t = 0,
	armor = {
		witch_hunter = {
			bright_wizard = "pwh_gameplay_armoured_enemy_bright_wizard",
			dwarf_ranger = "pwh_gameplay_armoured_enemy_dwarf",
			way_watcher = "pwh_gameplay_armoured_enemy_wood_elf",
			empire_soldier = "pwh_gameplay_armoured_enemy_empire_soldier",
		},
		bright_wizard = {
			witch_hunter = "pbw_gameplay_armoured_enemy_witch_hunter",
			dwarf_ranger = "pbw_gameplay_armoured_enemy_dwarf",
			way_watcher = "pbw_gameplay_armoured_enemy_wood_elf",
			empire_soldier = "pbw_gameplay_armoured_enemy_empire_soldier",
		},
		dwarf_ranger = {
			witch_hunter = "pdr_gameplay_armoured_enemy_witch_hunter",
			bright_wizard = "pdr_gameplay_armoured_enemy_bright_wizard",
			way_watcher = "pdr_gameplay_armoured_enemy_wood_elf",
			empire_soldier = "pdr_gameplay_armoured_enemy_empire_soldier",
		},
		way_watcher = {
			witch_hunter = "pwe_gameplay_armoured_enemy_witch_hunter",
			bright_wizard = "pwe_gameplay_armoured_enemy_bright_wizard",
			dwarf_ranger = "pwe_gameplay_armoured_enemy_dwarf_ranger",
			empire_soldier = "pwe_gameplay_armoured_enemy_empire_soldier",
		},
		empire_soldier = {
			witch_hunter = "pes_gameplay_armoured_enemy_witch_hunter",
			bright_wizard = "pes_gameplay_armoured_enemy_bright_wizard",
			way_watcher = "pes_gameplay_armoured_enemy_wood_elf",
			dwarf_ranger = "pes_gameplay_armoured_enemy_dwarf_ranger",
		},
	},
}
--[[
	Slave inventory
--]]
InventoryConfigurations.slave_shield = table.clone(InventoryConfigurations.sword_and_shield)
InventoryConfigurations.slave_shield.items[1] = InventoryConfigurations.sword_and_shield.items[1]
InventoryConfigurations.slave_shield.items[2] = {
	InventoryConfigurations.sword_and_shield.items[2][1],
	InventoryConfigurations.sword_and_shield.items[2][4],
	InventoryConfigurations.sword_and_shield.items[2][7],
	name = "shield",
	count = 3,
}
--[[
	Clan inventory
--]]
InventoryConfigurations.clan_shield = table.clone(InventoryConfigurations.sword_and_shield)
InventoryConfigurations.clan_shield.items[1] = InventoryConfigurations.sword_and_shield.items[1]
InventoryConfigurations.clan_shield.items[2] = {
	InventoryConfigurations.sword_and_shield.items[2][1],
	InventoryConfigurations.sword_and_shield.items[2][3],
	InventoryConfigurations.sword_and_shield.items[2][4],
	InventoryConfigurations.sword_and_shield.items[2][5],
	InventoryConfigurations.sword_and_shield.items[2][7],
	name = "shield",
	count = 5,
}
--[[
	Stormvermin inventory
--]]
InventoryConfigurations.halberd_and_shield = table.clone(InventoryConfigurations.sword_and_shield)
InventoryConfigurations.halberd_and_shield.items[1] = InventoryConfigurations.halberd.items[1]
InventoryConfigurations.halberd_and_shield.items[2] = {
	InventoryConfigurations.sword_and_shield.items[2][2],
	InventoryConfigurations.sword_and_shield.items[2][3],
	InventoryConfigurations.sword_and_shield.items[2][6],
	name = "shield",
	count = 3,
}

-- ##### ████████╗██████╗ ██╗ ██████╗  ██████╗ ███████╗██████╗ ███████╗ ###############################################
-- ##### ╚══██╔══╝██╔══██╗██║██╔════╝ ██╔════╝ ██╔════╝██╔══██╗██╔════╝ ###############################################
-- #####    ██║   ██████╔╝██║██║  ███╗██║  ███╗█████╗  ██████╔╝███████╗ ###############################################
-- #####    ██║   ██╔══██╗██║██║   ██║██║   ██║██╔══╝  ██╔══██╗╚════██║ ###############################################
-- #####    ██║   ██║  ██║██║╚██████╔╝╚██████╔╝███████╗██║  ██║███████║ ###############################################
-- #####    ╚═╝   ╚═╝  ╚═╝╚═╝ ╚═════╝  ╚═════╝ ╚══════╝╚═╝  ╚═╝╚══════╝ ###############################################
--[[
	Play shield sound for all players
--]]
mod.play_shield_sound = function(self, unit)
	if unit and ScriptUnit.has_extension(unit, "ai_inventory_system") and AiUtils.unit_alive(unit) then
		local event_pos = Unit.local_position(unit, 0)
		local players = Managers.player:human_players()
		local network_manager = Managers.state.network
		local unit_id = network_manager.unit_game_object_id(network_manager, unit)
		for _, player in pairs(players) do
			if player and player.player_unit then
				local player_pos = Unit.local_position(player.player_unit, 0)
				local distance = Vector3.distance(player_pos, event_pos)
				if distance <= self.shield_data.distance.far then
					local event_name = self.shield_data.sounds.quiet[math.random(1, #self.shield_data.sounds.quiet)]
					if distance <= self.shield_data.distance.near then
						event_name = self.shield_data.sounds.loud[math.random(1, #self.shield_data.sounds.loud)]
					elseif distance <= self.shield_data.distance.medium then
						event_name = self.shield_data.sounds.medium[math.random(1, #self.shield_data.sounds.medium)]
					end
					network_manager.network_transmit:send_rpc("rpc_server_audio_event_at_pos", player.peer_id, NetworkLookup.sound_events[event_name], event_pos)
				end
			end
		end
	end
end
--[[
	Play shield particle effect for all players
--]]
mod.play_shield_particle = function(self, unit, damage_direction)
	if unit and ScriptUnit.has_extension(unit, "ai_inventory_system") and AiUtils.unit_alive(unit) then
		local players = Managers.player:players()
		local network_manager = Managers.state.network
		local unit_id = network_manager.unit_game_object_id(network_manager, unit)
		-- Local
		local local_player = Managers.player:local_player()
		mod:execute_particle_effect(unit_id)
		-- Network
		for _, player in pairs(players) do
			if player ~= local_player then
				--Mods.network.send_rpc("rpc_mrw_play_particle", player.peer_id, unit_id)
			end
		end
	end
end
--[[
	Play shield particle that works with unmodded clients
	Send to self because if server it will spread to clients
--]]
mod.play_unmodded_shield_particle = function(self, unit, damage_direction)
	local network_manager = Managers.state.network
	local local_player = Managers.player:local_player()
	local go_id, is_level_unit = Managers.state.network:game_object_or_level_id(unit)
	local effect_name = "fx/bullet_sand"
	local effect_id = NetworkLookup.effects[effect_name]
	local node_id = Unit.node(unit, "j_leftweaponattach")
	local pos_offset = Vector3(0,0,0)
	local rot_offset = Quaternion.identity()
	network_manager.network_transmit:send_rpc("rpc_play_particle_effect", local_player.peer_id, effect_id, go_id, node_id, pos_offset, rot_offset, true)
end
--[[
	Drop shield for all players
--]]
mod.drop_shield = function(self, unit, damage_direction)
	local players = Managers.player:players()
	local network_manager = Managers.state.network
	local unit_id = network_manager.unit_game_object_id(network_manager, unit)
	if unit and ScriptUnit.has_extension(unit, "ai_inventory_system") and AiUtils.unit_alive(unit) then
		local inventory_extension = ScriptUnit.extension(unit, "ai_inventory_system")
		if inventory_extension.shield_health <= 0 and not inventory_extension.already_dropped_shield then
			network_manager.network_transmit:send_rpc_all("rpc_ai_show_single_item", unit_id, 2, false)
			local direction = {damage_direction[1], damage_direction[2], damage_direction[3]}
			-- Local
			local local_player = Managers.player:local_player()
			mod:execute_drop_shield(unit_id, direction)
			-- Network
			for _, player in pairs(players) do
				if player ~= local_player then
					--Mods.network.send_rpc("rpc_mrw_drop_shield", player.peer_id, unit_id, direction)
				end
			end
		end
	end
end

-- ##### ██████╗ ██╗ █████╗ ██╗      ██████╗  ██████╗ ██╗   ██╗███████╗ ###############################################
-- ##### ██╔══██╗██║██╔══██╗██║     ██╔═══██╗██╔════╝ ██║   ██║██╔════╝ ###############################################
-- ##### ██║  ██║██║███████║██║     ██║   ██║██║  ███╗██║   ██║█████╗   ###############################################
-- ##### ██║  ██║██║██╔══██║██║     ██║   ██║██║   ██║██║   ██║██╔══╝   ###############################################
-- ##### ██████╔╝██║██║  ██║███████╗╚██████╔╝╚██████╔╝╚██████╔╝███████╗ ###############################################
-- ##### ╚═════╝ ╚═╝╚═╝  ╚═╝╚══════╝ ╚═════╝  ╚═════╝  ╚═════╝ ╚══════╝ ###############################################
--[[
	Get dialog event index in case of multiple
--]]
local temp_rand_table = {}
local function get_dialogue_event_index(dialogue)
	local randomize_indexes = dialogue.randomize_indexes

	if randomize_indexes then
		local sound_events_n = dialogue.sound_events_n
		local randomize_indexes_n = dialogue.randomize_indexes_n

		if randomize_indexes_n == 0 then
			for i = 1, sound_events_n, 1 do
				temp_rand_table[i] = i
			end

			local sound_events = dialogue.sound_events

			for i = 1, sound_events_n, 1 do
				local rand = math.random(1, (sound_events_n + 1) - i)
				local val = table.remove(temp_rand_table, rand)
				randomize_indexes[i] = val
			end

			dialogue.randomize_indexes_n = sound_events_n - 1
			local index = randomize_indexes[sound_events_n]

			return index
		else
			dialogue.randomize_indexes_n = randomize_indexes_n - 1
			local index = randomize_indexes[randomize_indexes_n]

			return index
		end
	else
		return 1
	end

	return 
end
--[[
	Find players near unit
--]]
mod.players_near_unit = function(self, unit)
	local players_near = {}
	local players = Managers.player:human_and_bot_players()
	local event_pos = Unit.world_position(unit, 0)
	for _, player in pairs(players) do
		if player and player.player_unit and Unit.alive(player.player_unit) then
			local position = Unit.world_position(player.player_unit, 0)
			local distance = Vector3.distance(event_pos, position)
			local max_distance = mod:get("comment_distance")
			if distance <= max_distance and player.player_unit ~= unit then
				players_near[#players_near+1] = player
			end
		end
	end
	return players_near
end
--[[
	Check if dialog mod is installed
--]]
mod.dialog_mod_installed = function(self)
	local dialog_mod = get_mod("Dialog")
	if dialog_mod and dialog_mod.play_dialogue then
		return true
	end
	return false
end
--[[
	Play dialogue
--]]
mod.play_dialogue = function(self, player, t)
	-- Check dialogue time
	local pause = mod:get("comment_pause")
	if player.player_unit and self.dialogue.t + pause < t then
		local profile_synchronizer = Managers.state.network.profile_synchronizer
		local entity_manager = Managers.state.entity
		local network_manager = Managers.state.network
		local profile_index = profile_synchronizer:profile_by_peer(player:network_id(), player:local_player_id())
		local profile_name = SPProfiles[profile_index].unit_name
		local other_players = self:players_near_unit(player.player_unit)
		if other_players and #other_players > 0 then
			local rand = math.random(1, #other_players)
			local other_player = other_players[rand]
			
			if other_player and other_player.player_unit and ScriptUnit.has_extension(other_player.player_unit, "dialogue_system") then
				-- Try to let dialog mod play the dialog
				if mod:dialog_mod_installed() then
					local other_profile_index = profile_synchronizer:profile_by_peer(other_player:network_id(), other_player:local_player_id())
					local other_profile_name = SPProfiles[other_profile_index].unit_name
					local dialogue_name = self.dialogue.armor[other_profile_name][profile_name]
					local dialog_mod = get_mod("Dialog")
					if dialog_mod and dialog_mod:play_dialogue(other_player.player_unit, dialogue_name) then
						self.dialogue.t = t
					end
				else
					local dialogue_system = entity_manager.system(entity_manager, "dialogue_system")
					local dialogue_extension = dialogue_system.unit_extension_data[other_player.player_unit]
					if dialogue_extension and dialogue_extension.last_query then
						-- Dialogue id
						local other_profile_index = profile_synchronizer:profile_by_peer(other_player:network_id(), other_player:local_player_id())
						local other_profile_name = SPProfiles[other_profile_index].unit_name
						local dialogue_name = self.dialogue.armor[other_profile_name][profile_name]
						local dialogue_id = NetworkLookup.dialogues[dialogue_name]
						
						-- Speaking unit
						local go_id, is_level_unit = Managers.state.network:game_object_or_level_id(other_player.player_unit)
						
						-- Dialogue index
						local dialogue = dialogue_system.dialogues[dialogue_name]
						local dialogue_index = get_dialogue_event_index(dialogue)
						local local_player = Managers.player:local_player()
						
						if go_id and dialogue_id and dialogue_index then
							local players = Managers.player:players()
							for _, player in pairs(players) do
								
								if player and player.player_unit and not player.is_server and dialogue_system.unit_extension_data[player.player_unit] then
									Managers.state.network.network_transmit:send_rpc(
										'rpc_play_dialogue_event', player.peer_id, go_id, is_level_unit, dialogue_id, dialogue_index)
								end
							end
							self.dialogue.t = t
						end
					end
				end
			end
		end
	end
end

-- ##### ███████╗██╗  ██╗██╗███████╗██╗     ██████╗     ███╗   ███╗███████╗ ██████╗██╗  ██╗ █████╗ ███╗   ██╗██╗ ██████╗███████╗
-- ##### ██╔════╝██║  ██║██║██╔════╝██║     ██╔══██╗    ████╗ ████║██╔════╝██╔════╝██║  ██║██╔══██╗████╗  ██║██║██╔════╝██╔════╝
-- ##### ███████╗███████║██║█████╗  ██║     ██║  ██║    ██╔████╔██║█████╗  ██║     ███████║███████║██╔██╗ ██║██║██║     ███████╗
-- ##### ╚════██║██╔══██║██║██╔══╝  ██║     ██║  ██║    ██║╚██╔╝██║██╔══╝  ██║     ██╔══██║██╔══██║██║╚██╗██║██║██║     ╚════██║
-- ##### ███████║██║  ██║██║███████╗███████╗██████╔╝    ██║ ╚═╝ ██║███████╗╚██████╗██║  ██║██║  ██║██║ ╚████║██║╚██████╗███████║
-- ##### ╚══════╝╚═╝  ╚═╝╚═╝╚══════╝╚══════╝╚═════╝     ╚═╝     ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝ ╚═════╝╚══════╝
--[[
	Check if attacker in backstab relation
--]]
mod.check_backstab = function(self, attacker, target)
	local ax, ay, az = Quaternion.to_euler_angles_xyz(Unit.world_rotation(attacker, 0))
	local tx, ty, tz = Quaternion.to_euler_angles_xyz(Unit.world_rotation(target, 0))
	local diff = tz - az
	if diff > -120 and diff < 120 then
		return true
	end
	return false
end
--[[
	Manage server damage
--]]
mod:hook("DamageUtils.server_apply_hit", function(func, t, attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, hit_ragdoll_actor, damage_source, attack_damage_value_type, ...)
	--local args = table.pack(...)
	
	--safe_pcall(function()
		if not mod:is_suspended() and mod:get("shield_mechanics") then
			if Managers.player.is_server then
				if ScriptUnit.has_extension(hit_unit, "ai_system") and ScriptUnit.has_extension(hit_unit, "ai_inventory_system") and
						AiUtils.unit_alive(hit_unit) then
					local inventory_extension = ScriptUnit.extension(hit_unit, "ai_inventory_system")
					if inventory_extension.shield_health and inventory_extension.shield_health > 0 then

						-- Shielded region
						if table.contains(mod.shield_data.hit_zones, hit_zone_name) then
							if not mod:check_backstab(attacker_unit, hit_unit) then 
								local players = Managers.player:players()
								local network_manager = Managers.state.network
								local unit_id = network_manager.unit_game_object_id(network_manager, hit_unit)
								
								-- Play sound
								if mod:get("play_shield_sounds") then
									mod:play_shield_sound(hit_unit)
								end
								
								-- Play dialogue
								if mod:get("play_comments") then
									local player = Managers.player:owner(attacker_unit)
									if player then
										mod:play_dialogue(player, t)
									end
								end

								-- Particle
								if mod:get("play_particle_effects") then
									-- Mod particle
									mod:play_shield_particle(hit_unit, attack_direction)
									-- Unmodded particle
									mod:play_unmodded_shield_particle(hit_unit, attack_direction)
								end

								-- Damage
								if attack_damage_value_type then
									local piercing = attack_damage_value_type[2]

									local shield_damage = attack_damage_value_type[1] > 0 and attack_damage_value_type[1] or 
										attack_damage_value_type[2] > 0 and attack_damage_value_type[2] * 2 or
										attack_damage_value_type[3] > 0 and attack_damage_value_type[3] / 2 or
										attack_damage_value_type[4]
										
									if mod:get("shield_type") == 1 then
									
										if inventory_extension.shield_health > shield_damage then
											inventory_extension.shield_health = inventory_extension.shield_health - shield_damage
										else
											inventory_extension.shield_health = 0
										end
										
									elseif mod:get("shield_type") == 2 then
									
										inventory_extension.shield_health = inventory_extension.shield_health - 1
										
									end
									
									if piercing > 0 then
										attack_damage_value_type = {0, piercing / 2, 0, 0}
									else
										attack_damage_value_type = {0, 0, 0, 0}
									end
								end
								
								-- Drop shield
								mod:drop_shield(hit_unit, attack_direction)
							end
						end
					end
				end
			end
		end
		func(t, attack_template, attacker_unit, hit_unit, hit_zone_name, attack_direction, hit_ragdoll_actor, damage_source, attack_damage_value_type, ...)
	--end)
end)
--[[
	Give stormvermin, clan rats, slave rats shields
--]]
mod:hook("ConflictDirector.spawn_unit", function(func, self, breed, spawn_pos, spawn_rot, spawn_category, spawn_animation, spawn_type, inventory_template, group_data, ...)
	local ai_unit = nil
	if not mod:is_suspended() and Managers.player.is_server then
		local luck = math.random(1, 100)
		local storm_vermin = breed.name == "skaven_storm_vermin" or breed.name == "skaven_storm_vermin_commander"
		if storm_vermin and luck <= mod:get("storm_shield_chance") then
			ai_unit = func(self, breed, spawn_pos, spawn_rot, spawn_category, spawn_animation, spawn_type, "sword_and_shield", group_data, ...)
		elseif breed.name == "skaven_clan_rat" and luck <= mod:get("clan_shield_chance") then
			ai_unit = func(self, breed, spawn_pos, spawn_rot, spawn_category, spawn_animation, spawn_type, "sword_and_shield", group_data, ...)
		elseif breed.name == "skaven_slave" and luck <= mod:get("slave_shield_chance") then
			ai_unit = func(self, breed, spawn_pos, spawn_rot, spawn_category, spawn_animation, spawn_type, "sword_and_shield", group_data, ...)
		end
	end
	if not ai_unit then
		ai_unit = func(self, breed, spawn_pos, spawn_rot, spawn_category, spawn_animation, spawn_type, inventory_template, group_data, ...)
	end
	return ai_unit
end)
--[[
	Prevent running attack with shield
--]]
mod:hook("BTAttackAction.run", function(func, self, unit, blackboard, ...)
	--safe_pcall(function()
		if not mod:is_suspended() and mod:get("remove_running_attacks") then
			if unit and ScriptUnit.has_extension(unit, "ai_inventory_system") and AiUtils.unit_alive(unit) then
				local inventory_extension = ScriptUnit.extension(unit, "ai_inventory_system")
				if blackboard.action.moving_attack and inventory_extension.shield_health and not inventory_extension.already_dropped_shield then
					blackboard.attack_aborted = true
				end
			end
		end
	--end)
	return func(self, unit, blackboard, ...)
end)

-- ##### ██████╗ ██████╗  ██████╗     ██████╗ █████╗ ██╗     ██╗     ███████╗ #########################################
-- ##### ██╔══██╗██╔══██╗██╔════╝    ██╔════╝██╔══██╗██║     ██║     ██╔════╝ #########################################
-- ##### ██████╔╝██████╔╝██║         ██║     ███████║██║     ██║     ███████╗ #########################################
-- ##### ██╔══██╗██╔═══╝ ██║         ██║     ██╔══██║██║     ██║     ╚════██║ #########################################
-- ##### ██║  ██║██║     ╚██████╗    ╚██████╗██║  ██║███████╗███████╗███████║ #########################################
-- ##### ╚═╝  ╚═╝╚═╝      ╚═════╝     ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝ #########################################
--[[
	Play particle effect
--]]
mod.execute_particle_effect = function(self, unit_id)
	--safe_pcall(function()
		if not self:is_suspended() and self:get("play_particle_effects") then
			local network_manager = Managers.state.network
			local effect_name = "fx/hit_armored"
			local unit = network_manager.game_object_or_level_unit(network_manager, unit_id)
			if unit and ScriptUnit.has_extension(unit, "ai_inventory_system") and AiUtils.unit_alive(unit) then
				local inventory_extension = ScriptUnit.extension(unit, "ai_inventory_system")
				local shield_unit = inventory_extension.inventory_item_units[2]
				if shield_unit then
					local offset = Vector3(0,0,0)
					local rotation = Unit.local_rotation(shield_unit, 0)
					Managers.state.event:trigger("event_play_particle_effect", effect_name, shield_unit, 0, offset, rotation, false)
					--Unit.flow_event(unit, "break_shield")
				end
			end
		end
	--end)
end
-- Mods.network.register("rpc_mrw_play_particle", function(sender_peer_id, unit_id)
	-- mod:execute_particle_effect(unit_id)
-- end)
--[[
	Drop shield
--]]
mod.execute_drop_shield = function(self, unit_id, damage_direction)
	--safe_pcall(function()
		local network_manager = Managers.state.network
		local unit = network_manager.game_object_or_level_unit(network_manager, unit_id)
		if unit and ScriptUnit.has_extension(unit, "ai_inventory_system") and AiUtils.unit_alive(unit) then
			local inventory_extension = ScriptUnit.extension(unit, "ai_inventory_system")
			if inventory_extension and not inventory_extension.already_dropped_shield then
				local item_inventory_index = 2
				local item = inventory_extension.inventory_item_definitions[item_inventory_index]
				local item_unit_name = item.drop_unit_name or item.unit_name
				local item_unit = inventory_extension.inventory_item_units[item_inventory_index]
				if item_unit ~= nil then
					-- Drop shield
					if not self:is_suspended() and self:get("drop_shields") then
						local position = Unit.world_position(item_unit, 0)
						local rotation = Unit.world_rotation(item_unit, 0)
						local new_item_unit = World.spawn_unit(inventory_extension.world, item_unit_name, position, rotation, nil)

						Unit.flow_event(new_item_unit, "lua_dropped")
						local actor = Unit.create_actor(new_item_unit, "rp_dropped")
						Actor.add_angular_velocity(actor, Vector3(math.random(), math.random(), math.random())*10)
						Actor.add_velocity(actor, Vector3(damage_direction[1], damage_direction[2], 1)*5)
						
						inventory_extension:relink_visual_replacement(new_item_unit, actor, item_inventory_index, "dropped")
					end
					Unit.set_unit_visibility(item_unit, false)
					inventory_extension.already_dropped_shield = true
					self:delete_projectiles(unit)
					-- Switch to two-handed
					local breed = Unit.get_data(unit, "breed")
					if breed.name == "skaven_storm_vermin" or breed.name == "skaven_storm_vermin_commander" then
						Unit.animation_set_state(unit, 105)
					elseif breed.name == "skaven_slave" or breed.name == "skaven_clan_rat" then
						Unit.animation_set_state(unit, 375)
					end
				end
			end
		end
	--end)
end
-- Mods.network.register("rpc_mrw_drop_shield", function(sender_peer_id, unit_id, damage_direction)
	-- mod:execute_drop_shield(unit_id, damage_direction)
-- end)

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
	Link a unit
	Note: Copied from game source
--]]
local function link_unit(attachment_node_linking, world, target, source)
	for i, attachment_nodes in ipairs(attachment_node_linking) do
		local source_node = attachment_nodes.source
		local target_node = attachment_nodes.target
		local source_node_index = (type(source_node) == "string" and Unit.node(source, source_node)) or source_node
		local target_node_index = (type(target_node) == "string" and Unit.node(target, target_node)) or target_node

		World.link_unit(world, target, target_node_index, source, source_node_index)
	end

	return 
end

-- ####################################################################################################################
-- ##### AIInventoryExtension Extension ###############################################################################
-- ####################################################################################################################
--[[
	Set different inventory
--]]
AIInventoryExtension.set_inventory = function(self, inventory_template)
	local inventory_item_units_by_category = {}
	local inventory_item_units = {}
	local inventory_item_definitions = {}
	local inventory_configuration_name = inventory_template
	local unit_spawner = Managers.state.unit_spawner
	local inventory_configuration = InventoryConfigurations[inventory_configuration_name]
	local items = inventory_configuration.items
	local items_n = inventory_configuration.items_n
	
	-- Make current inventory items invisible
	for _, unit in pairs(self.inventory_item_units) do
		-- World.destroy_unit(world, unit)
		--Unit.set_unit_visibility(unit, false)
		local unit_spawner = Managers.state.unit_spawner
		if unit ~= nil and not unit_spawner:is_marked_for_deletion(unit) then --and Unit.alive(unit) then
			unit_spawner:mark_for_deletion(unit)
		end
	end
	
	local item_extension_init_data = {
		ai_inventory_item_system = {
			wielding_unit = self.unit,
		},
	}
	
	for i = 1, items_n, 1 do
		local item_category = items[i]
		local item_category_n = item_category.count
		local item_category_name = item_category.name
		local item_index = math.random(1, item_category_n)
		local item = item_category[item_index]
		local item_unit_name = item.unit_name
		local item_unit_template_name = item.unit_extension_template or "ai_inventory_item"
		item_extension_init_data.ai_inventory_item_system.drop_on_hit = item.drop_on_hit

		if item.extension_init_data then
			for data, value in pairs(item.extension_init_data) do
				item_extension_init_data[data] = value

				if data == "weapon_system" then
					item_extension_init_data[data].owner_unit = self.unit
				end
			end
		end

		local item_unit = unit_spawner.spawn_local_unit_with_extensions(unit_spawner, item_unit_name, item_unit_template_name, item_extension_init_data, nil, nil)
		local attachment_node_linking = item.attachment_node_linking

		link_unit(attachment_node_linking.unwielded, self.world, item_unit, self.unit)

		inventory_item_units[i] = item_unit
		inventory_item_units_by_category[item_category_name] = item_unit
		inventory_item_definitions[i] = item

		if script_data.ai_debug_inventory then
			printf("[AIInventorySystem] unit[%s] wielding item[%s] of category[%s] in slot[%d]", tostring(self.unit), item_unit_name, item_category_name, i)
		end
		
		self.wield_anim = inventory_configuration.wield_anim
		self.inventory_items_n = items_n
		self.inventory_item_units = inventory_item_units
		self.inventory_item_units_by_category = inventory_item_units_by_category
		self.inventory_item_definitions = inventory_item_definitions
	end
end
--[[
	Replace equipment visually
--]]
AIInventoryExtension.replace_inventory_visually = function(self, inventory_template)
	if mod:get("use_player_weapons") then
		--local definitions = get_mod("MoreRatWeapons_Def") --Mods.MoreRatWeaponsDefinitions
		if mod:loaded_all() then
			local luck_max = mod.replace_luck[inventory_template] or 0
			local luck = math.random(1, 100)
			if luck <= luck_max then
				local inventory_configuration_name = mod.replace_inventory[inventory_template]
				if inventory_configuration_name then
					local unit_spawner = Managers.state.unit_spawner
					local inventory_configuration = InventoryConfigurations[inventory_configuration_name]
					local items = inventory_configuration.items
					local items_n = inventory_configuration.items_n
					local world = Managers.world:world("level_world")
					
					for i = 1, items_n do
						local item_category = items[i]
						local item_category_n = item_category.count
						local item_category_name = item_category.name
						local item_index = math.random(1, item_category_n)
						local item = item_category[item_index]
						local item_unit_name = item.unit_name
						local item_unit_template_name = item.unit_extension_template or "ai_inventory_item"
						
						-- Check package
						local manager = Managers.package
						local reference = "MoreRatWeapons"
						if manager:has_loaded(item_unit_name, reference) then
							if self.inventory_item_units[i] then
								local item_unit = World.spawn_unit(world, item_unit_name)
								if not self.link_on_drop then self.link_on_drop = {} end
								self.link_on_drop[i] = item_unit
								if not self.linked_item then self.linked_item = {} end
								self.linked_item[i] = item
								
								-- World.link_unit(world, item_unit, self.inventory_item_units[i], 0)
								-- local pos = item.offset or {0, 0, 0}
								-- local rot = item.rotation or {0, 0, 0}
								-- local scale = item.scale or {1, 1, 1}
								-- Unit.set_local_position(item_unit, 0, Vector3(pos[1], pos[2], pos[3]))
								-- Unit.set_local_rotation(item_unit, 0, Quaternion.from_euler_angles_xyz(rot[1], rot[2], rot[3]))
								-- Unit.set_local_scale(item_unit, 0, Vector3(scale[1], scale[2], scale[3])) 
								-- Unit.set_unit_visibility(self.inventory_item_units[i], false)
								
								self:relink_visual_replacement(self.inventory_item_units[i], nil, i, "unwielded")
								--self:relink_visual_replacement(self.inventory_item_units[i], nil, i, "wielded")
								
							end
						else
							mod:echo("'"..item_unit_name.."' not loaded")
						end

					end
				end
			end
		end
	end
end
--[[
	Replace equipment visually
--]]
AIInventoryExtension.relink_visual_replacement = function(self, new_item_unit, actor, item_inventory_index, link_type)
	if self.link_on_drop and self.link_on_drop[item_inventory_index] then
		local link_type = link_type or "wielded"
		local item = self.linked_item[item_inventory_index]
		local item_unit = self.link_on_drop[item_inventory_index]
		-- local world = Managers.world:world("level_world")
		
		Unit.set_unit_visibility(new_item_unit, false)
		World.unlink_unit(self.world, item_unit)
		local node = actor and Actor.node(actor) or 0
		if link_type == "unwielded" then
			link_unit(item.attachment_node_linking.unwielded, self.world, item_unit, self.unit)
		else
			World.link_unit(self.world, item_unit, new_item_unit, node)
		end
		
		local offset = item[link_type]
		if offset then
			local pos = offset.position or {0, 0, 0}
			local rot = offset.rotation or {0, 0, 0}
			local scale = offset.scale or {1, 1, 1}
			Unit.set_local_position(item_unit, 0, Vector3(pos[1], pos[2], pos[3]))
			Unit.set_local_rotation(item_unit, 0, Quaternion.from_euler_angles_xyz(rot[1], rot[2], rot[3]))
			Unit.set_local_scale(item_unit, 0, Vector3(scale[1], scale[2], scale[3])) 
		end
	end
end
--[[
	Delete equipment visually
--]]
AIInventoryExtension.delete_visual_replacements = function(self)
	local unit_spawner = Managers.state.unit_spawner
	local inventory_items_n = self.inventory_items_n
	for i = 1, inventory_items_n, 1 do
		if self.link_on_drop and self.link_on_drop[i] then
			local item_unit = self.link_on_drop[i]
			unit_spawner.mark_for_deletion(unit_spawner, item_unit)
		end
	end
end
--[[
	AIInventorySystem.update
--]]
mod:hook("AIInventorySystem.update", function(func, self, ...)
	if self.units_to_wield_n > 0 then
		for i = 1, self.units_to_wield_n, 1 do
			local unit = self.units_to_wield[i]
			local extension = self.unit_extension_data[unit]
			local inventory_items_n = (not extension.dropped or 0) and extension.inventory_items_n
			for j = 1, inventory_items_n, 1 do
				local item_unit = extension.inventory_item_units[j]
				extension:relink_visual_replacement(item_unit, nil, j, "wielded")
			end
		end
	end
	func(self, ...)
end)

-- ####################################################################################################################
-- ##### Player weapons and packages ##################################################################################
-- ####################################################################################################################
--[[
	Load / unload player weapon packages
--]]
mod.load_packages = function(self)
	local manager = Managers.package
	local reference = "MoreRatWeapons"
	local active = self:get("use_player_weapons") or false
	local setting = self:get("player_weapons_count") or 1
	for i = 1, #self.packages do
		if i <= setting and active then
			for _, name in pairs(self.packages[i]) do
				if not manager:is_loading(name) and not manager:has_loaded(name, reference) then
					self:echo("+'"..name.."'!")
					manager:load(name, reference, self.package_callback(self, name), true)
					more_rat_weapons_loading_packages[name] = true
				end
			end
		else
			for _, name in pairs(self.packages[i]) do
				if manager:has_loaded(name, reference) and manager:can_unload(name) then
					manager:unload(name, reference)
					more_rat_weapons_loading_packages[name] = nil
					more_rat_weapons_loaded_packages[name] = nil
				end
			end
		end
	end
	self.custom_1h_weapons.count = self.custom_1h_weapons.count_settings[setting]
	self.custom_2h_weapons.count = self.custom_2h_weapons.count_settings[setting]
	self.custom_shields.count = self.custom_shields.count_settings[setting]
end
--[[
	Check if all packages are loaded
--]]
mod.loaded_all = function(self)
	return more_rat_weapons_loading_packages and #more_rat_weapons_loading_packages == 0
end
--[[
	Package load callback function
--]]
mod.package_callback = function(self, name)
	more_rat_weapons_loading_packages[name] = nil
	more_rat_weapons_loaded_packages[name] = true
end

-- ####################################################################################################################
-- ##### Local stuff ##################################################################################################
-- ####################################################################################################################
--[[
	Empty cache on game start
--]]
mod:hook("StateInGameRunning.event_game_started", function(func, ...)
	func(...)
	--mod:load_packages(true)
	more_rat_weapons_ignored_units = {}
	more_rat_weapons_shielded_units = {}
end)
--[[
	Initialize enemy unit
--]]
mod.init_enemy_unit = function(self, go_id)
	--safe_pcall(function()
		local network_manager = Managers.state.network
		local unit = network_manager.game_object_or_level_unit(network_manager, go_id)
		if unit and Unit.has_data(unit, "breed") and ScriptUnit.has_extension(unit, "ai_inventory_system") then
			local breed = Unit.get_data(unit, "breed")
			local inventory_extension = ScriptUnit.extension(unit, "ai_inventory_system")
			
			local inv_template = inventory_extension.inventory_configuration_name
			local mod_config = inventory_extension.inventory_configuration_name
			if inv_template == "sword_and_shield" and not inventory_extension.was_changed then
			
				-- Set inventory
				mod_config = mod.shield_data.inventory_config[breed.name]
				--mod_config = "test"
				inventory_extension:set_inventory(mod_config)
				inventory_extension.was_changed = true
				more_rat_weapons_ignored_units[unit] = unit
				more_rat_weapons_shielded_units[#more_rat_weapons_shielded_units+1] = unit
				
				-- Set Health
				local diff = Managers.state.difficulty:get_difficulty_rank()
				if mod:get("shield_type") == 1 then
					inventory_extension.shield_health = mod.shield_data.health[diff]
				elseif mod:get("shield_type") == 2 then
					inventory_extension.shield_health = 3
				else
					inventory_extension.shield_health = 1
				end
			end
			
			inventory_extension:replace_inventory_visually(mod_config)
		end
	--end)
end
--[[
	Delete projectiles linked to a unit
--]]
mod.delete_projectiles = function(self, link_unit)
	local projectile_linker_system = Managers.state.entity:system("projectile_linker_system")
	if projectile_linker_system then
		projectile_linker_system.clear_linked_projectiles(projectile_linker_system, link_unit)
	end
end
--[[
	Prevent shield from being dropped
--]]
mod:hook("AIInventoryExtension.drop_single_item", function(func, self, item_inventory_index, ...)
	if item_inventory_index == 2 and self.already_dropped_shield then
		return
	end
	func(self, item_inventory_index, ...)
	local item_unit = self.dropped_items[item_inventory_index]
	local actor = Unit.actor(item_unit, "rp_dropped")
	self:relink_visual_replacement(item_unit, actor, item_inventory_index, "dropped")
end)
--[[
	Delete visual weapons
--]]
mod:hook("AIInventoryExtension.destroy", function(func, self, ...)
	self:delete_visual_replacements()
	func(self, ...)
end)
--[[
	Catch unit spawn to change equipment
--]]
mod:hook("UnitSpawner.spawn_unit_from_game_object", function (func, self, go_id, ...)
	func(self, go_id, ...)
	mod:init_enemy_unit(go_id)
end)
--[[
	Catch unit spawn to change equipment
--]]
mod:hook("UnitSpawner.spawn_network_unit", function (func, ...)
	local unit, go_id = func(...)
	mod:init_enemy_unit(go_id)
	return unit, go_id
end)

-- ####################################################################################################################
-- ##### Ranged hits on shields #######################################################################################
-- ####################################################################################################################
--[[
	Check if we can hit owner of the shield
--]]
mod.check_hit_on_owner = function(self, hit_unit, impact_data)
	local damage_data = impact_data.damage
	if not damage_data or not ScriptUnit.has_extension(hit_unit, "damage_system") then
		
		for _, unit in pairs(more_rat_weapons_shielded_units) do
			if unit and ScriptUnit.has_extension(unit, "ai_inventory_system") and AiUtils.unit_alive(unit) then
				local inventory_extension = ScriptUnit.extension(unit, "ai_inventory_system")
				if inventory_extension.shield_health and not inventory_extension.already_dropped_shield then
					local item_unit = inventory_extension.inventory_item_units[2]
					local item_unit2 = inventory_extension.link_on_drop and inventory_extension.link_on_drop[2]
					if item_unit and item_unit == hit_unit or item_unit2 and item_unit2 == hit_unit then

						local breed = Unit.get_data(unit, "breed")
						if breed then
							return true, unit, breed
						end
						
					end
				end
			end
		end
		
	end
	return false, nil, nil
end
--[[
	Catch missing hits to shields
--]]
mod:hook("PlayerProjectileHuskExtension.hit_non_level_unit", function(func, self, impact_data, hit_unit, hit_position, hit_direction, hit_normal, ...)
	local hit, unit, breed = mod:check_hit_on_owner(hit_unit, impact_data)
	if hit then
		self.hit_enemy(self, impact_data, unit, hit_position, hit_direction, hit_normal, Unit.actor(unit, "c_lefthand"), breed)
	else
		func(self, impact_data, hit_unit, hit_position, hit_direction, hit_normal, ...)
	end
end)
--[[
	Catch missing hits to shields
--]]
mod:hook("PlayerProjectileUnitExtension.hit_non_level_unit", function(func, self, impact_data, hit_unit, hit_position, hit_direction, hit_normal, ...)
	--safe_pcall(function()
		local hit, unit, breed = mod:check_hit_on_owner(hit_unit, impact_data)
		if hit then
			self.hit_enemy(self, impact_data, unit, hit_position, hit_direction, hit_normal, Unit.actor(unit, "c_lefthand"), breed)
		else
			func(self, impact_data, hit_unit, hit_position, hit_direction, hit_normal, ...)
		end
	--end)
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
	local load_packages = false
	if setting_name == "use_player_weapons" then
		load_packages = true
	end
	if setting_name == "player_weapons_count" then
		load_packages = true
	end
	if load_packages then
		mod:load_packages()
	end
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
	if not mod.first_load_of_packages then
		local manager = Managers.package
		if manager then
			mod:load_packages()
			mod.first_load_of_packages = true
		end
	end
end

-- ##### ███████╗████████╗ █████╗ ██████╗ ████████╗ ###################################################################
-- ##### ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝ ###################################################################
-- ##### ███████╗   ██║   ███████║██████╔╝   ██║    ###################################################################
-- ##### ╚════██║   ██║   ██╔══██║██╔══██╗   ██║    ###################################################################
-- ##### ███████║   ██║   ██║  ██║██║  ██║   ██║    ###################################################################
-- ##### ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ###################################################################
mod:create_options(options_widgets, true, "More Rat Weapons", "Mod description")