local mod = get_mod("LoadoutManager")
--[[ 
	LoadoutManager
		- Saves load out settings
	
	Author: walterr, iamlupo & grasmann
	Version: 2.0.0
--]]

-- ##### ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗ #############################################
-- ##### ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝ #############################################
-- ##### ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗ #############################################
-- ##### ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║ #############################################
-- ##### ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║ #############################################
-- ##### ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝ #############################################
local mod_data = {}
mod_data.name = "Loadout Manager" -- Readable mod name
mod_data.description = "Provides quick and easy way to setup and load loadouts." -- Readable mod description
mod_data.is_togglable = false -- If the mod can be enabled/disabled
mod_data.is_mutator = false -- If the mod is mutator
mod_data.options_widgets = {}

-- ##### ██████╗  █████╗ ████████╗ █████╗ #############################################################################
-- ##### ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗ ############################################################################
-- ##### ██║  ██║███████║   ██║   ███████║ ############################################################################
-- ##### ██║  ██║██╔══██║   ██║   ██╔══██║ ############################################################################
-- ##### ██████╔╝██║  ██║   ██║   ██║  ██║ ############################################################################
-- ##### ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ############################################################################
mod.equipment_queue = {}
mod.hero_selection_popup = false
mod.window = nil
mod.last_profile_name = ""
mod.original_update_resync_loadout = nil

-- ##### ██╗      ██████╗  █████╗ ██████╗  ██████╗ ██╗   ██╗████████╗ #################################################
-- ##### ██║     ██╔═══██╗██╔══██╗██╔══██╗██╔═══██╗██║   ██║╚══██╔══╝ #################################################
-- ##### ██║     ██║   ██║███████║██║  ██║██║   ██║██║   ██║   ██║    #################################################
-- ##### ██║     ██║   ██║██╔══██║██║  ██║██║   ██║██║   ██║   ██║    #################################################
-- ##### ███████╗╚██████╔╝██║  ██║██████╔╝╚██████╔╝╚██████╔╝   ██║    #################################################
-- ##### ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝  ╚═════╝  ╚═════╝    ╚═╝    #################################################
--[[
	Check if specified loadout exists
--]]
mod.loadout_exists = function(self, profile_name, loadout_number)
	if profile_name ~= nil then
		local name = self:get_name()
		return self:get(name.."/"..profile_name.."/"..tostring(loadout_number)) ~= nil
	end
	return false
end
--[[
	Save specified loadout to user settings
--]]
mod.save_loadout = function(self, loadout_number, profile_name)
	local loadout = {}

	-- ##### Get Backend IDs ##########################################################################################
	for slot_name, _ in pairs(InventorySettings.slots_by_name) do
		local item_backend_id = ScriptBackendItem.get_loadout_item_id(profile_name, slot_name)
		if item_backend_id then
			loadout[slot_name] = item_backend_id
		end
	end
	
	-- ##### Save #####################################################################################################
	local name = self:get_name()
	self:set(name.."/"..profile_name.."/"..tostring(loadout_number), loadout, true)
	
	-- ##### Feedback #################################################################################################
	self:echo("Loadout #"..tostring(loadout_number).." saved for hero "..profile_name)
end
--[[
	Setup a loadout queue
--]]
mod.set_up_update_resync_loadout_queue = function(self)
	local player_unit = Managers.player:local_player().player_unit
	local inventory_extn = ScriptUnit.extension(player_unit, "inventory_system")
	local attachment_extn = ScriptUnit.extension(player_unit, "attachment_system")
	
	-- ##### Save orginal function ####################################################################################
	self.original_update_resync_loadout = inventory_extn.update_resync_loadout

	inventory_extn.update_resync_loadout = function(self)
		local lm = get_mod("LoadoutManager")
		local is_queue_empty = lm:process_equipment_queue(self, attachment_extn)
		
		-- ##### Check if there are still items to sync ###############################################################
		if self._item_to_spawn then
			-- Sync item
			lm.original_update_resync_loadout(self)
		elseif is_queue_empty then
			-- Restore orginal function
			self.update_resync_loadout = lm.original_update_resync_loadout
			lm.original_update_resync_loadout = nil
		end
	end
