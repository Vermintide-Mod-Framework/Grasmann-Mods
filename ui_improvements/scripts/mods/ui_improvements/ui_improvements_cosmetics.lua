local mod = get_mod("ui_improvements")
--[[
	Author: grasmann

	Displays seperate buttons for every crafting page

	Version: 1.3.2
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
--[[
	Prevent hat to be destroyed and spawned when not active character
--]]
mod:hook(PlayerUnitAttachmentExtension, "create_attachment_in_slot", function(func, self, ...)
	local player = Managers.player:local_player()
	-- If local player
	if self._player == player then
		-- If different character or career selected cancel process
		if mod.profile_index ~= mod.actual_profile_index or mod.career_index ~= mod.actual_career_index then
			return
		end
	end
	-- Continue with original function
	func(self, ...)
end)
--[[
	Prevent skin to be destroyed and spawned when not active character
--]]
mod:hook(IngameUI, "respawn", function(func, ...)
	-- If different character or career selected cancel process
	if mod.profile_index ~= mod.actual_profile_index or mod.career_index ~= mod.actual_career_index then
		return
	end
	-- Continue with original function
	func(...)
end)