local mod = new_mod("ThirdPerson")
--[[ 
	Third person
		- Does the necessary positioning of the camera
		- Applies different fixes to certain situations
	Issues:
		- When camera collides backwards with map aiming inaccurate
	
	Author: grasmann
	Version: 1.3.0
--]]

-- ##### ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗ #############################################
-- ##### ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝ #############################################
-- ##### ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗ #############################################
-- ##### ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║ #############################################
-- ##### ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║ #############################################
-- ##### ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝ #############################################
local options_widgets = {
	{
		["setting_name"] = "side",
		["widget_type"] = "stepper",
		["text"] = "Side",
		["tooltip"] = "Third Person Side\n" ..
			"Toggle side for third person left and right.\n\n" ..
			"Choose if the camera is to left or right of your character.",
		["value_type"] = "boolean",
		["options"] = {
			{text = "Left", value = false},
			{text = "Right", value = true}
		},
		["default_value"] = true,
	},
	{
		["setting_name"] = "offset",
		--["widget_type"] = "slider",
		["widget_type"] = "stepper",
		["text"] = "Offset",
		["tooltip"] = "Third Person Offset\n" ..
			"Set camera offset for third person.\n\n" ..
			"Change the distance between the camera and the character.",
		--["range"] = {50, 400},
		["options"] = {
			{text = "Default", value = 100},
			{text = "Medium", value = 200},
			{text = "Far", value = 300},
			{text = "Very Far", value = 400},
		},
		["default_value"] = 100,
	},
	{
		["setting_name"] = "zoom",
		--["widget_type"] = "dropdown",
		["widget_type"] = "stepper",
		["text"] = "Zoom",
		["tooltip"] = "Third Person Zoom\n" ..
			"Set camera zoom for third person.\n\n" ..
			"Change the zoom strength for third person.",
		["value_type"] = "number",
		["options"] = {
			{text = "Default", value = 1},
			{text = "Medium", value = 2},
			{text = "Low", value = 3},
			{text = "Off", value = 4},
		},
		["default_value"] = 1,
	},
	{
		["setting_name"] = "first_person_zoom",
		["widget_type"] = "stepper",
		["text"] = "First Person Zoom",
		["tooltip"] = "First Person Zoom\n" ..
			"Toggle first person zoom off or on.\n\n" ..
			"Aiming in third person will switch you to first person.",
		["value_type"] = "boolean",
		["options"] = {
			{text = "Off", value = false},
			{text = "On", value = true},
		},
		["default_value"] = false,
	},
	{
		["setting_name"] = "reload_stop_when_finished",
		["widget_type"] = "stepper",
		["text"] = "Stop Reload When Finished",
		["tooltip"] = "Stop Reload When Finished\n" ..
			"Toggle stop reload when finished off or on.\n\n" ..
			"The first- and third person animations can differ a lot.\n" ..
			"Especially the reload animation for ranged weapons.\n" ..
			"Stops third person reload animation after the correct time.",
		["value_type"] = "boolean",
		["options"] = {
			{text = "Off", value = false},
			{text = "On", value = true},
		},
		["default_value"] = true,
	},
	{
		["setting_name"] = "reload_extend_too_short",
		["widget_type"] = "stepper",
		["text"] = "Extend Short Reload Animations",
		["tooltip"] = "Extend short Animations\n" ..
			"Toggle extend short animations off or on.\n\n" ..
			"The first- and third person animations can differ a lot.\n" ..
			"Especially the reload animation for ranged weapons.\n" ..
			"Repeats third person reload animation if too short.",
		["value_type"] = "boolean",
		["options"] = {
			{text = "Off", value = false},
			{text = "On", value = true},
		},
		["default_value"] = true,
	},
}

-- ##### ██████╗  █████╗ ████████╗ █████╗ #############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################
mod.reset = true
mod.first_person_zoom = {
	active = false,
	end_zoom = false,
	wait_time = 0,
}
mod.firstperson = {
	value = false,
}
mod.offset = {
	x = 0.6,
	y = -0.8,
	z = 0.1
}
mod.zoom = {
	default = {
		default = 30,
		medium = 40,
		low = 50,
		off = 65,
	},
	increased = {
		default = 16,
		medium = 30,
		low = 45,
		off = 65,
	},
}
mod.reload = {
	reloading = {},
	extended = {},
	is_reloading = function(self, unit)
		if self.reloading[unit] and self.t then
			if self.reloading[unit].start_time + self.reloading[unit].reload_time > self.t then return true end
		end
		return false
	end
}

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
	Set zoom values
