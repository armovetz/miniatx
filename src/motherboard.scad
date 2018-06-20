use <include.scad>

// board dimensions
MB_L = 17;
MB_W = 17;
MB_H = 0.1;

module motherboard_base() {

    
    
    CORNER_R = 0.5;     // rounded corners radius
    
    // screw holes
    SCREW_SHIFT = 0.5;
    SCREW_HOLE_R = 0.2; // radius of screw holes - centered on rounded corners centers
    
    difference() {
        rounded_cuboid([MB_L, MB_W, MB_H], CORNER_R);
        translate([SCREW_SHIFT, SCREW_SHIFT,0])               { cylinder(h = MB_H, r = SCREW_HOLE_R, $fn = 20); }
        translate([MB_L - SCREW_SHIFT - 2.0, SCREW_SHIFT,0])  { cylinder(h = MB_H, r = SCREW_HOLE_R, $fn = 20); }
        translate([MB_L - SCREW_SHIFT, MB_W - SCREW_SHIFT,0]) { cylinder(h = MB_H, r = SCREW_HOLE_R, $fn = 20); }
        translate([SCREW_SHIFT, MB_W - SCREW_SHIFT,0])        { cylinder(h = MB_H, r = SCREW_HOLE_R, $fn = 20); }
    }
    
}

module radiator() {
    
    // base
    RAD_BASE_L = 4.0;
    RAD_BASE_W = 4.0;
    RAD_BASE_H = 0.4;
    R_CORNER   = 0.1;
    
    rounded_cuboid([RAD_BASE_L, RAD_BASE_W, RAD_BASE_H], R_CORNER);
    
    RAD_ELEM_L = 1.0;
    RAD_ELEM_W = 0.1;
    RAD_ELEM_H = 3.0;
    
    
    for (x_shift = [0 : 1.5 : 3]) {
    for (y_shift = [0 : 0.3 : 3.8]) {
        translate([x_shift, y_shift, 0]) {cube([RAD_ELEM_L, RAD_ELEM_W, RAD_ELEM_H,]);}
    }
    }
    
}

module pins_24() {
    
    PINS_L = 5.0;
    PINS_W = 1.0;
    PINS_H = 1.5;
    
    PINS_ROWS = 2;
    PINS_COLUMNS = 12;
    PIN_HOLE_SIZE = (PINS_L / PINS_COLUMNS) - 0.1;
    PIN_HOLE_DEPTH = PINS_H - 0.1;
    TINY_WALL = 0.05;
    
    Y_ADJUST = 0.1;
    X_ADJUST = 0.05;
    Z_ADJUST = 0.1;
    
    difference() {
        cube([PINS_L, PINS_W, PINS_H]);
        for (y_i = [0 : 1 : PINS_ROWS - 1]) {
            y = (y_i / PINS_ROWS) * PINS_W;
        for (x_i = [0 : 1 : PINS_COLUMNS - 1]) {
            x = (x_i / PINS_COLUMNS) * PINS_L;
            translate([x + X_ADJUST, y + Y_ADJUST, PINS_H - PIN_HOLE_DEPTH]) {cube([PIN_HOLE_SIZE, PIN_HOLE_SIZE, PIN_HOLE_DEPTH + Z_ADJUST]);}
            
        }
        }
    }
    
}

module pins_4() {
    PINS_L = 1.2;
    PINS_W = 1.2;
    PINS_H = 1.5;
    
    PINS_ROWS = 2;
    PINS_COLUMNS = 2;
    PIN_HOLE_SIZE = (PINS_L / PINS_COLUMNS) - 0.1;
    PIN_HOLE_DEPTH = PINS_H - 0.1;
    TINY_WALL = 0.05;
    
    Y_ADJUST = 0.05;
    X_ADJUST = 0.05;
    Z_ADJUST = 0.1;
    
