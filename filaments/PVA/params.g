; L: Load or unload

var filamentList =           {"Essentium Support S10", "Polymaker PolyDissolve S1", "Generic PVA"}
var activeTemperatureList =  {215,                     220,                         210}
var standbyTemperatureList = {100,                     100,                         100}
var bedTemperatureList =     {-1,                      -1,                          -1}
var retractionList =         {2,                       2,                           2}

if exists(param.L)
    if param.L = 1
        M291 P"Choose a filament" R"Choose a filament" S4 K{var.filamentList}

        M98 P{directories.system^"/System Macros/Filament Change/load_to_nozzle.g"} F{var.filamentList[input]} S{var.activeTemperatureList[input]} R{var.standbyTemperatureList[input]} B{var.bedTemperatureList[input]}
    else
        var filamentIndex = 0

        while iterations < #var.filamentList
            if var.filamentList[iterations] == global.filament[state.currentTool]
                set var.filamentIndex = iterations
                break

        M98 P{directories.system^"/System Macros/Filament Change/unload_from_nozzle.g"} F{var.filamentList[var.filamentIndex]} S{var.activeTemperatureList[var.filamentIndex]}

if exists(param.S)
    var filamentIndex = 0

    while iterations < #var.filamentList
        if var.filamentList[iterations] == global.filament[state.currentTool]
            set var.filamentIndex = iterations
            break

    ; Load settings
