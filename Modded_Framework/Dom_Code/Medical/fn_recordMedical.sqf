/*
	File: fn_recordMedical.sqf
	Author: Dom
	Description: Records a medical action
*/

params [
	["_unit",objNull,[objNull]],
	["_text","",[""]]
];

date params ["","","","_hour","_minute"];
if (_minute < 10) then {
	_minute = format["0%1",_minute];
};
if (_hour < 10) then {
	_hour = format["0%1",_hour];
};
_text = format["%1:%2 - %3",_hour,_minute,_text];
private _curRecords = _unit getVariable ["medRecords",[]];
_curRecords pushBack _text;