    difference() {
        cube([PINS_L, PINS_W, PINS_H]);
        for (y_i = [0 : 1 : PINS_ROWS - 1]) {
            y = (y_i / PINS_ROWS) * PINS_W;
        for (x_i = [0 : 1 : PINS_COLUMNS - 1]) {
            x = (x_i / PINS_COLUMNS) * PINS_L;
            translate([x + X_ADJUST, y + Y_ADJUST, PINS_H - PIN_HOLE_DEPTH]) {cube([PIN_HOLE_SIZE, PIN_HOLE_SIZE, PIN_HOLE_DEPTH + Z_ADJUST]);}
            
        }
        }
    }
    
}

module conds() {
    
    COND_R = 0.2;
    COND_H = 0.8;
    
    X_Y_COORDS = [
        [2, 1],
        [2, 1.5],
        [0.5, 3],
        [1.0, 3],
        [1.5, 3],
        [10.0, 5],
        [10.0, 5.5],
        [10.0, 6],
        [10.0, 6.5],
    ];
    
    for (coord = X_Y_COORDS) {
        translate([coord[0], coord[1], 0]) { cylinder(r = COND_R, h = COND_H, $fn=30);}
    }
}


module ps2_slots() {
    L = 2.0;
    W = 1.0;
    H = 3.0;
    
    SLOT_OUTER_R = 0.4;
    SLOT_INNER_R = 0.35;
    SLOT_DEPTH  = L / 2;
    
    difference() {
        
        cube([L, W, H]);
        
        for (z = [H * (1/4), H * (3/4)]) {
            translate([0, W / 2, z]) {
            rotate([0, 90, 0]) {
            difference() {
                cylinder(r = SLOT_OUTER_R, h = SLOT_DEPTH, $fn = 20);
                cylinder(r = SLOT_INNER_R, h = SLOT_DEPTH, $fn = 20);
            }
            }}
        }
    }
}

module audio_slots() {
    L = 3.0;
    W = 1.0;
    H = 3.0;
    
    SLOT_OUTER_R = 0.3;
    SLOT_INNER_R = 0.175;
    SLOT_DEPTH  = L / 2;
    
    SLOTS_LEDGE = 0.2;
    
    difference() {
        union() {
            cube([L, W, H]);
            for (z = [H * (1/6), H * (3/6), H * (5/6)]) {
                translate([ - SLOTS_LEDGE, W / 2, z]) {
                rotate([0, 90, 0]) {
                    cylinder(r = SLOT_OUTER_R, h = SLOT_DEPTH, $fn = 20);
                }}
            }
        }
    
    for (z = [H * (1/6), H * (3/6), H * (5/6)]) {
        translate([ - SLOTS_LEDGE, W / 2, z]) {
        rotate([0, 90, 0]) {
        difference() {
            cylinder(r = SLOT_INNER_R, h = SLOT_DEPTH, $fn = 20);
        }
        }}
    }
    }
    
}

module usb_slots() {
    L = 3.0;
    W = 2.0;
    H = 2.5;
    
    USB_SLOT_H = 0.3;
    USB_SLOT_W = 1.5;
    USB_SLOT_DEPTH = 1.0;
    
    difference() {
        cube([L, W, H]);
        for (z = [H * (1/6), H * (3/6), H * (5/6)]) {
            translate([0, (W - USB_SLOT_W) / 2, z]) {
                cube([USB_SLOT_DEPTH, USB_SLOT_W, USB_SLOT_H]);
            }
        }
    }
}



module mb() {
    translate([1, 14, 0]) { 
        pins_24(); 
    }
    translate([13, 3, 0]) { 
        pins_4();
    }
    conds();
    motherboard_base();
    
    translate([MB_L / 2, MB_W / 2,MB_H]) {
    rotate([0, 0, 45]) {
        radiator();
    }}
    
    translate([MB_L, MB_W - 2, 0]) {
    rotate([0, 0, 180]) {
        audio_slots();
    }}
    
    translate([MB_L, MB_W - 3.5, 0]) {
    rotate([0, 0, 180]) {
        usb_slots();
    }}
    
    translate([MB_L, 1.5, 0]) {
    rotate([0, 0, 180]) {
        ps2_slots();
    }}

}


mb();

