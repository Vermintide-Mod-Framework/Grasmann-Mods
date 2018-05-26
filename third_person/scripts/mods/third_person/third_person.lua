local mod = get_mod("ThirdPerson")
--[[ 
	Third person
		- Lets you play the game in third person
		- Does the necessary positioning of the camera
		- Applies different fixes to certain situations
	Issues:
		- When camera collides backwards with map aiming inaccurate
	
	Author: grasmann
	Version: 2.0.0
--]]

-- ##### ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗ #############################################
-- ##### ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝ #############################################
-- ##### ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗ #############################################
-- ##### ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║ #############################################
-- ##### ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║ #############################################
-- ##### ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝ #############################################
local mod_data = {}
mod_data.name = "Third Person" -- Readable mod name
mod_data.description = "Lets you play the game in third person." -- Readable mod description
mod_data.is_togglable = true -- If the mod can be enabled/disabled
mod_data.is_mutator = false -- If the mod is mutator
mod_data.options_widgets = {
	{
		["setting_name"] = "mode",
		["widget_type"] = "dropdown",
		["text"] = "Mode",
		["tooltip"] = "Mode\n\n" ..
			"-- THIRD PERSON --\nCamera is always in third person.\n\n" ..
			"-- AUTOMATIC --\nSetup camera settings for specific situations.",
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
				["text"] = "Ranged Weapon",
				["tooltip"] = "Ranged Weapon\n" ..
					"Camera settings when holding a ranged weapon.",
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
								["tooltip"] = "Side\n" ..
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
								["tooltip"] = "Offset\n" ..
									"Change the distance between the camera and the character.",
								["range"] = {50, 400},
								["default_value"] = 100,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_ranged_length",
								["widget_type"] = "numeric",
								["text"] = "Length",
								["unit_text"] = "",
								["tooltip"] = "Length\n" ..
									"Change the length of the transition.",
								["range"] = {0.1, 2},
								["decimals_number"] = 1,
								["default_value"] = 1,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_ranged_delay",
								["widget_type"] = "numeric",
								["text"] = "Delay",
								["unit_text"] = " sec",
								["tooltip"] = "Delay\n" ..
									"Change the delay of the transition.",
								["range"] = {0, 2},
								["decimals_number"] = 1,
								["default_value"] = 0.1,
							},
						},
					},
				},
			},
			{
				["show_widget_condition"] = {2},
				["setting_name"] = "automatic_aim",
				["widget_type"] = "checkbox",
				["text"] = "Aiming",
				["tooltip"] = "Aiming\n" ..
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
								["tooltip"] = "Side\n" ..
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
								["tooltip"] = "Offset\n" ..
									"Change the distance between the camera and the character.",
								["range"] = {50, 400},
								["default_value"] = 100,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_aim_zoom",
								["widget_type"] = "dropdown",
								["text"] = "Zoom",
								["tooltip"] = "Zoom\n" ..
									"Change the zoom strength.",
								["options"] = {
									{text = "Default", value = 1},
									{text = "Medium", value = 2},
									{text = "Low", value = 3},
									{text = "Off", value = 4},
								},
								["default_value"] = 1,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_aim_length",
								["widget_type"] = "numeric",
								["text"] = "Length",
								["unit_text"] = "",
								["tooltip"] = "Length\n" ..
									"Change the length of the transition.",
								["range"] = {0.1, 2},
								["decimals_number"] = 1,
								["default_value"] = 1,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_aim_delay",
								["widget_type"] = "numeric",
								["text"] = "Delay",
								["unit_text"] = " sec",
								["tooltip"] = "Delay\n" ..
									"Change the delay of the transition.",
								["range"] = {0, 2},
								["decimals_number"] = 1,
								["default_value"] = 0.1,
							},
						},
					},
				},
			},
			{
				["show_widget_condition"] = {2},
				["setting_name"] = "automatic_reload",
				["widget_type"] = "checkbox",
				["text"] = "Reloading",
				["tooltip"] = "Reloading\n" ..
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
								["tooltip"] = "Side\n" ..
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
								["tooltip"] = "Offset\n" ..
									"Change the distance between the camera and the character.",
								["range"] = {50, 400},
								["default_value"] = 100,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_reload_length",
								["widget_type"] = "numeric",
								["text"] = "Length",
								["unit_text"] = "",
								["tooltip"] = "Length\n" ..
									"Change the length of the transition.",
								["range"] = {0.1, 2},
								["decimals_number"] = 1,
								["default_value"] = 1,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_reload_delay",
								["widget_type"] = "numeric",
								["text"] = "Delay",
								["unit_text"] = " sec",
								["tooltip"] = "Delay\n" ..
									"Change the delay of the transition.",
								["range"] = {0, 2},
								["decimals_number"] = 1,
								["default_value"] = 0.1,
							},
						},
					},
				},
			},
			{
				["show_widget_condition"] = {2},
				["setting_name"] = "automatic_vent",
				["widget_type"] = "checkbox",
				["text"] = "Venting Overcharge",
				["tooltip"] = "Venting Overcharge\n" ..
					"Camera settings when venting overcharge.",
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
								["tooltip"] = "Side\n" ..
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
								["tooltip"] = "Offset\n" ..
									"Change the distance between the camera and the character.",
								["range"] = {50, 400},
								["default_value"] = 100,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_vent_length",
								["widget_type"] = "numeric",
								["text"] = "Length",
								["unit_text"] = "",
								["tooltip"] = "Length\n" ..
									"Change the length of the transition.",
								["range"] = {0.1, 2},
								["decimals_number"] = 1,
								["default_value"] = 1,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_vent_delay",
								["widget_type"] = "numeric",
								["text"] = "Delay",
								["unit_text"] = " sec",
								["tooltip"] = "Delay\n" ..
									"Change the delay of the transition.",
								["range"] = {0, 2},
								["decimals_number"] = 1,
								["default_value"] = 0.1,
							},
						},
					},
				},
			},
			{
				["show_widget_condition"] = {2},
				["setting_name"] = "automatic_melee",
				["widget_type"] = "checkbox",
				["text"] = "Melee Weapon",
				["tooltip"] = "Melee Weapon\n" ..
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
								["tooltip"] = "Side\n" ..
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
								["tooltip"] = "Offset\n" ..
									"Change the distance between the camera and the character.",
								["range"] = {50, 400},
								["default_value"] = 100,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_melee_length",
								["widget_type"] = "numeric",
								["text"] = "Length",
								["unit_text"] = "",
								["tooltip"] = "Length\n" ..
									"Change the length of the transition.",
								["range"] = {0.1, 2},
								["decimals_number"] = 1,
								["default_value"] = 1,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_melee_delay",
								["widget_type"] = "numeric",
								["text"] = "Delay",
								["unit_text"] = " sec",
								["tooltip"] = "Delay\n" ..
									"Change the delay of the transition.",
								["range"] = {0, 2},
								["decimals_number"] = 1,
								["default_value"] = 0.1,
							},
						},
					},
				},
			},
			{
				["show_widget_condition"] = {2},
				["setting_name"] = "automatic_block",
				["widget_type"] = "checkbox",
				["text"] = "Blocking",
				["tooltip"] = "Blocking\n" ..
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
								["tooltip"] = "Side\n" ..
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
								["tooltip"] = "Offset\n" ..
									"Change the distance between the camera and the character.",
								["range"] = {50, 400},
								["default_value"] = 100,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_block_length",
								["widget_type"] = "numeric",
								["text"] = "Length",
								["unit_text"] = "",
								["tooltip"] = "Length\n" ..
									"Change the length of the transition.",
								["range"] = {0.1, 2},
								["decimals_number"] = 1,
								["default_value"] = 1,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_block_delay",
								["widget_type"] = "numeric",
								["text"] = "Delay",
								["unit_text"] = " sec",
								["tooltip"] = "Delay\n" ..
									"Change the delay of the transition.",
								["range"] = {0, 2},
								["decimals_number"] = 1,
								["default_value"] = 0.5,
							},
						},
					},
				},
			},
			{
				["show_widget_condition"] = {2},
				["setting_name"] = "automatic_push",
				["widget_type"] = "checkbox",
				["text"] = "Pushing",
				["tooltip"] = "Pushing\n" ..
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
								["tooltip"] = "Side\n" ..
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
								["tooltip"] = "Offset\n" ..
									"Change the distance between the camera and the character.",
								["range"] = {50, 400},
								["default_value"] = 100,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_push_length",
								["widget_type"] = "numeric",
								["text"] = "Length",
								["unit_text"] = "",
								["tooltip"] = "Length\n" ..
									"Change the length of the transition.",
								["range"] = {0.1, 2},
								["decimals_number"] = 1,
								["default_value"] = 1,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_push_delay",
								["widget_type"] = "numeric",
								["text"] = "Delay",
								["unit_text"] = " sec",
								["tooltip"] = "Delay\n" ..
									"Change the delay of the transition.",
								["range"] = {0, 2},
								["decimals_number"] = 1,
								["default_value"] = 0.1,
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
								["tooltip"] = "Side\n" ..
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
								["tooltip"] = "Offset\n" ..
									"Change the distance between the camera and the character.",
								["range"] = {50, 400},
								["default_value"] = 100,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_stunned_length",
								["widget_type"] = "numeric",
								["text"] = "Length",
								["unit_text"] = "",
								["tooltip"] = "Length\n" ..
									"Change the length of the transition.",
								["range"] = {0.1, 2},
								["decimals_number"] = 1,
								["default_value"] = 1,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_stunned_delay",
								["widget_type"] = "numeric",
								["text"] = "Delay",
								["unit_text"] = " sec",
								["tooltip"] = "Delay\n" ..
									"Change the delay of the transition.",
								["range"] = {0, 2},
								["decimals_number"] = 1,
								["default_value"] = 0.1,
							},
						},
					},
				},
			},
			{
				["show_widget_condition"] = {2},
				["setting_name"] = "automatic_potion",
				["widget_type"] = "checkbox",
				["text"] = "Holding Potion",
				["tooltip"] = "Holding Potion\n" ..
					"Camera settings when holding a potion.",
				["default_value"] = false,
				["sub_widgets"] = {
					{
						["setting_name"] = "automatic_potion_mode",
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
								["setting_name"] = "automatic_potion_side",
								["widget_type"] = "dropdown",
								["text"] = "Side",
								["tooltip"] = "Side\n" ..
									"Choose if the camera is to left or right of your character.",
								["options"] = {
									{text = "Right", value = "right"},
									{text = "Left", value = "left"},
								},
								["default_value"] = "right",
							},
							{
								["show_widget_condition"] = {2},
								["setting_name"] = "automatic_potion_offset",
								["widget_type"] = "numeric",
								["text"] = "Offset",
								["unit_text"] = "",
								["tooltip"] = "Offset\n" ..
									"Change the distance between the camera and the character.",
								["range"] = {50, 400},
								["default_value"] = 100,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_potion_length",
								["widget_type"] = "numeric",
								["text"] = "Length",
								["unit_text"] = "",
								["tooltip"] = "Length\n" ..
									"Change the length of the transition.",
								["range"] = {0.1, 2},
								["decimals_number"] = 1,
								["default_value"] = 1,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_potion_delay",
								["widget_type"] = "numeric",
								["text"] = "Delay",
								["unit_text"] = " sec",
								["tooltip"] = "Delay\n" ..
									"Change the delay of the transition.",
								["range"] = {0, 2},
								["decimals_number"] = 1,
								["default_value"] = 0.1,
							},
						},
					},
				},
			},
			{
				["show_widget_condition"] = {2},
				["setting_name"] = "automatic_healthkit",
				["widget_type"] = "checkbox",
				["text"] = "Holding Healing Item",
				["tooltip"] = "Holding Healing Item\n" ..
					"Camera settings when holding a healing item.",
				["default_value"] = false,
				["sub_widgets"] = {
					{
						["setting_name"] = "automatic_healthkit_mode",
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
								["setting_name"] = "automatic_healthkit_side",
								["widget_type"] = "dropdown",
								["text"] = "Side",
								["tooltip"] = "Side\n" ..
									"Choose if the camera is to left or right of your character.",
								["options"] = {
									{text = "Right", value = "right"},
									{text = "Left", value = "left"},
								},
								["default_value"] = "right",
							},
							{
								["show_widget_condition"] = {2},
								["setting_name"] = "automatic_healthkit_offset",
								["widget_type"] = "numeric",
								["text"] = "Offset",
								["unit_text"] = "",
								["tooltip"] = "Offset\n" ..
									"Change the distance between the camera and the character.",
								["range"] = {50, 400},
								["default_value"] = 100,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_healthkit_length",
								["widget_type"] = "numeric",
								["text"] = "Length",
								["unit_text"] = "",
								["tooltip"] = "Length\n" ..
									"Change the length of the transition.",
								["range"] = {0.1, 2},
								["decimals_number"] = 1,
								["default_value"] = 1,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_healthkit_delay",
								["widget_type"] = "numeric",
								["text"] = "Delay",
								["unit_text"] = " sec",
								["tooltip"] = "Delay\n" ..
									"Change the delay of the transition.",
								["range"] = {0, 2},
								["decimals_number"] = 1,
								["default_value"] = 0.1,
							},
						},
					},
				},
			},
			{
				["show_widget_condition"] = {2},
				["setting_name"] = "automatic_grenade",
				["widget_type"] = "checkbox",
				["text"] = "Holding Grenades",
				["tooltip"] = "Holding Grenades\n" ..
					"Camera settings when holding a grenade.",
				["default_value"] = false,
				["sub_widgets"] = {
					{
						["setting_name"] = "automatic_grenade_mode",
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
								["setting_name"] = "automatic_grenade_side",
								["widget_type"] = "dropdown",
								["text"] = "Side",
								["tooltip"] = "Side\n" ..
									"Choose if the camera is to left or right of your character.",
								["options"] = {
									{text = "Right", value = "right"},
									{text = "Left", value = "left"},
								},
								["default_value"] = "right",
							},
							{
								["show_widget_condition"] = {2},
								["setting_name"] = "automatic_grenade_offset",
								["widget_type"] = "numeric",
								["text"] = "Offset",
								["unit_text"] = "",
								["tooltip"] = "Offset\n" ..
									"Change the distance between the camera and the character.",
								["range"] = {50, 400},
								["default_value"] = 100,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_grenade_length",
								["widget_type"] = "numeric",
								["text"] = "Length",
								["unit_text"] = "",
								["tooltip"] = "Length\n" ..
									"Change the length of the transition.",
								["range"] = {0.1, 2},
								["decimals_number"] = 1,
								["default_value"] = 1,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_grenade_delay",
								["widget_type"] = "numeric",
								["text"] = "Delay",
								["unit_text"] = " sec",
								["tooltip"] = "Delay\n" ..
									"Change the delay of the transition.",
								["range"] = {0, 2},
								["decimals_number"] = 1,
								["default_value"] = 0.1,
							},
						},
					},
				},
			},
			{
				["show_widget_condition"] = {2},
				["setting_name"] = "automatic_level_event",
				["widget_type"] = "checkbox",
				["text"] = "Carrying Event Item",
				["tooltip"] = "Carrying Event Item\n" ..
					"Camera settings when carrying objective items.",
				["default_value"] = false,
				["sub_widgets"] = {
					{
						["setting_name"] = "automatic_level_event_mode",
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
								["setting_name"] = "automatic_level_event_side",
								["widget_type"] = "dropdown",
								["text"] = "Side",
								["tooltip"] = "Side\n" ..
									"Choose if the camera is to left or right of your character.",
								["options"] = {
									{text = "Right", value = "right"},
									{text = "Left", value = "left"},
								},
								["default_value"] = "right",
							},
							{
								["show_widget_condition"] = {2},
								["setting_name"] = "automatic_level_event_offset",
								["widget_type"] = "numeric",
								["text"] = "Offset",
								["unit_text"] = "",
								["tooltip"] = "Offset\n" ..
									"Change the distance between the camera and the character.",
								["range"] = {50, 400},
								["default_value"] = 100,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_level_event_length",
								["widget_type"] = "numeric",
								["text"] = "Length",
								["unit_text"] = "",
								["tooltip"] = "Length\n" ..
									"Change the length of the transition.",
								["range"] = {0.1, 2},
								["decimals_number"] = 1,
								["default_value"] = 1,
							},
							{
								["show_widget_condition"] = {1, 2},
								["setting_name"] = "automatic_level_event_delay",
								["widget_type"] = "numeric",
								["text"] = "Delay",
								["unit_text"] = " sec",
								["tooltip"] = "Delay\n" ..
									"Change the delay of the transition.",
								["range"] = {0, 2},
								["decimals_number"] = 1,
								["default_value"] = 0.1,
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
				["tooltip"] = "Side\n" ..
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
				["tooltip"] = "Offset\n" ..
					"Change the distance between the camera and the character.",
				["range"] = {50, 400},
				["default_value"] = 100,
			},
			{
				["show_widget_condition"] = {1},
				["setting_name"] = "zoom",
				["widget_type"] = "dropdown",
				["text"] = "Zoom",
				["tooltip"] = "Zoom\n" ..
					"Change the zoom strength.",
				["options"] = {
					{text = "Default", value = 1},
					{text = "Medium", value = 2},
					{text = "Low", value = 3},
					{text = "Off", value = 4},
				},
				["default_value"] = 1,
			},
			{
				["show_widget_condition"] = {1, 2},
				["setting_name"] = "sway",
				["widget_type"] = "checkbox",
				["text"] = "Dynamic Swaying",
				["tooltip"] = "Dynamic Swaying\n" ..
					"In third person the camera smoothly sways from left to right when strafing.",
				["default_value"] = false,
				["sub_widgets"] = {
					{
						["setting_name"] = "sway_speed",
						["widget_type"] = "numeric",
						["text"] = "Speed",
						["unit_text"] = "",
						["tooltip"] = "Speed\n" ..
							"Camera sway speed.",
						["range"] = {0.1, 1},
						["decimals_number"] = 1,
						["default_value"] = 0.5,
					},
					{
						["setting_name"] = "sway_normalize",
						["widget_type"] = "checkbox",
						["text"] = "Normalize",
						["tooltip"] = "Normalize\n" ..
							"Smoothly resets sway amount when not strafing.",
						["default_value"] = false,
					},
					{
						["setting_name"] = "sway_input",
						["widget_type"] = "dropdown",
						["text"] = "Input Type",
						["tooltip"] = "Input Type\n" ..
							"The type of input used for camera sway.",
						["options"] = {
							{text = "Keyboard", value = "keyboard"},
							{text = "Mouse", value = "mouse"},
						},
						["default_value"] = "mouse",
					},
					{
						["setting_name"] = "sway_avoid_character",
						["widget_type"] = "checkbox",
						["text"] = "Avoid Character",
						["tooltip"] = "Avoid Character\n" ..
							"Avoids the character being in front of the camera.",
						["default_value"] = false,
						["sub_widgets"] = {
							{
								["setting_name"] = "sway_avoid_vertical",
								["widget_type"] = "numeric",
								["text"] = "Vertical",
								["unit_text"] = "",
								["tooltip"] = "Vertical\n" ..
									"The strength of sway applied vertically to avoid the character.",
								["range"] = {0, 1},
								["decimals_number"] = 1,
								["default_value"] = 0.75,
							},
							{
								["setting_name"] = "sway_avoid_backwards",
								["widget_type"] = "numeric",
								["text"] = "Backwards",
								["unit_text"] = "",
								["tooltip"] = "Backwards\n" ..
									"The strength of sway applied backwards to avoid the character.",
								["range"] = {0, 1},
								["decimals_number"] = 1,
								["default_value"] = 0.75,
							},
						}
					},
				},
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
	  ["action"] = "toggle_mod_state"
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
	zoom_in = {30, 40, 50, 65},
	increased_zoom_in = {16, 30, 45, 65},
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
			offset = {-0.5, -0.8, 0.1},
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
	sway = {
		frequency = 0.001,
		updated = 0,
		increment = 0.025,
		mouse = {x = 0, y = 0},
		offset = {x = 0, y = 0, z = 0},
	},
}
mod.camera.current_view = mod.camera.views.first_person

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
	Get current time
--]]
mod.get_time = function(self)
	return Managers.time and Managers.time:time("game") or 0
