---@class rove.Graphics.Quad
local quad = rove.utls.Class("QUAD_TYPE")
quad._type = 'Quad'
quad._data = {
    _x = nil, _y = nil, _width = nil, _height = nil
}

function quad.__tostring(_op) return _op._type end

function quad:new(_x, _y, _width, _height, _sw, _sh)
    self._data._x = _x or 0
    self._data._y = _y or 0
    self._data._width = _width or 0
    self._data._height = _height or 0
end

return quad