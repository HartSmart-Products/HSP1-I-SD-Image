; R: Axis with error
if !exists(param.R)
	M99

if state.status == "processing"
	M25
else
	M291 P{"Is the printer clear to home the "^param.R^" axis?"} R"Driver Error!" S3
	
if {param.R} == "X"
	M18 X
	M17 X
	G28 X
if {param.R} == "Y"
	M18 Y
	M17 Y
	G28 Y
if {param.R} == "U"
	M18 U
	M17 U
	G28 U

if state.status == "paused"
	M24