#include "script_component.hpp"

/*
  Name: TFAR_static_radios_fnc_setSpeakers

  Author: Dedmen
    Takes radio classnames and returns instanciated classnames. (with _ID appended)

  Arguments:
    0: The weaponholder containing the radio <OBJECT>
    1: Speaker enabled <BOOL>

  Return Value:
    None

  Example:
    ["TFAR_anprc_152_3",true] call TFAR_static_radios_fnc_setSpeakers;

  Public: No
*/
params ["_radioContainer","_enabled"];

CBA_SETTINGS_GUARD(TFAR_static_radios_fnc_setSpeakers);

_radio_id = _radioContainer call TFAR_static_radios_fnc_instanciatedRadio;

if (_radio_id call TFAR_fnc_isLRRadio) then {
    _radio_id = [_radio_id, "radio_settings"];
    private _settings = _radio_id call TFAR_fnc_getLrSettings;

    _settings set [TFAR_SR_SPEAKER_OFFSET, _enabled];

    (_radio_id select 0) setVariable ["TFAR_LRSpeakersEnabled", _enabled];

    [_radio_id, _settings] call TFAR_fnc_setLrSettings;
} else {
    private _settings = _radio_id call TFAR_fnc_getSwSettings;

    _settings set [TFAR_SR_SPEAKER_OFFSET, _enabled];

    [_radio_id, _settings] call TFAR_fnc_setSwSettings;
}
