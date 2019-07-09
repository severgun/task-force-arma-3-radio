#include "script_component.hpp"

/*
  Name: TFAR_fnc_generateSRSettings

  Author: NKey, Garth de Wet (L-H)
    Generates settings for the SR radio.

  Arguments:
    0: False to generate settings without generating frequencies <BOOL> (default: true)

  Return Value:
    0: Active channel <NUMBER>
    1: Volume <NUMBER>
    2: Frequencies for channels <ARRAY>
    3: Stereo setting <NUMBER>
    4: Encryption code <STRING>
    5: Additional active channel <NUMBER>
    6: Additional active channel stereo mode <NUMBER>
    7: Owner's UID <STRING>
    8: Speaker mode <NUMBER>
    9: Turned on <BOOL>

  Example:
    _settings = call TFAR_fnc_generateSRSettings;

  Public: Yes
*/

private _sr_settings = [0, TFAR_default_radioVolume, [], 0, nil, -1, 0, getPlayerUID player, false, true];
private _set = false;
private _sr_frequencies = [];

if (_this isEqualType true) then {
    if (!_this) then {
        for "_i" from 0 to TFAR_MAX_CHANNELS step 1 do {
            _sr_frequencies set [_i, "50"];
        };
        _set = true;
    };
};
if (!_set) then {
    _sr_frequencies = [TFAR_MAX_CHANNELS,TFAR_MAX_SR_FREQ,TFAR_MIN_SR_FREQ,TFAR_FREQ_ROUND_POWER] call TFAR_fnc_generateFrequencies;
};
_sr_settings set [2, _sr_frequencies];

_sr_settings
