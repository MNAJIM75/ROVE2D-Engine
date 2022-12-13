---@meta
---@class LIB_PATH
--Functions
---@field has_dir_end       fun(P:string) :boolean has_dir_end (P)	Returns true if path has trailing path name separator.
---@field remove_dir_end    fun(P:string) :string remove_dir_end (P)	Removes the path name separator from the end of path, if it has it.
---@field ensure_dir_end    fun(P:string) :string ensure_dir_end (P)	Appends a path name separator to path if one does not exist.
---@field normalize         fun(P:string) :string normalize (P)	Normalize a path.
---@field join              fun(...)      :string join (...)	Join one or more path components.
---@field splitext          fun(P:string) :string, string, ... splitext (P)	Split the path into root and extension.
---@field splitpath         fun(P:string) :string, string, ... splitpath (P)	Split the path into dirname and basename.
---@field split             fun(P:string) :string, string, ... split (P)	Alias to splitpath.
---@field splitroot         fun(P:string) :string, string, ... splitroot (P)	Split first path part for absolute path.
---@field splitdrive        fun(P:string) :string, string, ... splitdrive (P)	Split path into drive specification and path.
---@field basename          fun(P:string) :string basename (P)	Return the base name of path.
---@field dirname           fun(P:string) :string dirname (P)	Return the directory name of path.
---@field extension         fun(P:string) :string extension (P)	Return the extension of path.
---@field root              fun(P:string) :string root (P)	Return first path part for absolute path.
---@field isfullpath        fun(P:string) :boolean isfullpath (P)	Return `true` if path contain root part.
---@field isabs             fun(P:string) :boolean isabs (P)	Alias to isfullpath
---@field user_home         fun(P:string) :string user_home ()	return user_home dir
---@field flags             fun(P:string) :string flags (P)	Return file attributes.
---@field tmpdir            fun()         :string tmpdir ()	Return path to temp directory.
---@field tmpname           fun()         :string tmpname ()	Return full path for temp file.
---@field size              fun(P:string) :integer size (P)	Return size in bytes for file.
---@field getsize           fun(P:string) :integer getsize (P)	Alias to size
---@field fullpath          fun(P:string) :string fullpath (P)	Return full normalized path.
---@field abspath           fun(P:string) :string abspath (P)	Alias to fullpath.
---@field exists            fun(P:string) :string exists (P)	Return path if path existing in file system.
---@field isdir             fun(P:string) :string isdir (P)	Return path if path refers to an existing directory.
---@field isfile            fun(P:string) :string isfile (P)	Return path if path refers to an existing file.
---@field islink            fun(P:string) :string islink (P)	Return path if path refers to an existing symbolic link.
---@field isempty           fun(P:string) :string isempty (P)	Return true if directory is empty.
---@field ctime             fun(P:string) :number ctime (P)	Return creation file time.
---@field mtime             fun(P:string) :number mtime (P)	Return last modification file time.
---@field atime             fun(P:string) :number atime (P)	Return last access file time.
---@field cdate             fun(P:string) :osdate cdate (P)	Return `path.ctime` as `date` object.
---@field mdate             fun(P:string) :osdate mdate (P)	Return `path.mtime` as `date` object.
---@field adate             fun(P:string) :osdate adate (P)	Return `path.atime` as `date` object.
---@field getctime          fun(P:string) :number getctime (P)	Alias to ctime
---@field getmtime          fun(P:string) :number getmtime (P)	Alias to mtime
---@field getatime          fun(P:string) :number getatime (P)	Alias to atime
---@field mkdir             fun(P:string) :nil mkdir (P)	Create new directory.
---@field rmdir             fun(P:string) :nil rmdir (P)	Remove empty directory.
---@field remove            fun(P:string, opt:LIB_PATH.remove_opt) remove (P, opt)	Remove file or empty directory.
---@field rename            fun(from:string, to:string, force:boolean) rename (from, to, force)	Rename existed file.
---@field copy              fun(from:string, to:string, opt:LIB_PATH.copy_opt) copy (from, to, opt)	Copy file or directory tree.
---@field currentdir        fun() :string currentdir ()	Return current work directory path.
---@field chdir             fun(P:string) : nil chdir (P)	Change current work directory path.
---@field each              fun(str_file:string, func_callback:fun(P:string, mode:string), tbl_option:LIB_PATH.each_opt) each (str_file, func_callback, tbl_option)	Iterate over directory tree.
--[[
---@field each              fun(a) each (str_file, str_params, func_callback, tbl_option)	Iterate over directory tree.
---@field each function each (str_file, str_params, tbl_option)	Iterate over directory tree.
---@field each function each (str_file, tbl_option)	Iterate over directory tree.
---@field each function each (func_callback, tbl_option)	Iterate over directory tree.
]]
--Fields
---@field DIR_SEP string The path separator.
---@field IS_WINDOWS boolean	???

--Tables
---@class LIB_PATH.copy_opt table copy_opt Option table for `path.copy` function.
---@field delay             boolean (default false)
---@field recurse           boolean (default false)
---@field skipdirs          boolean (default false)
---@field skipfiles         boolean (default false)
---@field accept            fun(src) (default function(src))
---@field error             fun(err) (default function(err))

---@class LIB_PATH.remove_opt function remove_opt Option table for `path.remove` function.
---@field delay             boolean (default true)
---@field recurse           boolean (default false)
---@field skipdirs          boolean (default false)
---@field skipfiles         boolean (default false)
---@field accept            fun(src) (default function(src))
---@field error             fun(err) (default function(err))

---@class LIB_PATH.each_opt
---@field param             string # request full path and mode; default value -> "fm"
---@field delay             boolean # use snapshot of directory; default value -> true
---@field recurse           boolean # include subdirs; default value -> true
---@field reverse           boolean # subdirs at first; default value -> true
--[[
{
    param = "fm";   -- request full path and mode
    delay = true;   -- use snapshot of directory
    recurse = true; -- include subdirs
    reverse = true; -- subdirs at first
}
]]