end
--[[
	Process loadout queue
--]]
mod.process_equipment_queue = function(self, inventory_extn, attachment_extn)
	local equipment_queue = self.equipment_queue
	
	while equipment_queue[1] and not inventory_extn._item_to_spawn and not attachment_extn._item_to_spawn do
		local next_equip = equipment_queue[1]
		table.remove(equipment_queue, 1)
		
		-- ##### Check if item_backend_id still exist #################################################################
		if ScriptBackendItem.get_key(next_equip.item_backend_id) then
			local item = BackendUtils.get_item_from_masterlist(next_equip.item_backend_id)
			if item then
				local success = next_equip.equipment_page:equip_inventory_item(item, next_equip.slot.inventory_button_index)
				
				if success then
					next_equip.items_page:refresh_items_status()
				end
			end
		end
	end
	return not equipment_queue[1]
end
--[[
	Restore specified loadout
--]]
mod.restore_loadout = function(self, loadout_number, profile_name)
	-- ##### A restore is already running #############################################################################
	if self.original_update_resync_loadout then
		self:echo("Error: restore already in progress")
		return
	end

	-- ##### Inventory view must be open ##############################################################################
	local inventory_ui = self:get_inventory_ui()
	if not inventory_ui then
		self:echo("Error: individual loadout can only be restored from Inventory view")
		return
	end

	-- ##### Get loadout ##############################################################################################
	local pages = inventory_ui.ui_pages
	local name = self:get_name()
	local loadout = self:get(name.."/"..profile_name.."/"..tostring(loadout_number))
	if not loadout then
		self:echo("Error: loadout #"..tostring(loadout_number).." not found for hero "..profile_name)
		return
	end

	-- Part of each equipment change may be done asynchronously, so we set up a
	-- queue to perform the next change only when the current one is finished.
	self:set_up_update_resync_loadout_queue()

	local equipment_page = pages.equipment
	local items_page = pages.items
	local equipment_queue = self.equipment_queue
	
	-- First remove all trinkets in case the loadout contains a trinket that is currently
	-- equipped but in a different slot.
	for _, slot_name in ipairs(InventorySettings.slot_names_by_type["trinket"]) do
		local slot_index = InventorySettings.slots_by_name[slot_name].inventory_button_index
		equipment_page:remove_inventory_item(nil, slot_index)
	end
	
	-- Note that this ordering does slot_hat last, which is important because the
	-- new hat doesn't appear on the player model unless it's done last (for some
	-- reason that I dont have time to figure out right now).
	for _, slot in ipairs(InventorySettings.slots_by_inventory_button_index) do
		local item_backend_id = loadout[slot.name]
		if item_backend_id then
			local current_item = BackendUtils.get_loadout_item(profile_name, slot.name)
			if not current_item or current_item.backend_id ~= item_backend_id then
				equipment_queue[#equipment_queue + 1] = {
					equipment_page = equipment_page,
					items_page = items_page,
					item_backend_id = item_backend_id,
					slot = slot
				}
			end
		end
	end
	
	-- ##### Feedback #################################################################################################
	self:echo("Loadout #"..tostring(loadout_number).." restored for hero "..profile_name)
