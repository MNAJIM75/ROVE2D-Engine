---@class Module The base of all rove2d modules
---@field _internal table all non user api functions and types
local module = rove.utls.Class('MODULE_TYPE')

---Create new Modlue
---@param _moduleName string THe new module name
function module:new(_moduleName)
    self._internal.name = _moduleName
end

---Initilize function of the module
module._internal.init = function(self) end

---Update function of the module
module._internal.update = function(self) end

---Deinitialize function of the module
module._internal.deinit = function(self) end


return module