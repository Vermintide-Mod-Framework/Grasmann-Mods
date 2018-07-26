local mod = get_mod("ui_improvements")
--[[
	Author: grasmann

	Lets you switch equippment of all characters / classes in inventory

	Version: 1.3.0
--]]

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################
--[[
	Open chest for other heroes
--]]
mod:hook(HeroViewStateLoot, "_open_chest", function(func, self, ...)

	-- Change hero name
    self.hero_name = SPProfiles[mod.profile_index].display_name
    
	-- Original function
    func(self, ...)
    
end)
--[[
    Open loot state as selected hero
--]]
mod:hook(HeroViewStateLoot, "on_enter", function(func, self, params, optional_ignore_item_population, ...)

    -- Overwrite functions
    mod:overwrite_functions(true)
    
    -- Execute original function
    func(self, params, optional_ignore_item_population, ...)
    
    -- Reset functions
    mod:overwrite_functions(false)
    
end)