/*
 * itc_land_ew_fnc_manageTransmissions
 *
 * Makes a vehicle automatically transmit signals
 *
 * params: [(object) _vehicle]
 */
params ["_vehicle"];
private _sideOffset = switch (side _vehicle) do {
  case east: {0};
  case west: {25};
  case independent: {50};
  case civilian: {75};
};
private _datalinkFreq = 390 + (_sideOffset * 1.1) + random 20;
private _uavFreq = 240 + (_sideOffset / 10) + random 2;
if (unitIsUAV _vehicle) then {
  [_vehicle, _uavFreq, 1] call itc_land_ew_fnc_setBroadcastPower;
};
//_vehicle addEventHandler ["MPKilled", {}];
private _position = getPos _vehicle;
private _lastPositionUpdate = cba_missionTime;
waitUntil {
  private _dead = (isNil "_vehicle" || {isNull _vehicle} || {!alive _vehicle});
  if (_dead) exitWith {true};
  private _isBroadcastingTargets = vehicleReceiveRemoteTargets _vehicle;
  private _isBroadcastingPosition = vehicleReportOwnPosition _vehicle;

  private _updateWaitTime = if (_position distance (getPos _vehicle) > 10) then [{15}, {30}];
  private _targetUpdate = (_isBroadcastingTargets && (random 1 > 0.8));
  if (cba_missionTime + _updateWaitTime > _updateWaitTime || _targetUpdate) then {
    [_vehicle, _datalinkFreq, 1, 3, 1] spawn itc_land_ew_fnc_broadcast;
  };
  sleep 5;
  false
};
