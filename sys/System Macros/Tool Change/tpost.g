M703						; load filament config
M106 R2						; restore print cooling fan speed
M116 P{state.currentTool}	; wait for tool 0 heaters to reach operating temperature

if (state.status == "processing" || state.status == "resuming")
	M98 P{directories.system^"/System Macros/Tool Change/wipe.g"}
