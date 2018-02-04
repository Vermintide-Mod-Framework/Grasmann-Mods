Example mod, options_injector.mod in mod_data folder.

Basic Setup
===========
The .mod file contains the metadata needed for the mod, what packages to load and the entry point for the mod.
When the mod is done loading and the packages specified are loaded into memory the run function specified in this file will be called. 

Packages
========
Packages (specified by .package-files) are resource bundles to be loaded into the memory and the way the game loads resources. Packages can contain most types of resources used by the game, including but not limited to:
unit - an entity in the game world, it can have a graphical mesh, game logic, animations, physics shapes, etc
lua - lua files (gameplay code)
package - a reference to another package so that package then is able to be loaded into memory as well.
material - graphics materials, usually used for UI when loaded explicitly into a package
particles - particle system VFX
shading_environment - environments that define lighting conditions, can be switched runtime to achieve different weather, lighting, etc.
vector_field - vector fields to animate physics, particles etc
wwise_dep = wwise sound banks to be able to load sounds that aren't loaded through a unit.
font - text fonts for GUIs
mouse_cursor - mouse cursors
textures - specific textures not tied to anything else
physics_properties - physics metadata

Most assets can be used as soon as they are loaded, notable exceptions are:
lua files need to be loaded through require or dofile after being loaded through a package to actually be ran. Packages don't automatically load because they are in another package that is loaded, this just means it's not possible to load them at will and discretion.

Other Files
===========
settings.ini - specifies what package should be the first package to build the mod from
core/physx_metadata files - needed for compiling resources


To Build
========
run compile.bat to compile

Ready mods can be found in /BUILD
Move the entire mods directory to /bundle directory in Vermintide Steam folder, to make the mod be loaded on startup.
