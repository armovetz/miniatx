use <include.scad>

OVERLAP = 0.1;

MB_L = 10.64;
MB_W = 5.70;
MB_H = 0.1;

SCREW_DISTANCE_X = 9.82;
SCREW_DISTANCE_Y = 4.71;

module acdc_base() {
        // board dimensions
        
        
    
        
    
    
    CORNER_R = 0.1;     // rounded corners radius
    
    // screw holes
    SCREW_SHIFT_X = (MB_L - SCREW_DISTANCE_X) / 2;
    SCREW_SHIFT_Y = (MB_W - SCREW_DISTANCE_Y) / 2;
    SCREW_HOLE_R = 0.2; // radius of screw holes - centered on rounded corners centers
    
    difference() {
        rounded_cuboid([MB_L, MB_W, MB_H], CORNER_R);
        translate([SCREW_SHIFT_X, SCREW_SHIFT_Y,0])               { cylinder(h = MB_H + OVERLAP, r = SCREW_HOLE_R, $fn = 10); }
        translate([MB_L - SCREW_SHIFT_X, SCREW_SHIFT_Y,0])        { cylinder(h = MB_H + OVERLAP, r = SCREW_HOLE_R, $fn = 10); }
        translate([MB_L - SCREW_SHIFT_X, MB_W - SCREW_SHIFT_Y,0]) { cylinder(h = MB_H + OVERLAP, r = SCREW_HOLE_R, $fn = 10); }
        translate([SCREW_SHIFT_X, MB_W - SCREW_SHIFT_Y,0])        { cylinder(h = MB_H + OVERLAP, r = SCREW_HOLE_R, $fn = 10); }
    }

}

module radiator_1() {
    
    // base
    RAD_BASE_L = MB_W;
    RAD_BASE_W = 3.0;
    RAD_BASE_H = 0.3;
    
    cube([RAD_BASE_L, RAD_BASE_W, RAD_BASE_H]);
    
    RAD_ELEM_L = 0.1;
    RAD_ELEM_W = RAD_BASE_W;
    RAD_ELEM_H = 2.0;
    RAD_ELEM_NUMB = 7;
    
    for (x_shift = [0 : (RAD_BASE_L-RAD_ELEM_L) / RAD_ELEM_NUMB : RAD_BASE_L]) {
        translate([x_shift, 0, 0]) {cube([RAD_ELEM_L, RAD_ELEM_W, RAD_ELEM_H]);}
    }
    
}

module radiator_2() {
    
    // base
    RAD_BASE_L = MB_W - 2.0;
    RAD_BASE_W = 3.0;
    RAD_BASE_H = 0.2;
    
    RAD_ELEM_L = 0.05;
    RAD_ELEM_W = RAD_BASE_W;
    RAD_ELEM_H = 0.8;
    RAD_ELEM_NUMB = 7;

    
    translate([0, 0, (RAD_ELEM_H - RAD_BASE_H )/ 2]) { cube([RAD_BASE_L, RAD_BASE_W, RAD_BASE_H]); }
    
    for (x_shift = [0 : (RAD_BASE_L-RAD_ELEM_L) / RAD_ELEM_NUMB : RAD_BASE_L]) {
        translate([x_shift, 0, 0]) {cube([RAD_ELEM_L, RAD_ELEM_W, RAD_ELEM_H]);}
    }
    
}

module conds() {
    
    COND_R_1 = 0.4;
    COND_H_1 = 2.5;
    X_Y_COORDS_1 = [
        [1.5, 1.5],
        [1.5, 4],
    ];
    for (coord = X_Y_COORDS_1) {
        translate([coord[0], coord[1], 0]) { cylinder(r = COND_R_1, h = COND_H_1, $fn=30);}
    }
    
    COND_R = 0.8;
    COND_H = 3.0;
    X_Y_COORDS = [
        [8.5, 4.5],
    ];
    for (coord = X_Y_COORDS) {
        translate([coord[0], coord[1], 0]) { cylinder(r = COND_R, h = COND_H, $fn=30);}
    }


}

module transformer() {
    TRANS_L = 2.0;
    TRANS_W = 2.5;
    TRANS_H = 3.0;
    cube([TRANS_L, TRANS_W, TRANS_H]);
}

module power_inlet() {
    
    BODY_L = 1.5;
    BODY_W = 1.0;
    BODY_H = 1.5;
    
    HOLE_R = 0.15;
    HOLE_H = BODY_H * (2/3);
    
    //HOLE_SHIFT_X = ;
    HOLE_SHIFT_Y = 0.3;
    HOLE_SHIFT_Z = BODY_H / 2;
    
    difference() {
        cube([BODY_L, BODY_W, BODY_H]);
        translate([BODY_L * (3/6), HOLE_SHIFT_Y, HOLE_SHIFT_Z]) {
            cylinder(h = HOLE_H, r = HOLE_R, $fn = 10);
        }
        translate([BODY_L * (5/6), HOLE_SHIFT_Y, HOLE_SHIFT_Z]) {
            cylinder(h = HOLE_H, r = HOLE_R, $fn = 10);
        }
    }
    
}

module power_outlet() {
    
    BODY_L = 1.0;
    BODY_W = 1.0;
    BODY_H = 1.2;
    
    HOLE_R = 0.15;
    HOLE_H = BODY_H * (2/3);
    
    //HOLE_SHIFT_X = ;
    //HOLE_SHIFT_Y = 0.3;
    HOLE_SHIFT_Z = BODY_H / 2;
    
    difference() {
        cube([BODY_L, BODY_W, BODY_H]);
        translate([BODY_L * (1/3), BODY_W * (1/4), HOLE_SHIFT_Z]) {
            cylinder(h = HOLE_H, r = HOLE_R, $fn = 10);
        }
        translate([BODY_L * (1/3), BODY_W * (3/4), HOLE_SHIFT_Z]) {
            cylinder(h = HOLE_H, r = HOLE_R, $fn = 10);
        }
        
        translate([0, BODY_W * (1/12), 0]) {
            cube([BODY_L / 2, BODY_W / 3, BODY_H / 2]);
        }
        translate([0, BODY_W * (7/12), 0]) {
            cube([BODY_L / 2, BODY_W / 3, BODY_H / 2]);
        }

    }
    
}


module acdc() {
    
    acdc_base();
    
    translate([2,0,0]) {
    rotate([0, 90 ,0]) { 
    rotate([0, 0, 90]) {
            radiator_1();
    }}}
    
    translate([7,0,0]) {
    rotate([0, 90 ,0]) { 
    rotate([0, 0, 90]) {
            radiator_2();
    }}}

    conds();

    translate([5.0, 2.5, 0]) {
        transformer();
    }
    
    
    translate([8.0, 0.1, 0]) {
        power_inlet();
    }
    
    translate([0.5, (MB_W - 1.0) / 2, 0]) {
        power_outlet();
    }
}


acdc();