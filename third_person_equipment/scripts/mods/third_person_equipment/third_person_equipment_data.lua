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
  options = {
    widgets = {
      {
        setting_id = "dwarf_weapon_position",
        type = "dropdown",
        title = "dwarf_weapon_position_text",
        ["tooltip"] = "dwarf_weapon_position_tooltip",
        ["options"] = {
          {text = "option_backpack", value = 1},
          {text = "option_back", value = 2},
        },
        ["default_value"] = 1,
      },
      {
        setting_id = "dwarf_onehand_weapon_position",
        type = "dropdown",
        title = "dwarf_1h_weapon_position_text",
        ["tooltip"] = "dwarf_1h_weapon_position_tooltip",
        ["options"] = {
          {text = "option_default", value = 1},
          {text = "option_belt", value = 2},
          {text = "option_back", value = 3},
        },
        ["default_value"] = 1,
      },
      {
        setting_id = "waywatcher_dualweapon_position",
        type = "dropdown",
        title = "waywatcher_dual_position_text",
        ["tooltip"] = "waywatcher_dual_position_tooltip",
        ["options"] = {
          {text = "option_belt", value = 1},
          {text = "option_back", value = 2},
        },
        ["default_value"] = 1,
      },
      {
        setting_id = "onehand_weapon_position",
        type = "dropdown",
        title = "a_1h_weapon_position_text",
        ["tooltip"] = "a_1h_weapon_position_tooltip",
        ["options"] = {
          {text = "option_belt", value = 1},
          {text = "option_back", value = 2},
        },
        ["default_value"] = 1,
      },
      {
        setting_id = "downscale_big_weapons",
        type = "numeric",
        title = "scale_big_weapons_text",
        ["unit_text"] = "%",
        ["tooltip"] = "scale_big_weapons_tooltip",
        ["range"] = {70, 100},
        ["default_value"] = 75,
      },
      -- {
      --   show_widgets = {1},
      --   setting_id = "change_index",
      --   type = "keybind",
      --   keybind_trigger = "pressed",
      --   keybind_type = "function_call",
      --   title = "Index",
      --   ["tooltip"] = "Index.",
      --   ["default_value"] = {},
      --   function_name = "change_index"
      -- },
    }
  }
}