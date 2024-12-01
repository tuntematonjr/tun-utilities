#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"cba_main","cba_xeh","cba_settings","A3_BaseConfig_F",MAIN_ADDON_STR};
		author = "Tuntematon";
		authorUrl = GITHUBLINK;
		VERSION_CONFIG;
	};
};
// configs go here
#include "CfgEventHandlers.hpp"