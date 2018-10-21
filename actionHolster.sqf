_unit = _this select 0;

_unit addAction
[
    "Holster Weapon", 
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
		removeAllWeapons _target;
		_group = group _target;
		null = [_target,"_group",Civilian] call T_setGroupSide;
		_target removeAction _actionId; 
    },
    [],
    1.5, 
    true, 
    true, 
    "",
    "true", // _target, _this, _originalTarget
    1,
    false,
    "",
    ""
];