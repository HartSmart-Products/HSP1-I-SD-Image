; Parameters for heater state
if exists(global.heater_state)
	M568 P0 S{global.t0_active} R{global.t0_standby}
	M568 P1 S{global.t1_active} R{global.t1_standby}
	
	M568 P2 S{global.t2_0_active, global.t2_1_active} R{global.t2_0_standby,global.t2_1_standby}
	
	M568 P3 S{global.t3_0_active, global.t3_1_active} R{global.t3_0_standby,global.t3_1_standby}
	
	M140 S{global.bed_active}
