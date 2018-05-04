local mod = get_mod("ThirdPerson")
--[[ 
	Third person
		- Lets you play the game in third person
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
		["setting_name"] = "mode",
		["widget_type"] = "dropdown",
		["text"] = "Mode",
		["tooltip"] = "Mode\n" ..
			"Camera mode.",
		["options"] = {
			{text = "Third Person", value = "third_person"}, --1
			{text = "Automatic", value = "automatic"}, --2
		},
		["default_value"] = "third_person",
		["sub_widgets"] = {
			-- Automatic
			{
				["show_widget_condition"] = {2},
				["setting_name"] = "automatic_ranged",
				["widget_type"] = "checkbox",
				["text"] = "Ranged",
				["tooltip"] = "Ranged\n" ..
					"Camera settings with a ranged weapon.",
				["default_value"] = false,
				["sub_widgets"] = {
					{
						["setting_name"] = "automatic_ranged_mode",
						["widget_type"] = "dropdown",
						["text"] = "Mode",
						["tooltip"] = "Mode\n" ..
							"Camera mode to be used by this event.",
						["options"] = {
							{text = "First Peson", value = "first_person"}, --1
							{text = "Third Person", value = "third_person"}, --2
						},
						["default_value"] = "first_person",
						["sub_widgets"] = {
							{
								["show_widget_condition"] = {2},
								["setting_name"] = "automatic_ranged_side",
								["widget_type"] = "dropdown",
								["text"] = "Side",
								["tooltip"] = "Third Person Side\n" ..
									"Choose if the camera is to left or right of your character.",
								["options"] = {
									{text = "Right", value = "right"},
									{text = "Left", value = "left"},
								},
								["default_value"] = "right",
							},
							{
								["show_widget_condition"] = {2},
								["setting_name"] = "automatic_ranged_offset",
								["widget_type"] = "numeric",
								["text"] = "Offset",
								["unit_text"] = "",
								["tooltip"] = "Third Person Offset\n" ..
									"Change the distance between the camera and the character.",
								["range"] = {50, 400},
								["default_value"] = 100,
							},
						},
					},
				},
			},
			{
				["show_widget_condition"] = {2},
				["setting_name"] = "automatic_aim",
				["widget_type"] = "checkbox",
				["text"] = "Aim",
				["tooltip"] = "Aim\n" ..
					"Camera settings for aiming with a ranged weapon.",
				["default_value"] = false,
				["sub_widgets"] = {
					{
						["setting_name"] = "automatic_aim_mode",
						["widget_type"] = "dropdown",
						["text"] = "Mode",
						["tooltip"] = "Mode\n" ..
							"Camera mode to be used by this event.",
						["options"] = {
							{text = "First Peson", value = "first_person"}, --1
							{text = "Third Person", value = "third_person"}, --2
						},
						["default_value"] = "first_person",
						["sub_widgets"] = {
							{
								["show_widget_condition"] = {2},
								["setting_name"] = "automatic_aim_side",
								["widget_type"] = "dropdown",
								["text"] = "Side",
								["tooltip"] = "Third Person Side\n" ..
									"Choose if the camera is to left or right of your character.",
								["options"] = {
									{text = "Right", value = "right"},
									{text = "Left", value = "left"},
								},
								["default_value"] = "right",
							},
							{
								["show_widget_condition"] = {2},
								["setting_name"] = "automatic_aim_offset",
								["widget_type"] = "numeric",
								["text"] = "Offset",
								["unit_text"] = "",
								["tooltip"] = "Third Person Offset\n" ..
									"Change the distance between the camera and the character.",
								["range"] = {50, 400},
								["default_value"] = 100,
							},
							{
								["show_widget_condition"] = {2},
								["setting_name"] = "automatic_aim_zoom",
								["widget_type"] = "dropdown",
								["text"] = "Zoom",
								["tooltip"] = "Third Person Zoom\n" ..
									"Change the zoom strength for third person.",
								["options"] = {
									{text = "Default", value = 1},
									{text = "Medium", value = 2},
									{text = "Low", value = 3},
									{text = "Off", value = 4},
								},
								["default_value"] = 1,
							},
						},
					},
				},
			},
			{
				["show_widget_condition"] = {2},
				["setting_name"] = "automatic_reload",
				["widget_type"] = "checkbox",
				["text"] = "Reload",
				["tooltip"] = "Reload\n" ..
					"Camera settings for reloading a ranged weapon.",
				["default_value"] = false,
				["sub_widgets"] = {
					{
						["setting_name"] = "automatic_reload_mode",
						["widget_type"] = "dropdown",
						["text"] = "Mode",
						["tooltip"] = "Mode\n" ..
							"Camera mode to be used by this event.",
						["options"] = {
							{text = "First Peson", value = "first_person"}, --1
							{text = "Third Person", value = "third_person"}, --2
						},
						["default_value"] = "first_person",
						["sub_widgets"] = {
							{
								["show_widget_condition"] = {2},
								["setting_name"] = "automatic_reload_side",
								["widget_type"] = "dropdown",
								["text"] = "Side",
								["tooltip"] = "Third Person Side\n" ..
									"Choose if the camera is to left or right of your character.",
								["options"] = {
									{text = "Right", value = "right"},
									{text = "Left", value = "left"},
								},
								["default_value"] = "right",
							},
							{
								["show_widget_condition"] = {2},
								["setting_name"] = "automatic_reload_offset",
								["widget_type"] = "numeric",
								["text"] = "Offset",
								["unit_text"] = "",
								["tooltip"] = "Third Person Offset\n" ..
									"Change the distance between the camera and the character.",
								["range"] = {50, 400},
								["default_value"] = 100,
							},
						},
					},
				},
			},
			{
				["show_widget_condition"] = {2},
				["setting_name"] = "automatic_vent",
				["widget_type"] = "checkbox",
				["text"] = "Vent",
				["tooltip"] = "Vent\n" ..
					"Camera settings for reloading a ranged weapon.",
				["default_value"] = false,
				["sub_widgets"] = {
					{
						["setting_name"] = "automatic_vent_mode",
						["widget_type"] = "dropdown",
						["text"] = "Mode",
						["tooltip"] = "Mode\n" ..
							"Camera mode to be used by this event.",
						["options"] = {
							{text = "First Peson", value = "first_person"}, --1
							{text = "Third Person", value = "third_person"}, --2
						},
						["default_value"] = "first_person",
						["sub_widgets"] = {
							{
								["show_widget_condition"] = {2},
								["setting_name"] = "automatic_vent_side",
								["widget_type"] = "dropdown",
								["text"] = "Side",
								["tooltip"] = "Third Person Side\n" ..
									"Choose if the camera is to left or right of your character.",
								["options"] = {
									{text = "Right", value = "right"},
									{text = "Left", value = "left"},
								},
								["default_value"] = "right",
							},
							{
								["show_widget_condition"] = {2},
								["setting_name"] = "automatic_vent_offset",
								["widget_type"] = "numeric",
								["text"] = "Offset",
								["unit_text"] = "",
								["tooltip"] = "Third Person Offset\n" ..
									"Change the distance between the camera and the character.",
								["range"] = {50, 400},
								["default_value"] = 100,
							},
						},
					},
				},
			},
			{
				["show_widget_condition"] = {2},
				["setting_name"] = "automatic_melee",
				["widget_type"] = "checkbox",
				["text"] = "Melee",
				["tooltip"] = "Melee\n" ..
					"Camera settings with a melee weapon.",
				["default_value"] = false,
				["sub_widgets"] = {
					{
						["setting_name"] = "automatic_melee_mode",
						["widget_type"] = "dropdown",
						["text"] = "Mode",
						["tooltip"] = "Mode\n" ..
							"Camera mode to be used by this event.",
						["options"] = {
							{text = "First Peson", value = "first_person"}, --1
							{text = "Third Person", value = "third_person"}, --2
						},
						["default_value"] = "first_person",
						["sub_widgets"] = {
							{
								["show_widget_condition"] = {2},
								["setting_name"] = "automatic_melee_side",
								["widget_type"] = "dropdown",
								["text"] = "Side",
								["tooltip"] = "Third Person Side\n" ..
									"Choose if the camera is to left or right of your character.",
								["options"] = {
									{text = "Right", value = "right"},
									{text = "Left", value = "left"},
								},
								["default_value"] = "right",
							},
							{
								["show_widget_condition"] = {2},
								["setting_name"] = "automatic_melee_offset",
								["widget_type"] = "numeric",
								["text"] = "Offset",
								["unit_text"] = "",
								["tooltip"] = "Third Person Offset\n" ..
									"Change the distance between the camera and the character.",
								["range"] = {50, 400},
								["default_value"] = 100,
							},
						},
					},
				},
			},
			{
				["show_widget_condition"] = {2},
				["setting_name"] = "automatic_block",
				["widget_type"] = "checkbox",
				["text"] = "Block",
				["tooltip"] = "Block\n" ..
					"Camera settings for blocking with a melee weapon.",
				["default_value"] = false,
				["sub_widgets"] = {
					{
						["setting_name"] = "automatic_block_mode",
						["widget_type"] = "dropdown",
						["text"] = "Mode",
						["tooltip"] = "Mode\n" ..
							"Camera mode to be used by this event.",
						["options"] = {
							{text = "First Peson", value = "first_person"}, --1
							{text = "Third Person", value = "third_person"}, --2
						},
						["default_value"] = "first_person",
						["sub_widgets"] = {
							{
								["show_widget_condition"] = {2},
								["setting_name"] = "automatic_block_side",
								["widget_type"] = "dropdown",
								["text"] = "Side",
								["tooltip"] = "Third Person Side\n" ..
									"Choose if the camera is to left or right of your character.",
								["options"] = {
									{text = "Right", value = "right"},
									{text = "Left", value = "left"},
								},
								["default_value"] = "right",
							},
							{
								["show_widget_condition"] = {2},
								["setting_name"] = "automatic_block_offset",
								["widget_type"] = "numeric",
								["text"] = "Offset",
								["unit_text"] = "",
								["tooltip"] = "Third Person Offset\n" ..
									"Change the distance between the camera and the character.",
								["range"] = {50, 400},
								["default_value"] = 100,
							},
						},
					},
				},
			},
			{
				["show_widget_condition"] = {2},
				["setting_name"] = "automatic_push",
				["widget_type"] = "checkbox",
				["text"] = "Push",
				["tooltip"] = "Push\n" ..
					"Camera settings for pushing with a melee weapon.",
				["default_value"] = false,
				["sub_widgets"] = {
					{
						["setting_name"] = "automatic_push_mode",
						["widget_type"] = "dropdown",
						["text"] = "Mode",
						["tooltip"] = "Mode\n" ..
							"Camera mode to be used by this event.",
						["options"] = {
							{text = "First Peson", value = "first_person"}, --1
							{text = "Third Person", value = "third_person"}, --2
						},
						["default_value"] = "first_person",
						["sub_widgets"] = {
							{
								["show_widget_condition"] = {2},
								["setting_name"] = "automatic_push_side",
								["widget_type"] = "dropdown",
								["text"] = "Side",
								["tooltip"] = "Third Person Side\n" ..
									"Choose if the camera is to left or right of your character.",
								["options"] = {
									{text = "Right", value = "right"},
									{text = "Left", value = "left"},
								},
								["default_value"] = "right",
							},
							{
								["show_widget_condition"] = {2},
								["setting_name"] = "automatic_push_offset",
								["widget_type"] = "numeric",
								["text"] = "Offset",
								["unit_text"] = "",
								["tooltip"] = "Third Person Offset\n" ..
									"Change the distance between the camera and the character.",
								["range"] = {50, 400},
								["default_value"] = 100,
							},
						},
					},
				},
			},
			{
				["show_widget_condition"] = {2},
				["setting_name"] = "automatic_stunned",
				["widget_type"] = "checkbox",
				["text"] = "Stunned",
				["tooltip"] = "Stunned\n" ..
					"Camera settings when stunned after was broken.",
				["default_value"] = false,
				["sub_widgets"] = {
					{
						["setting_name"] = "automatic_stunned_mode",
						["widget_type"] = "dropdown",
						["text"] = "Mode",
						["tooltip"] = "Mode\n" ..
							"Camera mode to be used by this event.",
						["options"] = {
							{text = "First Peson", value = "first_person"}, --1
							{text = "Third Person", value = "third_person"}, --2
						},
						["default_value"] = "first_person",
						["sub_widgets"] = {
							{
								["show_widget_condition"] = {2},
								["setting_name"] = "automatic_stunned_side",
								["widget_type"] = "dropdown",
								["text"] = "Side",
								["tooltip"] = "Third Person Side\n" ..
									"Choose if the camera is to left or right of your character.",
								["options"] = {
									{text = "Right", value = "right"},
									{text = "Left", value = "left"},
								},
								["default_value"] = "right",
							},
							{
								["show_widget_condition"] = {2},
								["setting_name"] = "automatic_stunned_offset",
								["widget_type"] = "numeric",
								["text"] = "Offset",
								["unit_text"] = "",
								["tooltip"] = "Third Person Offset\n" ..
									"Change the distance between the camera and the character.",
								["range"] = {50, 400},
								["default_value"] = 100,
							},
						},
					},
				},
			},
			{
				["show_widget_condition"] = {2},
				["setting_name"] = "automatic_carry",
				["widget_type"] = "checkbox",
				["text"] = "Carry",
				["tooltip"] = "Carry\n" ..
					"Camera settings when carrying objective items.",
				["default_value"] = false,
				["sub_widgets"] = {
					{
						["setting_name"] = "automatic_carry_mode",
						["widget_type"] = "dropdown",
						["text"] = "Mode",
						["tooltip"] = "Mode\n" ..
							"Camera mode to be used by this event.",
						["options"] = {
							{text = "First Peson", value = "first_person"}, --1
							{text = "Third Person", value = "third_person"}, --2
						},
						["default_value"] = "first_person",
						["sub_widgets"] = {
							{
								["show_widget_condition"] = {2},
								["setting_name"] = "automatic_carry_side",
								["widget_type"] = "dropdown",
								["text"] = "Side",
								["tooltip"] = "Third Person Side\n" ..
									"Choose if the camera is to left or right of your character.",
								["options"] = {
									{text = "Right", value = "right"},
									{text = "Left", value = "left"},
								},
								["default_value"] = "right",
							},
							{
								["show_widget_condition"] = {2},
								["setting_name"] = "automatic_carry_offset",
								["widget_type"] = "numeric",
								["text"] = "Offset",
								["unit_text"] = "",
								["tooltip"] = "Third Person Offset\n" ..
									"Change the distance between the camera and the character.",
								["range"] = {50, 400},
								["default_value"] = 100,
							},
						},
					},
				},
			},
			-- Normal
			{
				["show_widget_condition"] = {1},
				["setting_name"] = "side",
				["widget_type"] = "dropdown",
				["text"] = "Side",
				["tooltip"] = "Third Person Side\n" ..
					"Choose if the camera is to left or right of your character.",
				["options"] = {
					{text = "Right", value = "right"},
					{text = "Left", value = "left"}
				},
				["default_value"] = "left",
			},
			{
				["show_widget_condition"] = {1},
				["setting_name"] = "offset",
				["widget_type"] = "numeric",
				["text"] = "Offset",
				["unit_text"] = "",
				["tooltip"] = "Third Person Offset\n" ..
					"Change the distance between the camera and the character.",
				["range"] = {50, 400},
				["default_value"] = 100,
			},
			{
				["show_widget_condition"] = {1},
				["setting_name"] = "zoom",
				["widget_type"] = "dropdown",
				["text"] = "Zoom",
				["tooltip"] = "Third Person Zoom\n" ..
					"Change the zoom strength for third person.",
				["options"] = {
					{text = "Default", value = 1},
					{text = "Medium", value = 2},
					{text = "Low", value = 3},
					{text = "Off", value = 4},
				},
				["default_value"] = 1,
			},
			{
				["show_widget_condition"] = {1},
				["setting_name"] = "toggle_side",
				["widget_type"] = "keybind",
				["text"] = "Toggle Side",
				["tooltip"] = "Toggle side left / right.",
				["default_value"] = {},
				["action"] = "toggle_side"
			},
			{
				["show_widget_condition"] = {1},
				["setting_name"] = "switch_offset",
				["widget_type"] = "keybind",
				["text"] = "Switch Offset",
				["tooltip"] = "Switch camera offset.",
				["default_value"] = {},
				["action"] = "switch_offset"
			},
			{
				["show_widget_condition"] = {1},
				["setting_name"] = "switch_zoom",
				["widget_type"] = "keybind",
				["text"] = "Switch Zoom",
				["tooltip"] = "Switch camera zoom.",
				["default_value"] = {},
				["action"] = "switch_zoom"
			},
		},
	},
	{
		["setting_name"] = "reload_stop_when_finished",
		["widget_type"] = "checkbox",
		["text"] = "Stop Reload When Finished",
		["tooltip"] = "Stop Reload When Finished\n" ..
			"Toggle stop reload when finished off or on.\n\n" ..
			"The first- and third person animations can differ a lot.\n" ..
			"Especially the reload animation for ranged weapons.\n" ..
			"Stops third person reload animation after the correct time.",
		["default_value"] = true,
	},
	{
		["setting_name"] = "reload_extend_too_short",
		["widget_type"] = "checkbox",
		["text"] = "Extend Short Reload Animations",
		["tooltip"] = "Extend short Animations\n" ..
			"Toggle extend short animations off or on.\n\n" ..
			"The first- and third person animations can differ a lot.\n" ..
			"Especially the reload animation for ranged weapons.\n" ..
			"Repeats third person reload animation if too short.",
		["default_value"] = true,
	},
	{
	  ["setting_name"] = "toggle_mod",
	  ["widget_type"] = "keybind",
	  ["text"] = "Toggle",
	  ["tooltip"] = "Toggle third person on / off.",
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
mod.reset = true
mod.firstperson = false
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
mod.camera = {
	views = {
		first_person = {
			offset = {0, 0, 0},
			models = {name = "first_person", value = 0.5},
			modifier = 1,
		},
		third_person_left = {
			offset = {0.6, -0.8, 0.1},
			models = {name = "third_person", value = 0.5},
			modifier = 1,
		},
		third_person_right = {
			offset = {-0.6, -0.8, 0.1},
			models = {name = "third_person", value = 0.5},
			modifier = 1,
		},
	},
	current_view = nil,
	offset = {x = 0, y = 0, z = 0},
	model = "first_person",
	transitions = {},
	transition_to = function(self, view, delay, length, callback)
		self.transitions = {}
		table.insert(self.transitions, 1, {view = view, delay = delay, length = length or 1.0, callback = callback})
	end,
}
mod.camera.current_view = mod.camera.views.first_person

--[[
	Get current time
--]]
mod.get_time = function(self)
	return Managers.time and Managers.time:time("game") or 0
end
--[[
	Calculate offset value
--]]
mod.calculate_offset = function(self)
	
	-- Set empty values
	-- if not mod.camera.current_view then
		-- mod.camera.current_view = mod.camera.views.first_person
		-- --mod.camera.previous_view = mod.camera.current_view
		-- mod:echo("views set")
	-- end
	
	-- Get current view offset
	local offset = Vector3(mod.camera.current_view.offset[1], mod.camera.current_view.offset[2] * mod.camera.current_view.modifier, mod.camera.current_view.offset[3])
	local t = mod:get_time()

	-- Do transitions
	if #mod.camera.transitions > 0 and Managers.player:local_player().player_unit then
		-- Get transition
		local tr = mod.camera.transitions[#mod.camera.transitions]
		
		if tr.delay then
			if not tr.start then
				-- Setup delay
				tr.start = t
				tr.wait = tr.delay
				
			elseif t > tr.start + tr.wait then
				-- End delay
				tr.delay = nil
				tr.start = nil
				tr.wait = nil
			end
		else
			if not tr.start then
				-- Setup transition
				tr.start = t
				tr.wait = 0.2 * tr.length
				tr.value = 0
				
			elseif t < tr.start + tr.wait then
				-- Running transition
				tr.value = (t - tr.start) / tr.wait
				local start_pos = Vector3(mod.camera.current_view.offset[1], mod.camera.current_view.offset[2] * mod.camera.current_view.modifier, mod.camera.current_view.offset[3])
				local end_pos = Vector3(tr.view.offset[1], tr.view.offset[2] * tr.view.modifier, tr.view.offset[3])
				offset = Vector3.lerp(start_pos, end_pos, tr.value)
				-- Update model on value
				if tr.value > tr.view.models.value then
					mod.camera.model = tr.view.models.name
				end
				
			elseif t > tr.start + tr.wait then
				-- End transition
				mod.camera.current_view = tr.view
				mod.camera.model = tr.view.models.name
				offset = Vector3(tr.view.offset[1], tr.view.offset[2] * tr.view.modifier, tr.view.offset[3]) --* tr.view.modifier
				table.remove(mod.camera.transitions)
				if tr.callback then
					tr.callback()
				end
			end
		end
	end
	
	-- Set camera offset
	mod.camera.offset = {x = offset[1], y = offset[2], z = offset[3]}

end

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
	Set zoom values
--]]
mod.set_zoom_values = function(self, current_node)
	local degrees_to_radians = math.pi/180
	local zoom_fov = 65
	local zoom_setting = self:get("zoom")
	if not self:is_enabled() then zoom_setting = 1 end
	
	if current_node._name == "zoom_in" then
		if zoom_setting == 2 then
			zoom_fov = self.zoom.default.medium
		elseif zoom_setting == 3 then
			zoom_fov = self.zoom.default.low
		elseif zoom_setting == 4 then
			zoom_fov = self.zoom.default.off
		else
			zoom_fov = self.zoom.default.default
		end
		current_node._vertical_fov = zoom_fov*degrees_to_radians				
	elseif current_node._name == "increased_zoom_in" then
		if zoom_setting == 2 then
			zoom_fov = self.zoom.increased.medium
		elseif zoom_setting == 3 then
			zoom_fov = self.zoom.increased.low
		elseif zoom_setting == 4 then
			zoom_fov = self.zoom.increased.off
		else
			zoom_fov = self.zoom.increased.default
		end
		current_node._vertical_fov = zoom_fov*degrees_to_radians
	end	
end
--[[
	Check if first person is blocked
--]]
mod.is_first_person_blocked = function(self, unit)
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
mod.is_third_person_active = function(self)
	return self:is_enabled() and mod.camera.model == "third_person"
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
	if mod:is_third_person_active() then
		if self._first_person_extension then self._first_person_extension.first_person_mode = true end
		func(self, ...)
		if self._first_person_extension then self._first_person_extension.first_person_mode = mod.firstperson end
	else
		func(self, ...)
	end
end)
--[[
	MAIN FUNCTION - Camera positioning
--]]
mod:hook("CameraManager.post_update", function(func, self, dt, t, viewport_name, ...)
	
	-- ##### Original function ########################################################################################
	func(self, dt, t, viewport_name, ...)			
	
	-- ##### Get data #################################################################################################
	local viewport = ScriptWorld.viewport(self._world, viewport_name)
	local camera = ScriptViewport.camera(viewport)
	local shadow_cull_camera = ScriptViewport.shadow_cull_camera(viewport)
	local camera_nodes = self._camera_nodes[viewport_name]
	local current_node = self._current_node(self, camera_nodes)
	local camera_data = self._update_transition(self, viewport_name, camera_nodes, dt)	
		
	-- ##### Counter offset #######################################################################################
	local offset = Vector3(mod.camera.offset.x, mod.camera.offset.y, mod.camera.offset.z)
	camera_data.position = self._calculate_sequence_event_position(self, camera_data, offset)

	-- ##### Change zoom ##############################################################################################
	mod:set_zoom_values(current_node)
	
	-- ##### Update camera ############################################################################################
	self._update_camera_properties(self, camera, shadow_cull_camera, current_node, camera_data, viewport_name)
	self._update_sound_listener(self, viewport_name)		
	ScriptCamera.force_update(self._world, camera)		

end)
--[[
	Fix to apply camera offset to ranged weapons
--]]
mod:hook("PlayerUnitFirstPerson.current_position", function(func, self, ...)

	-- ##### Get data #############################################################################################
	local position = Unit.world_position(self.first_person_unit, 0) --+ Vector3(0, 0, 1.5)
	local current_rot = Unit.local_rotation(self.first_person_unit, 0)

	-- ##### Counter offset #######################################################################################
	local offset = Vector3(mod.camera.offset.x, mod.camera.offset.y, mod.camera.offset.z)

	-- ##### Change position ######################################################################################
	local x = offset.x * Quaternion.right(current_rot)
	local y = offset.y * Quaternion.forward(current_rot)
	local z = Vector3(0, 0, offset.z)
	position = position + x + y + z	
	return position
		
end)
--[[
	MAIN FUNCTION - Set first / third person mode - Hide first person ammo
--]]
mod:hook("PlayerUnitFirstPerson.update", function(func, self, unit, ...)

	if mod.reset then
		self.set_first_person_mode(self, not mod:is_third_person_active())
		mod:start_view(nil, 0.05)
		mod:start_third_person()
		mod.reset = false
	end

	-- ##### Original function ########################################################################################
	func(self, unit, ...)
	
	if not mod:is_first_person_blocked(self.unit) then
		local first_person = mod.camera.model == "first_person"
		if first_person then
			-- ##### Enable first person ##############################################################################
				if not mod.firstperson then
					self.set_first_person_mode(self, true)
					mod.firstperson = true
				end
		else
			-- ##### Disable first person #############################################################################
			if mod.firstperson then
				self.set_first_person_mode(self, false)
				mod.firstperson = false
			end
			
			-- ##### Hide first person ammo ###########################################################################
			local inventory_extension = ScriptUnit.extension(self.unit, "inventory_system")
			local slot_data = inventory_extension.get_slot_data(inventory_extension, "slot_ranged")
			if slot_data then
				if slot_data.right_ammo_unit_1p then Unit.set_unit_visibility(slot_data.right_ammo_unit_1p, false) end
				if slot_data.left_ammo_unit_1p then Unit.set_unit_visibility(slot_data.left_ammo_unit_1p, false) end	
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
mod:hook("StateInGameRunning.event_game_started", function(func, self, ...)
	func(self, ...)
	mod.reset = true
end)
--[[
	Set first person mode for cutscenes
--]]
mod:hook("CutsceneSystem.set_first_person_mode", function(func, self, enabled, ...)
	func(self, enabled, ...)
	mod.reset = true
end)
--[[
	Reset view after character change
--]]
mod:hook("ProfileView.on_exit", function(func, ...)
	func(...)
	mod.reset = true
end)
--[[
	Reset view after equipment change
--]]
mod:hook("InventoryView.on_exit", function(func, self)
	func(self)
	mod.reset = true
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
mod:hook("ActionUtils.spawn_player_projectile", function(func, owner_unit, position, ...)

	-- ##### Get data #############################################################################################
	local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")
	local first_person_unit = first_person_extension.get_first_person_unit(first_person_extension)	
	position = Unit.world_position(first_person_unit, 0) --+ Vector3(0, 0, 1.5)
	local current_rot = Unit.local_rotation(first_person_unit, 0)

	-- ##### Counter offset #######################################################################################
	local offset = Vector3(mod.camera.offset.x, mod.camera.offset.y, mod.camera.offset.z)
	
	-- ##### Change position ######################################################################################
	local x = offset.x * Quaternion.right(current_rot)
	local y = offset.y * Quaternion.forward(current_rot)
	local z = Vector3(0, 0, offset.z)
	position = position + x + y + z	
	
	-- ##### Original function ########################################################################################
	func(owner_unit, position, ...)
end)
--[[
	Fix to apply camera offset to trueflight projectiles
--]]
mod:hook("ActionUtils.spawn_true_flight_projectile", function(func, owner_unit, target_unit, true_flight_template_id, position, ...)

	-- ##### Get data #############################################################################################
	local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")
	local first_person_unit = first_person_extension.get_first_person_unit(first_person_extension)	
	position = Unit.world_position(owner_unit, 0) + Vector3(0, 0, 1.5)
	local current_rot = Unit.local_rotation(first_person_unit, 0)
	
	-- ##### Create offset ########################################################################################
	local offset = Vector3(mod.camera.offset.x, mod.camera.offset.y, mod.camera.offset.z)
	
	-- ##### Change position ######################################################################################
	local x = offset.x * Quaternion.right(current_rot)
	local y = offset.y * Quaternion.forward(current_rot)
	local z = Vector3(0, 0, offset.z)
	position = position + x + y + z	
	
	func(owner_unit, target_unit, true_flight_template_id, position, ...)
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
mod:hook("GenericAmmoUserExtension.start_reload_animation", function(func, self, reload_time, ...)
	func(self, reload_time, ...)
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
mod:hook("GenericAmmoUserExtension.start_reload", function(func, self, ...)
	if self.reload_event and Managers.player:owner(self.owner_unit) == Managers.player:local_player() then
		mod:start_view("automatic_reload", 0.05)
	end
	func(self, ...)
end)
--[[
	Check to disable animation when reloading is done
--]]
mod:hook("GenericAmmoUserExtension.update", function(func, self, unit, input, dt, context, t, ...)
	func(self, unit, input, dt, context, t, ...)
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
			
			if Managers.player:owner(self.owner_unit) == Managers.player:local_player() then
				mod:start_view("automatic_ranged", 0.1)
			end
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
mod:hook("GenericAmmoUserExtension.abort_reload", function(func, self, ...)
	func(self, ...)
	mod.reload.reloading[self.owner_unit] = nil
	mod.reload.extended[self.owner_unit] = nil
	if self.reload_event and Managers.player:owner(self.owner_unit) == Managers.player:local_player() then
		mod:start_view("automatic_ranged", 0.1)
	end
end)

-- #####  █████╗ ██╗   ██╗████████╗ ██████╗ ███╗   ███╗ █████╗ ████████╗██╗ ██████╗ ###################################
-- ##### ██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗████╗ ████║██╔══██╗╚══██╔══╝██║██╔════╝ ###################################
-- ##### ███████║██║   ██║   ██║   ██║   ██║██╔████╔██║███████║   ██║   ██║██║      ###################################
-- ##### ██╔══██║██║   ██║   ██║   ██║   ██║██║╚██╔╝██║██╔══██║   ██║   ██║██║      ###################################
-- ##### ██║  ██║╚██████╔╝   ██║   ╚██████╔╝██║ ╚═╝ ██║██║  ██║   ██║   ██║╚██████╗ ###################################
-- ##### ╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ###################################
mod.start_first_person = function(self, length, delay, callback)
	local view = table.clone(mod.camera.views.first_person)
	mod.camera:transition_to(view, delay, length, callback)
end

mod.start_third_person = function(self, length, delay)
	
	if mod:get("mode") == "third_person" then
		local view = table.clone(mod.camera.views.third_person_left)
		if mod:get("side") == "right" then
			view = table.clone(mod.camera.views.third_person_right)
		end
		view.modifier = (mod:get("offset") or 100) / 100
		view.zoom = mod:get("zoom") or 1
		mod.camera:transition_to(view, delay or 0.1, length or 1.0)
	end
	
end

mod.start_view = function(self, name, delay, length)

	if mod:get("mode") == "automatic" then
		if name and mod:get(name) then
			local view = table.clone(mod.camera.views.first_person)
			if mod:get(name.."_mode") == "third_person" then
				if mod:get(name.."_side") == "right" then
					view = table.clone(mod.camera.views.third_person_right)
				else
					view = table.clone(mod.camera.views.third_person_left)
				end
				view.modifier = (mod:get(name.."_offset") or 100) / 100
				view.zoom = mod:get(name.."_zoom") or 1
			end
			mod.camera:transition_to(view, delay, length)
		else
			local player_unit = Managers.player:local_player() and Managers.player:local_player().player_unit
			if player_unit then
				local inventory_system = ScriptUnit.extension(player_unit, "inventory_system")
				local equipment = inventory_system.equipment(inventory_system)
				local slot_name = equipment.wielded_slot
				if slot_name == "slot_melee" then
					mod:start_view("automatic_melee", delay, length)
				elseif slot_name == "slot_ranged" then
					mod:start_view("automatic_ranged", delay, length)
				end
			end
		end
	end
	
end
--[[
	aim
--]]
mod:hook("ActionAim.client_owner_start_action", function(func, self, ...)
	if Managers.player:owner(self.owner_unit) == Managers.player:local_player() then
		mod:start_view("automatic_aim", 0.05)
	end
	func(self, ...)
end)
mod:hook("ActionAim.finish", function(func, self, ...)
	if Managers.player:owner(self.owner_unit) == Managers.player:local_player() then
		mod:start_view("automatic_ranged", 0.1)
	end
	func(self, ...)
end)
--[[
	trueflight aim
--]]
mod:hook("ActionTrueFlightBowAim.client_owner_start_action", function(func, self, ...)
	if Managers.player:owner(self.owner_unit) == Managers.player:local_player() then
		mod:start_view("automatic_aim", 0.05)
	end
	func(self, ...)
end)
mod:hook("ActionTrueFlightBowAim.finish", function(func, self, ...)
	if Managers.player:owner(self.owner_unit) == Managers.player:local_player() then
		mod:start_view("automatic_ranged", 0.1)
	end
	return func(self, ...)
end)
--[[
	Block
--]]
mod:hook("ActionBlock.client_owner_start_action", function(func, self, ...)
	if Managers.player:owner(self.owner_unit) == Managers.player:local_player() then
		mod:start_view("automatic_block", 0.05)
	end
	func(self, ...)
end)
mod:hook("ActionBlock.finish", function(func, self, reason)
	if Managers.player:owner(self.owner_unit) == Managers.player:local_player() and reason == "hold_input_released" then
		mod:start_view("automatic_melee", 0.1)
	end
	func(self, reason)
end)
--[[
	Wield
--]]
mod.wield_views = {
	slot_ranged = "automatic_ranged",
	slot_melee = "automatic_melee",
	slot_level_event = "automatic_vent",
}
mod:hook("ActionWield.finish", function(func, self)
	if Managers.player:owner(self.owner_unit) == Managers.player:local_player() then
		local view_name = mod.wield_views[self.new_slot]
		if view_name then
			mod:start_view(view_name, 0.1)
		end
	end
	func(self)
end)
--[[
	Push
--]]
mod:hook("ActionPushStagger.client_owner_start_action", function(func, self, ...)
	if Managers.player:owner(self.owner_unit) == Managers.player:local_player() then
		mod:start_view("automatic_push", 0.05)
	end
	func(self, ...)
end)
mod:hook("ActionPushStagger.finish", function(func, self, reason)
	if Managers.player:owner(self.owner_unit) == Managers.player:local_player() then
		mod:start_view("automatic_melee", 0.1)
	end
	func(self, reason)
end)
--[[
	Stunned
--]]
mod:hook("PlayerCharacterStateStunned.on_enter", function(func, self, unit, ...)
	if Managers.player:owner(unit) == Managers.player:local_player() then
		mod:start_view("automatic_stunned", 0.05)
	end
	func(self, unit, ...)
end)
mod:hook("PlayerCharacterStateStunned.on_exit", function(func, self, unit, ...)
	if Managers.player:owner(unit) == Managers.player:local_player() then
		mod:start_view("automatic_melee", 0.1)
	end
	func(self, unit, ...)
end)
--[[
	Vent
--]]
mod:hook("OverChargeExtension.vent_overcharge", function(func, self)
	if Managers.player:owner(self.owner_unit) == Managers.player:local_player() then
		mod:start_view("automatic_vent", 0.05)
	end
	func(self)
end)
mod:hook("OverChargeExtension.vent_overcharge_done", function(func, self)
	if Managers.player:owner(self.owner_unit) == Managers.player:local_player() then
		mod:start_view("automatic_ranged", 0.1)
	end
	func(self)
end)
--[[
	Carry
--]]
mod.level_event_item = false
mod:hook("SimpleInventoryExtension.wield", function(func, self, slot_name)
	func(self, slot_name)
	if Managers.player:owner(self._unit) == Managers.player:local_player() then
		if not mod.level_event_item and slot_name == "slot_level_event" then
			mod:start_view("automatic_carry", 0.05)
			mod.level_event_item = true
		elseif mod.level_event_item then
			mod:start_view(nil, 0.05)
			mod.level_event_item = false
		end
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
mod.on_setting_changed = function(setting_name)
	mod:start_view(nil, 0.05)
	mod:start_third_person()
end
--[[
	Mod Suspended
--]]
mod.on_disabled = function(initial_call)
	mod:start_first_person(1.0, 0.05, function()
		mod:disable_all_hooks()
	end)
end
--[[
	Mod Unsuspended
--]]
mod.on_enabled = function(initial_call)
	mod:enable_all_hooks()
	
	mod:start_view(nil, 0.05)
	mod:start_third_person()
end

-- #####  █████╗  ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ######################################################
-- ##### ██╔══██╗██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ######################################################
-- ##### ███████║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ######################################################
-- ##### ██╔══██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ######################################################
-- ##### ██║  ██║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ######################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ######################################################
--[[
	Toggle side
--]]
mod.toggle_side = function()
	local side = mod:get("side")
	if side == "left" then
		mod:set("side", "right", true)
	else
		mod:set("side", "left", true)
	end
	
	mod:start_third_person()
end
--[[
	Switch offset
--]]
mod.switch_offset = function()
	local offset = mod:get("offset")
	offset = offset + 100
	if offset > 400 then offset = 100 end
	mod:set("offset", offset, true)
	
	mod:start_third_person()
end
--[[
	Switch zoom
--]]
mod.switch_zoom = function()
	local zoom = mod:get("zoom")
	zoom = zoom + 1
	if zoom > 4 then zoom = 1 end
	mod:set("zoom", zoom, true)
	
	mod:start_third_person()
end
--[[
	Update cycle - wait for chatmanager to be present
--]]
mod.update = function(dt)

	-- ##### Calculate transition values ##############################################################################
	mod:calculate_offset()
	
end

-- ##### ███████╗████████╗ █████╗ ██████╗ ████████╗ ###################################################################
-- ##### ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝ ###################################################################
-- ##### ███████╗   ██║   ███████║██████╔╝   ██║    ###################################################################
-- ##### ╚════██║   ██║   ██╔══██║██╔══██╗   ██║    ###################################################################
-- ##### ███████║   ██║   ██║  ██║██║  ██║   ██║    ###################################################################
-- ##### ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ###################################################################
mod:create_options(options_widgets, true, "Third Person", "Lets you play the game in third person")
mod:init_state()