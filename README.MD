This project aims to create a LOVE2D-like API using the Raylib-Lua bindings (RayLua).

### Project Description:
First, I need to create a backend for the API to handle all the work. Instead of building each component as a table, I plan to structure them as modules where the engine will automatically execute a set of functions, like:
`init() ; update(_dt) ; preDeInit() ; deInit()`
These will be executed by the engine on their own.

The engine will also take functions from the developer and execute them, such as:
`rove.load(args) ; rove.update(_dt) ; rove.draw() ; rove.mousepressed(_x, _y, _b) ... etc`
The same as LÖVE2D API scripted functions.

### What will be integrated:
- Modules Type: The class/type that serves as the foundation for all integrated API libraries.
- Modules System/Scene: The system where module execution occurs within the game loop.
- Graphics: Provides access to graphic rendering.
- Audio: Allows playing, pausing, or stopping almost any sound.
- Mouse: Handles mouse input, buttons, and some touch features.
- Keyboard: Supports nearly all keyboard input keys.
- Event System: A system designed for in-game events specific to the rove-engine, not for the game itself.
        
Through this method, I can separate the Rove-Engine from the Sun-Engine. When developing complete or semi-complete systems, the Rove-Engine can be integrated into the Raylib-LuaJIT compiler, allowing the creation of a batch file that will run the specified directory's main.lua file, such as:

#### rove.bat:
```bash
@EACH OFF
%rayjit% rove main.lua conf.lua
@ECHO ON
```
