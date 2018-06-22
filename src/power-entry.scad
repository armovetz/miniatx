include <include.scad>
include <c14.scad>

module power_inlet() {
    
    L_frame = 5.0;
    W_frame = 3.05;
    H_frame = 0.25;
    
    // front block sizes
    L1 = 3.04;
    W1 = 2.85;
    H1 = 4.75;
    
    // second back block sizes
    L2 = 1.0;
    W2 = 2.85;
    H2 = 3.2;
    
    BUTTON_HOLE_H = L_frame / 4;
    BUTTON_HOLE_W = W_frame - 0.4;
    BUTTON_HOLE_DEPTH = 0.5;
    
    difference() {
    union() {
    union() {
        // face frame sizes
        
        
        
    
        // frame
        radius = 0.15;
        translate ([H_frame + L1 + L2, -(W_frame - W1)/2, -(L_frame - H1)/2]) {
        rotate([0,-90,0]) {
            rounded_cuboid([L_frame, W_frame, H_frame], radius);
        }
        }
    
        
        
        // front block
        translate ([L2, 0.0, 0.0] ) { cube([L1, W1, H1]); }
    }
    
        // second back block
        cube([L2, W2, H2]);
    }
    
        
        
        translate([L1 + L2 - BUTTON_HOLE_DEPTH + H_frame, -(BUTTON_HOLE_W - W_frame) / 3, L_frame * (4/6)]) {
            cube([BUTTON_HOLE_DEPTH , BUTTON_HOLE_W, BUTTON_HOLE_H]);
        }
        
        translate([L1 + L2 - 1.50, (W_frame - W1) / 2, 0.2]) {
        rotate([90, 0, 90]) {
            c14_inlet();
        }}
    }
    
    BUTTON_L = BUTTON_HOLE_W - 0.5;
    BUTTON_H = BUTTON_HOLE_H - 0.3;
    BUTTON_W = 0.5;
    
    translate([L1 + L2, -(BUTTON_HOLE_W - W_frame) , L_frame * (4/6) + 0.1]) {
        rotate([0, 0, 90]) {
            cube([BUTTON_L, BUTTON_W, BUTTON_H]);
            translate([0, -0.3, 0]) {
            rotate([0, 0, 15]) {
                cube([BUTTON_L, BUTTON_W, BUTTON_H]);
            }}
        }

    }
    

    
}


power_inlet();