end
--[[
	Restore loadout for unselected character
--]]
mod.restore_background_loadout = function(self, profile_name, loadout_number)
	-- ##### Doesn't work for currently selected character ############################################################
	if profile_name == Managers.player:local_player():profile_display_name() then
		self:echo("Error: cannot background-restore current hero's loadout")
		return
	end
	
	-- ##### Only works in inn ########################################################################################
	if not DamageUtils.is_in_inn then
		self:echo("Error: can only restore other hero's loadout in Red Moon Inn")
		return
	end

	-- ##### Equip items ##############################################################################################
	local name = self:get_name()
	local loadout = self:get(name.."/"..profile_name.."/"..tostring(loadout_number))
	if loadout then
		for slot_name, backend_id in pairs(loadout) do
			local current_backend_id = ScriptBackendItem.get_loadout_item_id(profile_name, slot_name)
			if backend_id ~= current_backend_id then
				ScriptBackendItem.set_loadout_item(backend_id, profile_name, slot_name)
			end
		end
	else
		self:echo("Error: loadout #"..tostring(loadout_number).." not found for hero "..profile_name)
		return
	end
	
	-- ##### Feedback #################################################################################################
	self:echo("Loadout #"..tostring(loadout_number).." restored for hero "..profile_name)
end

-- ##### ████████╗ ██████╗  ██████╗ ██╗  ████████╗██╗██████╗  #########################################################
-- ##### ╚══██╔══╝██╔═══██╗██╔═══██╗██║  ╚══██╔══╝██║██╔══██╗ #########################################################
-- #####    ██║   ██║   ██║██║   ██║██║     ██║   ██║██████╔╝ #########################################################
-- #####    ██║   ██║   ██║██║   ██║██║     ██║   ██║██╔═══╝  #########################################################
-- #####    ██║   ╚██████╔╝╚██████╔╝███████╗██║   ██║██║      #########################################################
-- #####    ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚═╝   ╚═╝╚═╝      #########################################################
--[[
	Get icons for specified loadout
--]]
mod.get_loadout_icons = function(self, loadout_number, profile_name)
	-- ##### Loadout must exist #######################################################################################
	local name = self:get_name()
	local loadout = self:get(name.."/"..profile_name.."/"..tostring(loadout_number))
	if not loadout then
		self:echo("Error: loadout #"..tostring(loadout_number).." not found for hero "..profile_name)
		return
	end
	
	-- ##### Colors ###################################################################################################
	local rarity_colors = {common = "green", plentiful = "white", exotic = "yellow",
		rare = "blue", promo = "purple", unique = "red"}
	
	-- ##### Get loadout icons ########################################################################################
	local results = {}
	for i = #InventorySettings.slots_by_inventory_button_index, 1, -1 do
		local slot = InventorySettings.slots_by_inventory_button_index[i]
		local item_backend_id = loadout[slot.name]
		-- Check if item key is in master list
		local item_master_list = ItemMasterList
		local key = ScriptBackendItem.get_key(item_backend_id)
		-- Check
		if item_backend_id and key then
			local item = BackendUtils.get_item_from_masterlist(item_backend_id)
			if item then
				local color_name = rarity_colors[item.rarity] or "white"
				results[#results+1] = {
					icon = item.inventory_icon,
					color_name = color_name,
					name = item.localized_name,
					traits = item.traits,
				}
			end
		end
	end
	return results
