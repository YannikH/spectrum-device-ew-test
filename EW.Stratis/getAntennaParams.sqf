/*
 * itc_land_ew_fnc_getAntennaParams
 *
 * Gets frequency range parameters from an antenna
 *
 * params: [(string) antenna classname]
 */
params ["_antenna"];
private _key = itc_land_ew_antennas find _antenna;
if (_key > -1) exitWith {
  itc_land_ew_antennas # (_key + 1)
};
