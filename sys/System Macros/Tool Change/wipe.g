; Wipe the nozzle
var wiper_x = 0
var wiper_y = 0
var dual_wipe = false
var wipe_direction = -1
var wiper_width = 15
var wiper_length = 40
var wipe_speed = 100*60
var prime_before_wipe_amount = 7.5

if state.currentTool == 0
	; Set tool 0 wipe settings
	set var.wiper_x = global.t0_wiper_x_pos
	set var.wiper_y = global.t0_wiper_y_pos
elif state.currentTool == 1
	; Set tool 1 wipe settings
	set var.wiper_x = global.t1_wiper_x_pos
	set var.wiper_y = global.t1_wiper_y_pos
	set var.wipe_direction = 1
elif state.currentTool == 2 || state.currentTool == 3
	set var.wiper_x = global.t0_wiper_x_pos
	set var.wiper_y = global.t0_wiper_y_pos
	set var.dual_wipe = true
else
	; Abort, since none of these tools are valid
	echo "No valid tool selected for wiping, aborting"
	M99

; Predefined X points
var start_position_x = var.wiper_x + (((var.wiper_width/2)+15)*var.wipe_direction)
var a_side_x = var.wiper_x + ((var.wiper_width/2)*var.wipe_direction)
var b_side_x = var.wiper_x - ((var.wiper_width/2)*var.wipe_direction)

; Predefined Y points
var start_position_y = (var.wiper_y - (var.wiper_length/2))+10
var a_side_y = var.wiper_y - (var.wiper_length/2)
var b_side_y = var.wiper_y + (var.wiper_length/2)

; Predefined U points
var start_position_u = global.t1_wiper_x_pos + ((var.wiper_width/2)+15)
var a_side_u = global.t1_wiper_x_pos + (var.wiper_width/2)
var b_side_u = global.t1_wiper_x_pos - (var.wiper_width/2)

; Wipe with settings from above
G90
M83

if var.dual_wipe == false
	G0 X{var.start_position_x} Y{var.start_position_y} F{global.rapid_speed}
else
	G0 H2 X{var.start_position_x} Y{var.start_position_y} U{var.start_position_u} F{global.rapid_speed}

G1 E{var.prime_before_wipe_amount} F{2*60}
G1 E-2 F{30*60}

if var.dual_wipe == false
	G1 X{var.a_side_x} F{var.wipe_speed}
	G1 X{var.b_side_x} Y{var.b_side_y}
	G1 X{var.a_side_x}
	G1 X{var.b_side_x} Y{var.a_side_y}
else
	G1 H2 X{var.a_side_x} U{var.a_side_u} F{var.wipe_speed}
	G1 H2 X{var.b_side_x} Y{var.b_side_y} U{var.b_side_u}
	G1 H2 X{var.a_side_x} U{var.a_side_u}
	G1 H2 X{var.b_side_x} Y{var.a_side_y} U{var.b_side_u}
