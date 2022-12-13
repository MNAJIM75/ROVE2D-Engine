local raylib = rove._internal._raylib

---@class rove.Filesystem : rove.Module
local filesystem = rove.utls.Module('FILESYSTEM')

---@type LIB_PATH
local _path = require'path'

-- ### Vars and Internal func and vars ###
filesystem._internal._paths = {}
---@type string
filesystem._internal._paths['MainFileDirectory'] = nil
---@type string
filesystem._internal._extension = '.rove'

--- ### Module Functions ###
function filesystem._internal:init()
    self._paths['MainFileDirectory'] = _path.currentdir()

    -- register the events
    rove.eventSystem.sub(rove, 'filedropped')
    rove.eventSystem.sub(rove, 'directorydropped')
end

function filesystem._internal:update()
    if raylib.IsFileDropped() then
        local _dropped_files = raylib.GetDroppedFiles(1)
        rove.eventSystem.trigger('filedropped', _dropped_files)
    end
end

-- ### Functions ###

---
---Recursively creates a directory.
---
---When called with 'a/b' it creates both 'a' and 'a/b', if they don't exist already.
---
---@param name string # The directory to create.
---@return boolean success # True if the directory was created, false if not.
function filesystem.createDirectory(name)
    local _newPath = _path.mkdir(name) -- the full newly created directory path
    if _newPath then return true else return false end
end

---
---Returns the application data directory (could be the same as getUserDirectory)
---
---@return string path # The path of the application data directory
function filesystem.getAppdataDirectory()
    local _user_path = filesystem.getUserDirectory()
    if _path.IS_WINDOWS then _user_path = _user_path .. '\\AppData\\' end
    return _user_path
end

---
---Returns a table with the names of files and subdirectories in the specified path. The table is not sorted in any way; the order is undefined.
---
---If the path passed to the function exists in the game and the save directory, it will list the files and directories from both places.
---
---@overload fun(dir: string, callback: function):table
---@param dir string # The directory.
---@return table files # A sequence with the names of all files and subdirectories as strings.
function filesystem.getDirectoryItems(dir)
    local _rt_files = {}

    ---@type LIB_PATH.each_opt
    local each_opt = { delay = true, param = 'fm', recurse = true, reverse = true}
    _path.each(dir, function(P, mode)
        if mode == 'file' then table.insert(_rt_files, P) end
    end, each_opt)

    return _rt_files
end

---
---Returns the path of the user's directory
---
---@return string path # The path of the user's directory
function filesystem.getUserDirectory()
    return _path.user_home()
end

---
---Gets the current working directory.
---
---@return string cwd # The current working directory.
function filesystem.getWorkingDirectory()
    return _path.currentdir()
end

---
---Gets the write directory name for your game. 
---
---Note that this only returns the name of the folder to store your files in, not the full path.
---
---@return string name # The identity that is used as write directory.
function filesystem.getIdentity()
    local _mainPath = filesystem._internal._paths.MainFileDirectory
    local _parebtPath, _currentPathNameOnly =  _path.splitpath(_mainPath)
    return _currentPathNameOnly:sub(1, _currentPathNameOnly:find(filesystem._internal._extension) - 1) -- the -1 to remove the . since the function return it's index
end



return filesystem