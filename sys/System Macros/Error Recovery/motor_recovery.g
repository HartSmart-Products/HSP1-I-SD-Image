; R: Axis with error
if !exists(A)
	M99

if state.status == "processing"
	M25
else
	M291 P{"Is the printer clear to home the "^param.A^" axis?"} R"Driver Error!" S3
	
if {param.A} == "X"
	M18 X
	M17 X
	G28 X
if {param.A} == "Y"
	M18 Y
	M17 Y
	G28 Y
if {param.A} == "U"
	M18 U
	M17 U
	G28 U

if state.status == "paused"
	M24