local mod = get_mod("AmmoMeter")
--[[
	AmmoMeter
		- Shows ammo meter in hud for players
		
	Authors: walterr and IamLupo
	Ported: grasmann
	Version: 1.2.0
--]]

-- ##### ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗ #############################################
-- ##### ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝ #############################################
-- ##### ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗ #############################################
-- ##### ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║ #############################################
-- ##### ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║ #############################################
-- ##### ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝ #############################################
local options_widgets = {}

-- ##### ██████╗  █████╗ ████████╗ █████╗ #############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################
mod.ammo = {}
--[[
	Ammo meter widget definition, based on code from scripts/ui/views/player_inventory_ui_definitions.lua
	(it's a very simplified version of the overcharge meter shown to the right of combustion-based
	weapons' icons on the HUD).
--]]
local ammo_meter_widget = {
	scenegraph_id = "pivot",
	offset = { 225, -79, -2 },
	element = {
		passes = {
			{
				pass_type = "texture",
				style_id = "ammo_bar_fg",
				texture_id = "ammo_bar_fg",
			},
			{
				style_id = "ammo_bar",
				pass_type = "texture_uv_dynamic_color_uvs_size_offset",
				content_id = "ammo_bar",
				dynamic_function = function (content, style, size, dt)
					local bar_value = content.bar_value
					local uv_start_pixels = style.uv_start_pixels
					local uv_scale_pixels = style.uv_scale_pixels
					local uv_pixels = uv_start_pixels + uv_scale_pixels*bar_value
					local uvs = style.uvs
					local uv_scale_axis = style.scale_axis
					local offset = style.offset
					uvs[1][uv_scale_axis] = 1 - uv_pixels/(uv_start_pixels + uv_scale_pixels)
					size[uv_scale_axis] = uv_pixels
					return nil, uvs, size, offset
				end
			},
		},
	},
	content = {
		ammo_bar_fg = "stance_bar_frame",
		ammo_bar = {
			bar_value = 0,
			texture_id = "stance_bar_blue",
		},
	},
	style = {
		ammo_bar_fg = {
			color = { 255, 255, 255, 255 },
			offset = { 0, 0, 1 },
			size = { 32, 128 },
		},
		ammo_bar = {
			uv_start_pixels = 0,
			uv_scale_pixels = 67,
			offset_scale = 1,
			scale_axis = 2,
			offset = { 9, 15, 0 },
			size = { 9, 0 },
			uvs = {
				{ 0, 0 },
				{ 1, 1 }
			},
		},
	},
}

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
	Helper function to retrieve the ammo extension from the given slot data.
--]]
mod.get_ammo_extension = function(self, slot_data)
	if slot_data then
		local right_unit = slot_data.right_unit_1p
		local left_unit = slot_data.left_unit_1p
		return (right_unit and ScriptUnit.has_extension(right_unit, "ammo_system")) or
			(left_unit and ScriptUnit.has_extension(left_unit, "ammo_system"))
	end
	return nil
end
--[[
	Returns the current ammo and the maximum ammo from the given ammo.  Based on
	SimpleInventoryExtension.current_ammo_status, which we can't use because it doesn't give the max
	ammo we want (it gives the 'raw' max ammo for the weapon type without the Ammo Holder trait).
--]]
mod.current_ammo_status = function(self, inventory_extn)
	local slot_data = inventory_extn:equipment().slots["slot_ranged"]
	if slot_data then
		local item_data = slot_data.item_data
		local item_template = BackendUtils.get_item_template(item_data)
		local ammo_data = item_template.ammo_data
		if ammo_data then
			local ammo_extn = self:get_ammo_extension(slot_data)
			
			return ammo_extn:total_remaining_ammo(), ammo_extn.max_ammo
		end
	end
	return nil, nil
