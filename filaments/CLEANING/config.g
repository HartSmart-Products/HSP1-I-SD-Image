M568 A2                     ; Set active tool to temp
M116 P{state.currentTool}	; Wait for the temperatures to be reached

M83							; Extruder to relative mode
G1 E100 F120				; Feed 100mm of filament
M82							; Extruder to absolute mode
M400

M702
