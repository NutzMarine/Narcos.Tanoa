_unit = _this select 0;

_ok = createDialog "MyHelloWorldDialog";
waitUntil { !dialog }; // hit ESC to close it
_name = name _unit;
hint format ["%1 spotted!",_name];

null = [_unit,(group _unit),East] call T_setGroupSide;
