


module rounded_cuboid(dimensions, CORNER_R) {
    
    MB_L = dimensions[0];
    MB_W = dimensions[1];
    MB_H = dimensions[2];
    
    difference() {
        
        // main cube body
        cube([MB_L, MB_W, MB_H]);
        
        // for each corner - remove triangled piece
        for (coord_pair = [
                        [[0, 0, 0],                             [CORNER_R,CORNER_R,0]],
                        [[MB_L - CORNER_R, MB_W - CORNER_R, 0], [MB_L - CORNER_R, MB_W - CORNER_R, 0]],
                        [[0, MB_W - CORNER_R, 0],               [CORNER_R, MB_W - CORNER_R ,0]],
                        [[MB_L - CORNER_R, 0, 0],               [MB_L - CORNER_R, CORNER_R, 0]]
            ]) {
            // triangled piece - is difference between cube and cylinder
            difference() {
                translate(coord_pair[0]) {
                    cube([CORNER_R, CORNER_R, MB_H]);
                }
                translate(coord_pair[1]) {
                    cylinder(h = MB_H, r = CORNER_R, $fn=50);
                }
            }
        }
    }
}

module rounded_corner_flat(r, fn) {
    /*** 
        triangle corner size r x r, rounded by circle with radius = r
    ***/
    difference() {
        square(r);
        translate([r, r, 0]) { circle(r, $fn = fn);}
    }
}
    
    
    
    
    









