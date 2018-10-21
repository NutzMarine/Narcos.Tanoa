while {true} do
   {
      call T_someScript; // using call and not spawn, because in this case there is no need to spawn
      sleep 1;
   };