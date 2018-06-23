use <include.scad>

OVERLAP = 1;

MB_L = 106.4;
MB_W = 57.0;
MB_H = 1.0;

SCREW_DISTANCE_X = 98.2;
SCREW_DISTANCE_Y = 47.1;

module acdc_base() {
        // board dimensions
        
    
    CORNER_R = 1.0;     // rounded corners radius
    
    // screw holes
    SCREW_SHIFT_X = (MB_L - SCREW_DISTANCE_X) / 2;
    SCREW_SHIFT_Y = (MB_W - SCREW_DISTANCE_Y) / 2;
    SCREW_HOLE_R = 2.0; // radius of screw holes - centered on rounded corners centers
    
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
    RAD_BASE_W = 30.0;
    RAD_BASE_H = 3.0;
    
    cube([RAD_BASE_L, RAD_BASE_W, RAD_BASE_H]);
    
    RAD_ELEM_L = 1.0;
    RAD_ELEM_W = RAD_BASE_W;
    RAD_ELEM_H = 20.0;
    RAD_ELEM_NUMB = 7;
    
    for (x_shift = [0 : (RAD_BASE_L-RAD_ELEM_L) / RAD_ELEM_NUMB : RAD_BASE_L]) {
        translate([x_shift, 0, 0]) {cube([RAD_ELEM_L, RAD_ELEM_W, RAD_ELEM_H]);}
    }
    
}

module radiator_2() {
    
    // base
    RAD_BASE_L = MB_W - 20.0;
    RAD_BASE_W = 30.0;
    RAD_BASE_H = 2.0;
    
    RAD_ELEM_L = 0.5;
    RAD_ELEM_W = RAD_BASE_W;
    RAD_ELEM_H = 8.0;
    RAD_ELEM_NUMB = 7;

    
    translate([0, 0, (RAD_ELEM_H - RAD_BASE_H )/ 2]) { cube([RAD_BASE_L, RAD_BASE_W, RAD_BASE_H]); }
    
    for (x_shift = [0 : (RAD_BASE_L-RAD_ELEM_L) / RAD_ELEM_NUMB : RAD_BASE_L]) {
        translate([x_shift, 0, 0]) {cube([RAD_ELEM_L, RAD_ELEM_W, RAD_ELEM_H]);}
    }
    
}

module conds() {
    
    COND_R_1 = 4.0;
    COND_H_1 = 25.0;
    X_Y_COORDS_1 = [
        [15.0, 15.0],
        [15.0, 4.0],
    ];
    for (coord = X_Y_COORDS_1) {
        translate([coord[0], coord[1], 0]) { cylinder(r = COND_R_1, h = COND_H_1, $fn=30);}
    }
    
    COND_R = 8.0;
    COND_H = 30.0;
    X_Y_COORDS = [
        [85.0, 45.0],
    ];
    for (coord = X_Y_COORDS) {
        translate([coord[0], coord[1], 0]) { cylinder(r = COND_R, h = COND_H, $fn=30);}
    }


}

module transformer() {
    TRANS_L = 20.0;
    TRANS_W = 25.0;
    TRANS_H = 30.0;
    cube([TRANS_L, TRANS_W, TRANS_H]);
}

module inlet_110v() {
    
    BODY_L = 15.0;
    BODY_W = 10.0;
    BODY_H = 15.0;
    
    HOLE_R = 1.5;
    HOLE_H = BODY_H * (2/3);
    
    //HOLE_SHIFT_X = ;
    HOLE_SHIFT_Y = 3.0;
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

module outlet_12v() {
    
    BODY_L = 10.0;
    BODY_W = 10.0;
    BODY_H = 12.0;
    
    HOLE_R = 1.5;
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
    
    translate([20.0,0,0]) {
    rotate([0, 90.0 ,0]) { 
    rotate([0, 0, 90.0]) {
            radiator_1();
    }}}
    
    translate([70.0,0,0]) {
    rotate([0, 90 ,0]) { 
    rotate([0, 0, 90]) {
            radiator_2();
    }}}

    conds();

    translate([50.0, 25.0, 0]) {
        transformer();
    }
    
    
    translate([80.0, 10.0, 0]) {
        inlet_110v();
    }
    
    translate([5.0, (MB_W - 10.0) / 2, 0]) {
        outlet_12v();
    }
}


acdc();