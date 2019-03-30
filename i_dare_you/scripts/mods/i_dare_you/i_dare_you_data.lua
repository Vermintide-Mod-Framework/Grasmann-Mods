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
		-- punishments_default = {
		-- 	damage = {
		-- 		value_default = 2,
		-- 		value_range = {1, 10},
		-- 		frequency_default = 0.25,
		-- 		frequency_range = {0.1, 1},
		-- 	},
		-- },
	},
	{
		setting_id = "stay_on_ground",
		title = "stay_on_ground_text",
		type = "checkbox",
		default_value = true,
		length_default = 30,
		length_range = {10, 60},
		-- punishments_default = {
		-- 	damage = {
		-- 		value_default = 1,
		-- 		value_range = {1, 200},
		-- 		frequency_default = 0.1,
		-- 		frequency_range = {0.1, 1},
		-- 	},
		-- },
	},
	{
		setting_id = "dont_block",
		title = "dont_block_text",
		type = "checkbox",
		default_value = true,
		length_default = 40,
		length_range = {10, 60},
	},
	{
		setting_id = "dont_dodge",
		title = "dont_dodge_text",
		type = "checkbox",
		default_value = true,
		length_default = 30,
		length_range = {10, 60},
	},
	{
		setting_id = "dont_push",
		title = "dont_push_text",
		type = "checkbox",
		default_value = true,
		length_default = 40,
		length_range = {10, 60},
	},
	{
		setting_id = "dont_quick_switch",
		title = "dont_quick_switch_text",
		type = "checkbox",
		default_value = true,
		length_default = 30,
		length_range = {10, 60},
	},
	{
		setting_id = "dont_use_item",
		title = "dont_use_item_text",
		type = "checkbox",
		default_value = true,
		length_default = 40,
		length_range = {10, 60},
	},
	{
		setting_id = "dont_use_melee",
		title = "dont_use_melee_text",
		type = "checkbox",
		default_value = true,
		length_default = 20,
		length_range = {10, 60},
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
	},
	{
		setting_id = "drop_grim",
		title = "drop_grim_text",
		type = "checkbox",
		default_value = true,
		length_default = 30,
		length_range = {10, 60},
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
		-- {
		-- 	setting_id = custom_entry.setting_id.."_dare_punishment",
		-- 	title = "dare_punishment",
		-- 	tooltip = "dare_punishment_description",
		-- 	type = "group",
		-- 	sub_widgets = {
		-- 		{
		-- 			setting_id = custom_entry.setting_id.."_damage_active",
		-- 			title = "dare_punishment_damage",
		-- 			type = "checkbox",
		-- 			default_value = custom_entry.punishments_default.damage ~= nil,
		-- 			sub_widgets = {
		-- 				{
		-- 					setting_id = custom_entry.setting_id.."_damage_amount",
		-- 					title = "dare_punishment_damage_amount",
		-- 					type = "numeric",
		-- 					range = custom_entry.punishments_default.damage.value_range,
		-- 					default_value = custom_entry.punishments_default.damage.value_default,
		-- 					unit_text = "unit_text_empty",
		-- 					decimals_number = 0,
		-- 				},
		-- 			},
		-- 		},
		-- 	},
		-- },
	}
	-- if custom_entry.punishments_default.damage.frequency_default then	
	-- 	custom_entry.sub_widgets[2].sub_widgets[1].sub_widgets[index] = {
	-- 		setting_id = custom_entry.setting_id.."_frequency",
	-- 		title = "dare_punishment_damage_frequency",
	-- 		type = "numeric",
	-- 		range = custom_entry.punishments_default.damage.frequency_range,
	-- 		default_value = custom_entry.punishments_default.damage.frequency_default,
	-- 		unit_text = "unit_text_seconds",
	-- 		decimals_number = 2,
	-- 	}
	-- end
	-- index = index + 1
	customize_dares_table[#customize_dares_table+1] = custom_entry
end

return {
	name = "I dare you!",                           -- Readable mod name
	description = mod:localize("mod_description"),  -- Mod description
	is_togglable = false,                           -- If the mod can be enabled/disabled
	is_mutator = false,                             -- If the mod is mutator
	mutator_settings = {},                          -- Extra settings, if it's mutator
	options = {
		widgets = {                             -- Widget settings for the mod options menu
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
						setting_id = "debug",
						type = "checkbox",
						default_value = false,
					},
					{
						setting_id = "configure_dares",
						type = "group",
						sub_widgets = customize_dares_table,
					},
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
				},
			},
		},
	},
}