local addonName, ns = ...
local M = {}

function M:Load()
  -- Placeholder for actionbars module
  print("Loaded module: actionbars")
end

ns.core:RegisterModule(M)
