local mod = get_mod("ui_improvements")
--[[
	Author: grasmann

	Prevents crashes when switching cosmetics items for other characters
	Reopens saved cosmetics pages
--]]

-- ##### ██████╗  █████╗ ████████╗ █████╗ #############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################
local dont_save = false
local saved_index = 1

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################
--[[
    Change saved cosmetics category on enter
--]]
mod:hook(HeroWindowCosmeticsInventory, "on_enter", function(func, self, ...)

    -- Prevent saved cosmetics category to be overwritten
	dont_save = true
	func(self, ...)
    dont_save = false
    
    -- Open saved cosmetics category
	if saved_index and mod:get("remember_categories") then
		self.parent:set_selected_cosmetic_slot_index(saved_index)
    end
    
end)
--[[
    Save selected cosmetics category
--]]
mod:hook_safe(HeroWindowCosmeticsInventory, "_change_category_by_index", function(self, index, ...)

    -- Save opened cosmetics category
	if not dont_save then saved_index = index end
    
end)
