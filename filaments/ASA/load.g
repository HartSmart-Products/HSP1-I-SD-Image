M98 P"0:/sys/System Macros/Filament Change/load_to_nozzle.g" R"ASA" S230
if global.filament_loaded == false
	T-1 P0
	M99