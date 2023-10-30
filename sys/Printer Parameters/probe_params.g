; Parameters for probing
if !exists(global.probe_params)
	; --- Do not modify the values here ---
	global probe_params = null
	global dock_position_x = 0
	global dock_position_y = 0
	global probe_z_offset = 0.0

; --- Modify values below here ---

; Probe dock position
M98 P{directories.system^"/Printer Parameters/Probe/dock_position.g"}

; Probe offsets
M98 P{directories.system^"/Printer Parameters/Probe/probe_offset.g"}