end
--[[
	Collect ammo data from local player and store in the ammo list
]]--
mod.update_ammo = function(self, player)
	local player_unit = player.player_unit
	local id = tostring(player.peer_id) .. ":" .. tostring(player._local_player_id)
	if ScriptUnit.has_extension(player_unit, "inventory_system") then
		local inventory_extn = ScriptUnit.has_extension(player_unit, "inventory_system")
		local current_ammo, max_ammo = self:current_ammo_status(inventory_extn)
		if current_ammo then
			self.ammo[id] = {
				["current"] = current_ammo,
				["max"] = max_ammo
			}
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
	Add player unit info to unit frame to allow identification
--]]	
mod:hook("UnitFramesHandler.update", function(func, self, dt, t, my_player)
	local player_unit = self.my_player.player_unit
	
	if player_unit then
		-- Save player_unit to unit frame
		for _, unit_frame in ipairs(self._unit_frames) do
			if unit_frame and unit_frame.player_data and unit_frame.player_data.player then
				unit_frame.data.player_unit = unit_frame.player_data.player_unit
				unit_frame.data.player_ui_id = unit_frame.player_data.player_ui_id
			end
		end
	end
	
	return func(self, dt, t, my_player)
end)
--[[
	Render widgets
--]]
mod:hook("UnitFrameUI.draw", function(func, self, dt)
	local data = self.data
	
	if self._is_visible then
		local ui_renderer = self.ui_renderer
		local input_service = self.input_manager:get_service("ingame_menu")
		
		UIRenderer.begin_pass(ui_renderer, self.ui_scenegraph, input_service, dt, nil, self.render_settings)
		
		--if mod.get(mod.widget_settings.ACTIVE.save) then
		if not mod:is_suspended() then
			-- Draw Ammo bars
			local ammo = mod.ammo[self.data.player_ui_id]
			if ammo then
				local widget = self._ammo_widget
				
				if not widget then
					widget = UIWidget.init(ammo_meter_widget)
					self._ammo_widget = widget
				end
				
				local ammo_bar = widget.content.ammo_bar
				
				ammo_bar.bar_value = math.max(0, math.min(ammo.current / ammo.max, 1))
				
				UIRenderer.draw_widget(ui_renderer, widget)
			end
		end
		
		UIRenderer.end_pass(ui_renderer)
	end
 
	return func(self, dt)
end)

--[[
	When you join a room or you start a new game you
	request every modded clients to give the ammo
]]--
mod:hook("StateInGameRunning.event_game_started", function(func, self)
	func(self)
	
	mod:request_player_ammo()
end)

--[[
	When player leave a bot will spawn, the after bot is spawned
	the ammo data needs to be sync with the modded clients
]]--
mod:hook("GenericAmmoUserExtension.init", function(func, self, ...)
	local players = Managers.player:players()
	for _, player in pairs(players) do
		if player.player_unit == self.owner_unit then
			mod:send_player_ammo(player)
		end
	end
	
	func(self, ...)
	
	-- Fix: When you start a new game the new ammo status will be sync
	mod:request_player_ammo()
end)

--[[
	When a player shoots it needs to send everyone a update
--]]
mod:hook("GenericAmmoUserExtension.use_ammo", function(func, self, ammo_used)
	--safe_pcall(function()
		if self.slot_name == "slot_ranged" then
			if Managers.player.is_server then
				local players = Managers.player:players()
				for _, player in pairs(players) do
					if player.player_unit == self.owner_unit then
						mod:send_player_ammo(player)
					end
				end
			else
				mod:send_player_ammo(Managers.player:local_player())
			end
		end
	--end)
	
	func(self, ammo_used)
end)

--[[
	When picking up ammo on the floor it needs to send everyone a update
]]--
mod:hook("GenericAmmoUserExtension.add_ammo", function (func, self)
	func(self)
	
	--safe_pcall(function()
		if Managers.player.is_server then
			local players = Managers.player:players()
			for _, player in pairs(players) do
				if player.player_unit == self.owner_unit then
					mod:send_player_ammo(player)
				end
			end
		else
			mod:send_player_ammo(Managers.player:local_player())
		end
	--end) 
end)

