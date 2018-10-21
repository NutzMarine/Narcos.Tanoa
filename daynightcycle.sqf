If ! (IsServer)exitwith{};
 _addtime = 10; 		// Number of minutes you want to advance per cycle)
 _delay = 180; 		// delay in seconds between loops (3 minutes in this example)

While{TRUE}do
{
sleep _delay;
Tag_NewDate = [date select 0, date select 1, date select 2, date select 3, (date select 4 + _addtime)];
PublicVariable "Tag_NewDate";
SetDate Tag_NewDate;
};