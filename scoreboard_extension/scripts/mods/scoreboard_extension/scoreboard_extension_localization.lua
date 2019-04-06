local mod = get_mod("scoreboard_extension")
--[[
	Scoreboard Extension

	Localization file.

	author: grasmann
--]]

local localizations = {
	mod_description = {
		en = "Provides an interface to add custom entries to the scoreboard.",
		de = "Bietet eine Schnittstelle um benutzerdefinierte Elemente im Scoreboard anzuzeigen.",
	},
	autoscroll = {
		en = "Autoscroll",
		de = "Automatisch Scrollen",
	},
	autoscroll_description = {
		en = "Scrolls through the scoreboard automatically.\n"..
			"Stops when you manually scroll.",
		de = "Scrollt automatisch durch das Scoreboard.\n"..
			"Stoppt wenn du manuell scrollst.",
	},
	initial_time = {
		en = "Delay",
		de = "Verzögerung",
	},
	initial_time_description = {
		en = "Initial time waited before the autoscrolling starts.",
		de = "Anfangszeit bevor das automatische Scrollen startet.",
	},
	loop = {
		en = "Loop",
		de = "Wiederholen",
	},
	loop_description = {
		en = "After reaching the end of the list autoscroll will loop.",
		de = "Springt wieder zum Anfang wenn das Ende der Liste erreicht wurde.",
	},
	loop_time = {
		en = "Delay",
		de = "Verzögerung",
	},
	loop_time_description = {
		en = "Time waited before autoscroll loops.",
		de = "Zeit die gewartet wird bevor das automatische Scrollen wiederholt wird.",
	},
	unit_text_second = {
		en = "sec",
		de = "sek",
	},
	unit_text_empty = {
		en = "",
	},
	direction = {
		en = "Direction",
		de = "Richtung",
	},
	direction_description = {
		en = "Direction of the autosroll.\n\n"..
			"-- TOP TO BOTTOM --\n"..
			"Autoscroll starts at the top and scrolls down.\n\n"..
			"-- BOTTOM TO TOP --\n"..
			"Autoscroll starts at the bottom and scrolls up.",
		de = "Richtung des automatischen Scrollens.\n\n"..
			"-- VON OBEN NACH UNTEN --\n"..
			"Automatisches Scrollen fängt oben an und scrollt herunter.\n\n"..
			"-- VON UNTEN NACH OBEN --\n"..
			"Automatisches Scrollen fängt unten an und scrollt hoch.",
	},
	direction_option_top_to_bottom_text = {
		en = "Top to Bottom",
		de = "Von Oben nach Unten",
	},
	direction_option_bottom_to_top_text = {
		en = "Bottom to Top",
		de = "Von Unten nach Oben",
	},
	extend = {
		en = "Rows",
		de = "Zeilen",
	},
	extend_description = {
		en = "Extends the size / number of rows in the scoreboard.",
		de = "Erweitert die Größe / Anzahl der Zeilen im Scoreboard.",
	},
}

return localizations