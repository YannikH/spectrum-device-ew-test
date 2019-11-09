
itc_land_ew_freqs = [
  ["phantom4", [2440, 5760]],
  ["gps", [1227, 1575]],
  ["eplrs", [420, 450]]
];

missionNamespace setVariable ["#EM_SMin", 0];
missionNamespace setVariable ["#EM_SMax", 100];
missionNameSpace setVariable ["#EM_Transmit", false];
missionNameSpace setVariable ["#EM_Progress", 0];
missionNameSpace setVariable ["#EM_Values", []];

itc_land_ew_antennas = [
    "muzzle_antenna_01_f", [
      78, 89, // freq range
      78, 79 // accuracy
    ],
    "muzzle_antenna_02_f", [
      390, 500, // freq range
      390, 400 // accuracy
    ],
    "muzzle_antenna_03_f", [
      240, 250, // freq range
      240, 240.5 // accuracy
    ]
];

itc_land_ew_fnc_manageTransmissions = compile preprocessFileLineNumbers "manageTransmissions.sqf";
itc_land_ew_fnc_broadcast = compile preprocessFileLineNumbers "broadcast.sqf";
itc_land_ew_fnc_setValues = compile preprocessFileLineNumbers "setValues.sqf";
itc_land_ew_fnc_setBroadcastPower = compile preprocessFileLineNumbers "setBroadcastPower.sqf";
itc_land_ew_fnc_handlePerFrame = compile preprocessFileLineNumbers "handlePerFrame.sqf";
itc_land_ew_fnc_getAntennaParams = compile preprocessFileLineNumbers "getAntennaParams.sqf";

{
  [_x] spawn itc_land_ew_fnc_manageTransmissions;
} forEach vehicles;

[{_this call itc_land_ew_fnc_handlePerFrame}, 0, [currentWeapon player, (handgunItems player) # 0]] call CBA_fnc_addPerFrameHandler;
