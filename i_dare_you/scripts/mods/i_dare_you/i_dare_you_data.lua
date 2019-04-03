local mod = get_mod("i_dare_you")
--[[
	I dare you!

	Optione menu definitions.
--]]

local customize_dares = {
	{
		setting_id = "jump_continuously",
		title = "jump_continuously_text",
		type = "checkbox",
		default_value = true,
		length_default = 20,
		length_range = {10, 60},
	},
	{
		setting_id = "stay_on_ground",
		title = "stay_on_ground_text",
		type = "checkbox",
		default_value = true,
		length_default = 30,
		length_range = {10, 60},
	},
	{
		setting_id = "dont_block",
		title = "dont_block_text",
		type = "checkbox",
		default_value = true,
		length_default = 40,
		length_range = {10, 60},
		deactivate_on_assisted_respawn = true,
	},
	{
		setting_id = "dont_dodge",
		title = "dont_dodge_text",
		type = "checkbox",
		default_value = true,
		length_default = 30,
		length_range = {10, 60},
		allow_catapult = true,
	},
	{
		setting_id = "dont_push",
		title = "dont_push_text",
		type = "checkbox",
		default_value = true,
		length_default = 40,
		length_range = {10, 60},
		allow_catapult = true,
	},
	{
		setting_id = "dont_switch_equipment",
		title = "dont_switch_equipment_text",
		type = "checkbox",
		default_value = true,
		length_default = 30,
		length_range = {10, 60},
		allow_catapult = true,
	},
	{
		setting_id = "dont_use_item",
		title = "dont_use_item_text",
		type = "checkbox",
		default_value = true,
		length_default = 40,
		length_range = {10, 60},
		allow_catapult = true,
	},
	{
		setting_id = "dont_use_melee",
		title = "dont_use_melee_text",
		type = "checkbox",
		default_value = true,
		length_default = 20,
		length_range = {10, 60},
		allow_catapult = true,
	},
	{
		setting_id = "dont_use_ranged",
		title = "dont_use_ranged_text",
		type = "checkbox",
		default_value = true,
		length_default = 30,
		length_range = {10, 60},
	},
	{
		setting_id = "dont_use_skill",
		title = "dont_use_skill_text",
		type = "checkbox",
		default_value = true,
		length_default = 40,
		length_range = {10, 60},
		allow_catapult = true,
	},
	{
		setting_id = "drop_grim",
		title = "drop_grim_text",
		type = "checkbox",
		default_value = true,
		length_default = 30,
		length_range = {10, 60},
	},
	{
		setting_id = "dont_ping",
		title = "dont_ping_text",
		type = "checkbox",
		default_value = true,
		length_default = 30,
		length_range = {10, 60},
		allow_catapult = true,
	},
}

local customize_dares_table = {}

