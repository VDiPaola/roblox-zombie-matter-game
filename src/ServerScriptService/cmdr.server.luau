local ServerScriptService = game:GetService("ServerScriptService")
local Cmdr = require(ServerScriptService.WallyServerPackages.cmdr)

Cmdr:RegisterDefaultCommands() -- This loads the default set of commands that Cmdr comes with. (Optional)
-- Cmdr:RegisterCommandsIn(script.Parent.CmdrCommands) -- Register commands from your own folder. (Optional)
