--[[
	Author:
--]]

local mod = get_mod("gui_test")

--[[
	Functions
--]]

local window = nil

local function create_window()
	local window_size = {170, 330}
	local window_position = {500, 500}

	window = get_mod("simple_ui").create_window("test", window_position, window_size, nil, function() end, true)

	window:create_title("title", "Window Title")
	--window:create_resizer("resizer")
	window:create_close_button("close")

	window:create_button("button", {10, 50}, {150, 30}, "Test Button", function() mod:echo("Test Button") end)
	window:create_textbox("textbox", {10, 90}, {150, 30}, "", "Test...", function() mod:echo("Text changed") end)

	window:create_label("label", {10, 130},  {150, 30}, "Test label")

	window:create_dropdown("dropdown", {10, 170},  {150, 30}, {
		["one"] = 1,
		["two"] = 2
	}, 1, function() mod:echo("Index changed") end, true)

	window:create_dropdown("dropdown1", {10, 210},  {150, 30}, {
		["one"] = 1,
		["two"] = 2
	}, 2, function() mod:echo("Index changed") end)

	window:create_checkbox("button", {10, 250}, {30, 30}, "Checkbox", true, function() mod:echo("Test checkbox") end)

	window:init()
end

local function destroy_window()
	if window then
		window:destroy()
		window = nil
	end
end

local function reload_window()
	destroy_window()
	create_window()
end

local function view_callback(func, ...)
	reload_window()
	return func(...)
end


--[[
	Hooks
--]]

mod:hook("InventoryView.on_enter", view_callback)
mod:hook("InventoryView.unsuspend", view_callback)
mod:hook("InventoryView.on_exit", function(func, ...)
	destroy_window()
	return func(...)
end)
