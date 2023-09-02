#define COMPONENT utilitiesMain
#define PREFIX Tun

#define MAJOR 1
#define MINOR 2
#define PATCHLVL 2
#define BUILD 02092023

#define VERSION MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD

// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 2.12

#define DEBUG_MODE_FULL

#include "\z\ace\addons\main\script_macros.hpp"

// Default versioning level
#define DEFAULT_VERSIONING_LEVEL 2

#define TUN_FIND_MAPDISPLAY ([53, 52, 37, 12, nil] select ([53, 52, 37, 12] findIf {!isNull findDisplay _x}))