end
--[[
	Set zoom values
--]]
mod.set_zoom_values = function(self, current_node)
	
	local zoom_setting = self.camera.current_view.zoom
	if not self:is_enabled() then zoom_setting = 1 end
	
	local zoom_entry = self.zoom[current_node._name]
	if zoom_entry and zoom_setting then
		local zoom_fov = zoom_entry[zoom_setting] or 65
		local degrees_to_radians = math.pi/180
		current_node._vertical_fov = zoom_fov * degrees_to_radians
	end

end
--[[
	Check if first person is blocked
--]]
mod.is_first_person_blocked = function(self, unit)
	local blocked = false
	local state_system = ScriptUnit.extension(unit, "character_state_machine_system")
	if state_system ~= nil then
		local state = state_system.state_machine.state_current
		blocked = blocked or state.name == "dead"
		blocked = blocked or state.name == "grabbed_by_pack_master"
		blocked = blocked or state.name == "inspecting"
		blocked = blocked or state.name == "interacting"
		blocked = blocked or state.name == "knocked_down"
		blocked = blocked or state.name == "leave_ledge_hanging_falling"
		blocked = blocked or state.name == "leave_ledge_hanging_pull_up"
		blocked = blocked or state.name == "ledge_hanging"
		blocked = blocked or state.name == "pounced_down"
		blocked = blocked or state.name == "waiting_for_assisted_respawn"
		blocked = blocked or state.name == "catapulted"
		blocked = blocked or state.name == "overcharge_exploding"
	end
	return blocked
