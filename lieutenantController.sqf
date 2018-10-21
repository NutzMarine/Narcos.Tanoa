//INIT
_unit = Lieutenant;
null = [_unit,"_groupLieutenant",Civilian] call T_setGroupSide;
_name = name _unit;
null = _unit addAction [_name, "MyHelloWorldDialog.sqf",_unit,1,false,false,"","_target != _this"];
//hint "escobarController initialized";
_money 	= 500;
_wanted	= 0;
_busy	= false;

//MAIN LOOP
while {true} do {
	if (!_busy) then {
		//run business
	};

	sleep 1;
};
