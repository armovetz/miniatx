use <include.scad>


FAN_SIZE  = 4.0;
FAN_DEPTH = 1.0;
CORNER_R = 0.1;



module fan40() {



    difference() {
        rounded_cuboid([FAN_SIZE, FAN_SIZE, FAN_DEPTH], CORNER_R);
        
        // screw holes
        MOUNT_HOLE_SPACING = 3.2;
        SCREW_SHIFT = (FAN_SIZE - MOUNT_HOLE_SPACING) / 2;
        SCREW_HOLE_R = 0.2; // radius of screw holes - centered on rounded corners centers
    
        translate([SCREW_SHIFT, SCREW_SHIFT,0])               { cylinder(h = FAN_DEPTH, r = SCREW_HOLE_R, $fn = 20); }
        translate([FAN_SIZE - SCREW_SHIFT, SCREW_SHIFT,0])  { cylinder(h = FAN_DEPTH, r = SCREW_HOLE_R, $fn = 20); }
        translate([FAN_SIZE - SCREW_SHIFT, FAN_SIZE - SCREW_SHIFT,0]) { cylinder(h = FAN_DEPTH, r = SCREW_HOLE_R, $fn = 20); }
        translate([SCREW_SHIFT, FAN_SIZE - SCREW_SHIFT,0])        { cylinder(h = FAN_DEPTH, r = SCREW_HOLE_R, $fn = 20); }
        
        // fan hole
        FAN_HOLE_R = (FAN_SIZE / 2) - 0.1;
        translate([FAN_SIZE / 2, FAN_SIZE / 2, 0]) {
            cylinder(h = FAN_DEPTH, r = FAN_HOLE_R, $fn = 20);
        }
    }
    
    
    //fan center with blades 
    FAN_CENTER_R = 0.75;
    FAN_CENTER_H = FAN_DEPTH - 0.2;
    BLADE_LENGTH = 1.75;
    BLADE_WIDTH = FAN_CENTER_H;
    BLADE_THICKNESS = 0.1;
    BLADES_NUMB = 7;
    
    translate([FAN_SIZE / 2, FAN_SIZE / 2, (FAN_DEPTH - FAN_CENTER_H) / 2]) {
        cylinder(h = FAN_CENTER_H, r = FAN_CENTER_R, $fn = 20);
        for ( angle = [0 : 360/BLADES_NUMB: 360]) {
            rotate([0, 0, angle]) {
                translate([0,  (BLADE_LENGTH / 2), 0.03]) {
                
                // single blade
                rotate([90, 30, 0]) {
                    linear_extrude(height = BLADE_LENGTH, center = true, convexity = 10, twist = 30) {
                        square([BLADE_THICKNESS, BLADE_WIDTH]);
                    }
                }}
            }
        }
    }
}

fan40();

