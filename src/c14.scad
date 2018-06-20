

//polygon(points=[[0,0],[100,0],[0,100],[10,10],[80,10],[10,80]], paths=[[0,1,2],[3,4,5]],convexity=10);

SLOT_L  = 2.4;
SLOT_H  = 1.6;
CORNER  = 0.6;
PIN_X   = 0.5;
PIN_Y   = 0.4;
PIN_Y_2 = 0.9;

POINTS = [
    [0,0],
    [SLOT_L, 0],
    [SLOT_L, SLOT_H - CORNER],
    [SLOT_L - CORNER, SLOT_H],
    [CORNER, SLOT_H],
    [0.0, SLOT_H - CORNER]
];


module c14_profile() {
    difference() {
        polygon(points = POINTS); //, paths = POINTS, convexity = 10);
        
        PIN_H = 0.4;
        PIN_W = 0.2;
        
        translate([PIN_X, PIN_Y, 0]) {
            square([PIN_W, PIN_H]);
        }
        
        translate([SLOT_L - PIN_X - PIN_W, PIN_Y, 0]) {
            square([PIN_W, PIN_H]);
        }
        
        translate([(SLOT_L - PIN_W)/ 2, PIN_Y_2, 0]) {
            square([PIN_W, PIN_H]);
        }
        
    }
}


module c14_inlet() {
    
    C14_DEPTH = 2.0;
    
    linear_extrude(height = C14_DEPTH, convexity = 10, slices = 20, scale = 1.0)  {
        c14_profile();
    }
}

//c14_inlet();