/*
 * itc_land_ew_fnc_setValues
 *
 * Sets #EM_Values displayed on the spectrum device
 *
 * params: NONE
 */
private _values = [];
{
  _vehicle = _x;
  private _broadcasts = _vehicle getVariable ["itc_land_ew_broadcasts", []];
  //_broadcasts = [420, 1];
  if (count _broadcasts == 0) exitWith {};
  for "_i" from 0 to (count _broadcasts - 1) step 2 do {
    private _freq = _broadcasts # _i;
    private _power = _broadcasts # (_i + 1);
    if (_power > 0.1) then {
      private _directionVect = (getPosASL player) vectorFromTo (getPosASL _vehicle);
      private _weaponDir = player weaponDirection currentWeapon player;
      private _vectDot = _weaponDir vectorDotProduct _directionVect;
      _vectDot = (_vectDot ^ 30);
      _values = _values + [_freq, _power * _vectDot * 100];
    };
  };
} forEach vehicles;
missionNameSpace setVariable ["#EM_Values", _values];
