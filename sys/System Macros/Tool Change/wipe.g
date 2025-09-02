M98 R0

; Wipe the nozzle
var wiper_x = 0
var wiper_y = 0
var dual_wipe = false
var wipe_direction = -1
var wiper_width = 15
var wiper_length = 40
var wipe_y_step = 5
var wipe_speed = 100*60
var prime_before_wipe_amount = 13

if !exists(global.wiper_offset)
	global wiper_offset = 0

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
var start_position_y = (var.wiper_y - (var.wiper_length/2))+5+global.wiper_offset
var a_side_y = var.wiper_y - (var.wiper_length/2)
var b_side_y = var.wiper_y + (var.wiper_length/2)

set global.wiper_offset = global.wiper_offset + var.wipe_y_step
if global.wiper_offset >= var.wiper_length - 20
	set global.wiper_offset = 0

; Predefined U points
var start_position_u = global.t1_wiper_x_pos + ((var.wiper_width/2)+15)
var a_side_u = global.t1_wiper_x_pos + (var.wiper_width/2)
var b_side_u = global.t1_wiper_x_pos - (var.wiper_width/2)

; Wipe with settings from above
M116 P{state.currentTool}
G90
M83

if var.dual_wipe == false
	G0 X{var.start_position_x} Y{var.start_position_y} F{global.rapid_speed}
else
	G0 H2 X{var.start_position_x} Y{var.start_position_y} U{var.start_position_u} F{global.rapid_speed}

G1 E{var.prime_before_wipe_amount} F{2*60}
G1 E-2 F{30*60}

if var.dual_wipe == false
	G1 X{var.a_side_x+(10*var.wipe_direction)} F{var.wipe_speed}
	G1 X{var.a_side_x} Y{var.a_side_y}
	var steps = var.wipe_y_step*2
	while var.steps < var.wiper_length
		G1 Y{var.a_side_y+var.steps}
		G1 X{var.b_side_x} 
		set var.steps = var.steps + (var.wipe_y_step*2)
		G1 Y{var.a_side_y+var.steps}
		G1 X{var.a_side_x}
		set var.steps = var.steps + (var.wipe_y_step*2)
else
	G1 H2 X{var.a_side_x-10} U{var.a_side_u+10} F{var.wipe_speed}
	M400
	G1 H2 X{var.a_side_x} U{var.a_side_u} Y{var.a_side_y}
	var steps = var.wipe_y_step*2
	while var.steps < var.wiper_length
		G1 H2 Y{var.a_side_y+var.steps}
		G1 H2 X{var.b_side_x} U{var.b_side_u}
		set var.steps = var.steps + (var.wipe_y_step*2)
		G1 H2 Y{var.a_side_y+var.steps}
		G1 H2 X{var.a_side_x} U{var.a_side_u}
		set var.steps = var.steps + (var.wipe_y_step*2)
