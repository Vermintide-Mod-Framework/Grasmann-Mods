local mod = get_mod("ThirdPersonEquipment")
--[[ 
	Third person equipment localization

	Author: grasmann
--]]

local parts = {
	backpack_1 = {
		en = "-- Backpack --\n",
		de = "-- Rucksack --\n",
	},
	backpack_2 = {
		en = "Weapons will be placed on the backpack.\n\n",
		de = "Waffen werden am Rucksack platziert.\n\n",
	},
	back_1 = {
		en = "-- Back --\n",
		de = "-- Rücken --\n",
	},
	back_2 = {
		en = "Weapons will be placed on the back.\n\n",
		de = "Waffen werden am Rücken platziert.\n\n",
	},
	dwarf_default_1 = {
		en = "-- Default --\n",
		de = "-- Standard --\n",
	},
	dwarf_default_2 = {
		en = "Uses dwarf weapon position.\n\n",
		de = "Benutzt Zwerg Waffenposition.\n\n",
	},
	belt_1 = {
		en = "-- Belt --\n",
		de = "-- Gürtel --\n",
	},
	belt_2 = {
		en = "Weapons will be placed on the belt.\n\n",
		de = "Waffen werden am Gürtel platziert.\n\n",
	},
}

return {
	mod_description = {
		en = "Shows equipped items on characters.",
		de = "Zeigt ausgerüstete Items für Charaktere an.",
	},
	option_backpack = {
		en = "Backpack",
		de = "Rucksack",
	},
	option_back = {
		en = "Back",
		de = "Rücken",
	},
	option_default = {
		en = "Default",
		de = "Standard",
	},
	option_belt = {
		en = "Belt",
		de = "Gürtel",
	},
	dwarf_weapon_position_text = {
		en = "Dwarf Weapon Position",
		de = "Zwerg Waffenposition",
	},
	dwarf_weapon_position_tooltip = {
		en = "Choose the position of dwarf weapons.\n\n"..
			parts.backpack_1.en..
			parts.backpack_2.en..
			parts.back_1.en..
			parts.back_2.en,
		de = "Wähle die Position für Zwergwaffen.\n\n" ..
			parts.backpack_1.de..
			parts.backpack_2.de..
			parts.back_1.de..
			parts.back_2.de,
	},
	dwarf_1h_weapon_position_text = {
		en = "Dwarf One-Handed Weapon Position",
		de = "Zwerg Einhandwaffen Position",
	},
	dwarf_1h_weapon_position_tooltip = {
		en = "Choose the position of the one-handed dwarf weapons.\n\n"..
			parts.dwarf_default_1.en..
			parts.dwarf_default_2.en..
			parts.belt_1.en..
			parts.belt_2.en..
			parts.back_1.en..
			parts.back_2.en,
		de = "Wähle die Position für Zwerg Einhandwaffen.\n\n"..
			parts.dwarf_default_1.de..
			parts.dwarf_default_2.de..
			parts.belt_1.de..
			parts.belt_2.de..
			parts.back_1.de..
			parts.back_2.de,
	},
	waywatcher_dual_position_text = {
		en = "Waywatcher Dual Weapon Position",
		de = "Waywatcher Dualwaffen Position",
	},
	waywatcher_dual_position_tooltip = {
		en = "Choose the position of the waywatcher dual weapons.\n\n"..
			parts.belt_1.en..
			parts.belt_2.en..
			parts.back_1.en..
			parts.back_2.en,
		de = "Wähle die Position für Waywatcher Dualwaffen.\n\n"..
			parts.belt_1.de..
			parts.belt_2.de..
			parts.back_1.de..
			parts.back_2.de,
	},
	a_1h_weapon_position_text = {
		en = "One-Handed Weapon Position",
		de = "Einhandwaffen Position",
	},
	a_1h_weapon_position_tooltip = {
		en = "Choose the position of the one-handed weapons.\n\n"..
			parts.belt_1.en..
			parts.belt_2.en..
			parts.back_1.en..
			parts.back_2.en,
		de = "Wähle die Position für Einhandwaffen.\n\n"..
			parts.belt_1.de..
			parts.belt_2.de..
			parts.back_1.de..
			parts.back_2.de,
	},
	scale_big_weapons_text = {
		en = "Downscale Big Weapons",
		de = "Große Waffen verkleinern",
	},
	scale_big_weapons_tooltip = {
		en = "Downscale the biggest weapons.",
		de = "Verkleinert die größten Waffen.",
	},
}