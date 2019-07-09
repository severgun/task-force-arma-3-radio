#include "script_component.hpp"

/*
  Name: TFAR_fnc_isForcedCurator

  Author: NKey
    Return if unit if forced curator.

  Arguments:
    0: Unit to check <OBJECT>

  Return Value:
    Is unit forced curator <BOOL>

  Example:
    player call TFAR_fnc_isForcedCurator;

  Public: Yes
*/

private _result = _this getVariable "tf_forcedCurator";
if (!isNil "_result") exitWith {_result};

_result = ((typeOf _this) == "VirtualCurator_F") ||
            {[configFile >> "CfgVehicles" >> (typeOf _this), configFile >> "CfgVehicles" >> "VirtualCurator_F"] call CBA_fnc_inheritsFrom};
_this setVariable ["tf_forcedCurator", _result];

_result
