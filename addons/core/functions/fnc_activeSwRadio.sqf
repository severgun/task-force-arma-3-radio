#include "script_component.hpp"

/*
  Name: TFAR_fnc_activeSwRadio

  Author: NKey
    Returns the active SR radio.

  Arguments:
    None

  Return Value:
    Active SR radio <STRING>

  Example:
    call TFAR_fnc_activeSwRadio;

  Public: Yes
*/

private _result = nil;
{
    if (_x call TFAR_fnc_isRadio) exitWith {_result = _x};
    true;
} count (assignedItems TFAR_currentUnit);
_result