end
--[[
	Draw loadout tooltip
	Parameters:
		1) loadout_info:{hero_name, id} [, int:font_size, int:line_padding, table:offset, table:padding, string:font_material]
--]]
mod.loadout_tooltip = function(self, loadout_info, font_size, line_padding, offset, padding, font_material)
	local loadout = self:get_loadout_icons(loadout_info[2], loadout_info[1])
	if loadout then
		-- Get mouse position
		local cursor_axis_id = stingray.Mouse.axis_id("cursor")
		local mouse = stingray.Mouse.axis(cursor_axis_id)
		
		-- UI
		local scale = UIResolutionScale()
		local screen_w, screen_h = UIResolution()
		local basic_gui = get_mod("BasicUI")
		
		-- Font
		font_size = font_size or screen_w / 100
		font_material = font_material or basic_gui.default_font_material
		
		-- Offset / Padding
		offset = offset or {20*scale, -20*scale}
		padding = padding or {5*scale, 5*scale, 5*scale, 5*scale}
		line_padding = line_padding or 0*scale
		
		-- Render background
		local tooltip_position = Vector3(mouse[1] + offset[1], mouse[2] + offset[2], 999)
		local size = Vector2(250*scale, 190*scale)
		basic_gui.rect(tooltip_position, size, Color(200, 0, 0, 0))
		
		-- Render Text
		local text_position = Vector3(tooltip_position[1] + padding[1], tooltip_position[2] + size[2] - font_size - padding[2], 999)
		local color = Colors.get_color_with_alpha("cheeseburger", 255)
		basic_gui.text("Loadout "..tostring(loadout_info[2]), text_position, font_size+2, color)
		
		-- Render Icons
		local index = 1
		local icon_size = Vector2(60*scale, 60*scale)
		local icon_x = text_position[1]
		local lines_y = {text_position[2] - icon_size[2] - font_size, text_position[2] - font_size - icon_size[2]*2 - 20*scale}
		for _, item in pairs(loadout) do
		
			color = Colors.get_color_with_alpha(item.color_name, 255)
			local icon_position = Vector3(icon_x, lines_y[1], 999)
			if index > 3 then icon_position = Vector3(icon_x, lines_y[2], 999) end
			
			basic_gui.draw_icon(item.icon, icon_position, nil, icon_size, "gui_item_icons_atlas")
			basic_gui.draw_icon("frame_01", icon_position, color, icon_size, "gui_item_icons_atlas")
			
			-- Render traits
			if item.traits then
				local trait_x = icon_position[1] + icon_size[1] - 10*scale
				local trait_y = icon_position[2] + icon_size[2] - 22*scale
				local tsize = 30
				local trait_size = Vector2(tsize*scale, tsize*scale)
				for i = 1, #item.traits do
					local buff = BuffTemplates[item.traits[i]]
					if buff then
						local c_x = trait_x
						if i == 1 or i == 3 then c_x = trait_x - trait_size[1]/3 end
						basic_gui.draw_icon(buff.icon, Vector3(c_x, trait_y, 999), nil, trait_size, "gui_item_icons_atlas")
						trait_y = trait_y - trait_size[2]*0.75
					end
				end
			end
			
			icon_x = icon_x + icon_size[1] + 20*scale
			index = index + 1
			if index == 4 then icon_x = text_position[1] end
		end
		
	end
end

-- ##### ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗ ###################################
-- ##### ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝ ###################################
-- ##### █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗ ###################################
-- ##### ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║ ###################################
-- ##### ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║ ###################################
-- ##### ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ###################################
--[[
	Get inventory ui
--]]
mod.get_inventory_ui = function(self)
	local matchmaking_manager = Managers.matchmaking
	local ingame_ui = matchmaking_manager and matchmaking_manager.ingame_ui
	local inventory_is_active = ingame_ui and ingame_ui.current_view == "inventory_view"
	return inventory_is_active and ingame_ui.views["inventory_view"]
end
--[[
	Get current profile name in inventory
--]]
mod.current_profile_name = function(self)
	local inventory_ui = self:get_inventory_ui()
	if inventory_ui ~= nil then
		local pages = inventory_ui.ui_pages
		if pages ~= nil then
			return pages.items:current_profile_name()
		end
	end
	return ""
end

