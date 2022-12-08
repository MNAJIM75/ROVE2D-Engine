local raylib = require'raylib'

local _internal = {}
_internal._files = {
    main_lua = 'main.lua', conf_lua = 'conf.lua'
}

---@class Rove2D
---@field conf function
---@field load function
---@field update function
---@field draw function
---@field graphics function
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
                width = 800, height = 480
            },
            console = false,
            modules = {
                audio = false,
                graphics = true,
                physics = false
            }
        },
        _program = {
            InitDevices = function()
                if rove._internal._config.modules.audio then raylib.InitAudioDevice() end
                if rove._internal._config.modules.graphics then raylib.InitWindow(rove.graphics.getWindow()) end
                if rove._internal._config.modules.physics then print'Not Yey been implemaneted' end
            end,
            DeInitDevices = function ()
                if raylib.IsWindowReady() then raylib.CloseWindow() end
                if raylib.IsAudioDeviceReady() then raylib.CloseAudioDevice() end
            end
        }
    },
    eventSystem = require'rove.modules.event_system_i',
    utls = require'rove.modules.utls_i',
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

    run = function(self)
        self._internal._program.InitDevices()

        --#region Load the Game Data
        if self.load then self.load() end

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