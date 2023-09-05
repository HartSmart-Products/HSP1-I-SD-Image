M98 P"0:/sys/System Macros/Filament Change/Load to Nozzle.g" R"Generic PLA" S210
if global.filament_loaded == false
	T-1 P0
	M99