--]]
mod.set_zoom_values = function(current_node)
	local degrees_to_radians = math.pi/180
	local zoom_fov = 65
	local zoom_setting = mod:get("zoom")
	
	if current_node._name == "zoom_in" then
		if zoom_setting == 2 then
			zoom_fov = mod.zoom.default.medium
		elseif zoom_setting == 3 then
			zoom_fov = mod.zoom.default.low
		elseif zoom_setting == 4 then
			zoom_fov = mod.zoom.default.off
		else
			zoom_fov = mod.zoom.default.default
		end
		current_node._vertical_fov = zoom_fov*degrees_to_radians				
	elseif current_node._name == "increased_zoom_in" then
		if zoom_setting == 2 then
			zoom_fov = mod.zoom.increased.medium
		elseif zoom_setting == 3 then
			zoom_fov = mod.zoom.increased.low
		elseif zoom_setting == 4 then
			zoom_fov = mod.zoom.increased.off
		else
			zoom_fov = mod.zoom.increased.default
		end
		current_node._vertical_fov = zoom_fov*degrees_to_radians
	end	
end
--[[
	Check if first person is blocked
--]]
mod.is_first_person_blocked = function(unit)
	local blocked = false
	local state_system = ScriptUnit.extension(unit, "character_state_machine_system")
	if state_system ~= nil then
		blocked = blocked or state_system.state_machine.state_current.name == "dead"
		blocked = blocked or state_system.state_machine.state_current.name == "grabbed_by_pack_master"
		blocked = blocked or state_system.state_machine.state_current.name == "inspecting"
		blocked = blocked or state_system.state_machine.state_current.name == "interacting"
		blocked = blocked or state_system.state_machine.state_current.name == "knocked_down"
		--blocked = blocked or state_system.state_machine.state_current.name == "leave_ledge_hanging_falling"
		--blocked = blocked or state_system.state_machine.state_current.name == "leave_ledge_hanging_pull_up"
		blocked = blocked or state_system.state_machine.state_current.name == "ledge_hanging"
		blocked = blocked or state_system.state_machine.state_current.name == "pounced_down"
		blocked = blocked or state_system.state_machine.state_current.name == "waiting_for_assisted_respawn"
	end
	return blocked
