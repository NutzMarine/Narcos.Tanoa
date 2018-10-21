_unit = _this select 0;
_camp = _this select 1;
_veh = nil;
_task = nil;
_type = "man";
_busy = false;

if (vehicle _unit != _unit) then {
	_veh = vehicle _unit;
	_type = "driver";
};

switch (_type) do {
    case "driver": {_task = "Drive";};
    case "man": {_task = "Patrol"};
    default {_task = "Patrol"};
};

_nearestObjects = nearestObjects [_camp, [], 50];
while {!(isNil "_unit")} do {
	if (!_busy && behaviour _unit == "SAFE") then {
		if (_task == "Patrol") then {
			_busy = true;
			_pos = position _unit;
			
			_target = position (selectRandom _nearestObjects);
			_unit doMove _target;
			waitUntil {_unit distance _target < 5};
			sleep random[60,120,180];
			_busy = false;
		};
	};
	if (behaviour _unit != "SAFE") then {
		_unit doFollow leader _unit;
	};
};