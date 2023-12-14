; Parameters for heater state
if !exists(global.heater_state)
	global heater_state = null
	global t0_active = 0
	global t0_standby = 0
	global t1_active = 0
	global t1_standby = 0
	global t2_0_active = 0
	global t2_0_standby = 0
	global t2_1_active = 0
	global t2_1_standby = 0
	global t3_0_active = 0
	global t3_0_standby = 0
	global t3_1_active = 0
	global t3_1_standby = 0
	global bed_active = 0

set global.t0_active = tools[0].active[0]
set global.t0_standby = tools[0].standby[0]
set global.t1_active = tools[1].active[0]
set global.t1_standby = tools[1].standby[0]

set global.t2_0_active = tools[2].active[0]
set global.t2_0_standby = tools[2].standby[0]
set global.t2_1_active = tools[2].active[1]
set global.t2_1_standby = tools[2].standby[1]

set global.t3_0_active = tools[3].active[0]
set global.t3_0_standby = tools[3].standby[0]
set global.t3_1_active = tools[3].active[1]
set global.t3_1_standby = tools[3].standby[1]

set global.bed_active = heat.heaters[0].active
