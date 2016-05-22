union(){
    difference(){
        cylinder(r=4, h=5, $fn=100);
        translate([0, 0, -0.5])cylinder(r=2.6, h=6,$fn=100);
    };


    intersection(){
        union(){
            difference(){
                translate([-50, 1.6, 0])
                cube([100, 2, 5]);
                translate([-1, -2, 0])
                cube([2, 5, 6]);
            };
            
            difference(){
                translate([-50, -3.6, 0])
                cube([100, 2, 5]);
                translate([-1, -2.5, 0])
                cube([2, 5, 6]);
            };
        };
        cylinder(r=3.5, h=5, $fn=100);
    };
};

difference(){
    translate([0,0,-2])
    cylinder(h=2, r=10, $fn=100);
    
    for(i = [0 : 72 : 360]){
        rotate([0, 0, i])
        translate([10, 0, -2.5])
        cylinder(r=3, h=5, $fn=100);
        
        rotate([0, 0,  i + 72/2])
        translate([7, 0, -2.5])
        cylinder(r=1.6, h=10, $fn=100);
    };
};