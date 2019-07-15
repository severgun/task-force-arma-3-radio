#include "script_component.hpp"

if (!isMultiplayer && !is3DENMultiplayer) exitWith {}; //Don't do anything in Singleplayer


if (hasInterface) then {
    // Set the name for the current player
    ["unit", {
        params ["_newPlayer","_oldPlayer"];

        if (alive _newPlayer) then {
            [DFUNC(setName), [_newPlayer]] call CBA_fnc_execNextFrame;
        };

        if (alive _oldPlayer) then {
            [DFUNC(setName), [_oldPlayer]] call CBA_fnc_execNextFrame;
        };
    }] call CBA_fnc_addPlayerEventHandler;

    [   {time > 0 && !(isNull player)},
        TFAR_fnc_clientInit
    ] call CBA_fnc_waitUntilAndExecute;
};
