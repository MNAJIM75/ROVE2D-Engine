local raylib = rove._internal._raylib

---@class rove.Graphics : rove.Module
local graphics = rove.utls.Module("GRAPHICS")
local quad = require'rove.modules.graphics.quad_t'

-- internal vars and functions
graphics._internal = {}
graphics._internal._loaded = {}
graphics._internal._loaded._sprites = {}
graphics._internal._window = {}
graphics._internal._window._focus = false

-- colors
local lastActiveColor, clearColor = raylib.WHITE, raylib.BLACK
local function setRgbaColor(_r, _g, _b, _a) 
    assert(type(_r) == 'number', 'ERROR: Invalid value for color component r')
    assert(type(_g) == 'number', 'ERROR: Invalid value for color component g')
    assert(type(_b) == 'number', 'ERROR: Invalid value for color component b')
    assert(type(_a) == 'number', 'ERROR: Invalid value for color component a')
    return { _r *255, _g *255, _b *255, _a *255 } 
end

function graphics._internal:init()
    -- Init Window InitWindow(int width, int height, const char *title)
    local _width, _height, _title 
      = math.floor(rove._internal._config.window.width),
        math.floor(rove._internal._config.window.height),
        rove._internal._config.window.title
    raylib.InitWindow(_width, _height, _title)
    rove.utls.log['info']('Window was Initialized.')

    -- check focus
    if raylib.IsWindowFocused() then self._window._focus = true end

    --#region Register the events
    --#endregion

end

function graphics._internal:_preQuit()
    rove.utls.loopInTable(self._loaded._sprites, function(_k, _v)
        raylib.UnloadTexture(_v)
        rove.utls.log['info']('Texture of key ->> ' .. _k .. ' <<- was unloaded')
    end)
end

function graphics._internal:deinit()
    -- unload all sprites
    self:_preQuit()
    -- Close Window
    if raylib.IsWindowReady() then raylib.CloseWindow() end
end

function graphics._internal.randerByType(_mode, _funFill, _funLine, ...)
    if string.lower(_mode) == graphics._draw_modes.FILL then
        _funFill(...)
    elseif string.lower(_mode) == graphics._draw_modes.LINE then
        _funLine(...)
    else error('ERROR: Invalid draw mode must be string -> fill or line')
    end
end

-- end

graphics._draw_modes = {
    LINE = 'line', FILL = 'fill'
}


-- vars
graphics._window = {
	__width = nil, __height = nil, __title = nil
}

-- Properties
	-- Setter
function graphics:setWindow(_w_width, _w_height, _w_title)
	self._window.__width = _w_width
	self._window.__height = _w_height
	self._window.__title = _w_title
end

function graphics.setColor(_c, ...) if type(_c) == 'table' then lastActiveColor = _c
    elseif type(_c) == 'number' then lastActiveColor = setRgbaColor(_c, ...)
    else error'ERROR: Wrong color input must be 4 elements table or rgba byte args' end
end
function graphics.setBackgroundColor(_c, ...) if type(_c) == 'table' then clearColor = _c
    elseif type(_c) == 'number' then clearColor = setRgbaColor(_c, ...)
    else error'ERROR: Wrong background color input must be 4 elements table or rgba byte args' end
end

	-- Getter
--function graphics:getWindow() return self._window.__width, self._window.__height, self._window.__title end
function graphics.getBackgroundColor() return clearColor end
function graphics.getColor() return lastActiveColor end
function graphics.getWidth() return raylib.GetScreenWidth() end
function graphics.getHeight() return raylib.GetScreenHeight() end
function graphics.getMonitorCount() return raylib.GetMonitorCount() end
function graphics.getCurrentMonitor() return raylib.GetCurrentMonitor() end
function graphics.getDimensions() return graphics.getWidth(), graphics.getHeight() end

-- new Object
function graphics.newImage(_filename) 
    table.insert(graphics._internal._loaded._sprites, raylib.LoadTexture(_filename))
    rove.utls.log['info']('Texture of key ->> ' .. tostring(#graphics._internal._loaded._sprites) .. ' <<- was loaded')
    return graphics._internal._loaded._sprites[#graphics._internal._loaded._sprites]
end

function graphics.newQuad(_x, _y, _width, _height, _sw, _sh)
    return quad.new(_x, _y, _width, _height, _sw, _sh)
end

-- drawing functions

function graphics.circle(_mode, _x, _y, _r)
    assert('string' == type(_mode), 'ERROR: Invalid draw mode must be string -> fill or line')
    assert('number' == type(_x),    'ERROR: Invalid x position must be number')
    assert('number' == type(_y),    'ERROR: Invalid y position must be number')
    assert('number' == type(_r),    'ERROR: Invalid radius value must be number')

    graphics._internal.randerByType(_mode, 
        raylib.DrawCircle, 
        raylib.DrawCircleLines,
        _x, _y, _r, lastActiveColor
    )
    --[[
    if string.lower(_mode) == graphics._draw_modes.FILL then
        raylib.DrawCircle(_x, _y, _r, lastActiveColor)
    elseif string.lower(_mode) == graphics._draw_modes.LINE then
        raylib.DrawCircleLines(_x, _y, _r, lastActiveColor)
    else error('ERROR: Invalid draw mode must be string -> fill or line')
    end]]
end

function graphics.rectangle(_mode, _x, _y, _width, _height)
    assert('string' == type(_mode),     'ERROR: Invalid draw mode must be string -> fill or line')
    assert('number' == type(_x),        'ERROR: Invalid x position must be number')
    assert('number' == type(_y),        'ERROR: Invalid y position must be number')
    assert('number' == type(_width),    'ERROR: Invalid width value must be number')
    assert('number' == type(_height),   'ERROR: Invalid height value must be number')

    graphics._internal.randerByType(_mode,
        raylib.DrawRectangle,
        raylib.DrawRectangleLines,
        _x, _y, _width, _height, lastActiveColor
    )
    --[[
    if string.lower(_mode) == graphics._draw_modes.FILL then
        raylib.DrawRectangle(_x, _y, _width, _height, lastActiveColor)
    elseif string.lower(_mode) == graphics._draw_modes.LINE then
        raylib.DrawRectangleLines(_x, _y, _width, _height, lastActiveColor)
    else error('ERROR: Invalid draw mode must be string -> fill or line')
    end]]
end

function graphics.draw(_drawable, _x, _y)
    raylib.DrawTexture(_drawable, _x or 0, _y or 0, lastActiveColor)
end

-- return the table
return graphics
