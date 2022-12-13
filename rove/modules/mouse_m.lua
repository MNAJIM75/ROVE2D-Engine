local raylib = rove._internal._raylib
---@class rove.Mouse : rove.Module
local mouse = rove.utls.Module('MOUSE')
local lastButtonPressed = nil

mouse._internal.buttons = {
    MOUSE_BUTTON_LEFT    = 0,       -- Mouse button left
    MOUSE_BUTTON_RIGHT   = 1,       -- Mouse button right
    MOUSE_BUTTON_MIDDLE  = 2,       -- Mouse button middle (pressed wheel)
    MOUSE_BUTTON_SIDE    = 3,       -- Mouse button side (advanced mouse device)
    MOUSE_BUTTON_EXTRA   = 4,       -- Mouse button extra (advanced mouse device)
    MOUSE_BUTTON_FORWARD = 5,       -- Mouse button fordward (advanced mouse device)
    MOUSE_BUTTON_BACK    = 6,       -- Mouse button back (advanced mouse device)
}

-- properties 

--#region Getter
function mouse._internal:getMouseINT(_bstr) return self['MOUSE_BUTTON_' .. string.upper(_bstr)] end
function mouse.getPosition() return raylib.GetMouseX(), raylib.GetMouseY() end
function mouse.getX() return raylib.GetMouseX() end
function mouse.getY() return raylib.GetMouseY() end
--#endregion

--#region Setter
function mouse.setPosition(_x, _y)
    assert(type(_x) == 'number' and type(_y) == 'number', 'ERROR: The mouse position has a non-number input to it')
    raylib.SetMousePosition(math.floor(_x), math.floor(_y))
end
function mouse.setX(_x) mouse.setPosition(_x, mouse.getY()) end
function mouse.setY(_y) mouse.setPosition(mouse.getX(), _y) end

function mouse.isDown(_button)
    if type(_button) == 'number' then return raylib.IsMouseButtonDown(_button - 1)
    elseif type(_button) == 'string' then return raylib.IsMouseButtonDown(mouse._internal:getMouseINT(_button)) end
end
--#endregion

function mouse._internal:init()
    -- register the mouse event
    rove.eventSystem.sub(rove, 'mousepressed')
    rove.eventSystem.sub(rove, 'mousereleased')
    rove.eventSystem.sub(rove, 'mousefocus')
end

function mouse._internal:update()
    for _key, _value in pairs(self.buttons) do
        if raylib.IsMouseButtonPressed(_value) then
            rove.eventSystem.trigger('mousepressed', rove.mouse.getX(), rove.mouse.getY(),_value + 1)
            lastButtonPressed = _value
        end
    end
    if lastButtonPressed and raylib.IsMouseButtonReleased(lastButtonPressed) then
        rove.eventSystem.trigger('mousereleased', rove.mouse.getX(), rove.mouse.getY(), lastButtonPressed + 1)
        lastButtonPressed = nil
    end
    local _window_focus = raylib.IsWindowFocused()
    if _window_focus ~= rove.graphics._internal._window._focus then
        rove.eventSystem.trigger('mousefocus', nil)
        rove.graphics._internal._window._focus = _window_focus
    end
end
    
return mouse