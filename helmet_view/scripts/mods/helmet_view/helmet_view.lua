local mod = get_mod("helmet_view")
--[[
	Author: grasmann

	Simulates a view from inside helmets
--]]

mod:dofile("scripts/mods/helmet_view/helmet_view_definitions")

-- ##### ██████╗  █████╗ ████████╗ █████╗ #############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################
mod.helmet_model = nil
mod.overlay_widget = nil

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
mod.update_helmet_overlay = function(self, helmet)
	self.overlay_widget = nil

	if not helmet then
		local player = Managers.player:local_player()
		local attachment_extension = ScriptUnit.extension(player.player_unit, "attachment_system")
		local slot_data = attachment_extension:get_slot_data("slot_hat")
		helmet = slot_data.name
	end

	local texture = mod.overlays[helmet]
	local opacity = (255 / 100) * mod:get("opacity")

	if texture and texture ~= "none" then
		local widget = {
			element = {
				passes = {
					{
						texture_id = "helmet_overlay",
						style_id = "helmet_overlay",
						pass_type = "texture",
					},
				},
			},
			content = {
				helmet_overlay = texture,
			},
			style = {
				helmet_overlay = {
					vertical_alignment = "center",
					scale = "fit",
					horizontal_alignment = "center",
					color = {opacity, 255, 255, 255},
				},
			},
			scenegraph_id = "screen",
			offset = {0, 0, -40}
		}
		self.overlay_widget = UIWidget.init(widget)
	end

end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################
--[[
	Create widget on hat changed
--]]
mod:hook_safe(PlayerUnitAttachmentExtension, "create_attachment", function(self, slot_name, item_data, ...)
	if slot_name == "slot_hat" then
		mod:update_helmet_overlay(item_data.name)
	end
end)
--[[
	Draw overlay widget
--]]
mod:hook_safe(EquipmentUI, "draw", function(self, dt, ...)
	local ui_renderer = self.ui_renderer
	local ui_scenegraph = self.ui_scenegraph
	local input_service = self.input_manager:get_service("ingame_menu")
	local render_settings = self.render_settings

	local player = Managers.player:local_player()
	local first_person_extension = ScriptUnit.extension(player.player_unit, "first_person_system")

	if mod.overlay_widget and first_person_extension.first_person_mode then
		UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, nil, render_settings)
		UIRenderer.draw_widget(ui_renderer, mod.overlay_widget)
		UIRenderer.end_pass(ui_renderer)
	end
end)

-- ##### ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗ #########################################################
-- ##### ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝ #########################################################
-- ##### █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗ #########################################################
-- ##### ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║ #########################################################
-- ##### ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║ #########################################################
-- ##### ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ #########################################################
--[[
	Recreate widget on settings changed
--]]
mod.on_setting_changed = function(setting_name)
	if setting_name == "opacity" then
		mod:update_helmet_overlay()
	end
end
--[[
	Recreate widget on enabled
--]]
mod.on_enabled = function(is_first_call)
	mod:update_helmet_overlay()
end

-- mod:hook_safe(PlayerUnitFirstPerson, "update", function(self, unit, input, dt, context, t, ...)
-- 	if mod.helmet_model then

-- 		local offset = Vector3(0, 0, 0)
-- 		local right = Vector3.right() * 0
-- 		local forward = Vector3.forward() * -0.1
-- 		local up = Vector3.up() * -0.05
-- 		offset = right + forward + up

-- 		local look_rotation = self.look_rotation:unbox()
-- 		local pitch = math.clamp(Quaternion.pitch(look_rotation), -self.MAX_MIN_PITCH, self.MAX_MIN_PITCH) / 15
-- 		Unit.set_local_position(mod.helmet_model, 0, Vector3.forward() * pitch + offset)
-- 	end
-- end)
-- mod:hook_safe(ActionAim, "client_owner_start_action", function(...)
-- 	if mod.helmet_model then
-- 		--Unit.set_unit_visibility(mod.helmet_model, false)
-- 	end
-- end)
-- mod:hook_safe(ActionAim, "finish", function(self, ...)
-- 	if mod.helmet_model then
-- 		--Unit.set_unit_visibility(mod.helmet_model, true)
-- 	end
-- end)
-- mod:hook(PlayerUnitAttachmentExtension, "create_attachment", function(func, self, slot_name, item_data, ...)
-- 	func(self, slot_name, item_data, ...)

-- 	-- if not mod.overlays[item_data.name] then
-- 	-- 	local player = Managers.player:local_player()
-- 	-- 	if self._unit == player.player_unit and slot_name == "slot_hat" then
-- 	-- 		local unit_spawner = Managers.state.unit_spawner
-- 	-- 		local world = Managers.world:world("level_world")
-- 	-- 		local first_person_extension = ScriptUnit.extension(player.player_unit, "first_person_system")
-- 	-- 		local first_person_unit = first_person_extension:get_first_person_unit()
-- 	-- 		local camera_manager = Managers.state.camera
-- 	-- 		local viewport_name = "player_1"
-- 	-- 		camera_manager:set_node_tree_root_near_range(viewport_name, "first_person", 0.01)
-- 	-- 		local camerabone = Unit.node(first_person_unit, "camera_node")
-- 	-- 		mod.helmet_model = unit_spawner:spawn_local_unit(item_data.unit)
-- 	-- 		World.link_unit(world, mod.helmet_model, 0, first_person_unit, camerabone)
-- 	-- 	end
-- 	-- end
-- 	-- local camera_manager = Managers.state.camera
-- 	-- local viewport_name = "player_1"
-- 	-- camera_manager:set_node_tree_root_near_range(viewport_name, "first_person", 0.01)

-- 	mod:update_helmet_overlay(item_data.name)
-- end)
-- mod:hook(PlayerUnitAttachmentExtension, "remove_attachment", function(func, self, slot_name, ...)

-- 	local player = Managers.player:local_player()

-- 	if self._unit == player.player_unit and slot_name == "slot_hat" then
-- 		mod:echo("Despawn")

-- 		if mod.helmet_model then
-- 			local unit_spawner = Managers.state.unit_spawner
-- 			unit_spawner:mark_for_deletion(mod.helmet_model)
-- 			mod.helmet_model = nil
-- 		end
-- 	end

-- 	func(self, slot_name, ...)
-- end)
-- Called when all mods are being unloaded
-- exit_game - if true, game will close after unloading
-- mod.on_unload = function(exit_game)
-- 	if mod.helmet_model then
-- 		local unit_spawner = Managers.state.unit_spawner
-- 		unit_spawner:mark_for_deletion(mod.helmet_model)
-- 		mod.helmet_model = nil
-- 	end
-- end
