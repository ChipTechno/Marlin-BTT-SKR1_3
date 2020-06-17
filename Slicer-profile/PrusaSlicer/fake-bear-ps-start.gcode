M862.3 P "[printer_model]" ; printer model check
M862.1 P[nozzle_diameter] ; nozzle diameter check
M115 U3.8.1 ; tell printer latest fw version
G90 ; use absolute coordinates
M83 ; extruder relative mode

G28 W ; home all without mesh bed level
G1 X0 Y200 Z50 F1000 ; raise z 

; then preheat
M104 S[first_layer_temperature] ; set extruder temp
M140 S[first_layer_bed_temperature] ; set bed temp
M190 S[first_layer_bed_temperature] ; wait for bed temp
M109 S[first_layer_temperature] ; wait for extruder temp

M400 ; wait for complete
M300 S440 P500 ; play sound
M0 S30 Clean nozzle then click to continue ; wait for user to clean nozzle

G28 W ; home all without mesh bed level
G80 ; mesh bed leveling
G1 Y-3.0 F1000.0 ; go outside print area
G92 E0.0
G1 X60.0 E9.0 F1000.0 ; intro line
G1 X100.0 E12.5 F1000.0 ; intro line
G92 E0.0
M221 S{if layer_height<0.075}100{else}95{endif}




; STOP GCODE
G4 ; wait
M221 S100
M104 S0 ; turn off temperature
M140 S0 ; turn off heatbed
M107 ; turn off fan
{if layer_z < max_print_height}G1 Z{z_offset+min(layer_z+30, max_print_height)}{endif} ; Move print head up
G1 X0 Y200 F3000 ; home X axis
M300 S440 P300 ; play sound
M300 S0 P100 ; mute
M300 S440 P300 ; play sound
M84 ; disable motors