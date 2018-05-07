local ret = {
	run = function()
		local mod = new_mod("ChatBlock")
		mod:initialize("scripts/mods/chat_block/chat_block")
	end,
	packages = {
		"resource_packages/chat_block/chat_block"
	},
}
return ret