for _, custom in pairs(customize_dares) do
	local custom_entry = table.clone(custom)
	local index = 2
	custom_entry.sub_widgets = {
		{
			setting_id = custom_entry.setting_id.."_dare_length",
			title = "dare_length",
			tooltip = "dare_length_description",
			type = "numeric",
			range = custom_entry.length_range,
			default_value = custom_entry.length_default,
			unit_text = "unit_text_seconds",
			decimals_number = 0,
		},
	}
	-- Deactivate on revive / assisted respawn
	if custom_entry.deactivate_on_assisted_respawn ~= nil then
		custom_entry.sub_widgets[#custom_entry.sub_widgets+1] = {
			setting_id = custom_entry.setting_id.."_deactivate_on_assisted_respawn",
			title = "deactivate_on_assisted_respawn",
			tooltip = "deactivate_on_assisted_respawn_description",
			type = "checkbox",
			default_value = custom_entry.deactivate_on_assisted_respawn,
		}
	end
	-- Allow catapult punishment
	if custom_entry.allow_catapult ~= nil then
		custom_entry.sub_widgets[#custom_entry.sub_widgets+1] = {
			setting_id = custom_entry.setting_id.."_allow_catapult",
			title = "allow_catapult",
			tooltip = "allow_catapult_description",
			type = "checkbox",
			default_value = custom_entry.allow_catapult,
		}
	end
	customize_dares_table[#customize_dares_table+1] = custom_entry
end

return {
	name = "I dare you!",                           -- Readable mod name
	description = mod:localize("mod_description"),  -- Mod description
	is_togglable = false,                           -- If the mod can be enabled/disabled
	is_mutator = false,                             -- If the mod is mutator
	mutator_settings = {},                          -- Extra settings, if it's mutator
	options = {
		collapsed_widgets = {
			"common_settings",
			"configure_dares",
			"configure_hotkeys",
			"configure_punishments",
	  	},
		widgets = {                             	-- Widget settings for the mod options menu
			{
				setting_id = "active",
				type = "checkbox",
				default_value = true,
				sub_widgets = {
					{
						setting_id = "mode",
						type = "dropdown",
						options = {
							{text = "mode_option_full_party_text", 	value = 1},
							{text = "mode_option_at_least_2_text", 	value = 2},
							{text = "mode_option_alone_text", 		value = 3},
						},
						default_value = 2,
					},
					{
						setting_id = "common_settings",
						type = "group",
						sub_widgets = {
							{
								setting_id = "initial_time",
								type = "numeric",
								range = {10, 60},
								default_value = 20,
								decimals_number = 0,
								unit_text = "unit_text_seconds",
							},
							{
								setting_id = "selection_time",
								type = "numeric",
								range = {5, 30},
								default_value = 20,
								decimals_number = 0,
								unit_text = "unit_text_seconds",
							},
							{
								setting_id = "random_choice",
								type = "checkbox",
								default_value = false,
							},
							{
								setting_id = "sound_effects",
								type = "checkbox",
								default_value = true,
							},
							{
								setting_id = "all_players",
								type = "checkbox",
								default_value = true,
								sub_widgets = {
									{
										setting_id = "all_players_chance",
										type = "numeric",
										range = {1, 100},
										default_value = 5,
										decimals_number = 0,
										unit_text = "unit_text_percent",
									},
								},
							},
						},
					},
					{
						setting_id = "configure_dares",
						type = "group",
						sub_widgets = customize_dares_table,
					},
					{
						setting_id = "configure_punishments",
						type = "group",
						sub_widgets = {
							{
								setting_id = "punishment_catapult",
								tooltip = "allow_catapult_description",
								type = "checkbox",
								default_value = true,
							},
						},
					},
					{
						setting_id = "configure_hotkeys",
						type = "group",
						sub_widgets = {
							{
								setting_id = "activate_dare_1",
								type = "keybind",
								keybind_trigger = "pressed",
								keybind_type = "function_call",
								function_name = "activate_dare_1",
								default_value = {"f5"},
							},
							{
								setting_id = "activate_dare_2",
								type = "keybind",
								keybind_trigger = "pressed",
								keybind_type = "function_call",
								function_name = "activate_dare_2",
								default_value = {"f6"},
							},
							{
								setting_id = "activate_dare_3",
								type = "keybind",
								keybind_trigger = "pressed",
								keybind_type = "function_call",
								function_name = "activate_dare_3",
								default_value = {"f7"},
							},
							{
								setting_id = "activate_random_dare",
								type = "keybind",
								keybind_trigger = "pressed",
								keybind_type = "function_call",
								function_name = "activate_random_dare",
								default_value = {},
							},
							{
								setting_id = "start_server",
								type = "keybind",
								keybind_trigger = "pressed",
								keybind_type = "function_call",
								function_name = "start_server",
								default_value = {},
							},
							{
								setting_id = "stop_server",
								type = "keybind",
								keybind_trigger = "pressed",
								keybind_type = "function_call",
								function_name = "stop_server",
								default_value = {},
							},
							-- {
							-- 	setting_id = "test_player_knockdown",
							-- 	type = "keybind",
							-- 	keybind_trigger = "pressed",
							-- 	keybind_type = "function_call",
							-- 	function_name = "test_player_knockdown",
							-- 	default_value = {},
							-- },
						},
					},
					{
						setting_id = "debug",
						type = "checkbox",
						default_value = false,
					},
				},
			},
		},
	},
}