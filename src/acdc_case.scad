use <acdc.scad>;
use <include.scad>;




/*
    PARAMS to validate by calipers or from other sources (for example screw radius
*/

// these are taken from acdc.scad and from official specs
ACDC_L = 106.4;
ACDC_W = 57.0;
SCREW_DISTANCE_X = 98.2;
SCREW_DISTANCE_Y = 47.1;

// total height of acdc case
ACDC_H_screw_flow = 2.0; // we can play with this depending on screws length
ACDC_H = 33.0 + ACDC_H_screw_flow;

ACDC_BOARD_H = 1.5; // between 1.5 and 2.0 mms - thickness of acdc bottom board
SOLDER_GAP = 2.0;


SCREW_R = 2.0;
SCREW_HEAD_R = 3.5;
SCREW_HEAD_H = 2.0;

/* --- end of params to validate --- */



CASE_THICKNESS = 2.0; // thickness of case wall 
CASE_GAP = 1.5;
CASE_OUTER_L = ACDC_L   + (CASE_THICKNESS + CASE_GAP) * 2;
CASE_OUTER_W = ACDC_W   + (CASE_THICKNESS + CASE_GAP) * 2;
CASE_OUTER_H = ACDC_H;

CASE_INNER_L = CASE_OUTER_L - CASE_THICKNESS * 2;
CASE_INNER_W = CASE_OUTER_W - CASE_THICKNESS * 2;
CASE_INNER_H = CASE_OUTER_H - CASE_THICKNESS;

ACDC_SHIFT_X = (CASE_OUTER_L - ACDC_L) / 2;
ACDC_SHIFT_Y = (CASE_OUTER_W - ACDC_W) / 2;

CORNER_R = 3.0;


module body() {
    difference() {
        rounded_cuboid([CASE_OUTER_L, CASE_OUTER_W, CASE_OUTER_H], CORNER_R);
        translate([(CASE_OUTER_L - CASE_INNER_L) / 2, (CASE_OUTER_W - CASE_INNER_W) / 2, 0]) {
            rounded_cuboid([CASE_INNER_L, CASE_INNER_W, CASE_INNER_H], CORNER_R);
        }
    }
}


module leg_profile() {
    SCREW_SHIFT_X = (ACDC_L - SCREW_DISTANCE_X) / 2;
    SCREW_SHIFT_Y = (ACDC_W - SCREW_DISTANCE_Y) / 2;
    
    MERGING_R = 1.0;
    
    LEG_R = SCREW_R + 2.0;
    
    difference() {
        square([CASE_GAP + SCREW_SHIFT_X + LEG_R, CASE_GAP + SCREW_SHIFT_Y + LEG_R]);
        translate([CASE_GAP + SCREW_SHIFT_X + LEG_R, CASE_GAP + SCREW_SHIFT_Y + LEG_R, 0]) {
            rotate([0, 0, 180]) { rounded_corner_flat(LEG_R, 30);} 
        }
    }
    
    translate([CASE_GAP + SCREW_SHIFT_X + LEG_R, 0, 0]) { rounded_corner_flat(MERGING_R, 30);}
    translate([0, CASE_GAP + SCREW_SHIFT_Y + LEG_R, 0]) { rounded_corner_flat(MERGING_R, 30);}
    
}

module leg(leg_h) {
    linear_extrude(height = leg_h, convexity = 10, slices = 20, scale = 1.0)  {
        leg_profile();
    }
}

module drill_vent_side() {
    
    // side fan holes
    
    HOLE_SHIFT_Y = 12.0;
    HOLE_SHIFT_X = 12.0;
    HOLE_SHIFT_Z = 5.0;
    
    SIDE_HOLE_L = 10.0;
    SIDE_HOLE_H = 30.0;
    SIDE_HOLE_R = 1.0;
    
    SIDE_ROWS_NUMB = 1;
    SIDE_COLS_NUMB = 3;

    side_y_start = HOLE_SHIFT_Y;
    side_y_end   = CASE_OUTER_W - HOLE_SHIFT_Y;
    side_d_y = (side_y_end - side_y_start) / SIDE_COLS_NUMB;
    side_z_start = HOLE_SHIFT_Z;
    side_z_end   = CASE_OUTER_H - HOLE_SHIFT_Z;
    side_d_z = (side_z_end - side_z_start) / SIDE_ROWS_NUMB;
    
