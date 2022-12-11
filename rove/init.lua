local raylib = require'raylib'

local _internal = {}
_internal._files = {
    main_lua = 'main.lua', conf_lua = 'conf.lua'
}

---@class rove
---@field conf fun(t:table)
---@field load fun(arg:table)
---@field update fun(dt:number)
---@field draw fun()
---@field graphics rove.Graphics
---@field mouse rove.Mouse
---@field keyboard rove.Keyboard
---@field audio Module
---@field filesystem table
rove = {
    _internal = {
        _raylib = raylib,
        _errorHandler = {
            checkFileAssert = function(_filename, _errMsg) -- to kill the program
                local __errMsg = _errMsg or ''
                assert(raylib.FileExists(_filename), __errMsg .. '\t-error: The '.. _filename .. ' wasn\'t found')
            end,
            checkFile = function (_filename) -- to check if the file exist or not only
                return raylib.FileExists(_filename)
            end
        },
        _config = {
            window = {
                width = 800, height = 480, title = 'Untitled'
            },
            console = false,
            modules = {
                audio = false,
                graphics = true,
                physics = false,
                mouse = true,
                keyboard = true
            }
        },
        _program = {
            InitDevices = function()
                rove.utls.loopInTable(rove._internal._config.modules, function(_key, _value)
                    print(_key, _value)
                    if _value then
                        local modulePath = 'rove.modules.' .. _key .. '_m'
                        ---@type Module
                        rove[_key] = require(modulePath)
                        rove[_key]._internal:init()
                        rove.utls.log['info']('Module [' .. _key .. '] was Initialized.')
                    end
                end)
            end,
            DeInitDevices = function ()
                rove.utls.loopInTable(rove._internal._config.modules, function(_key, _value)
                    if _value then
                        rove[_key]._internal:deinit()
                        rove.utls.log['info']('Module [' .. _key .. '] was Deinitialized.')
                    end
                end)
            end
        }
    },
    eventSystem = require'rove.modules.event_system_i',
    utls = require'rove.modules.utls_i',
    ---@class rove.Filesystem
    filesystem = require'path',
    initialize = function(self)
        --#region Error and Missing File Handleing
        self._internal._errorHandler.checkFileAssert(_internal._files.main_lua, 'There is no starting point')
        --#endregion

        --#region Execute the files
            -- Window Setting and Configuring
        if self._internal._errorHandler.checkFile(_internal._files.conf_lua) then
            dofile(_internal._files.conf_lua)
            rove.conf(self._internal._config) -- testing
        end

        dofile(_internal._files.main_lua) -- regs every func and var provided by the developer
        --#endregion
    end,

    run = function(self, ...)
        self._internal._program.InitDevices()

        --#region Load the Game Data
        if self.load then self.load(...) end

        while not raylib.WindowShouldClose() do
            --#region Update
            if self.update then self.update(raylib.GetFrameTime()) end
            --#endregion

            --#region Draw
            raylib.BeginDrawing()
            raylib.ClearBackground(raylib.WHITE)
            if self.draw then self.draw() end
            raylib.EndDrawing()
            --#endregion
        end

        self._internal._program.DeInitDevices()
    end
}

rove.utls.log['info']('Rove2D initialized')
rove.gundam = require'rove.modules.gundam_m'
rove.gundam._internal:init()

local arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 = ...

-- check for the working directory
local _dirctory_path = arg0 == '.' and rove.filesystem.currentdir() or arg0
rove.filesystem.chdir(_dirctory_path) -- change to that directory

rove:initialize()
rove:run({arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9})
