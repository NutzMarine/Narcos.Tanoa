_drugLabs = _this select 0;

_vehicleTypes = ["C_Truck_02_covered_F",
	"C_Truck_02_transport_F",
	"C_Offroad_01_F",
	"C_Hatchback_01_F",
	"C_Hatchback_01_sport_F",
	"C_Offroad_02_unarmed_F",
	"C_SUV_01_F",
	"C_Van_01_transport_F",
	"C_Van_01_box_F",
	"C_Van_02_vehicle_F",
	"C_Van_02_transport_F"];
	
//_vehicleTypes = ["O_T_Truck_03_covered_ghex_F"];

_group = createGroup Civilian;
_group setGroupId ["Smugglers"];

{
	_y = _x;
	_pos = _y; 
	_nearestRoad = [_pos, 500] call BIS_fnc_nearestRoad;
	_pickupPos = position _nearestRoad;
	
	_vehicle = selectRandom _vehicleTypes;
	_veh = createVehicle [_vehicle, _pickupPos, [], 0, "NONE"];
	_veh allowDamage false;
	_null = [_veh] spawn 
	{
		sleep 5;
		_this select 0 allowDamage true;
	};
	createVehicleCrew _veh;
	{
		[_x] joinSilent _group;
	} forEach units (group _veh);
	doStop _veh;
	_group setBehaviour "SAFE";
	_group setSpeedMode "LIMITED";
	_smugglerDriver = [_veh, _pos] spawn T_smugglerBehavior;
} foreach _drugLabs;