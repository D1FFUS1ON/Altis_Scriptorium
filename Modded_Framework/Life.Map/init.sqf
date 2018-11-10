
if !(isServer) then {
	waitUntil {!isNull player && !(isNil "mod_list")};
	cutText ["Requesting player data from the server...","BLACK",1];
	private _check = false;
	{
		if !(configName _x in mod_list) exitWith {_check = true};
	} forEach ("true" configClasses (configFile >> "CfgPatches"));
	if (_check) exitWith {
		[player,"Extra PBO detected",true] remoteExecCall ["server_fnc_logAction",2];
		["YouSuck",false,5] call BIS_fnc_endMission;
	};
	call compile preprocessFileLineNumbers "initVars.sqf";
	call compile preProcessFileLineNumbers '\Dom_Client\XEH_postClientInit.sqf';
	[getPlayerUID player,player] remoteExec ["DB_fnc_initialStats",2];
} else {
	[] call compile preprocessFileLineNumbers "\Dom_Server\init.sqf";
	[] spawn {
		waitUntil {time > 0};
		setDate (missionStart select [0,5]);
	};		
};