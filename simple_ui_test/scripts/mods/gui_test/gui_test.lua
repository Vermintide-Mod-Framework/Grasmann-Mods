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
	local simple_ui = get_mod("SimpleUI")
	
	window = simple_ui.create_window("test", window_position, window_size)

	window:create_title("title", "Window Title")
	window:create_close_button("close")
	
	local button = window:create_button("button", {10, 50}, {150, 30}, nil, "Test Button")
	button:set("on_click", function()
		mod:echo("Button Clicked")
	end)
	
	local textbox = window:create_textbox("textbox", {10, 90}, {150, 30}, nil, "", "Test...")
	textbox:set("on_text_changed", function()
		mod:echo("Text Changed")
	end)
	
	window:create_label("label", {10, 130},  {150, 30}, nil, "Test label")
	
	local dropdown1 = window:create_dropdown("dropdown", {10, 170},  {150, 30}, nil, {["one"] = 1, ["two"] = 2}, nil, 1, true)
	dropdown1:set("on_index_changed", function()
		mod:echo("Index changed")
	end)
	
	local dropdown2 = window:create_dropdown("dropdown1", {10, 210},  {150, 30}, nil, {["one"] = 1, ["two"] = 2}, nil, 2)
	dropdown2:set("on_index_changed", function()
		mod:echo("Index changed")
	end)
	
	local checkbox = window:create_checkbox("button", {10, 250}, {30, 30}, nil, "Checkbox", true)
	checkbox:set("on_value_changed", function()
		mod:echo("Test checkbox")
	end)
	
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

mod.on_enabled = function(initial_call)
end

--[[
	Hooks
--]]

if VT1 then
	mod:hook("InventoryView.on_enter", view_callback)
	mod:hook("InventoryView.unsuspend", view_callback)
	mod:hook("InventoryView.on_exit", function(func, ...)
		destroy_window()
		return func(...)
	end)
else
	mod:hook("HeroView.on_enter", view_callback)
	mod:hook("HeroView.unsuspend", view_callback)
	mod:hook("HeroView.on_exit", function(func, ...)
		destroy_window()
		return func(...)
	end)
end