-- ##### ██╗    ██╗██╗███╗   ██╗██████╗  ██████╗ ██╗    ██╗ ###########################################################
-- ##### ██║    ██║██║████╗  ██║██╔══██╗██╔═══██╗██║    ██║ ###########################################################
-- ##### ██║ █╗ ██║██║██╔██╗ ██║██║  ██║██║   ██║██║ █╗ ██║ ###########################################################
-- ##### ██║███╗██║██║██║╚██╗██║██║  ██║██║   ██║██║███╗██║ ###########################################################
-- ##### ╚███╔███╔╝██║██║ ╚████║██████╔╝╚██████╔╝╚███╔███╔╝ ###########################################################
-- #####  ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝  ╚══╝╚══╝  ###########################################################
--[[
	Create loadout manager window
--]]
mod.create_window = function(self)
	local screen_w, screen_h = UIResolution()
	local scale = UIResolutionScale()
	local border = 3*scale
	local ui = get_mod("SimpleUI")
	local middle_center = ui and ui.text_alignment.middle_center
	
	-- ##### Check if character selection on join #####################################################################
	if not self.hero_selection_popup then
		-- ##### Inventory must be open ###############################################################################
		local inventory_ui = self:get_inventory_ui()
		if not inventory_ui then
			self:echo("Error: individual loadout can only be restored from Inventory view")
			return
		end
		local pages = inventory_ui.ui_pages
		local profile_name = pages.items:current_profile_name()
		
		-- ##### Window ###############################################################################################
		local window_size = {415, 60}
		local button_size = {(window_size[1]-30)/11, 24}
		local label_size = {36, button_size[2]}
		local label_x = 15
		local line_y = {5, button_size[2] + 10}
		local window_position = {80, 185}
		self.window = ui.create_window("loadout_saver_window", window_position, window_size)
		--self.window:set("transparent", true)
		
		-- ##### Load / Save labels ###################################################################################
		local label = self.window:create_label("loadout_saver_load_text", {label_x, line_y[2]}, label_size, "Load")
		label:set("text_alignment", middle_center)
		local label = self.window:create_label("loadout_saver_save_text", {label_x, line_y[1]}, label_size, "Save")
		label:set("text_alignment", middle_center)
		
		-- ##### Loadout buttons ######################################################################################
		for i=1, 9 do
			if self:loadout_exists(profile_name, i) then
				local position = {30+(button_size[1]+border)*(i), line_y[2]}
				
				-- ##### Load button ##################################################################################
				local button = self.window:create_button("loadout_saver_load" .. tostring(i), position, button_size, tostring(i), nil, {profile_name, i})
				button:set("on_click", function(self)
					local lm = get_mod("LoadoutManager")
					lm:restore_loadout(self.params[2], self.params[1])
				end)
				button:set("on_hover", function(self)
					local lm = get_mod("LoadoutManager")
					lm:loadout_tooltip(self.params)
				end)
			end
			local position = {30+(button_size[1]+border)*(i), line_y[1]}
			
			-- ##### Save button ######################################################################################
			local button = self.window:create_button("loadout_saver_save" .. tostring(i), position, button_size, tostring(i), nil, {profile_name, i})
			button:set("on_click", function(self)
				local lm = get_mod("LoadoutManager")
				lm:save_loadout(self.params[2], self.params[1])
				lm:reload_window()
			end)
			
			button:set("tooltip", "Save loadout "..tostring(i))
		end
	else
		-- ##### Char popup ###########################################################################################
		local window_size = {screen_w, screen_h}
		local window_position = {0, 0}
		
		-- ##### Window ###############################################################################################
		self.window = ui.create_window("loadout_saver_window", window_position, window_size)
		self.window:set("transparent", true)
		
		-- ##### Load / Save labels ###################################################################################
		local label = self.window:create_label("loadout_saver_load_text", {0, screen_h*0.42}, {screen_w, 24}, "Change Loadouts")
		label:set("text_alignment", middle_center)

		-- ##### Loadout buttons ######################################################################################
		local lobby_data = self.hero_selection_popup.lobby_data
		if lobby_data then
			local num_heroes = #SPProfiles
			for i = 1, num_heroes, 1 do
				local hero_name = SPProfiles[i].display_name
				local hero_available = Managers.matchmaking:hero_available_in_lobby_data(i, lobby_data)
				if hero_available then
					local frame_scenegraph = self.hero_selection_popup.ui_scenegraph["button_frame_" .. hero_name]
					local frame_width = frame_scenegraph.size[1]
					local frame_height = frame_scenegraph.size[2]
					local frame_x = frame_scenegraph.world_position[1]
					local frame_y = frame_scenegraph.world_position[2]
					local button_size = {frame_width/3, frame_height/6}
					for j = 1, 9 do
						if self:loadout_exists(hero_name, i) then
						
							-- ##### Get position #####################################################################
							local position = {}
							if j <= 3 then
								position = {frame_x + (button_size[1] + border)*(j-1), frame_y + frame_height}
							else
								position = {frame_x + (button_size[1] + border)*(3), frame_y + frame_height - (button_size[2] + border)*(j-4)}
							end
							
							-- ##### Load button ######################################################################
							local button = self.window:create_button("loadout_saver_load" .. tostring(j), position,
								button_size, tostring(j), nil, nil, {hero_name, j})
							button:set("on_click", function(self)
								local lm = get_mod("LoadoutManager")
								lm:restore_background_loadout(self.params[1], self.params[2])
							end)
							button:set("on_hover", function(self)
								local lm = get_mod("LoadoutManager")
								lm.loadout_tooltip(self.params)
							end)
						end
					end
				end
			end
		end
	end

	self.window:init()
