; Macro to load the appropriate heightmap at the beginning of a print
var heightmap_name = floor(heat.heaters[0].active/10)*10 ^ " degrees.csv"

G29 S1 P{var.heightmap_name}
