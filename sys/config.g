; Configuration file for Duet 3 MB 6XD
; executed by the firmware on start-up

; Execute pre parameter macros
M98 P{directories.system^"/Printer Parameters/tool_params.g"}
M98 P{directories.system^"/Printer Parameters/probe_params.g"}

; General preferences
M575 P1 S1 B57600													; enable support for PanelDue
G90																	; send absolute coordinates...
M83																	; ...but relative extruder moves

; Wait a moment for the CAN expansion boards to start
G4 S2

; Drives
M569 P0.0 S1 R0 T3.0:3.0:5.0:0										; physical drive 1.0 goes forwards (U-axis)
M569 P0.1 S1 R0 T3.0:3.0:5.0:0										; phycical drive 1.1               (X-axis)
M569 P0.2 S0 R0 T3.0:3.0:5.0:0										; physical drive 1.2 goes forwards (Y-axis)
M569 P0.3 S1 R0 T3.0:3.0:5.0:0										; physical drive 1.2               (Y-Axis)
M569 P1.0 S1 R0 T3.0:3.0:5.0:0										; physical drive 0.0 goes forwards (Z-axis, Front-Left)
M569 P1.1 S1 R0 T3.0:3.0:5.0:0										; physical drive 0.1 goes forwards (Z-axis, Rear-Left)
M569 P1.2 S1 R0 T3.0:3.0:5.0:0										; physical drive 0.2 goes forwards (Z-axis, Rear-Right)
M569 P1.3 S1 R0 T3.0:3.0:5.0:0										; physical drive 0.3 goes forwards (Z-axis, Front-Right)
M569 P20.0 S0														; physical drive 20.0 goes backwards (E0)
M569 P21.0 S0														; physical drive 21.0 goes backwards (E1)
M584 U0.0 X0.1 Y0.2:0.3 Z1.0:1.1:1.2:1.3 E20.0:21.0					; set drive mapping
M350 E16:16 I1														; set extruder drive microstepping
M92 U200.00 X200.00 Y200.00 Z800.00 E{global.t0_e_steps, global.t1_e_steps}	; set steps per mm
M566 U240.00 X240.00 Y240.00 Z150.00 E900.00:900.00					; set maximum instantaneous speed changes (mm/min)
M203 U30000.0 X30000.00 Y30000.00 Z600.00 E6000.00:6000.00			; set maximum speeds (mm/min)
M201 U5000.0 X5000.00 Y5000.00 Z300.00 E2400.00:2400.00				; set accelerations (mm/s^2)
M906 E850:850														; set motor currents (mA)
M84 S0																; Disable motor idle current reduction

; Axis Limits
M671 X-20:-20:720:720 Y-88.5:672.5:672.5:-88.5 S3.0					; position of leadscrew/bed pivot point at front left, rear left, rear right and front right
M208 U0 X-63 Y0 Z0 S1												; set axis minima
M208 U709 X650 Y640 Z1050 S0										; set axis maxima

; Endstops
M574 U2 S1 P"21.out1.tach"											; configure switch-type for U-axis
M574 X1 S1 P"20.out1.tach"											; configure switch-type for X-axis
M574 Y1 S1 P"0.io2.in+0.io3.in"							    		; configure switch-type for Y-axis

; Z-Probe
M574 Z1 S2															; Configure probe as Z min endstop
M558 K0 P8 C"20.io0.in" H5 F450:240 T18000 A3 S0.01					; Setup probe input
G31 K0 P500 X-35.0 Y45.0 Z{global.probe_z_offset}					; Set rough probe parameters
M557 X20:610 Y55:610 P7							    				; define mesh grid

; Heaters
M308 S0 P"0.temp0" Y"thermistor" T100000 B4138 A"Bed Heater"		; configure sensor 0 as thermistor on pin temp0
M950 H0 Q10 C"0.out3" T0											; create bed heater output on out3 and map it to sensor 0
M307 H0 B0 S1.00													; disable bang-bang mode for the bed heater and set PWM limit
M140 H0																; map heated bed to heater 0
M143 H0 S120														; set temperature limit for heater 0 to 120C

M308 S1 P"20.temp0" Y"pt1000" A"Left Heater"						; sensor 1 (toolboard)
M950 H1 C"20.out0" T1												; create heater 1 and map sensor 1 (toolboard)
M307 H1 B0 S0.80													; disable bang-bang mode for heater  and set PWM limit
M143 H1 S305														; set temperature limit for heater 1 to 305C