    for (column = [0 : 1 : SIDE_COLS_NUMB - 1]) {
    for (row    = [0 : 1 : SIDE_ROWS_NUMB - 1]) {
        y = side_y_start + column*side_d_y + side_d_y/2;
        z = side_z_start + row*side_d_z + side_d_z/2;
        
        translate([0, y, z]) {
            rotate([0, 90, 0]) {
                translate([-SIDE_HOLE_H /2 , -SIDE_HOLE_L / 2, -1]) {
                    rounded_cuboid([SIDE_HOLE_H, SIDE_HOLE_L, CASE_OUTER_L + 2], SIDE_HOLE_R);
                }
            }
        }
    }
    }
}
    
module drill_vent_front() {
    
    HOLE_SHIFT_Y = 12.0;
    HOLE_SHIFT_X = 12.0;
    HOLE_SHIFT_Z = 5.0;
    
    FRONT_HOLE_L = 10.0;
    FRONT_HOLE_H = 30.0;
    FRONT_HOLE_R = 1.0;
    
    FRONT_ROWS_NUMB = 1;
    FRONT_COLS_NUMB = 7;

    front_x_start = HOLE_SHIFT_X;
    front_x_end   = CASE_OUTER_L - HOLE_SHIFT_X;
    front_d_x = (front_x_end - front_x_start) / FRONT_COLS_NUMB;
    front_z_start = HOLE_SHIFT_Z;
    front_z_end   = CASE_OUTER_H - HOLE_SHIFT_Z;
    front_d_z = (front_z_end - front_z_start) / FRONT_ROWS_NUMB;
    
    for (column = [0 : 1 : FRONT_COLS_NUMB - 1]) {
    for (row    = [0 : 1 : FRONT_ROWS_NUMB - 1]) {
        x = front_x_start + column*front_d_x + front_d_x/2;
        z = front_z_start + row*front_d_z + front_d_z/2;
        
        translate([x, 0, z]) {
            rotate([-90, 0, 0]) {
                translate([-FRONT_HOLE_L /2 , -FRONT_HOLE_H / 2, -1]) {
                    rounded_cuboid([FRONT_HOLE_L, FRONT_HOLE_H, CASE_OUTER_W + 2], FRONT_HOLE_R);
                }
            }
        }
    }
    }
    
}

module drill_vent_top() {
    
    HOLE_SHIFT_Y = 10.0;
    HOLE_SHIFT_X = 10.0;
    
    TOP_HOLE_L = 21.0;
    TOP_HOLE_H = 13.0;
    TOP_HOLE_R = 1.0;
    
    TOP_ROWS_NUMB = 3;
    TOP_COLS_NUMB = 4;

    top_x_start = HOLE_SHIFT_X;
    top_x_end   = CASE_OUTER_L - HOLE_SHIFT_X;
    top_d_x = (top_x_end - top_x_start) / TOP_COLS_NUMB;
    top_y_start = HOLE_SHIFT_Y;
    top_y_end   = CASE_OUTER_W - HOLE_SHIFT_Y;
    top_d_y = (top_y_end - top_y_start) / TOP_ROWS_NUMB;
    
    for (column = [0 : 1 : TOP_COLS_NUMB - 1]) {
    for (row    = [0 : 1 : TOP_ROWS_NUMB - 1]) {
        x = top_x_start + column*top_d_x    + top_d_x/2 - TOP_HOLE_L/2;
        y = top_y_start + row*top_d_y       + top_d_y/2 - TOP_HOLE_H/2;

        translate([x, y, CASE_INNER_H]) {
            rounded_cuboid([TOP_HOLE_L, TOP_HOLE_H, CASE_THICKNESS + 2], TOP_HOLE_R);
        }
    }
    }
    

    
}

module acdc_case() {
    
    // legs
    
    SCREW_SHIFT_X = (ACDC_L - SCREW_DISTANCE_X) / 2;
    SCREW_SHIFT_Y = (ACDC_W - SCREW_DISTANCE_Y) / 2;
    
    SCREW_HOLE_1_X = ACDC_SHIFT_X + SCREW_SHIFT_X;
    SCREW_HOLE_2_X = ACDC_SHIFT_X + ACDC_L - SCREW_SHIFT_X;
    SCREW_HOLE_3_X = ACDC_SHIFT_X + ACDC_L - SCREW_SHIFT_X;
    SCREW_HOLE_4_X = ACDC_SHIFT_X + SCREW_SHIFT_X;
    
