; Parameters for heater state
if !exists(global.heater_state)
	global heater_state = null
	global tool_active = {0, 0, {0, 0}, {0, 0}}
	global tool_standby = {0, 0, {0, 0}, {0, 0}}
	global bed_active = 0

set global.tool_active = {tools[0].active[0], tools[1].active[0], {tools[2].active[0], tools[2].active[1]}, {tools[3].active[0], tools[3].active[1]}}
set global.tool_standby = {tools[0].standby[0], tools[1].standby[0], {tools[2].standby[0], tools[2].standby[1]}, {tools[3].standby[0], tools[3].standby[1]}}

set global.bed_active = heat.heaters[0].active
