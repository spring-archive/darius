function widget:GetInfo()
	return {
		name = "Hide commands",
		desc = "Hides all commands",
		author = "Jammer",
		date = "June 2010",
		license = "GNU GPL, v2 or later",
		layer = 0,
		enabled = true,
		handler = true, --access to handler
	}
end

function widget:CommandsChanged()
	local cmds = widgetHandler.commands
	local n = widgetHandler.commands.n
	for i=1,n do
		cmds[i].hidden = true
	end
end