    SCREW_HOLE_1_Y = ACDC_SHIFT_Y + SCREW_SHIFT_Y;
    SCREW_HOLE_2_Y = ACDC_SHIFT_Y + SCREW_SHIFT_Y;
    SCREW_HOLE_3_Y = ACDC_SHIFT_Y + ACDC_W - SCREW_SHIFT_Y;
    SCREW_HOLE_4_Y = ACDC_SHIFT_Y + ACDC_W - SCREW_SHIFT_Y;

    LEG_1_X = CASE_THICKNESS + 0;
    LEG_2_X = CASE_THICKNESS + 2* CASE_GAP + ACDC_L;
    LEG_3_X = CASE_THICKNESS + 2* CASE_GAP + ACDC_L;
    LEG_4_X = CASE_THICKNESS + 0;
              
    LEG_1_Y = CASE_THICKNESS + 0;
    LEG_2_Y = CASE_THICKNESS + 0;
    LEG_3_Y = CASE_THICKNESS + 2 * CASE_GAP + ACDC_W;
    LEG_4_Y = CASE_THICKNESS + 2 * CASE_GAP + ACDC_W;
    
    LEG_Z = ACDC_BOARD_H + SOLDER_GAP;
    
    // drill screwholes for the legs
    difference() {
        union() {
            difference() {
                body();
                drill_vent_front();
                drill_vent_side();
                drill_vent_top();
            }
            LEG_H = CASE_INNER_H - LEG_Z;
            LEG_L = (SCREW_SHIFT_X + CASE_GAP)*2;
            LEG_W = (SCREW_SHIFT_Y + CASE_GAP)*2;

            translate([LEG_1_X, LEG_1_Y, LEG_Z]) { rotate([0,0,0])   {leg(LEG_H); } }
            translate([LEG_2_X, LEG_2_Y, LEG_Z]) { mirror([1,0,0])   {leg(LEG_H); } }
            translate([LEG_3_X, LEG_3_Y, LEG_Z]) { rotate([0,0,180]) {leg(LEG_H); } }
            //translate([LEG_4_X, LEG_4_Y, LEG_Z]) { mirror([0,1,0])   {leg(LEG_H); } }
        }
        
        // screw holes themselves
        translate([SCREW_HOLE_1_X, SCREW_HOLE_1_Y, CASE_GAP]) { cylinder(r = SCREW_R, h = CASE_OUTER_H, $fn = 20);}
        translate([SCREW_HOLE_2_X, SCREW_HOLE_2_Y, CASE_GAP]) { cylinder(r = SCREW_R, h = CASE_OUTER_H, $fn = 20);}
        translate([SCREW_HOLE_3_X, SCREW_HOLE_3_Y, CASE_GAP]) { cylinder(r = SCREW_R, h = CASE_OUTER_H, $fn = 20);}
        //translate([SCREW_HOLE_4_X, SCREW_HOLE_4_Y, CASE_GAP]) { cylinder(r = SCREW_R, h = CASE_OUTER_H, $fn = 20);}

        SCREW_HEAD_Z = CASE_OUTER_H - SCREW_HEAD_H;
        translate([SCREW_HOLE_1_X, SCREW_HOLE_1_Y, SCREW_HEAD_Z]) { cylinder(r = SCREW_HEAD_R, h = SCREW_HEAD_H, $fn = 20);}
        translate([SCREW_HOLE_2_X, SCREW_HOLE_2_Y, SCREW_HEAD_Z]) { cylinder(r = SCREW_HEAD_R, h = SCREW_HEAD_H, $fn = 20);}
        translate([SCREW_HOLE_3_X, SCREW_HOLE_3_Y, SCREW_HEAD_Z]) { cylinder(r = SCREW_HEAD_R, h = SCREW_HEAD_H, $fn = 20);}
        //translate([SCREW_HOLE_4_X, SCREW_HOLE_4_Y, SCREW_HEAD_Z]) { cylinder(r = SCREW_HEAD_R, h = SCREW_HEAD_H, $fn = 20);}

    }
}

translate([ACDC_SHIFT_X, ACDC_SHIFT_Y, 0]) {
    //acdc();
}


rotate([0, 0, 0]) {
    acdc_case();
}
