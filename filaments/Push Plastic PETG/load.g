M98 P"0:/macros/Filament Change Macros/Load to Nozzle.g" R"Push Plastic PETG" S240
if global.filament_loaded == false
	T-1 P0
	M99