-- ##### ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗ ###############################################
-- ##### ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝ ###############################################
-- ##### ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝  ###############################################
-- ##### ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗  ###############################################
-- ##### ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗ ###############################################
-- ##### ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ###############################################
--[[
	Send request ammo data:
		- on Join game
		- On reload mod_loader
	
	Send ammo data:
		* On fire/reload weapon
		* On pick up ammo box
]]--

--[[
	Request all modded users to send there ammo
]]--
mod.request_player_ammo = function(self)
	local local_player = Managers.player:local_player()
	if local_player then
		local id = tostring(local_player.peer_id) .. ":1"
		local human_players = Managers.player:human_players()
		
		-- Update our ammo list
		self:update_ammo(local_player)
		
		for _, player in pairs(human_players) do
			if player.peer_id ~= local_player.peer_id then
				--Mods.network.send_rpc("rpc_ammo_meter_request", player.peer_id, id, self.ammo[id])
			end
		end
	end
end

--[[
	Send all users your new ammo state
]]--
mod.send_player_ammo = function(self, local_player)
	local id = tostring(local_player.peer_id) .. ":" .. tostring(local_player._local_player_id)
	local human_players = Managers.player:human_players()
	
	-- Update our ammo list
	self:update_ammo(local_player)
	
	for _, player in pairs(human_players) do
		if player.peer_id ~= local_player.peer_id then
			--Mods.network.send_rpc("rpc_ammo_meter_response", player.peer_id, id, self.ammo[id])
		end
	end
end

-- Mods.network.register("rpc_ammo_meter_request", function(sender_peer_id, sender_id, sender_ammo)
	-- safe_pcall(function()
		-- -- Send own ammo data ( and bots )
		-- local local_player = Managers.player:local_player()
		-- if local_player then
			-- local id = tostring(local_player.peer_id) .. ":1"
			
			-- -- Update player ammo list
			-- mod:update_ammo(local_player)
			
			-- -- Send local player ammo to requested user
			-- Mods.network.send_rpc(
				-- "rpc_ammo_meter_response",
				-- sender_peer_id, id, mod.ammo[id])
			
			-- if Managers.player.is_server then
				-- local bots = Managers.player:bots()
				
				-- if bots then
					-- for _, bot in pairs(bots) do
						-- -- Update our ammo list
						-- mod:update_ammo(bot)
						
						-- -- Generate bot id
						-- id = tostring(bot.peer_id) .. ":" .. tostring(bot._local_player_id)
						
						-- -- Send bot ammo to requested user
						-- Mods.network.send_rpc(
							-- "rpc_ammo_meter_response",
							-- sender_peer_id, id, mod.ammo[id])
					-- end
				-- end
			-- end
		-- end
		
		-- -- Update received ammo
		-- mod.ammo[sender_id] = sender_ammo
	-- end)
-- end)

-- Mods.network.register("rpc_ammo_meter_response", function(sender_peer_id, sender_id, sender_ammo)
	-- safe_pcall(function()
		-- -- Update received response ammo
		-- mod.ammo[sender_id] = sender_ammo
	-- end)
-- end)

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

-- ##### ███████╗████████╗ █████╗ ██████╗ ████████╗ ###################################################################
-- ##### ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝ ###################################################################
-- ##### ███████╗   ██║   ███████║██████╔╝   ██║    ###################################################################
-- ##### ╚════██║   ██║   ██╔══██║██╔══██╗   ██║    ###################################################################
-- ##### ███████║   ██║   ██║  ██║██║  ██║   ██║    ###################################################################
-- ##### ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ###################################################################
--[[
	Create option widgets
--]]
mod:create_options(options_widgets, true, "Ammo Meter", "Shows ammo meter in hud for players")
--[[
	Suspend if needed
--]]
if mod:is_suspended() then
	mod.suspended()
end