var daemon_sleep = 2

if !exists(global.bed_timeout_start)
	global bed_timeout_start = 0
	global tool_timeout_start = 0
    global bed_timer_active = false
	global tool_timer_active = false

while true
	if (state.status == "idle" || state.status == "simulating")
		var beds_active = false
		var tools_active = false
		while iterations < #heat.bedHeaters
			if heat.bedHeaters[iterations] != -1
				if heat.heaters[iterations].state == "active" || heat.heaters[iterations].state == "standby"
					set var.beds_active = true
					if global.bed_timer_active && state.upTime - global.bed_timeout_start >= global.bed_heater_timeout
						M140 S-273.1
		
		while iterations < #tools
			var current_tool = iterations
			while true
				if iterations >= #tools[var.current_tool].heaters
					break
				
				if heat.heaters[tools[var.current_tool].heaters[iterations]].state == "active" || heat.heaters[tools[var.current_tool].heaters[iterations]].state == "standby"
					set var.tools_active = true
					if global.tool_timer_active && state.upTime - global.tool_timeout_start >= global.tool_heater_timeout
						M568 P{var.current_tool} A0

		if var.beds_active
            if !global.bed_timer_active
                set global.bed_timeout_start = state.upTime
                set global.bed_timer_active = true
		else
			set global.bed_timer_active = false

		if var.tools_active
            if !global.tool_timer_active
                set global.tool_timeout_start = state.upTime
                set global.tool_timer_active = true
		else
			set global.tool_timer_active = false
	else
		set global.tool_timer_active = false
		set global.bed_timer_active = false
	
	G4 S{var.daemon_sleep}
