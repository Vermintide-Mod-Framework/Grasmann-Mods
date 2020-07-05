local mod = get_mod("ui_improvements")
--[[
	Author: grasmann

    Shows correct comparison tooltip on equipment for other characters
    Reopens saved inventory pages
--]]

-- ##### ██████╗  █████╗ ████████╗ █████╗ #############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################
local saved_index = 1
local dont_save = false
mod.orig_profile_index = nil
mod.orig_career_index = nil

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
    Overwrite functions
--]]
mod.overwrite_item_functions = function(self, overwrite)
    local player = Managers.player:local_player()

    if overwrite then

        -- Backup original profile function
        mod.orig_profile_index = player.profile_index

        -- Overwrite profile function
        player.profile_index = function(self)
            return mod.profile_index or mod.orig_profile_index(self)
        end

        -- Backup original career function
        mod.orig_career_index = player.career_index

        -- Overwrite career function
        player.career_index = function(self)
            return mod.career_index or mod.orig_career_index(self)
        end

    else

        -- Reset original profile functions
        if mod.orig_profile_index then
            player.profile_index = mod.orig_profile_index
            mod.orig_profile_index = nil
        end

        -- Reset original career functions
        if mod.orig_career_index then
            player.career_index = mod.orig_career_index
            mod.orig_career_index = nil
        end

    end

end
--[[
    Replace exotic background texture
--]]
-- mod.overwrite_exotic_background = function(self)
--     if mod:is_enabled() and mod:get("alternative_exotic_background") then
--         UISettings.item_rarity_textures.exotic = "icon_bg_exotic_2"
--     else
--         UISettings.item_rarity_textures.exotic = "icon_bg_exotic"
--     end
-- end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################
--[[
	Render correct item tooltips
--]]
mod:hook(UIPasses.item_tooltip, "draw", function(func, ...)
	
    -- Overwrite item functions
    mod:overwrite_item_functions(true)

	-- Original function
	func(...)

	-- Reset functions
    mod:overwrite_item_functions(false)

end)
--[[
	Get correct items for selected character
--]]
mod:hook(ItemGridUI, "_get_items_by_filter", function(func, self, ...)
	
	-- Overwrite item functions
    mod:overwrite_item_functions(true)

	-- Orig function
    local items = func(self, ...)
	
	-- Reset functions
    mod:overwrite_item_functions(false)

    -- local widget = self._widget
    -- local content = widget.content
    -- local passes = widget.element.passes
    -- mod:dump(passes, "passes", 2)

	return items
end)
--[[
    Open saved inventory category on enter
--]]
mod:hook(HeroWindowLoadoutInventory, "on_enter", function(func, self, ...)

    -- Prevent saved inventory category being overwritten
	dont_save = true
	func(self, ...)
    dont_save = false
    
    -- Open saved inventory category
	if saved_index and mod:get("remember_categories") then
		self.parent:set_selected_loadout_slot_index(saved_index)
    end
    
end)
--[[
    Save opened inventory category
--]]
mod:hook_safe(HeroWindowLoadoutInventory, "_change_category_by_index", function(self, index, ...)

    -- Save selected inventory category
    if not dont_save then saved_index = index end
    
end)
