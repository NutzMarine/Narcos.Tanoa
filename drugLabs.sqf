T_smugglingRoutes			= compileFinal preProcessFileLineNumbers "smugglingRoutes.sqf";
T_smugglerBehavior			= compileFinal preProcessFileLineNumbers "smugglerBehavior.sqf";

_center = [9847.133,7755.915,0];
_expression = "(1 + forest + trees) * (1 - sea) * (1 - meadow)";
_tmpGroup = createGroup east;
_group = createGroup east;
_group setGroupId ["Lab Guards"];

_bestPlaces = selectBestPlaces [_center, 7000, _expression, 50, 5];
//hint format["%1", _bestPlaces];
_count = 1;
_drugLabs = [[],[],[],[],[]];
_expression = "(1 + forest + trees) * (1 - sea) * (1 - meadow) * (1- houses)";
{
	_y = _x;
	_pos = _y select 0;
	_pos = selectBestPlaces [_pos, 500, _expression, 10, 1] select 0 select 0;
	_drugLabs set [_count-1,_pos];
	_markerstr = createMarker [format["Drug Lab %1",_count],[_pos select 0,_pos select 1]];
	_markerstr setMarkerShape "ICON";
	_markerstr setMarkerType "mil_objective";
	_markerstr setMarkerColor "ColorOPFOR";
	
	_campPos = [_pos, 0, 50, 5, 0, 45, 0, [], _pos] call BIS_fnc_findSafePos;
	_campPos = [_campPos select 0, _campPos select 1, 0];
	
	_pilePos = [_campPos, 0, 5, 1, 0, 45, 0, [], _campPos] call BIS_fnc_findSafePos;
	_pileObj = ["Land_BarrelSand_F",_pilePos,6] spawn T_createPile;
	
	_pilePos = [_campPos, 0, 3, 1, 0, 45, 0, [], _campPos] call BIS_fnc_findSafePos;
	_pileObj = ["Land_Sacks_heap_F",_pilePos,4] spawn T_createPile;

	_obj = createVehicle ["CamoNet_ghex_F", _campPos, [], 0, "CAN_COLLIDE"];
	_obj allowDamage false; 
	
	_squad = [
		"I_C_Soldier_Bandit_7_F", //Dealer (Rifle)
		"I_C_Soldier_Bandit_3_F", //Guard (MG)
		"I_C_Soldier_Bandit_5_F", //Scout (Rifle)
		"I_C_Soldier_Bandit_6_F", //Smuggler (UGL)
		"I_C_Soldier_Bandit_1_F", //Snatcher (Medikit)
		"I_C_Soldier_Bandit_4_F"]; //Watcher (Rifle)
	
	_tmpGroup = createGroup east;
	{
		_man = _tmpGroup createUnit [_x, _campPos, [], 5, "NONE"];
		_man setBehaviour "SAFE";
		_man setSpeedMode "LIMITED";
		_smugglerBehavior = [_man, _campPos] spawn T_smugglerBehavior;
		doStop _man;
		_man = "";
		
	} forEach _squad;
	_group = [leader _tmpGroup,"_group",East] call T_setGroupSide;
	_group setBehaviour "SAFE";
	_group setSpeedMode "LIMITED";
	
	_count = _count + 1;
} forEach _bestPlaces;
_drugLabs