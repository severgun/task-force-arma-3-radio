#include "script_component.hpp"

/*
  Name: TFAR_fnc_showVoiceVolume

  Author: Garth de Wet (L-H)
    Shows the radio volume

  Arguments:
    0: Show/Hide voice volume HUD <BOOL>

  Return Value:
    None

  Example:
    [true] call TFAR_fnc_showVoiceVolume;

  Public: No
*/

params ["_show"];

if (_show) then {
    (QGVAR(HUDVolumeIndicatorRsc) call BIS_fnc_rscLayer) cutRsc [QGVAR(HUDVolumeIndicatorRsc), "PLAIN", 0, true];
} else {
    (QGVAR(HUDVolumeIndicatorRsc) call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
};