end
--[[
	Check if third person is active
--]]
mod.is_third_person_active = function()
	return not mod:is_suspended() and not mod.first_person_zoom.active
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################
--[[
	Fix to make mission objectives visible in third person
--]]
mod:hook("TutorialUI.update", function(func, self, ...)
	if mod.is_third_person_active() then
		local extension = self._first_person_extension
		if extension then extension.first_person_mode = true end
		func(self, ...)
		if extension then extension.first_person_mode = mod.firstperson.value end
	else
		func(self, ...)
	end
end)
--[[
	MAIN FUNCTION - Camera positioning
--]]
mod:hook("CameraManager.post_update", function(func, self, dt, t, viewport_name)
	
	-- ##### Original function ########################################################################################
	func(self, dt, t, viewport_name)			
	
	-- ##### Get data #################################################################################################
	local viewport = ScriptWorld.viewport(self._world, viewport_name)
	local camera = ScriptViewport.camera(viewport)
	local shadow_cull_camera = ScriptViewport.shadow_cull_camera(viewport)
	local camera_nodes = self._camera_nodes[viewport_name]
	local current_node = self._current_node(self, camera_nodes)
	local camera_data = self._update_transition(self, viewport_name, camera_nodes, dt)	
		
	if mod.is_third_person_active() then
		-- ##### Check side ###########################################################################################
		local offset = nil
		local mult = mod:get("offset") / 100
		if mult == nil then mult = 1 end		
		if not mod:get("side") then
			offset = Vector3(mod.offset.x, mod.offset.y * mult, mod.offset.z)
		else
			offset = Vector3(-mod.offset.x, mod.offset.y * mult, mod.offset.z)
		end

		camera_data.position = self._calculate_sequence_event_position(self, camera_data, offset)
	end
	
	-- ##### Change zoom ##############################################################################################
	mod.set_zoom_values(current_node)
	
	-- ##### Update camera ############################################################################################
	self._update_camera_properties(self, camera, shadow_cull_camera, current_node, camera_data, viewport_name)
	self._update_sound_listener(self, viewport_name)		
	ScriptCamera.force_update(self._world, camera)		

end)
--[[
	Fix to apply camera offset to ranged weapons
--]]
mod:hook("PlayerUnitFirstPerson.current_position", function(func, self)
	
	if mod.is_third_person_active() then
		-- ##### Get data #############################################################################################
		local position = Unit.world_position(self.first_person_unit, 0) --+ Vector3(0, 0, 1.5)
		local current_rot = Unit.local_rotation(self.first_person_unit, 0)

		-- ##### Counter offset #######################################################################################
		local offset = {}
		if not mod:get("side") then
			offset = Vector3(mod.offset.x, 0, mod.offset.z)
		else
			offset = Vector3(-mod.offset.x, 0, mod.offset.z)
		end
		
		-- ##### Change position ######################################################################################
		local x = offset.x * Quaternion.right(current_rot)
		local y = offset.y * Quaternion.forward(current_rot)
		local z = Vector3(0, 0, offset.z)
		position = position + x + y + z	
		return position
	end
	
	-- ##### Original function ########################################################################################
	return func(self)
end)
--[[
	MAIN FUNCTION - Set first / third person mode - Hide first person ammo
--]]
mod:hook("PlayerUnitFirstPerson.update", function(func, self, unit, input, dt, context, t)

	-- ##### Reset view ###############################################################################################
	if mod.reset then
		self.set_first_person_mode(self, mod:is_suspended())
		mod.reset = false
	end
	
	-- ##### Original function ########################################################################################
	func(self, unit, input, dt, context, t)
	
	if not mod.is_first_person_blocked(self.unit) then
		if mod.is_third_person_active() then
			-- ##### Disable first person #############################################################################
			if mod.firstperson.value then
				self.set_first_person_mode(self, false)
				mod.firstperson.value = false
			end
			
			-- ##### Hide first person ammo ###########################################################################
			local inventory_extension = ScriptUnit.extension(self.unit, "inventory_system")
			local slot_data = inventory_extension.get_slot_data(inventory_extension, "slot_ranged")
			if slot_data then
				if slot_data.right_ammo_unit_1p then Unit.set_unit_visibility(slot_data.right_ammo_unit_1p, false) end
				if slot_data.left_ammo_unit_1p then Unit.set_unit_visibility(slot_data.left_ammo_unit_1p, false) end	
			end
		else
			-- ##### Enable first person ##############################################################################
			if not mod.firstperson.value then
				self.set_first_person_mode(self, true)
				mod.firstperson.value = true
			end
		end
	end
	
end)

-- ##### ██████╗ ███████╗███████╗███████╗████████╗ ####################################################################
-- ##### ██╔══██╗██╔════╝██╔════╝██╔════╝╚══██╔══╝ ####################################################################
-- ##### ██████╔╝█████╗  ███████╗█████╗     ██║    ####################################################################
-- ##### ██╔══██╗██╔══╝  ╚════██║██╔══╝     ██║    ####################################################################
-- ##### ██║  ██║███████╗███████║███████╗   ██║    ####################################################################
-- ##### ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝   ╚═╝    ####################################################################
--[[
	A game was started
--]]
mod:hook("StateInGameRunning.event_game_started", function(func, self)
	func(self)
	mod.reset = true
end)
--[[
	A game was actually started ... lol
--]]
-- mod:hook("StateInGameRunning.event_game_actually_starts", function(func, self)
	-- func(self)
	-- mod.reset = true
-- end)
--[[
	Set first person mode for cutscenes
--]]
mod:hook("CutsceneSystem.set_first_person_mode", function(func, self, enabled)
	func(self, enabled)
	if enabled then mod.reset = true end
end)
--[[
	Reset view after character change
--]]
mod:hook("ProfileView.on_exit", function(func, ...)
	func(...)
	if not mod:is_suspended() then mod.reset = true end
end)
--[[
	Reset view after equipment change
--]]
mod:hook("InventoryView.on_exit", function(func, self)
	func(self)
	if not mod:is_suspended() then mod.reset = true end
end)

