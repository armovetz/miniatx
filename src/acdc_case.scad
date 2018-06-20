use <acdc.scad>;
use <include.scad>;


// these are taken from acdc.scad
MB_L = 10.64;
MB_W = 5.70;
MB_H = 0.1;

SCREW_DISTANCE_X = 9.82;
SCREW_DISTANCE_Y = 4.71;
//

ACDC_H = 3.5;

CASE_THICKNESS = 0.4;
CASE_GAP = 0.1;
CASE_OUTER_L = MB_L   + CASE_GAP + CASE_THICKNESS;
CASE_OUTER_W = MB_W   + CASE_GAP + CASE_THICKNESS;
CASE_OUTER_H = ACDC_H + CASE_GAP + CASE_THICKNESS;

CASE_INNER_L = MB_L   + CASE_GAP;
CASE_INNER_W = MB_W   + CASE_GAP;
CASE_INNER_H = ACDC_H + CASE_GAP;

ACDC_SHIFT_X = (CASE_OUTER_L - MB_L) / 2;
ACDC_SHIFT_Y = (CASE_OUTER_W - MB_W) / 2;

CORNER_R = 0.1;


module body() {
    difference() {
        rounded_cuboid([CASE_OUTER_L, CASE_OUTER_W, CASE_OUTER_H], CORNER_R);
        translate([(CASE_OUTER_L - CASE_INNER_L) / 2, (CASE_OUTER_W - CASE_INNER_W) / 2, 0]) {
            rounded_cuboid([CASE_INNER_L, CASE_INNER_W, CASE_INNER_H], CORNER_R);
        }
    }
}

//body();

module leg() {
    LEG_L = CASE_INNER_H - CASE_GAP;
    LEG_R = 0.3;
    BOT_FOOT_R = 0.4;
    BOT_FOOT_H = 0.4;
    TOP_FOOT_R = 0.4;
    TOP_FOOT_H = 0.4;
    
    BOT_FOOT_RD = BOT_FOOT_R - LEG_R;
    TOP_FOOT_RD = TOP_FOOT_R - LEG_R;
    
    rotate_extrude(angle = 360, convexity = 10, $fn=20) {
        square([LEG_R, LEG_L]);
        
        //translate([LEG_R, 0]) {
        //    intersection() {
        //        difference() {
        //            square([2 * BOT_FOOT_RD, 2 * BOT_FOOT_H]);
        //            translate([BOT_FOOT_RD, BOT_FOOT_H]) {
        //                scale([BOT_FOOT_RD, BOT_FOOT_H]) circle(1.0, $fn = 30);
        //            }
        //        }
        //        
        //        square([BOT_FOOT_RD, BOT_FOOT_H]);
        //    }
        //}
    
        
        translate([LEG_R, LEG_L - 2 * TOP_FOOT_H]) {
            intersection() {
                difference() {
                    square([2 * TOP_FOOT_RD, 2 * TOP_FOOT_H]);
                    translate([TOP_FOOT_RD, TOP_FOOT_H]) {
                        scale([TOP_FOOT_RD, TOP_FOOT_H]) circle(1.0, $fn = 30);
                    }
                }
                
                translate([0, TOP_FOOT_H]) {
                    square([TOP_FOOT_RD, TOP_FOOT_H]);
                }
            }
        }
    
    }
}


module cell() {
    
    difference() {
        body();
        
        // side fan holes
        
        SIDE_ROWS_NUMB = 4;
        SIDE_COLS_NUMB = 5;
        SIDE_HOLE_L = 0.3;
        SIDE_HOLE_H = SIDE_HOLE_L;
        for (i = [0 : 1: SIDE_ROWS_NUMB - 1]) {
        for (j = [1 : 1: SIDE_COLS_NUMB - 2]) {
            
            z = ((i + 1)/ (SIDE_ROWS_NUMB + 1) ) * CASE_OUTER_H;
            y = ((j + 1)/ (SIDE_COLS_NUMB + 1) ) * CASE_OUTER_W;
            translate([0, y, z]) {
                //cube([CASE_OUTER_L, SIDE_HOLE_L, SIDE_HOLE_H]);
                rotate([0, 90,0]) {
                    cylinder(h = CASE_OUTER_L, r = SIDE_HOLE_L, $fn = 20);
                }
            }
        }
        }
        
        // front fan holes
        FRONT_ROWS_NUMB = 4;
        FRONT_COLS_NUMB = 8;
        FRONT_HOLE_L = 0.3;
        FRONT_HOLE_H = FRONT_HOLE_L;
        for (i = [0 : 1: FRONT_ROWS_NUMB - 1]) {
        for (j = [1 : 1: FRONT_COLS_NUMB - 2]) {
            
            z = ((i + 1)/ (FRONT_ROWS_NUMB + 1) ) * CASE_OUTER_H;
            x = ((j + 1)/ (FRONT_COLS_NUMB + 1) ) * CASE_OUTER_L;
            translate([x, 0, z]) {
                //cube([FRONT_HOLE_L, CASE_OUTER_W, FRONT_HOLE_H]);
                rotate([-90, 0, 0]) {
                    cylinder(h = CASE_OUTER_L, r = FRONT_HOLE_L, $fn = 20);
                }
            }
        }
        }
    }
    
    
    
}

