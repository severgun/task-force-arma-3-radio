#include "script_component.hpp"

/*
  Name: TFAR_fnc_setName

  Author: severgun, based on function from ACE3 by commy2.
    Sets the name variable of the object. Used to prevent issues with the name command.

  Arguments:
    0: Unit <OBJECT>

  Return Value:
    None

  Example:
    [bob] call TFAR_fnc_setName;

  Public: No
*/

params ["_unit"];
TRACE_3("setName",_unit,alive _unit,name _unit);

if (isNull _unit || {!alive _unit}) exitWith {};

if (_unit isKindOf "CAManBase") then {
    _unit setVariable ["TFAR_unitName", name _unit, true];
};