-- ##### ██████╗ ██████╗  ██████╗      ██╗███████╗ ██████╗████████╗██╗██╗     ███████╗███████╗ ########################
-- ##### ██╔══██╗██╔══██╗██╔═══██╗     ██║██╔════╝██╔════╝╚══██╔══╝██║██║     ██╔════╝██╔════╝ ########################
-- ##### ██████╔╝██████╔╝██║   ██║     ██║█████╗  ██║        ██║   ██║██║     █████╗  ███████╗ ########################
-- ##### ██╔═══╝ ██╔══██╗██║   ██║██   ██║██╔══╝  ██║        ██║   ██║██║     ██╔══╝  ╚════██║ ########################
-- ##### ██║     ██║  ██║╚██████╔╝╚█████╔╝███████╗╚██████╗   ██║   ██║███████╗███████╗███████║ ########################
-- ##### ╚═╝     ╚═╝  ╚═╝ ╚═════╝  ╚════╝ ╚══════╝ ╚═════╝   ╚═╝   ╚═╝╚══════╝╚══════╝╚══════╝ ########################
--[[
	Fix to apply camera offset to projectiles
--]]
mod:hook("ActionUtils.spawn_player_projectile", function(func, owner_unit, position, rotation, scale, angle, 
	target_vector, speed, item_name, item_template_name, action_name, sub_action_name)
	if mod.is_third_person_active() then
		-- ##### Get data #############################################################################################
		local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")
		local first_person_unit = first_person_extension.get_first_person_unit(first_person_extension)	
		position = Unit.world_position(first_person_unit, 0) --+ Vector3(0, 0, 1.5)
		local current_rot = Unit.local_rotation(first_person_unit, 0)

		-- ##### Counter offset #######################################################################################
		local offset = {}
		if not mod:get("side") then
			offset = Vector3(mod.offset.x, -mod.offset.y*2, mod.offset.z)
		else
			offset = Vector3(-mod.offset.x, -mod.offset.y*2, mod.offset.z)
		end
		
		-- ##### Change position ######################################################################################
		local x = offset.x * Quaternion.right(current_rot)
		local y = offset.y * Quaternion.forward(current_rot)
		local z = Vector3(0, 0, offset.z)
		position = position + x + y + z	
	end
	
	-- ##### Original function ########################################################################################
	func(owner_unit, position, rotation, scale, angle, target_vector, speed, item_name, 
		item_template_name, action_name, sub_action_name)
end)
--[[
	Fix to apply camera offset to trueflight projectiles
--]]
mod:hook("ActionUtils.spawn_true_flight_projectile", function(func, owner_unit, target_unit, true_flight_template_id, 
	position, rotation, angle, target_vector, speed, item_name, item_template_name, action_name, sub_action_name, scale)
	
	if mod.is_third_person_active() then
		-- ##### Get data #############################################################################################
		local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")
		local first_person_unit = first_person_extension.get_first_person_unit(first_person_extension)	
		position = Unit.world_position(owner_unit, 0) + Vector3(0, 0, 1.5)
		local current_rot = Unit.local_rotation(first_person_unit, 0)
		
		-- ##### Create offset ########################################################################################
		local offset = {}
		if not mod:get("side") then
			offset = Vector3(mod.offset.x, -mod.offset.y*2, mod.offset.z)
		else
			offset = Vector3(-mod.offset.x, -mod.offset.y*2, mod.offset.z)
		end
		
		-- ##### Change position ######################################################################################
		local x = offset.x * Quaternion.right(current_rot)
		local y = offset.y * Quaternion.forward(current_rot)
		local z = Vector3(0, 0, offset.z)
		position = position + x + y + z	
	end
	
	func(owner_unit, target_unit, true_flight_template_id, position, rotation, angle, 
		target_vector, speed, item_name, item_template_name, action_name, sub_action_name, scale)
end)

