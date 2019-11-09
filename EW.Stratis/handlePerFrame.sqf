/*
 * itc_land_ew_fnc_handlePerFrame
 *
 * Runs on every frame, detects weapon and antenna changes, runs the antenna display code if required
 *
 * params: [(array) arguments, (SCALAR) perframehandler id]
 */
params ["_args", "_pfhId"];
_args params ["_currentWeapon", "_attachment"];
if (_currentWeapon != currentWeapon player || _attachment != (handgunItems player) # 0) then {
  systemChat "weapon change";
  _currentWeapon = currentweapon player;
  _attachment= (handgunItems player) # 0;
  _args set [0, _currentWeapon];
  _args set [1, _attachment];
  if (_currentWeapon == "hgun_esd_01_F") then {
    systemChat "spectrum device selected";
    private _antennaParams = [_attachment] call itc_land_ew_fnc_getAntennaParams;
    { // forEach ["EM_FMin", "EM_FMax", "EM_SelMin", "EM_SelMax"];
      missionNameSpace setVariable [_x, _antennaParams # _foreachindex];
    } forEach ["#EM_FMin", "#EM_FMax", "#EM_SelMin", "#EM_SelMax"];
  };
};
if (currentWeapon player != "hgun_esd_01_F") exitWith {};
[] call itc_land_ew_fnc_setValues;