//leg();

module acdc_case() {
    
    // legs
    
    SCREW_SHIFT_X = (MB_L - SCREW_DISTANCE_X) / 2;
    SCREW_SHIFT_Y = (MB_W - SCREW_DISTANCE_Y) / 2;
    
    SCREW_HOLE_1_X = ACDC_SHIFT_X + SCREW_SHIFT_X;
    SCREW_HOLE_2_X = ACDC_SHIFT_X + MB_L - SCREW_SHIFT_X;
    SCREW_HOLE_3_X = ACDC_SHIFT_X + MB_L - SCREW_SHIFT_X;
    SCREW_HOLE_4_X = ACDC_SHIFT_X + SCREW_SHIFT_X;
    
    SCREW_HOLE_1_Y = ACDC_SHIFT_Y + SCREW_SHIFT_Y;
    SCREW_HOLE_2_Y = ACDC_SHIFT_Y + SCREW_SHIFT_Y;
    SCREW_HOLE_3_Y = ACDC_SHIFT_Y + MB_W - SCREW_SHIFT_Y;
    SCREW_HOLE_4_Y = ACDC_SHIFT_Y + MB_W - SCREW_SHIFT_Y;

    LEG_1_X = 0;
    LEG_2_X = MB_L;
    LEG_3_X = MB_L;
    LEG_4_X = 0;
              
    LEG_1_Y = 0;
    LEG_2_Y = 0;
    LEG_3_Y = MB_W;
    LEG_4_Y = MB_W;
    
    // drill screwholes for the legs
    difference() {
        union() {
            cell();
            LEG_H = CASE_INNER_H - CASE_GAP;
            LEG_L = (SCREW_SHIFT_X + CASE_GAP)*2;
            LEG_W = (SCREW_SHIFT_Y + CASE_GAP)*2;
            translate([SCREW_HOLE_1_X, SCREW_HOLE_1_Y, CASE_GAP + MB_H]) { translate([-LEG_L/2, -LEG_W/2, 0]) {rounded_cuboid([LEG_L, LEG_W, LEG_H], CORNER_R);}}
            translate([SCREW_HOLE_2_X, SCREW_HOLE_2_Y, CASE_GAP + MB_H]) { translate([-LEG_L/2, -LEG_W/2, 0]) {rounded_cuboid([LEG_L, LEG_W, LEG_H], CORNER_R);}}
            translate([SCREW_HOLE_3_X, SCREW_HOLE_3_Y, CASE_GAP + MB_H]) { translate([-LEG_L/2, -LEG_W/2, 0]) {rounded_cuboid([LEG_L, LEG_W, LEG_H], CORNER_R);}}
            translate([SCREW_HOLE_4_X, SCREW_HOLE_4_Y, CASE_GAP + MB_H]) { translate([-LEG_L/2, -LEG_W/2, 0]) {rounded_cuboid([LEG_L, LEG_W, LEG_H], CORNER_R);}}
            
            //translate([LEG_1_X, LEG_1_Y, CASE_GAP + MB_H]) { leg();}
            //translate([LEG_2_X, LEG_2_Y, CASE_GAP + MB_H]) { leg();}
            //translate([LEG_3_X, LEG_3_Y, CASE_GAP + MB_H]) { leg();}
            //translate([LEG_4_X, LEG_4_Y, CASE_GAP + MB_H]) { leg();}
        }
        
        SCREW_R = 0.2;
        
        translate([SCREW_HOLE_1_X, SCREW_HOLE_1_Y, CASE_GAP + MB_H]) { cylinder(r = SCREW_R, h = CASE_OUTER_H, $fn = 20);}
        translate([SCREW_HOLE_2_X, SCREW_HOLE_2_Y, CASE_GAP + MB_H]) { cylinder(r = SCREW_R, h = CASE_OUTER_H, $fn = 20);}
        translate([SCREW_HOLE_3_X, SCREW_HOLE_3_Y, CASE_GAP + MB_H]) { cylinder(r = SCREW_R, h = CASE_OUTER_H, $fn = 20);}
        translate([SCREW_HOLE_4_X, SCREW_HOLE_4_Y, CASE_GAP + MB_H]) { cylinder(r = SCREW_R, h = CASE_OUTER_H, $fn = 20);}

    }
}

translate([ACDC_SHIFT_X, ACDC_SHIFT_Y, -2]) {
#    acdc();
}


rotate([0, 0, 0]) {
    acdc_case();
}