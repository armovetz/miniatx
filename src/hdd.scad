use <include.scad>

module hard_drive() {
    
    L = 14.68; // 5.782 inches
    W = 10.16; // 4.000 inches
    H = 2.61;  // 1.028 inches
    
    MOUNT_HOLE_R = 0.1;//
    MOUNT_HOLE_H = 0.3;//
    
    // side mounting holes coords
    SIDE_HOLE_1_X = 2.84;// 1.12 inches 
    SIDE_HOLE_2_X = SIDE_HOLE_1_X +  4.16;  // + 1.638 inches 
    SIDE_HOLE_3_X = SIDE_HOLE_1_X + 10.16; // + 4.000 inches 
    
    SIDE_HOLE_1_Y = 0;
    SIDE_HOLE_2_Y = W;
    
    SIDE_HOLE_Z = 0.63;// 0.250 inches
    
    // bottom mounting holes coords
    BOTT_HOLE_1_X = 4.12; // 1.625 inches
    BOTT_HOLE_2_X = BOTT_HOLE_1_X + 4.44; // + 1.750 inches
    
    DY = 9.52; // 3.750 - distance between bottom holes by Y / width
    BOTT_HOLE_1_Y = (W - DY) / 2;
    BOTT_HOLE_2_Y = DY + (W - DY) / 2;
    
    difference() {
        // body
        rounded_cuboid([L, W, H], 0.2); 
        
        // side holes
        for (x_i = [SIDE_HOLE_1_X, SIDE_HOLE_2_X, SIDE_HOLE_3_X]) {
        for (y_i = [SIDE_HOLE_1_Y, SIDE_HOLE_2_Y]) {
            translate([x_i, y_i, SIDE_HOLE_Z]) {
            rotate([90, 0, 0]) {
                cylinder(h = MOUNT_HOLE_H, r = MOUNT_HOLE_R, $fn = 10);
            }}
        }}
        
        // bottom holes
        for (x_i = [BOTT_HOLE_1_X, BOTT_HOLE_2_X]) {
        for (y_i = [BOTT_HOLE_1_Y, BOTT_HOLE_2_Y]) {
            translate([x_i, y_i, 0]) {
                cylinder(h = MOUNT_HOLE_H, r = MOUNT_HOLE_R, $fn = 10);
            }
        }}
        
        // hole for sata and power slots
        translate([0, 1.0, 0]) {
            cube([1.5, 5.0, 0.5]);
        }

    }
    
    // sata pins
    translate([0, 1.5, 0.2]) {
        cube([1.5, 2.5, 0.1]);
    }
    
    translate([0, 4.5, 0.2]) {
        cube([1.5, 1.0, 0.1]);
    }


}

hard_drive();