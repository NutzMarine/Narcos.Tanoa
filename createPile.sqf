_objType = _this select 0;
_pilePos = _this select 1;
_num = _this select 2;
_deg = 360/(_num-1);

_pileObj = createVehicle [_objType, _pilePos, [], 0, "CAN_COLLIDE"];
for [{_i=1}, {_i<_num-1}, {_i=_i+1}] do
{
	_objPos = _pileObj getRelPos[1,_i*_deg];
	_obj = createVehicle [_objType, _objPos, [], 0, "CAN_COLLIDE"];
	_obj allowDamage false;
};
_pileObj