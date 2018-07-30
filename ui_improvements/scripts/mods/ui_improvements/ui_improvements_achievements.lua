local mod = get_mod("ui_improvements")
--[[
	Author: grasmann

	Provides hotkey for okri's challenges

	Version: 1.5.1
--]]

local open_pressed = false
local close_pressed = false

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
    Check if keybinding is pressed
--]]
mod.is_keybinding_pressed = function(self, keybinding)
    local pressed = false

    -- Get VMF input service and blocked state
    local input_service = Managers.input:get_service("VMFMods")
    local original_is_blocked = input_service:is_blocked()

    -- Unblock if needed
    if original_is_blocked then
        Managers.input:device_unblock_service("keyboard", 1, "VMFMods")
    end

    -- Check if hotkey still pressed
    if open_pressed and not input_service:get(keybinding[1]) then
        open_pressed = false
    end

    -- Check keys
    local input_ctrl = input_service:get("ctrl")
    local input_shift = input_service:get("shift")
    local input_alt = input_service:get("alt")
    if not open_pressed then
        if input_service:get(keybinding[1]) and
        (not keybinding[2] and not input_ctrl or keybinding[2] and input_ctrl) and
        (not keybinding[3] and not input_alt or keybinding[3] and input_alt) and
        (not keybinding[4] and not input_shift or keybinding[4] and input_shift) then
            pressed = true
        end
    end

    -- Block
    if original_is_blocked then
        Managers.input:device_block_service("keyboard", 1, "VMFMods")
    end

    return pressed
end
--[[
    Check if ingame ui is active
--]]
mod.is_ingame_ui_active = function(self)
    local ingame_ui = Managers.matchmaking and Managers.matchmaking._ingame_ui
	if ingame_ui and ingame_ui.current_view then
        return true
    end
    return false
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################
--[[
    Close okri's challenges with open hotkey
--]]
mod:hook_safe(HeroViewStateAchievements, "_handle_input", function(self, ...)
    -- Keybinding
    local close_keybind = mod:get("open_achievements")
    local close_menu = mod:is_keybinding_pressed(close_keybind)

    -- Close menu
    if close_menu then
        close_pressed = true
        self:close_menu()
    end
end)

-- ##### ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗ #########################################################
-- ##### ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝ #########################################################
-- ##### █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗ #########################################################
-- ##### ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║ #########################################################
-- ##### ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║ #########################################################
-- ##### ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ #########################################################
--[[
    Reset close button pressed
--]]
mod.update = function(dt)
    -- Check if pressed and ingame ui not active
    if close_pressed and not mod:is_ingame_ui_active() then

        -- Check keybinding
        local close_keybind = mod:get("open_achievements")
        close_pressed = mod:is_keybinding_pressed(close_keybind)

    end
end
--[[
	Open okri's challenges
--]]
mod.open_achievements = function()
	-- Check if in inn / keep and close hotkey not pressed
    if mod:is_in_inn() and not close_pressed then
        
		-- Get ingame ui
		local ingame_ui = Managers.matchmaking and Managers.matchmaking._ingame_ui
        if ingame_ui then
            
            -- Open achievements
            open_pressed = true
            ingame_ui:transition_with_fade("hero_view_force", "achievements", nil)
            
		end
    end

    -- Hotkey not pressed anymore
    close_pressed = false
end