end
--[[
	Destroy loadout manager window
--]]
mod.destroy_window = function(self)
	if self.window then
		self.window:destroy()
	end
end
--[[
	Reload loadout manager window
--]]
mod.reload_window = function(self)
	self:destroy_window()
	self:create_window()
end

-- ##### ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗ ###################################################################
-- ##### ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝ ###################################################################
-- ##### ███████║██║   ██║██║   ██║█████╔╝ ███████╗ ###################################################################
-- ##### ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║ ###################################################################
-- ##### ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║ ###################################################################
-- ##### ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝ ###################################################################
--[[
	InventoryView
--]]
mod:hook("InventoryView.on_exit", function(func, ...)
	func(...)
	mod:destroy_window()
	-- No profile has been selected anymore when closing the inventory menu
	mod.last_profile_name = ""
end)
mod:hook("InventoryView.handle_index_changes", function(func, self)
	-- Can not switch hero display during Loadout Restore or equipment can get equipped to wrong hero.
	if not mod.original_update_resync_loadout then
		func(self)
		local pages = self.ui_pages
		local equipment_page = pages.equipment
		if equipment_page.character_profile_changed then
			mod:reload_window()
		end
	end
end)
mod:hook("InventoryView.exit", function(func, ...)
	-- Can not exit before Loadout Restore is finished else game crash
	if not mod.original_update_resync_loadout then
		func(...)
	end
end)
mod:hook("InventoryView.update_animations", function(func, ...)
	func(...)
	-- Check profile name that has been selected
	local name = mod:current_profile_name()
	if mod.last_profile_name ~= name then
		mod:reload_window()
		mod.last_profile_name = name
	end
end)
--[[
	Join popup
--]]
mod:hook("PopupJoinLobbyHandler.draw", function(func, self, ...)
	func(self, ...)
	if self.visible and not mod.hero_selection_popup then
		mod.hero_selection_popup = self
		mod:reload_window()
	end
end)
mod:hook("PopupJoinLobbyHandler.hide", function(func, ...)
	mod:destroy_window()
	mod.hero_selection_popup = nil
	func(...)
end)
mod:hook("PopupJoinLobbyHandler.update_lobby_data", function(func, ...)
	func(...)
	if mod.window then
		mod:reload_window()
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
mod.on_setting_changed = function(setting_name)
end
--[[
	Mod Suspended
--]]
mod.on_disabled = function(initial_call)
end
--[[
	Mod Unsuspended
--]]
mod.on_enabled = function(initial_call)
end
--[[
	Update cycle - wait for chatmanager to be present
--]]
mod.update = function(dt)
end

-- ##### ███████╗████████╗ █████╗ ██████╗ ████████╗ ###################################################################
-- ##### ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝ ###################################################################
-- ##### ███████╗   ██║   ███████║██████╔╝   ██║    ###################################################################
-- ##### ╚════██║   ██║   ██╔══██║██╔══██╗   ██║    ###################################################################
-- ##### ███████║   ██║   ██║  ██║██║  ██║   ██║    ###################################################################
-- ##### ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ###################################################################
mod:initialize_data(mod_data)