; Parameters for the tool configurations
if !exists(global.tool_params)
	; --- Do not modify the values here ---
	global tool_params = null
	global t0_nozzle_diameter = 0.0
	global t1_nozzle_diameter = 0.0
	global t0_fm_diameter = 8.000
	global t1_fm_diameter = 8.000
	global t0_e_steps = 400.0
	global t1_e_steps = 400.0
	global t0_wiper_x_pos = 0
	global t0_wiper_y_pos = 0
	global t1_wiper_x_pos = 0
	global t1_wiper_y_pos = 0
	global filament = {"",""}
	global default_fm_low = 0
	global default_fm_high = 0
	global default_fm_override = false

; --- Modify values below here ---

; Nozzle diameter settings
M98 P{directories.system^"/Printer Parameters/Tool/t0_nozzle.g"}
M98 P{directories.system^"/Printer Parameters/Tool/t1_nozzle.g"}

; Tool offset settings
M98 P{directories.system^"/Printer Parameters/Tool/t1_offsets.g"}

; Filament monitor settings
set global.t0_fm_diameter = 8.000
set global.t1_fm_diameter = 8.000

; Extruder steps per mm settings
M98 P{directories.system^"/Printer Parameters/Tool/t0_esteps.g"}
M98 P{directories.system^"/Printer Parameters/Tool/t1_esteps.g"}

; Nozzle wiper positions
M98 P{directories.system^"/Printer Parameters/Tool/t0_wiper_position.g"}
M98 P{directories.system^"/Printer Parameters/Tool/t1_wiper_position.g"}

; Filaments
M98 P{directories.system^"/Printer Parameters/Tool/filament.g"}

; Filament Monitor default settings
set global.default_fm_low = 80
set global.default_fm_high = 120
