local addonName, ns = ...
local core = CreateFrame("Frame")
core.modules = {}

function core:RegisterModule(module)
  table.insert(self.modules, module)
end

function core:Initialize()
  for _, module in ipairs(self.modules) do
    if type(module.Load) == "function" then
      module:Load()
    end
  end
  print("LBUI loaded. Type /lbui for options.")
end

core:RegisterEvent("PLAYER_LOGIN")
core:SetScript("OnEvent", function(self, event)
  if event == "PLAYER_LOGIN" then
    self:Initialize()
  end
end)

-- Basic slash command
SLASH_LBUI1 = "/lbui"
SlashCmdList["LBUI"] = function(msg)
  print("LBUI command: ", msg)
end

ns.core = core
