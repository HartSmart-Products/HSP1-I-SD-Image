var messageBoxTitle = "Bed Mesh Compensation"
var bedMaxDeviation = 0.5

var bed_temp_difference = abs(heat.heaters[0].active - heat.heaters[0].current)
var heightmap_name = floor(heat.heaters[0].active/10)*10 ^ " degrees.csv"

if heat.heaters[0].state == "active" && var.bed_temp_difference <= var.bedMaxDeviation
	M98 P{directories.system^"/homez.g"} S1	; home Z without docking the probe after

	G0 X{move.compensation.probeGrid.mins[0]-sensors.probes[0].offsets[0]} Y{move.compensation.probeGrid.mins[1]-sensors.probes[0].offsets[1]} F{global.rapid_speed}
	G29 S0									; probe the bed
	G29 S3 P{var.heightmap_name}			; save the heightmap to a file named for the set point
	M291 P{"Heightmap successfully generated, saving to " ^ var.heightmap_name} R{var.messageBoxTitle} S1 T5
	
	M402									; return probe to dock
else
	M98 P{directories.system^"/System Macros/Alert Sounds/invalid.g"}
	M291 P"The bed is not active or has not yet reached the set point. Please ensure it is active and preheated before running this routine." R{var.messageBoxTitle} S1 T5