M308 S2 P"21.temp0" Y"pt1000" A"Right Heater"						; sensor 2 (toolboard)
M950 H2 C"21.out0" T2												; create heater 2 and map sensor 2 (toolboard)
M307 H2 B0 S0.80													; disable bang-bang mode for heater  and set PWM limit
M143 H2 S305														; set temperature limit for heater 2 to 305C

; Fans
M950 F0 C"20.out2+out2.tach" Q500									; create fan 0 and set its frequency
M106 P0 H1 T45														; set fan 0 value. Thermostatic control is turned on
M950 F1 C"21.out2+out2.tach" Q500									; create fan and set its frequency
M106 P1 H2 T45														; set fan 1 value. Thermostatic control is turned on
M950 F2 C"0.out0" Q25000											; (BERDAIR) create fan 2 and set its frequency 
M106 P2 C"Airpump primary" S0 H-1									; (BERDAIR) set fan 2 name and value. Thermostatic control is turned off
M950 F3 C"0.out1" Q25000											; (BERDAIR) create fan 3 and set its frequency
M106 P3 C"Airpump secondary" S0 H-1									; (BERDAIR) set fan 3 name and value. Thermostatic control is turned off

; Tools
M563 P0 D0 H1 F2 S"Left"											; define tool 0
G10 P0 X0 Y0 Z0														; set tool 0 axis offsets
M568 P0 R0 S0														; set initial tool 0 active and standby temperatures to 0C
M591 D0 P3 C"20.io1.in" S1 L{global.t0_fm_diameter * pi} R{global.default_fm_low, global.default_fm_high}	; extruder 0 filament monitor

M563 P1 D1 X3 H2 F3 S"Right"										; define tool 1
G10 P1 U{global.t1_x_offset} Y{global.t1_y_offset} Z{global.t1_z_offset}	; set tool 1 axis offsets
M568 P1 R0 S0														; set initial tool 1 active and standby temperatures to 0C
M591 D1 P3 C"21.io1.in" S1 L{global.t1_fm_diameter * pi} R{global.default_fm_low, global.default_fm_high}	; extruder 1 filament monitor

M563 P2 D0:1 H1:2 X0:3 F2:3 S"Duplicator"							; define tool 2, "duplicator mode"
G10 P2 X0 Y0 U{-move.axes[0].max/2}									; set tool offsets
M568 P2 R0 S0														; set initial tool 1 active and standby temperatures to 0C
M567 P2 E1:1														; set mix ratio 100% on both extruders

M563 P3 D0:1 H1:2 X0:3 F2:3 S"Mirror"								; define tool 2, "duplicator mode"
G10 P3 X0 Y0 U{-move.axes[0].max}									; set tool offsets
M568 P3 R0 S0														; set initial tool 1 active and standby temperatures to 0C
M567 P3 E1:1														; set mix ratio 100% on both extruders

; Accelerometers
M955 P20.0 I56														; left toolhead accelerometer
M955 P21.0 I56														; righ toolhead accelerometer

; Temperature Monitoring
M308 S10 Y"mcu-temp" A"Primary 6XD MCU"								; defines sensor 10 as MCU temperature sensor
M308 S11 Y"mcu-temp" P"1.dummy" A"Secondary 6XD MCU"				; defines sensor 11 as MCU temperature sensor
M308 S12 Y"mcu-temp" P"20.dummy" A"Left Toolhead MCU"				; defines sensor 12 as MCU temperature sensor
M308 S13 Y"drivers" P"20.dummy" A"Left Toolhead Driver"				; defines sensor 13 as stepper driver temperature sensor
M308 S14 Y"mcu-temp" P"21.dummy" A"Right Toolhead MCU"				; defines sensor 14 as MCU temperature sensor
M308 S15 Y"drivers" P"21.dummy" A"Right Toolhead Driver"			; defines sensor 15 as stepper driver temperature sensor

; Miscellaneous
M501																; load saved parameters from non-volatile memory
M911 S25.0 R26.0 P"G91 M83 G1 Z3 E-5 F450"							; set voltage thresholds and actions to run on power loss
M950 P0 C"0.out4" Q0												; (BOFA)
M42 P0 S1.0															; (BOFA)

; Input Shaper
M593 P"zvd" F40.0 S0.10

; Execute post parameter macros
M98 P{directories.system^"/Printer Parameters/machine_params.g"}
