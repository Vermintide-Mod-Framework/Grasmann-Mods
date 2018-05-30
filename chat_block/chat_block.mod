local ret = {
	run = function()
		local mod_resources = {
			mod_script       = "scripts/mods/chat_block/chat_block",
			mod_data         = "scripts/mods/chat_block/chat_block_data",
			mod_localization = "scripts/mods/chat_block/chat_block_localization"
		}
		new_mod("ChatBlock", mod_resources)
	end,
	packages = {
		"resource_packages/chat_block/chat_block"
	},
}
return ret