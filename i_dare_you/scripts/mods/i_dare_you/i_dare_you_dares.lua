local mod = get_mod("i_dare_you")
--[[
	I dare you!


--]]

mod.template_dare = {
	-- Data
	id = "",
	dare = "",
	fallible = false,
	punishment = "",
	-- Functions
	start_function = function(self)
		return true
	end,
	update_function = function(self)
		return true
	end,
	end_function = function(self)
		return true
	end,
}

local dares = {
	{
		id = "jump_continuously",
		text = "jump_continuously",
		fallible = true,
		punishment = "damage",
	},
	{
		id = "dont_block",
		text = "dont_block",
		fallible = true,
		punishment = "damage",
	},
	{
		id = "dont_dodge",
		text = "dont_dodge",
		fallible = true,
		punishment = "damage",
	},
	{
		id = "dont_use_melee",
		text = "dont_use_melee",
		fallible = true,
		punishment = "damage",
	},
	{
		id = "dont_use_ranged",
		text = "dont_use_ranged",
		fallible = true,
		punishment = "damage",
	},
	{
		id = "reverse_camera",
		text = "reverse_camera",
		fallible = false,
		punishment = nil,
	},
}

return dares
