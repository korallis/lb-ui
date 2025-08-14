local addonName, ns = ...
local M = {}

function M:Load()
  -- Placeholder for chat module
  print("Loaded module: chat")
end

ns.core:RegisterModule(M)
