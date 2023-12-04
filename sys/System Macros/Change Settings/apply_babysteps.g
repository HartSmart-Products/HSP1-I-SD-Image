; Clear babysteps and apply new trigger height only when homing the z axis
if exists(global.trigger_height_to_apply)
	if global.trigger_height_to_apply != sensors.probes[0].triggerHeight
		M290 R0 S0									; Clear babystepping
		G31 L0 Z{global.trigger_height_to_apply}	; Apply new trigger height
		M99