-- ##### ██████╗ ███████╗██╗      ██████╗  █████╗ ██████╗  ############################################################
-- ##### ██╔══██╗██╔════╝██║     ██╔═══██╗██╔══██╗██╔══██╗ ############################################################
-- ##### ██████╔╝█████╗  ██║     ██║   ██║███████║██║  ██║ ############################################################
-- ##### ██╔══██╗██╔══╝  ██║     ██║   ██║██╔══██║██║  ██║ ############################################################
-- ##### ██║  ██║███████╗███████╗╚██████╔╝██║  ██║██████╔╝ ############################################################
-- ##### ╚═╝  ╚═╝╚══════╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝  ############################################################
--[[
	Play third person animation for yourself
--]]
mod:hook("GenericAmmoUserExtension.start_reload_animation", function(func, self, reload_time)
	func(self, reload_time)
	if self.reload_event then
		-- ##### Play 3rd person animation ############################################################################
		Unit.animation_event(self.owner_unit, self.reload_event)
		-- ##### Set reloading ########################################################################################
		mod.reload.reloading[self.owner_unit] = {
			reload_time = reload_time,
			start_time = mod.reload.t or 0,
			event = self.reload_event,
		}
	end
end)
--[[
	Check to disable animation when reloading is done
--]]
mod:hook("GenericAmmoUserExtension.update", function(func, self, unit, input, dt, context, t)
	func(self, unit, input, dt, context, t)
	mod.reload.t = t
	-- ##### Check if reload process is issued ########################################################################
	if mod.reload.reloading[self.owner_unit] then
		if not mod.reload:is_reloading(self.owner_unit) then
			if mod:get("reload_stop_when_finished") then
				-- ##### Reload animation is too long #################################################################
				local inventory_extension = ScriptUnit.extension(self.owner_unit, "inventory_system")
				local slot_data = inventory_extension.get_slot_data(inventory_extension, "slot_ranged")
				local item_template = BackendUtils.get_item_template(slot_data.item_data)
				local wield_anim = item_template.wield_anim
				if self.available_ammo <= 0 then
					wield_anim = item_template.wield_anim_no_ammo
				end
				CharacterStateHelper.play_animation_event(self.owner_unit, item_template.wield_anim)
			end
			mod.reload.reloading[self.owner_unit] = nil
			mod.reload.extended[self.owner_unit] = nil
		elseif not mod.reload.extended[self.owner_unit] and mod:get("reload_extend_too_short") then
			local t, length = Unit.animation_layer_info(self.owner_unit, 2)
			if length > mod.reload.reloading[self.owner_unit].reload_time then
				-- ##### Reload animation is too short ################################################################
				CharacterStateHelper.play_animation_event(self.owner_unit, mod.reload.reloading[self.owner_unit].event)
				mod.reload.extended[self.owner_unit] = true
			end
		end
	end
end)
--[[
	Cancel reload
--]]
mod:hook("GenericAmmoUserExtension.abort_reload", function(func, self)
	func(self)
	mod.reload.reloading[self.owner_unit] = nil
	mod.reload.extended[self.owner_unit] = nil
end)

-- #####  ██╗███████╗████████╗██████╗     ███████╗ ██████╗  ██████╗ ███╗   ███╗ #######################################
-- ##### ███║██╔════╝╚══██╔══╝██╔══██╗    ╚══███╔╝██╔═══██╗██╔═══██╗████╗ ████║ #######################################
-- ##### ╚██║███████╗   ██║   ██████╔╝      ███╔╝ ██║   ██║██║   ██║██╔████╔██║ #######################################
-- #####  ██║╚════██║   ██║   ██╔═══╝      ███╔╝  ██║   ██║██║   ██║██║╚██╔╝██║ #######################################
-- #####  ██║███████║   ██║   ██║         ███████╗╚██████╔╝╚██████╔╝██║ ╚═╝ ██║ #######################################
-- #####  ╚═╝╚══════╝   ╚═╝   ╚═╝         ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝     ╚═╝ #######################################
--[[
	Activate first person view on aim start
--]]
mod:hook("ActionAim.client_owner_start_action", function(func, ...)
	func(...)
	if mod:get("first_person_zoom") then
		mod.first_person_zoom.active = not mod.firstperson.value
	end
end)
--[[
	Activate ending first person view on aim finish
--]]
mod:hook("ActionAim.finish", function(func, ...)
	func(...)
	mod.first_person_zoom.end_zoom = true
end)
--[[
	Activate ending first person view on trueflight aim finish
--]]
mod:hook("ActionTrueFlightBowAim.client_owner_start_action", function(func, ...)
	func(...)
	if mod:get("first_person_zoom") then
		mod.first_person_zoom.active = not mod.firstperson.value
	end
end)
--[[
	Activate first person view on trueflight aim start
--]]
mod:hook("ActionTrueFlightBowAim.finish", function(func, ...)
	local chain_action_data = func(...)
	mod.first_person_zoom.end_zoom = true
	return chain_action_data
end)
--[[
	Deactivate first person view
--]]
mod:hook("MatchmakingManager.update", function(func, self, dt, t)
	func(self, dt, t)
	-- ##### Check if end zoom has triggered ##########################################################################
	if mod.first_person_zoom.end_zoom then
		-- ##### Save the now time to wait 1 second to end first person mode ##########################################
		mod.first_person_zoom.wait_time = t
		mod.first_person_zoom.end_zoom = false
	end
	-- ##### After 1 second ###########################################################################################
	if mod.first_person_zoom.wait_time ~= 0 and mod.first_person_zoom.wait_time + 0.3 < t then
		mod.first_person_zoom.wait_time = 0
		mod.first_person_zoom.active = false
	end
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

mod:create_options(options_widgets, true, "Third Person", "Mod description")