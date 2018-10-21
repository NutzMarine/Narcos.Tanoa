_unit		= _this select 0;
_group		= _this select 1;
_maxSize	= 100;
_range = 200;
_civTypes = ["C_Man_casual_1_F_tanoan",
	"C_Man_casual_2_F_tanoan",
	"C_Man_casual_3_F_tanoan",
	"C_Man_casual_4_F_tanoan",
	"C_Man_casual_5_F_tanoan",
	"C_Man_casual_6_F_tanoan",
	"C_man_sport_1_F_tanoan",
	"C_man_sport_2_F_tanoan",
	"C_man_sport_3_F_tanoan",
  	"I_C_Soldier_Bandit_1_F",
	"I_C_Soldier_Bandit_2_F",
	"I_C_Soldier_Bandit_3_F",
	"I_C_Soldier_Bandit_4_F",
	"I_C_Soldier_Bandit_5_F",
	"I_C_Soldier_Bandit_6_F",
	"I_C_Soldier_Bandit_7_F",
	"I_C_Soldier_Bandit_8_F"];

_buildingTypes = [
	"Land_House_Big_01_F",
	"Land_House_Big_02_F",
	"Land_House_Big_04_F",
	"Land_House_Small_01_F",
	"Land_House_Small_02_F",
	"Land_House_Small_03_F",
	"Land_House_Small_04_F",
	"Land_House_Small_05_F",
	"Land_House_Small_06_F",
	"Land_Shed_01_F",
	"Land_Shed_02_F",
	"Land_Shed_03_F",
	"Land_Shed_05_F",
	"Land_Shed_04_F",
	"Land_Shed_07_F",
	"Land_Slum_01_F",
	"Land_Slum_02_F",
	"Land_Slum_03_F",
	"Land_GarageShelter_01_F",
	"Land_Shop_City_01_F",
	"Land_Shop_City_02_F",
	"Land_Shop_City_03_F",
	"Land_Shop_City_06_F",
	"Land_Shop_Town_01_F",
	"Land_Shop_Town_03_F",
	"Land_Addon_04_F",
	"Land_School_01_F",
	"Land_House_Big_03_F",
	"Land_FuelStation_shop_01_F",
	"Land_FuelStation_workshop_01_F",
	"Land_FuelStation_workshop_02_F",
	"Land_Hotel_01_F",
	"Land_Hotel_02_F",
	"Land_Supermarket_01_F",
	"Land_Airport_01_controlTower_F",
	"Land_Airport_02_controlTower_F",
	"Land_Airport_02_terminal_F",
	"Land_Airport_01_terminal_F",
	"Land_House_Native_01_F",
	"Land_House_Native_02_F",
	"Land_Temple_Native_01_F",
	"Land_SM_01_shed_F",
	"Land_SCF_diffuser_01_F",
	"Land_SCF_generalBuilding_01_F",
	"Land_SCF_washer_01_F",
	"Land_Warehouse_03_F",
	"Land_GuardHouse_01_F",
	"Land_PierWooden_02_hut_F",
	"Land_PierWooden_01_dock_F",
	"Land_PierWooden_01_16m_F"];

	
_srcPos = position _unit;
_pos = _srcPos;
_nearestBuildings = nearestObjects [_unit,_buildingTypes,_range];
_maxSize = round (count _nearestBuildings)*2;
//_group = createGroup Civilian;
_tmpGroup = grpNull;
_leader = nil;
_placement = 0;

_group setBehaviour "SAFE";
_group setSpeedMode "LIMITED";

while {true} do {
	_size = count (units _group);
	_veh = nil;
	
	if (_srcPos distance _unit > _range/2) then {
		_srcPos = position _unit;
		_nearestBuildings = nearestObjects [_unit,_buildingTypes,_range];
		_maxSize = round (count _nearestBuildings)*2;
		_group setBehaviour "SAFE";
		_group setSpeedMode "LIMITED";
	};
	
	if (_size < _maxSize) then {
		_tmpGroup = createGroup Civilian;
		_civ = selectRandom _civTypes;
		
		
		_spawnType = selectRandom["Building"];
		switch (_spawnType) do {
			case "Building": {
				_building = selectRandom _nearestBuildings;
				_return = [_building,_pos] call T_civBuildingSpawn;
				_pos = _return select 0;
				_placement = _return select 1;
			};
			case "Object": {
			
			};
			case "Bench": {

			};
			case "Vehicle": {
				_vehicles = nearestObjects[_unit,["Car"],_range];
				_veh = selectRandom _vehicles;
				_pos = _veh getRelPos[2,-90];
			};
		};
		
		if (_size == 0 || isNil "_size") then {
			_civ = "C_Man_casual_1_F_tanoan";
			_civ = _tmpGroup createUnit [_civ, _pos, [], _placement, "NONE"];
			_civ setRank "COLONEL";
			_group setBehaviour "SAFE";
			_group setSpeedMode "LIMITED";
		} else {
			_civ = _tmpGroup createUnit [_civ, _pos, [], _placement, "NONE"];
			removeAllWeapons _civ;
			removeVest _civ;
			_group setBehaviour "SAFE";
			_group setSpeedMode "LIMITED";
			//removeBackpack _civ;
		};
		[_civ] joinSilent _group;
		deleteGroup _tmpGroup;
		if (rank _civ == "COLONEL") then {
			_leader = _civ;
		};
		
		if (!(isNil "_veh")) then {
			_civ assignAsDriver _veh;
			[_civ] orderGetIn true;
		};
		_behavior = [_civ,_unit,_buildingTypes] spawn T_civBehavior;
	};
};