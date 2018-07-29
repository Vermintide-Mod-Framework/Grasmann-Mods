local mod = get_mod("ui_improvements")
--[[
	Author: grasmann

	Provides hotkey for okri's challenges

	Version: 1.5.0
--]]

mod.opening_keybind_is_pressed = false
mod.closing_keybind_is_pressed = false

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
	Open okri's challenges
--]]
mod.open_achievements = function()
	-- Check if in inn / keep and close hotkey not pressed
	if mod:is_in_inn() and not mod.closing_keybind_is_pressed then
		-- Get ingame ui
		local ingame_ui = Managers.matchmaking and Managers.matchmaking._ingame_ui
		if ingame_ui then
            -- Open achievements
            mod.opening_keybind_is_pressed = true
			ingame_ui:transition_with_fade("hero_view_force", "achievements", nil)
		end
    end
    -- Hotkey not pressed anymore
    mod.closing_keybind_is_pressed = false
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
    local close_keybind = get_mod("ui_improvements"):get("open_achievements")

    -- vmf keybinds input service
    local input_service = Managers.input:get_service("VMFMods")
    local original_is_blocked = input_service:is_blocked()

    -- Unblock
    if original_is_blocked then
        Managers.input:device_unblock_service("keyboard", 1, "VMFMods")
    end

    -- Check if hotkey still pressed
    if mod.opening_keybind_is_pressed and not input_service:get(close_keybind[1]) then
        mod.opening_keybind_is_pressed = false
    end

    -- Check keys
    local input_ctrl = input_service:get("ctrl")
    local input_shift = input_service:get("shift")
    local input_alt = input_service:get("alt")
    local close_menu = false
    if not mod.opening_keybind_is_pressed then
        if input_service:get(close_keybind[1]) and
        (not close_keybind[2] and not input_ctrl or close_keybind[2] and input_ctrl) and
        (not close_keybind[3] and not input_alt or close_keybind[3] and input_alt) and
        (not close_keybind[4] and not input_shift or close_keybind[4] and input_shift) then
            close_menu = true
        end
    end

    -- Block
    if original_is_blocked then
        Managers.input:device_block_service("keyboard", 1, "VMFMods")
    end

    -- Close menu
    if close_menu then
        mod.closing_keybind_is_pressed = true
        --ingame_ui:handle_transition("exit_menu")
        self:close_menu()
    end
end)