local mod = get_mod("ChatBlock")
--[[ 
	Chat Block
		- When you are typing in the chat the charter will automaticly block
	
	Author: IamLupo
	Ported: Grasmann
	Improvements: bi
	Version: 1.1.0
--]]

-- ##### ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗ #############################################
-- ##### ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝ #############################################
-- ##### ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗ #############################################
-- ##### ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║ #############################################
-- ##### ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║ #############################################
-- ##### ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝ #############################################
local options_widgets = {
	{
		["setting_name"] = "mode",
		["widget_type"] = "stepper",
		["text"] = "Mode",
		["tooltip"] = "Automatically block when you're chatting.\n\n"..
			"Your block will still break if your stamina runs out.\n\n"..
			"-- ANIMATION --\n"..
			"Blocking animation will play, works only with melee weapons.\n\n"..
			"-- ANIMATION AND PUSH --\n"..
			"You will also push when closing the chat window.\n\n"..
			"-- NO ANIMATION --\n"..
			"No blocking animation, works with ranged weapons.",
		["options"] = {
			{text = "Animation", value = 2},
			{text = "Animation and Push", value = 3},
			{text = "No Animation", value = 1},
		},
		["default_value"] = 2,
	},
}

-- ##### ██████╗  █████╗ ████████╗ █████╗ #############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################
local block_state = {
	NOT_BLOCKING = 0,
	SHOULD_BLOCK = 1,
	BLOCKING = 2,
	SHOULD_PUSH = 3
}
local mod_state = {
	OFF = 0,
	SIMPLE = 1,
	NO_PUSH = 2,
	PUSH = 3
}
mod.block_state = block_state.NOT_BLOCKING

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################
--[[
	Execute weapon action
--]]
mod:hook("CharacterStateHelper.update_weapon_actions", function(func, t, unit, input_extension, inventory_extension, ...)
	local player_unit = Managers.player:local_player().player_unit

	--Check if local player and not in inn
	if(player_unit ~= unit or LevelHelper:current_level_settings().level_id == "inn_level") then
		func(t, unit, input_extension, inventory_extension, ...)
		return
	end

	local status_extension = player_unit and ScriptUnit.has_extension(player_unit, "status_system") and ScriptUnit.extension(player_unit, "status_system")

	--Get data about weapon
	local item_data, right_hand_weapon_extension, left_hand_weapon_extension = CharacterStateHelper._get_item_data_and_weapon_extensions(inventory_extension)
	local new_action, new_sub_action, current_action_settings, current_action_extension, current_action_hand = nil
	current_action_settings, current_action_extension, current_action_hand = CharacterStateHelper._get_current_action_data(left_hand_weapon_extension, right_hand_weapon_extension)
	if not(item_data) or not(status_extension) then
		func(t, unit, input_extension, inventory_extension, ...)
		return
	end
	local item_template = BackendUtils.get_item_template(item_data)
	if not(item_template) then
		func(t, unit, input_extension, inventory_extension, ...)
		return
	end

	--Check if weapon can block
	new_action = "action_two"
	new_sub_action = "default"
	local new_action_template = item_template.actions[new_action]
	local new_sub_action_template = new_action_template and item_template.actions[new_action][new_sub_action] 
	if not(new_sub_action_template) or (not right_hand_weapon_extension and not left_hand_weapon_extension) or (new_sub_action_template.kind ~= "block") then
		func(t, unit, input_extension, inventory_extension, ...)
		return
	end

	--Block
	if (mod.block_state == block_state.SHOULD_BLOCK) then
		mod.block_state = block_state.BLOCKING
		if(left_hand_weapon_extension) then
			left_hand_weapon_extension.start_action(left_hand_weapon_extension, new_action, new_sub_action, item_template.actions, t)				
		end
		if(right_hand_weapon_extension) then
			right_hand_weapon_extension.start_action(right_hand_weapon_extension, new_action, new_sub_action, item_template.actions, t)
		end
		return

	--Push
	elseif(mod.block_state == block_state.SHOULD_PUSH and not status_extension.fatigued(status_extension)) then
		new_action = "action_one"
		new_sub_action = "push"
		if(item_template.actions[new_action][new_sub_action]) then
			if(left_hand_weapon_extension) then
				left_hand_weapon_extension.start_action(left_hand_weapon_extension, new_action, new_sub_action, item_template.actions, t)				
			end
			if(right_hand_weapon_extension) then
				right_hand_weapon_extension.start_action(right_hand_weapon_extension, new_action, new_sub_action, item_template.actions, t)
			end
		end

		--Reset block state
		mod.block_state = block_state.NOT_BLOCKING
	end

	--Continue blocking
	if not(mod.block_state == block_state.BLOCKING) then
		func(t, unit, input_extension, inventory_extension, ...)
	end
end)

-- ##### ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗ #########################################################
-- ##### ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝ #########################################################
-- ##### █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗ #########################################################
-- ##### ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║ #########################################################
-- ##### ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║ #########################################################
-- ##### ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ #########################################################
--[[
	Mod Setting changed
--]]
mod.setting_changed = function(setting_name)
end
--[[
	Mod Suspended
--]]
mod.suspended = function()
	mod:disable_all_hooks()
end
--[[
	Mod Unsuspended
--]]
mod.unsuspended = function()
	mod:enable_all_hooks()
end
--[[
	Update cycle - wait for chatmanager to be present
--]]
mod.update = function(dt)
  -- geting VMF input service for keybindings
  local input_service = Managers.input:get_service("VMFMods")
  if input_service then

    local should_block = input_service:is_blocked()
    local state = mod:get("mode")
    
    if should_block and mod.block_state == block_state.NOT_BLOCKING then	
    
      mod.block_state = block_state.SHOULD_BLOCK
      
    elseif not should_block and mod.block_state == block_state.BLOCKING then
    
      if state == mod_state.PUSH then
        mod.block_state = block_state.SHOULD_PUSH
      else
        mod.block_state = block_state.NOT_BLOCKING
      end
      
    elseif not should_block and mod.block_state ~= block_state.NOT_BLOCKING then
    
      mod.block_state = block_state.NOT_BLOCKING
    end
  end
end

-- ##### ███████╗████████╗ █████╗ ██████╗ ████████╗ ###################################################################
-- ##### ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝ ###################################################################
-- ##### ███████╗   ██║   ███████║██████╔╝   ██║    ###################################################################
-- ##### ╚════██║   ██║   ██╔══██║██╔══██╗   ██║    ###################################################################
-- ##### ███████║   ██║   ██║  ██║██║  ██║   ██║    ###################################################################
-- ##### ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ###################################################################
--[[
	Create option widgets
--]]
mod:create_options(options_widgets, true, "Chat Block", "Block attacks when typing in chat")
--[[
	Suspend if needed
--]]
if mod:is_suspended() then mod.suspended() end