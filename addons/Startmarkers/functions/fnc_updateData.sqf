﻿/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tun_startmarkers_fnc_updateData
 */
#include "script_component.hpp"

GVAR(squadMarkersWestData) = [];
GVAR(squadMarkersEastData) = [];
GVAR(squadMarkersIndependentData) = [];
GVAR(squadMarkersCivilianData) = [];

GVAR(vehicleMarkersWestData) = [];
GVAR(vehicleMarkersEastData) = [];
GVAR(vehicleMarkersIndependentData) = [];
GVAR(vehicleMarkersCivilianData) = [];

private _colorWEST = "ColorWEST";
private _colorEAST = "ColorEAST";
private _colorINDEPENDENT = "ColorGUER";
private _colorCIVILIAN = "ColorCIV";

{ 
    private _group = _x;
    private _leader = leader _group;

    if (vehicle _leader == _leader && _group getVariable [QGVAR(enableMarker), true] ) then {
        private _side = side _group;
        private _icon = [_group] call FUNC(squadIcon);
        private _pos = getPosWorld _leader;

        switch (_side) do {
            case west: { 
                GVAR(squadMarkersWestData) pushBack [_icon, _pos, _colorWEST, _group];
            };
            case east: { 
                GVAR(squadMarkersEastData) pushBack [_icon, _pos, _colorEAST, _group];
            };
            case independent: { 
                GVAR(squadMarkersIndependentData) pushBack [_icon, _pos, _colorINDEPENDENT, _group];
            };
            default { 
                GVAR(squadMarkersCivilianData) pushBack [_icon, _pos, _colorCIVILIAN, _group];
            };
        };
    };
} forEach allgroups;

private _vehiclesToCreateMarkers = [];
//Collect vehicles
{
    private _vehicle = _x; // "Tun_startmarkers_vehicleSide"
    if !(_vehicle getVariable [QGVAR(noStartMarker), false]) then {

        private _pos = getPosWorld _vehicle;
        private _direction = getDir _vehicle;
        private _classname = typeOf _vehicle;
        private _text = "";
        private _text1 = "";
        _text = _vehicle getVariable ["displayName", getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName")];

        if (!(_vehicle isKindOf "thing") && {!(_vehicle isKindOf "uav")}) then {
            if (count (crew _vehicle) > 0) then {
                private _groups = [];
                private _groupsText = [];
                {
                    _groups pushBackUnique group _x;
                } forEach crew _vehicle;

                {
                    private _group = _x;
                    if (GVAR(showAI) && { units _group findIf {_x in playableUnits + switchableUnits} isEqualTo -1 }) then {
                        _groupsText pushBackUnique format["%1 (AI)", groupId _group];
                    } else {
                        _groupsText pushBackUnique groupId _group;
                    };
                } forEach _groups;

                _text1 = _groupsText joinString ", ";

            } else {
                if (true) then {
                    _text1 = "Unmanned";
                };
            };
        };   


        private _side = _vehicle getVariable [QGVAR(vehicleSide), sideLogic];
        private _color = [_side, false] call BIS_fnc_sideColor;
        ///check that side is defined
        if ( _side in [west, east, independent, civilian] ) then {
            switch (_side) do {
                case west: { 
                    GVAR(vehicleMarkersWestData) pushBack [_classname, [_text, _text1], _pos, _direction, _color];
                };
                case east: { 
                    GVAR(vehicleMarkersEastData) pushBack [_classname, [_text, _text1], _pos, _direction, _color];
                };
                case independent: { 
                    GVAR(vehicleMarkersIndependentData) pushBack [_classname, [_text, _text1], _pos, _direction, _color];
                };
                default { 
                    GVAR(vehicleMarkersCivilianData) pushBack [_classname, [_text, _text1], _pos, _direction, _color];
                };
            };
        };
    };
} forEach vehicles;

if (isServer && {cba_missiontime < GVAR(updateInterval) }) then {
    publicVariable QGVAR(squadMarkersWestData);
    publicVariable QGVAR(squadMarkersEastData);
    publicVariable QGVAR(squadMarkersIndependentData);
    publicVariable QGVAR(squadMarkersCivilianData);

    publicVariable QGVAR(vehicleMarkersWestData);
    publicVariable QGVAR(vehicleMarkersEastData);
    publicVariable QGVAR(vehicleMarkersIndependentData);
    publicVariable QGVAR(vehicleMarkersCivilianData);
};