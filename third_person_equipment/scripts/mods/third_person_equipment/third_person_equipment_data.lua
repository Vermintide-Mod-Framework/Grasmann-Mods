local mod = get_mod("ThirdPersonEquipment")
--[[ 
  Third person equipment data
	
	Author: grasmann
--]]

return {
  name = "Third Person Equipment",
  description = mod:localize("mod_description"),
  is_togglable = true,
  allow_rehooking = true,
  options_widgets = {
    {
      ["setting_name"] = "dwarf_weapon_position",
      ["widget_type"] = "dropdown",
      ["text"] = mod:localize("dwarf_weapon_position_text"),
      ["tooltip"] = mod:localize("dwarf_weapon_position_tooltip"),
      ["options"] = {
        {text = mod:localize("option_backpack"), value = 1},
        {text = mod:localize("option_back"), value = 2},
      },
      ["default_value"] = 1,
    },
    {
      ["setting_name"] = "dwarf_onehand_weapon_position",
      ["widget_type"] = "dropdown",
      ["text"] = mod:localize("dwarf_1h_weapon_position_text"),
      ["tooltip"] = mod:localize("dwarf_1h_weapon_position_tooltip"),
      ["options"] = {
        {text = mod:localize("option_default"), value = 1},
        {text = mod:localize("option_belt"), value = 2},
        {text = mod:localize("option_back"), value = 3},
      },
      ["default_value"] = 1,
    },
    {
      ["setting_name"] = "waywatcher_dualweapon_position",
      ["widget_type"] = "dropdown",
      ["text"] = mod:localize("waywatcher_dual_position_text"),
      ["tooltip"] = mod:localize("waywatcher_dual_position_tooltip"),
      ["options"] = {
        {text = mod:localize("option_belt"), value = 1},
        {text = mod:localize("option_back"), value = 2},
      },
      ["default_value"] = 1,
    },
    {
      ["setting_name"] = "onehand_weapon_position",
      ["widget_type"] = "dropdown",
      ["text"] = mod:localize("a_1h_weapon_position_text"),
      ["tooltip"] = mod:localize("a_1h_weapon_position_tooltip"),
      ["options"] = {
        {text = mod:localize("option_belt"), value = 1},
        {text = mod:localize("option_back"), value = 2},
      },
      ["default_value"] = 1,
    },
    {
      ["setting_name"] = "downscale_big_weapons",
      ["widget_type"] = "numeric",
      ["text"] = mod:localize("scale_big_weapons_text"),
      ["unit_text"] = "%",
      ["tooltip"] = mod:localize("scale_big_weapons_tooltip"),
      ["range"] = {50, 100},
      ["default_value"] = 75,
    },
    -- {
    --   ["show_widget_condition"] = {1},
    --   ["setting_name"] = "change_index",
    --   ["widget_type"] = "keybind",
    --   ["text"] = "Index",
    --   ["tooltip"] = "Index.",
    --   ["default_value"] = {},
    --   ["action"] = "change_index"
    -- },
  }
}