end
--[[
	Check if third person is active
--]]
mod.is_third_person_active = function(self)
	return self:is_enabled() and self.camera.model == "third_person"
end
--[[
	Calculate offset value
--]]
mod.calculate_offset = function(self)

	-- Get current view offset
	local view = self.camera.current_view
	local offset = Vector3(view.offset[1], view.offset[2] * view.modifier, view.offset[3])
	local t = self:get_time()

	-- Do transitions
	if #self.camera.transitions > 0 then --and Managers.player:local_player().player_unit then
		-- Get transition
		local tr = self.camera.transitions[#self.camera.transitions]
		
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
				local start_pos = Vector3(view.offset[1], view.offset[2] * view.modifier, view.offset[3])
				local end_pos = Vector3(tr.view.offset[1], tr.view.offset[2] * tr.view.modifier, tr.view.offset[3])
				offset = Vector3.lerp(start_pos, end_pos, tr.value)
				-- Update model on value
				if tr.value > tr.view.models.value then
					self.camera.model = tr.view.models.name
				end
				
			elseif t > tr.start + tr.wait then
				-- End transition
				self.camera.current_view = tr.view
				self.camera.model = tr.view.models.name
				offset = Vector3(tr.view.offset[1], tr.view.offset[2] * tr.view.modifier, tr.view.offset[3])
				-- Remove transition
				table.remove(self.camera.transitions)
				-- Execute callback
				if tr.callback then
					tr.callback()
				end
			end
		end
	end
	
	local third_person = self.camera.model == "third_person"
	if self:get("sway") and third_person then
		if t > self.camera.sway.updated + self.camera.sway.frequency then
			local input_manager = Managers.input
			local input_service = input_manager:get_service("Player")
			
			-- ##### Keyboard Input ###################################################################################
			local move_left = input_service:get("move_left")
			local move_right = input_service:get("move_right")
			
			-- ##### Mouse Input ######################################################################################
			local look_left = self.camera.sway.mouse.x < 0
			local look_right = self.camera.sway.mouse.x > 0
			
			-- ##### Values ###########################################################################################
			local view = self.camera.current_view
			local diff = self.camera.views.third_person_left.offset[1] - self.camera.views.third_person_right.offset[1]
			local sway_offset = self.camera.sway.offset
			local increment = self.camera.sway.increment * self:get("sway_speed") or 0.5
			
			-- ##### Move left / right ################################################################################
			if (self:get("sway_input") == "keyboard" and move_left > 0) or (self:get("sway_input") == "mouse" and look_left) then
				sway_offset.x = sway_offset.x - increment
			elseif (self:get("sway_input") == "keyboard" and move_right > 0) or (self:get("sway_input") == "mouse" and look_right) then
				sway_offset.x = sway_offset.x + increment
			else
				if self:get("sway_normalize") then
					if sway_offset.x > 0 then
						sway_offset.x = sway_offset.x - increment
						if sway_offset.x < 0 then sway_offset.x = 0 end
					elseif sway_offset.x < 0 then
						sway_offset.x = sway_offset.x + increment
						if sway_offset.x > 0 then sway_offset.x = 0 end
					end
				end
			end
			
			-- ##### Avoid Character ##################################################################################
			if self:get("sway_avoid_character") then
				
				-- ##### Vertical #####################################################################################
				local max_val = 0.5 * self:get("sway_avoid_vertical") or 0.5
				if self.camera.offset.x <= max_val or self.camera.offset.x >= -max_val then
					sway_offset.z = math.clamp(max_val - math.abs(self.camera.offset.x), 0, max_val)
				end
				
				-- ##### Backwards ####################################################################################
				local max_val = 0.5 * self:get("sway_avoid_backwards") or 0.5
				if self.camera.offset.x <= max_val or self.camera.offset.x >= -max_val then
					sway_offset.y = math.clamp(math.abs(self.camera.offset.x) - max_val, -max_val, 0)
				end
				
			end
			
			-- ##### Change side ######################################################################################
			if view.offset[1] > 0 then
				self.camera.sway.offset = {x = math.clamp(sway_offset.x, -diff, 0), y = sway_offset.y, z = sway_offset.z}
				if self.camera.sway.offset.x == -diff then
					view.offset = self.camera.views.third_person_right.offset
					offset = Vector3(view.offset[1], view.offset[2] * view.modifier, view.offset[3])
					self.camera.sway.offset = {x = 0, y = 0, z = 0}
				end
			elseif view.offset[1] < 0 then
				self.camera.sway.offset = {x = math.clamp(sway_offset.x, 0, diff), y = sway_offset.y, z = sway_offset.z}
				if self.camera.sway.offset.x == diff then
					view.offset = self.camera.views.third_person_left.offset
					offset = Vector3(view.offset[1], view.offset[2] * view.modifier, view.offset[3])
					self.camera.sway.offset = {x = 0, y = 0, z = 0}
				end
			end
			
			self.camera.sway.updated = t
		end
	else
		self.camera.sway.offset = {x = 0, y = 0, z = 0}
	end
	
	-- Set camera offset
	self.camera.offset = {x = offset[1] + self.camera.sway.offset.x, y = offset[2] + self.camera.sway.offset.y, z = offset[3] + self.camera.sway.offset.z}

end
--[[
	Get look input
--]]
mod:hook("PlayerUnitFirstPerson.calculate_look_rotation", function(func, self, current_rotation, look_delta)
	mod.camera.sway.mouse.x = look_delta.x
	mod.camera.sway.mouse.y = look_delta.y
	return func(self, current_rotation, look_delta)
end)
--[[
	Transition to first person
--]]
mod.start_first_person = function(self, callback)
	local view = table.clone(self.camera.views.first_person)
	self.camera:transition_to(view, 0.2, 1.0, callback)
end
--[[
	Transition to third person
--]]
mod.start_third_person = function(self)
	
	if self:is_enabled() and self:get("mode") == "third_person" then
		local view = table.clone(self.camera.views.third_person_left)
		if self:get("side") == "right" then
			view = table.clone(self.camera.views.third_person_right)
		end
		view.modifier = (self:get("offset") or 100) / 100
		view.zoom = self:get("zoom")
		self.camera:transition_to(view, 0.2, 1.0)
	end
	
end
--[[
	Transition to automatic
--]]
mod.start_view = function(self, name)

	if self:is_enabled() and self:get("mode") == "automatic" then
		if name then
			if self:get(name) then
				local view = table.clone(self.camera.views.first_person)
				local length = self:get(name.."_length") or 1.0
				local delay = self:get(name.."_delay") or 0.05
				if self:get(name.."_mode") == "third_person" then
					if self:get(name.."_side") == "right" then
						view = table.clone(self.camera.views.third_person_right)
					else
						view = table.clone(self.camera.views.third_person_left)
					end
					view.modifier = (self:get(name.."_offset") or 100) / 100
				end
				view.zoom = self:get(name.."_zoom")
				self.camera:transition_to(view, delay, length)
			end
		else
			local player_unit = Managers.player and Managers.player:local_player().player_unit
			if player_unit then
				local inventory_system = ScriptUnit.extension(player_unit, "inventory_system")
				local equipment = inventory_system.equipment(inventory_system)
				local slot_name = equipment.wielded_slot
				if slot_name == "slot_melee" then
					self:start_view("automatic_melee")
				elseif slot_name == "slot_ranged" then
					self:start_view("automatic_ranged")
				end
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
	local position = Unit.local_position(self.first_person_unit, 0)
	--local position = func(self, ...)
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
		mod.camera.sway.updated = 0
		self:set_first_person_mode(not mod:is_third_person_active())
		mod:start_view(nil)
		mod:start_third_person()
		mod.reset = false
	end

	-- ##### Original function ########################################################################################
	func(self, unit, ...)
	
	-- ##### Update visibility of weapons #############################################################################
	if not mod:is_first_person_blocked(self.unit) then
		local first_person = mod.camera.model == "first_person"
		if mod:get("mode") == "first_person" then
			--if mod.firstperson then
				self:set_first_person_mode(false)
				mod.firstperson = false
			--end
		elseif mod.camera.model == "first_person" then
			-- ##### Enable first person ##############################################################################
				if not mod.firstperson then
					self:set_first_person_mode(true)
					mod.firstperson = true
				end
		elseif mod.camera.model == "third_person" then
			-- ##### Disable first person #############################################################################
			if mod.firstperson then
				self:set_first_person_mode(false)
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
--[[
	Fix to apply camera offset to projectiles
--]]
mod:hook("ActionUtils.spawn_player_projectile", function(func, owner_unit, position, ...)

	-- ##### Get data #############################################################################################
	local first_person_extension = ScriptUnit.extension(owner_unit, "first_person_system")
	local first_person_unit = first_person_extension.get_first_person_unit(first_person_extension)	
	position = Unit.local_position(first_person_unit, 0)
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
	position = Unit.local_position(first_person_unit, 0)
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

-- ##### ██████╗ ███████╗███████╗███████╗████████╗ ####################################################################
-- ##### ██╔══██╗██╔════╝██╔════╝██╔════╝╚══██╔══╝ ####################################################################
-- ##### ██████╔╝█████╗  ███████╗█████╗     ██║    ####################################################################
-- ##### ██╔══██╗██╔══╝  ╚════██║██╔══╝     ██║    ####################################################################
-- ##### ██║  ██║███████╗███████║███████╗   ██║    ####################################################################
-- ##### ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝   ╚═╝    ####################################################################
--[[
	On some occasions it's necessary to reset the visibility of first- and third person model
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
if VT1 then
	mod:hook("ProfileView.on_exit", function(func, ...)
		func(...)
		mod.reset = true
	end)
else
	mod:hook("CharacterSelectionView.on_exit", function(func, ...)
		func(...)
		mod.reset = true
	end)
	mod:hook("StartMenuView.on_exit", function(func, ...)
		func(...)
		mod.reset = true
	end)
end
--[[
	Reset view after equipment change
--]]
if VT1 then
	mod:hook("InventoryView.on_exit", function(func, ...)
		func(...)
		mod.reset = true
	end)
else
	mod:hook("HeroView.on_exit", function(func, ...)
		func(...)
		mod.reset = true
	end)
end

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
		--CharacterStateHelper.play_animation_event(self.owner_unit, self.reload_event)
		-- ##### Set reloading ########################################################################################
		mod.reload.reloading[self.owner_unit] = {
			reload_time = reload_time,
			start_time = mod.reload.t or 0,
			event = self.reload_event,
		}
	end
end)
--[[
	Start reload
--]]
mod:hook("GenericAmmoUserExtension.start_reload", function(func, self, ...)
	if self.reload_event and Managers.player:owner(self.owner_unit) == Managers.player:local_player() then
		mod:start_view("automatic_reload")
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
				if table.contains(NetworkLookup.anims, wield_anim) then -- Shade volley crossbow fix - wield anim is not in network lookup
					CharacterStateHelper.play_animation_event(self.owner_unit, wield_anim)
				else
					Unit.animation_event(self.owner_unit, wield_anim)
				end
			end
			mod.reload.reloading[self.owner_unit] = nil
			mod.reload.extended[self.owner_unit] = nil
			
			if Managers.player:owner(self.owner_unit) == Managers.player:local_player() then
				mod:start_view("automatic_ranged")
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
		mod:start_view("automatic_ranged")
	end
end)

-- #####  █████╗ ██╗   ██╗████████╗ ██████╗ ███╗   ███╗ █████╗ ████████╗██╗ ██████╗ ###################################
-- ##### ██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗████╗ ████║██╔══██╗╚══██╔══╝██║██╔════╝ ###################################
-- ##### ███████║██║   ██║   ██║   ██║   ██║██╔████╔██║███████║   ██║   ██║██║      ###################################
-- ##### ██╔══██║██║   ██║   ██║   ██║   ██║██║╚██╔╝██║██╔══██║   ██║   ██║██║      ###################################
-- ##### ██║  ██║╚██████╔╝   ██║   ╚██████╔╝██║ ╚═╝ ██║██║  ██║   ██║   ██║╚██████╗ ###################################
-- ##### ╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ###################################
--[[
	Aim
--]]
mod:hook("ActionAim.client_owner_start_action", function(func, self, ...)
	if Managers.player:owner(self.owner_unit) == Managers.player:local_player() then
		mod:start_view("automatic_aim")
	end
	func(self, ...)
end)
mod:hook("ActionAim.finish", function(func, self, ...)
	if Managers.player:owner(self.owner_unit) == Managers.player:local_player() then
		--mod:start_view("automatic_ranged")
		mod:start_view(nil)
	end
	func(self, ...)
end)
--[[
	trueflight aim
--]]
mod:hook("ActionTrueFlightBowAim.client_owner_start_action", function(func, self, ...)
	if Managers.player:owner(self.owner_unit) == Managers.player:local_player() then
		mod:start_view("automatic_aim")
	end
	func(self, ...)
end)
mod:hook("ActionTrueFlightBowAim.finish", function(func, self, ...)
	if Managers.player:owner(self.owner_unit) == Managers.player:local_player() then
		--mod:start_view("automatic_ranged")
		mod:start_view(nil)
	end
	return func(self, ...)
end)
--[[
	Block
--]]
mod:hook("ActionBlock.client_owner_start_action", function(func, self, ...)
	if Managers.player:owner(self.owner_unit) == Managers.player:local_player() then
		mod:start_view("automatic_block")
	end
	func(self, ...)
end)
mod:hook("ActionBlock.finish", function(func, self, reason)
	if Managers.player:owner(self.owner_unit) == Managers.player:local_player() and reason == "hold_input_released" then
		--mod:start_view("automatic_melee")
		mod:start_view(nil)
	end
	func(self, reason)
end)
--[[
	Push
--]]
mod:hook("ActionPushStagger.client_owner_start_action", function(func, self, ...)
	if Managers.player:owner(self.owner_unit) == Managers.player:local_player() then
		mod:start_view("automatic_push")
	end
	func(self, ...)
end)
mod:hook("ActionPushStagger.finish", function(func, self, reason)
	if Managers.player:owner(self.owner_unit) == Managers.player:local_player() then
		--mod:start_view("automatic_melee")
		mod:start_view(nil)
	end
	func(self, reason)
end)
--[[
	Stunned
--]]
mod:hook("PlayerCharacterStateStunned.on_enter", function(func, self, unit, ...)
	if Managers.player:owner(unit) == Managers.player:local_player() then
		mod:start_view("automatic_stunned")
	end
	func(self, unit, ...)
end)
mod:hook("PlayerCharacterStateStunned.on_exit", function(func, self, unit, ...)
	if Managers.player:owner(unit) == Managers.player:local_player() then
		--mod:start_view("automatic_melee")
		mod:start_view(nil)
	end
	func(self, unit, ...)
end)
--[[
	Vent
--]]
if VT1 then
	mod:hook("OverChargeExtension.vent_overcharge", function(func, self)
		if Managers.player:owner(self.owner_unit) == Managers.player:local_player() then
			mod:start_view("automatic_vent")
		end
		func(self)
	end)
	mod:hook("OverChargeExtension.vent_overcharge_done", function(func, self)
		if Managers.player:owner(self.owner_unit) == Managers.player:local_player() then
			--mod:start_view("automatic_ranged")
			mod:start_view(nil)
		end
		func(self)
	end)
else
	mod:hook("PlayerUnitOverchargeExtension.vent_overcharge", function(func, self)
		if Managers.player:owner(self.unit) == Managers.player:local_player() then
			mod:start_view("automatic_vent")
		end
		func(self)
	end)
	mod:hook("PlayerUnitOverchargeExtension.vent_overcharge_done", function(func, self)
		if Managers.player:owner(self.unit) == Managers.player:local_player() then
			--mod:start_view("automatic_ranged")
			mod:start_view(nil)
		end
		func(self)
	end)
end
--[[
	Wield
--]]
mod:hook("SimpleInventoryExtension.wield", function(func, self, slot_name)
	func(self, slot_name)
	if Managers.player:owner(self._unit) == Managers.player:local_player() then
		mod:start_view("automatic_"..string.sub(slot_name, 6))
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
	mod:start_view(nil)
	mod:start_third_person()
end
--[[
	Mod Suspended
--]]
mod.on_disabled = function(initial_call)
	mod:start_first_person(function()
		mod:disable_all_hooks()
		mod:hook_enable("CameraManager.post_update")
	end)
end
--[[
	Mod Unsuspended
--]]
mod.on_enabled = function(initial_call)
	mod:enable_all_hooks()
	mod:start_view(nil)
	mod:start_third_person()
end
--[[
	Update cycle - wait for chatmanager to be present
--]]
mod.update = function(dt)
	mod:calculate_offset()
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
	if side == "left" then mod:set("side", "right", true)
	else mod:set("side", "left", true) end
	
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

-- ##### ███████╗████████╗ █████╗ ██████╗ ████████╗ ###################################################################
-- ##### ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝ ###################################################################
-- ##### ███████╗   ██║   ███████║██████╔╝   ██║    ###################################################################
-- ##### ╚════██║   ██║   ██╔══██║██╔══██╗   ██║    ###################################################################
-- ##### ███████║   ██║   ██║  ██║██║  ██║   ██║    ###################################################################
-- ##### ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ###################################################################
mod:initialize_data(mod_data)