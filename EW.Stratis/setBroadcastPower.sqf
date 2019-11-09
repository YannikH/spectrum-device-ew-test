/*
 * itc_land_ew_setBroadcastPower
 *
 * Sets broadcast power variable on a broadcasting vehicle
 *
 * params: [(object) _vehicle, (SCALAR) _freq, (SCALAR) _power]
 */
params ["_vehicle", "_freq", "_power"];
private _broadcasts = _vehicle getVariable ["itc_land_ew_broadcasts", []];
private _index = _broadcasts find _freq;
if (_index > -1) then {_broadcasts set [(_index + 1), _power]} else {
  _broadcasts pushBack _freq;
  _broadcasts pushBack _power;
};
_vehicle setVariable ["itc_land_ew_broadcasts", _broadcasts];
