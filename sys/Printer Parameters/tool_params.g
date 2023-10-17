; Parameters for the tool configurations
if !exists(global.tool_params)
	; --- Do not modify the values here ---
	global tool_params = null
	global t0_nozzle_diameter = 0.0
	global t1_nozzle_diameter = 0.0
	global t1_x_offset = 0.0
	global t1_y_offset = 0.0
	global t1_z_offset = 0.0
	global t0_fm_diameter = 8.000
	global t1_fm_diameter = 8.000
	global t0_e_steps = 400.0
	global t1_e_steps = 400.0
	global t0_filament = ""
	global t1_filament = ""

; --- Modify values below here ---

; Nozzle diameter settings
set global.t0_nozzle_diameter = 0.6
set global.t1_nozzle_diameter = 0.6

; Tool offset settings
set global.t1_x_offset = 0.0
set global.t1_y_offset = 0.0
set global.t1_z_offset = 0.0

; Filament monitor settings
set global.t0_fm_diameter = 8.000
set global.t1_fm_diameter = 8.000

; Extruder steps per mm settings
set global.t0_e_steps = 404.70
set global.t1_e_steps = 404.70
