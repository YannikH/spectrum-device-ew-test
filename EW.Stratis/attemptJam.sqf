private _highestCoverage = 0;
private _jammedVehicles = [];
{
  _vehicle = _x;
  private _broadcasts = _vehicle getVariable ["itc_land_ew_broadcasts", []];
  //_broadcasts = [420, 1];
  if (count _broadcasts == 0) exitWith {};
  for "_i" from 0 to (count _broadcasts - 1) step 2 do {
    private _freq = _broadcasts # _i;
    (missionNamespace getVariable "#em_prev") params ["","","","","_scanMin","_scanMax"];
    private _power = _broadcasts # (_i + 1);
    if (_power > 0.1 && _freq > _scanMin && _freq < _scanMax) then {
      private _directionVect = (eyePos player) vectorFromTo (getPosASL _vehicle);
      private _weaponDir = player weaponDirection currentWeapon player;
      private _vectDot = _weaponDir vectorDotProduct _directionVect;
      private _relDir = player getRelDir _vehicle;
      if (_relDir < 90 && _relDir > 270) then {_vectDot = 0};
      _vectDot = (_vectDot ^ 30);
      _coverage = _power * _vectDot * 100;
      if (_coverage > 60) then {_jammedVehicles pushBack _vehicle};
      if (_coverage > _highestCoverage) then { _highestCoverage = _coverage };
    };
  };
} forEach vehicles;
missionNameSpace setVariable ["#EM_Progress", _highestCoverage / 100];

{
  dostop _x;
  private _altitude = (getPos _x) # 2;
  _x doWatch ((getPos _x) vectorAdd [-50 + (random 100), -50 + (random 100), -50 + (random 100)]);
  (group _x) forgetTarget (assignedTarget _x);
  _x commandWatch objNull;
  _x doTarget objNull;
  if (isTouchingGround _x) then {
    if (isEngineOn _x) then { _x engineOn false; };
  } else {
    _x addForce [[0,0,-(_altitude * 50) max -150], [0,0,0]];
  };
} forEach _jammedVehicles;
