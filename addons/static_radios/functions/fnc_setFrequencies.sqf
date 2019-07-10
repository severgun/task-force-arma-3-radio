#include "script_component.hpp"

/*
  Name: TFAR_static_radios_fnc_setFrequencies

  Author: Dedmen
    takes radio classnames and returns instanciated classnames (with _ID appended)

  Arguments:
    0: the weaponholder containing the radio <OBJECT>
    1: 9 channels of frequencies <ARRAY>

  Return Value:
    None

  Example:
    ["TFAR_anprc_152_3",["72.4","60","66.4",...]] call TFAR_static_radios_fnc_setFrequencies;

  Public: No
*/
params ["_radioContainer","_frequencies"];

CBA_SETTINGS_GUARD(TFAR_static_radios_fnc_setFrequencies);

_radio_id = _radioContainer call TFAR_static_radios_fnc_instanciatedRadio;

private _freqsCount = count _frequencies;

if (_radio_id call TFAR_fnc_isLRRadio) then {
    _radio_id = [_radio_id, "radio_settings"];
    private _settings = _radio_id call TFAR_fnc_getLrSettings;

    if (_freqsCount < TFAR_MAX_LR_CHANNELS) then {
        private _additionalFreqs = [TFAR_MAX_LR_CHANNELS - _freqsCount - 1,TFAR_MAX_ASIP_FREQ,TFAR_MIN_ASIP_FREQ,TFAR_FREQ_ROUND_POWER] call TFAR_fnc_generateFrequencies;
        _frequencies append _additionalFreqs;
    };
    _settings set [TFAR_FREQ_OFFSET, _frequencies];

    [_radio_id, _settings] call TFAR_fnc_setLrSettings;
} else {
    _settings = _radio_id call TFAR_fnc_getSwSettings;

    if (_freqsCount < TFAR_MAX_CHANNELS) then {
        private _additionalFreqs = [TFAR_MAX_CHANNELS - _freqsCount - 1,TFAR_MAX_SW_FREQ,TFAR_MIN_SW_FREQ,TFAR_FREQ_ROUND_POWER] call TFAR_fnc_generateFrequencies;
        _frequencies append _additionalFreqs;
    };
    _settings set [TFAR_FREQ_OFFSET, _frequencies];

    [_radio_id, _settings] call TFAR_fnc_setSwSettings;
}
