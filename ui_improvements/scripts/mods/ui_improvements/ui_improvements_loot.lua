local mod = get_mod("ui_improvements")
--[[
	Author: grasmann

	Lets you open loot boxes for other characters
--]]

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################
--[[
    Open loot state as selected hero
--]]
mod:hook(HeroViewStateLoot, "on_enter", function(func, self, ...)

    -- Overwrite functions
    mod:overwrite_functions(true)
    
    -- Execute original function
    func(self, ...)

    -- Change hero name
    local profile_index = mod.profile_index or self.profile_index
    self.hero_name = SPProfiles[profile_index].display_name
    
    -- Reset functions
    mod:overwrite_functions(false)
    
end)