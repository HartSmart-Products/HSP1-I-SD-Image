; Parameters for heater state
if exists(global.heater_state)
	M568 P0 S{global.tool_active[0]} R{global.tool_standby[0]}
	M568 P1 S{global.tool_active[1]} R{global.tool_standby[1]}
	
	M568 P2 S{global.tool_active[2][0], global.tool_active[2][1]} R{global.tool_standby[2][0], global.tool_standby[2][1]}
	
	M568 P3 S{global.tool_active[3][0], global.tool_active[3][1]} R{global.tool_standby[3][0], global.tool_standby[3][1]}
	
	M140 S{global.bed_active}
