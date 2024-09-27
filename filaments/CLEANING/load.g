M98 P{directories.system^"/System Macros/Filament Change/load_to_nozzle.g"} F"CLEANING" S270

if global.filament_loaded == false
	T-1 P0
	M99

M568 A2                     ; Set active tool to temp
M116 P{state.currentTool}	; Wait for the temperatures to be reached

M83							; Extruder to relative mode
G1 E100 F120				; Feed 100mm of filament
M82							; Extruder to absolute mode
M400

M702
