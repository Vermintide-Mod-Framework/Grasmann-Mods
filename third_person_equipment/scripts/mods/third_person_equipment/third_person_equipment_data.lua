local mod = get_mod("ThirdPersonEquipment")

return {
  name = "Third Person Equipment",
  description = mod:localize("mod_description"),
  is_togglable = true,
  options_widgets = {
    {
      ["setting_name"] = "dwarf_weapon_position",
      ["widget_type"] = "dropdown",
      ["text"] = "Dwarf Weapon Position",
      ["tooltip"] =  VT1 and "Dwarf Weapon Position\n" ..
        "Choose the position of the dwarf weapons.\n\n" ..
        "-- Backpack --\n" ..
        "Weapons will be placed on the backpack.\n\n" ..
        "-- Back --\n" ..
        "Weapons will be placed on the back.",
      ["options"] = VT1 and {
        {text = "Backpack", value = 1},
        {text = "Back", value = 2},
      } or {
        {text = "Back", value = 2},
      },
      ["default_value"] = VT1 and 1 or 2,
    },
    {
      ["setting_name"] = "dwarf_onehand_weapon_position",
      ["widget_type"] = "dropdown",
      ["text"] = "Dwarf One-Handed Weapon Position",
      ["tooltip"] =  "Dwarf One-Handed Weapon Position\n" ..
        "Choose the position of the one-handed dwarf weapons.\n\n" ..
        "-- Default --\n" ..
        "Uses dwarf weapon position.\n\n" ..
        "-- Belt --\n" ..
        "Weapons will be placed on the belt.",
      ["options"] = {
        {text = "Dwarf Weapon Position", value = 1},
        {text = "Belt", value = 2},
        {text = "Back", value = 3},
      },
      ["default_value"] = 1,
    },
    {
      ["setting_name"] = "waywatcher_dualweapon_position",
      ["widget_type"] = "dropdown",
      ["text"] = "Waywatcher Dual Weapon Position",
      ["tooltip"] =  "Waywatcher Dual Weapon Position\n" ..
        "Choose the position of the waywatcher dual weapons.\n\n" ..
        "-- Belt --\n" ..
        "Weapons will be placed on the belt.\n\n" ..
        "-- Back --\n" ..
        "Weapons will be placed on the back.",
      ["options"] = {
        {text = "Belt", value = 1},
        {text = "Back", value = 2},
      },
      ["default_value"] = 1,
    },
    {
      ["setting_name"] = "onehand_weapon_position",
      ["widget_type"] = "dropdown",
      ["text"] = "One-Handed Weapon Position",
      ["tooltip"] =  "One-Handed Weapon Position\n" ..
        "Choose the position of the one-handed weapons.\n\n" ..
        "-- Belt --\n" ..
        "Weapons will be placed on the belt.\n\n" ..
        "-- Back --\n" ..
        "Weapons will be placed on the back.",
      ["options"] = {
        {text = "Belt", value = 1},
        {text = "Back", value = 2},
      },
      ["default_value"] = 1,
    },
    {
      ["setting_name"] = "downscale_big_weapons",
      ["widget_type"] = "numeric",
      ["text"] = "Downscale Big Weapons",
      ["unit_text"] = "%",
      ["tooltip"] =  "Downscale Big Weapons\n" ..
        "Downscale the biggest weapons in the game.\n\n" ..
        "Affects: Red staffs, volley crossbow, wh crossbow",
      ["range"] = {50, 100},
      ["default_value"] = 75,
    },
  }
}