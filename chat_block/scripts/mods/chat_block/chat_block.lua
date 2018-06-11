local mod = get_mod("ChatBlock")
--[[ 
	Chat Block
		- When you are typing in the chat the charter will automaticly block
	
	Author: IamLupo
	Ported: Grasmann
	Improvements: bi
	Version: 2.0.2
--]]

-- ##### ██████╗  █████╗ ████████╗ █████╗  ############################################################################
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
mod:hook(CharacterStateHelper, "update_weapon_actions", function(func, t, unit, input_extension, inventory_extension, ...)
	local player_unit = Managers.player and Managers.player:local_player().player_unit
	
	-- Check if local player
	if player_unit ~= unit then
		func(t, unit, input_extension, inventory_extension, ...)
		return
	end
	
	-- Check not in inn
	if LevelHelper:current_level_settings().level_id == "inn_level" then
		func(t, unit, input_extension, inventory_extension, ...)
		return
	end

	local status_extension = player_unit and ScriptUnit.has_extension(player_unit, "status_system") and ScriptUnit.extension(player_unit, "status_system")

	--Get data about weapon
	local item_data, right_hand_weapon_extension, left_hand_weapon_extension
	local new_action, new_sub_action, current_action_settings, current_action_extension, current_action_hand
	if VT1 then
		item_data, right_hand_weapon_extension, left_hand_weapon_extension = CharacterStateHelper._get_item_data_and_weapon_extensions(inventory_extension)
		current_action_settings, current_action_extension, current_action_hand = CharacterStateHelper._get_current_action_data(left_hand_weapon_extension, right_hand_weapon_extension)
	else
		item_data, right_hand_weapon_extension, left_hand_weapon_extension = CharacterStateHelper.get_item_data_and_weapon_extensions(inventory_extension)
		current_action_settings, current_action_extension, current_action_hand = CharacterStateHelper.get_current_action_data(left_hand_weapon_extension, right_hand_weapon_extension)
	end
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
		if(right_hand_weapon_extension) then
			right_hand_weapon_extension.start_action(right_hand_weapon_extension, new_action, new_sub_action, item_template.actions, t)
		elseif(left_hand_weapon_extension) then
			left_hand_weapon_extension.start_action(left_hand_weapon_extension, new_action, new_sub_action, item_template.actions, t)				
		end
		return

	--Push
	elseif(mod.block_state == block_state.SHOULD_PUSH and not status_extension.fatigued(status_extension)) then
		new_action = "action_one"
		new_sub_action = "push"
		if(item_template.actions[new_action][new_sub_action]) then
			if(right_hand_weapon_extension) then
				right_hand_weapon_extension.start_action(right_hand_weapon_extension, new_action, new_sub_action, item_template.actions, t)
			elseif(left_hand_weapon_extension) then
				left_hand_weapon_extension.start_action(left_hand_weapon_extension, new_action, new_sub_action, item_template.actions, t)				
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
	Mod Unsuspended
--]]
mod.on_enabled = function(initial_call)
	-- Set block because option menu must be open
	if not initial_call then
		mod.block_state = block_state.SHOULD_BLOCK
	end
end
--[[
	Update cycle - wait for chatmanager to be present
--]]
mod.update = function(dt)
  -- geting VMF input service for keybindings
  local input_service = Managers.input:get_service("VMFMods")
  if input_service then

    local should_block = input_service:is_blocked()
	
    if should_block and mod.block_state == block_state.NOT_BLOCKING then	
		
      mod.block_state = block_state.SHOULD_BLOCK
      
    elseif not should_block and mod.block_state == block_state.BLOCKING then
    
      if mod:get("mode") == "animation_push" then
        mod.block_state = block_state.SHOULD_PUSH
      else
        mod.block_state = block_state.NOT_BLOCKING
      end
      
    elseif not should_block and mod.block_state ~= block_state.NOT_BLOCKING then
    
      mod.block_state = block_state.NOT_BLOCKING
    end
  end
end