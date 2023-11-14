; Parameters for the machine kinematics
if !exists(global.machine_params)
	; --- Do not modify the values here ---
	global machine_params = null
	global y_axis_skew = 0
	global rapid_speed = 0

; --- Modify values below here ---

set global.y_axis_skew = 0.0

set global.rapid_speed = 400 * 60
