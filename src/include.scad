//$fs = 0.05;
$fn = 100;
//$fa = 20;

OVERLAP = 0.1;

module rounded_cuboid(dimensions, CORNER_R) {
    
    MB_L = dimensions[0];
    MB_W = dimensions[1];
    MB_H = dimensions[2];
    
    difference() {
        cube([MB_L, MB_W, MB_H]);
        difference() {
            translate([0,0,0])                              { cube([CORNER_R, CORNER_R, MB_H]);}
            translate([CORNER_R,CORNER_R,0])                { cylinder(h = MB_H, r = CORNER_R, $fs = 0.1);}
        }
        difference() {
            translate([MB_L-CORNER_R,MB_W-CORNER_R,0])      { cube([CORNER_R, CORNER_R, MB_H+1]);}
            translate([MB_L - CORNER_R,MB_W - CORNER_R,0])  { cylinder(h = MB_H, r = CORNER_R, $fs = 0.1);}
        }
        difference() {
            translate([0,MB_W-CORNER_R,0])                  { cube([CORNER_R, CORNER_R, MB_H+1]);}
            translate([CORNER_R,MB_W - CORNER_R,0])         { cylinder(h = MB_H, r = CORNER_R, $fs = 0.1);}
        }
        difference() {
            translate([MB_L-CORNER_R,0,0])                  { cube([CORNER_R, CORNER_R, MB_H+1]);}
            translate([MB_L - CORNER_R,CORNER_R,0])         { cylinder(h = MB_H, r = CORNER_R, $fs = 0.1);}
        }
    }
}
