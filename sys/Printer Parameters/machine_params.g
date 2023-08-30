; Parameters for the machine kinematics
if !exists(global.machine_params)
	; --- Do not modify the values here ---
	global machine_params = null
	global x_max_travel = move.axes[0].max
	global x_max_travel_duplicator = global.x_max_travel/2
	global y_axis_skew = 0
	global rapid_speed = 0

; --- Modify values below here ---

set global.y_axis_skew = 0.0

set global.rapid_speed = 200 * 60