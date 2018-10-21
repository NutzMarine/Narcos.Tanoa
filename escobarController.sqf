//INIT
//null = [Escobar,"_groupEscobar",Civilian] execVM "setGroupSide.sqf";
_unit = Escobar;
_name = name _unit;
null = [_unit,"_groupEscobar",Civilian] call T_setGroupSide;
_EscobarSpotted = Escobar addAction [_name, "MyHelloWorldDialog.sqf",nil,1,false,false,"","_target != _this"];
//hint "escobarController initialized";
_money 	= 1000000;
_wanted	= 0;
_busy	= false;

//MAIN LOOP
while {true} do {
	if (!_busy) then {
		//run business
		_busy = true;
		_task = [] spawn T_establishSmugglingRoute;
		//null = [Escobar,Lieutenant] execVM "scheduleMeeting.sqf";
	};

	sleep 1;
};
