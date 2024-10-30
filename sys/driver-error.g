; B: CAN address of board with driver
; D: Local driver #
; P: Lower 16 bits of driver status word
; S: The full text string describing the fault

var driver_with_error = {param.B} ^ "." ^ {param.D}

;echo "Driver error from driver: "^{param.B}^"."^{param.D}^" : "^{param.P}^" ,"^{param.S}

while true ; Check Z motors
	if iterations >= #move.axes[2].drivers-1
		break
	
	if move.axes[2].drivers[iterations] == var.driver_with_error
		if state.status == "processing"
			M25
		M291 P"One or more Z axis motors are reporting an error. Axis tramming may need to be redone." A"Motor Error!" S1 T0
		M99
		
while true ; Check X motors
	if iterations >= #move.axes[0].drivers
		break
	
	if move.axes[0].drivers[iterations] == var.driver_with_error
		M98 P{directories.system^"/System Macros/Error Recovery/motor_recovery.g"} A"X"
		M99
		
while true ; Check U motors
	if iterations >= #move.axes[3].drivers
		break
	
	if move.axes[3].drivers[iterations] == var.driver_with_error
		M98 P{directories.system^"/System Macros/Error Recovery/motor_recovery.g"} A"U"
		M99
		
while true ; Check Y motors
	if iterations >= #move.axes[1].drivers
		break
	
	if move.axes[1].drivers[iterations] == var.driver_with_error
		M98 P{directories.system^"/System Macros/Error Recovery/motor_recovery.g"} A"Y"
		M99
