params ["_unit","_town"];

[_unit, (selectRandom OT_faces_local)] remoteExecCall ["setFace", 0, _unit];
[_unit, (selectRandom OT_voices_local)] remoteExecCall ["setSpeaker", 0, _unit];

_unit setVariable ["garrison",_town,false];

private _stability = server getVariable format["stability%1",_town];

_unit addEventHandler ["HandleDamage", {
	_me = _this select 0;
	_src = _this select 3;
	if(captive _src) then {
		if(!isNull objectParent _src || (_src call OT_fnc_unitSeenNATO)) then {
			_src setCaptive false;
		};
	};
}];

if((random 100) < 75 && OT_randomizeLoadouts) then {
	_unit setUnitLoadout [_unit call OT_fnc_getRandomLoadout, true];
};

_unit addEventHandler ["Dammaged", OT_fnc_EnemyDamagedHandler];
