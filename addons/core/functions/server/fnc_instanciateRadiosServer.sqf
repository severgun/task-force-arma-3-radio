#include "script_component.hpp"

/*
  Name: TFAR_fnc_instanciateRadios

  Author: Dorbedo
    Replaces all prototype radios

  Arguments:
    None

  Return Value:
    None

  Example:
    call TFAR_fnc_instanciateRadiosServer;

  Public: No
*/

if !(isServer) exitWith {};

{
    private _unit = _x;
    private _newRadios = [];
    {
        private _radioBaseClass = _x;
        if (_radioBaseClass == "ItemRadio") then {
            _radioBaseClass = (_unit call TFAR_fnc_getDefaultRadioClasses) param [[2, 1] select ((TFAR_givePersonalRadioToRegularSoldier) or {leader _unit == _unit} or {rankId _unit >= 2}), ""];
        } else {
            //get Radio baseclass without ID
            _radioBaseClass = [_radioBaseClass, "tf_parent", ""] call DFUNC(getWeaponConfigProperty);
        };
        private _id = [[_radioBaseClass], _unit] call TFAR_fnc_instanciateRadios;
        private _newItem = format["%1_%2", _radioBaseClass, _id select 0];
        _unit linkItem _newItem;
        _newRadios pushBack _newItem;
    } forEach ((assignedItems _unit) select {_x call TFAR_fnc_isPrototypeRadio});

    private _allItems = ((getItemCargo (uniformContainer _unit)) select 0);
    _allItems append ((getItemCargo (vestContainer _unit)) select 0);
    _allItems append ((getItemCargo (backpackContainer _unit)) select 0);

    {
        private _radioBaseClass = _x;
        if (_radioBaseClass == "ItemRadio") then {
            _radioBaseClass = (_unit call TFAR_fnc_getDefaultRadioClasses) param [[2, 1] select ((TFAR_givePersonalRadioToRegularSoldier) or {leader _unit == _unit} or {rankId _unit >= 2}), ""];
        } else {
            //get Radio baseclass without ID
            _radioBaseClass = [_radioBaseClass, "tf_parent", ""] call DFUNC(getWeaponConfigProperty);
        };
        private _id = [[_radioBaseClass], _unit] call TFAR_fnc_instanciateRadios;
        _unit removeItem _x;
        private _newItem = format["%1_%2", _radioBaseClass, _id select 0];
        if (_unit canAdd _newItem) then {
            _unit addItem _newItem;
            _newRadios pushBack _newItem;
        };
    } forEach (_allItems select {_x call TFAR_fnc_isPrototypeRadio});

    ["TFAR_event_OnRadiosReceived", [_unit, _newRadios], _unit] call CBA_fnc_targetEvent;
} forEach (playableUnits);
