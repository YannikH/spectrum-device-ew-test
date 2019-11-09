/*
 * itc_land_ew_fnc_broadcast
 *
 * Adds a broadcast that powers up and down for set amount of time on a specific frequency
 *
 * params: [(object) _vehicle, (SCALAR) _freq, (SCALAR) _buildUpTime, (SCALAR) _holdTime, (SCALAR) _buildDownTime]
 */
params ["_vehicle", "_freq", "_buildUpTime", "_holdTime", "_buildDownTime"];
private _freqs = _vehicle getVariable ["itc_land_ew_freqs", []];
private _startTime = cba_missionTime;
private _powerBuildUp = 1 / _buildUpTime;
private _powerBuildDown = 1 / _buildDownTime;
while {_startTime + _buildUpTime + _holdTime + _buildDownTime > cba_missionTime} do {
  private _timeElapsed = cba_missionTime - _startTime;
  private _power = 1;
  private _state = "holding";
  //building up
  if (_timeElapsed < _buildUpTime) then {
    _power = _powerBuildUp * _timeElapsed; _state = "building";
  } else {
    //building down
    if (_timeElapsed > _buildUpTime + _holdTime) then {
      _power = 1 - (_powerBuildUp * (_timeElapsed - _buildUpTime - _holdTime)); _state = "down";
    };
  };
  [_vehicle, _freq, _power] call itc_land_ew_fnc_setBroadcastPower;
  sleep 0.01;
};

[_vehicle, _freq, 0] call itc_land_ew_fnc_setBroadcastPower;
