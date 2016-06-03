cube_size = 30;
rod_diameter = 12.8;
tab_width = 4; 
gap_width = 5;
rod_height = 30;
wall_width = 4;
cube_size = 100;

difference(){
    translate([-cube_size/2, -cube_size/4, 0])
    cube([cube_size, cube_size/2, cube_size/2]);

    translate([-cube_size/2 -1,0, rod_diameter/2 + 4])
    rotate([0,90,0])
    cylinder(r = rod_diameter/2 + 4, h = cube_size + 2);
    translate([-cube_size/2 - 1, -rod_diameter/2 - 4, 0])
    cube([cube_size + 2, rod_diameter + 8, rod_diameter/2 + 4]);
    
    translate([-cube_size/2 + 12, -cube_size/4 + 5, 0])
    cube([cube_size - 17, cube_size/2 - 10, cube_size/2]);
    
    translate([-cube_size/2 + 12, -cube_size/4 , 0 + 5])
    cube([cube_size - 17, cube_size/2  , cube_size/2 - 10]);
    
    difference(){
    translate([-cube_size/2, -cube_size/4 + 4,  + 4])
    cube([cube_size, cube_size/2 - 8, cube_size/2 - 8]);
        
    translate([-cube_size/2 -1,0, rod_diameter/2 + 4])
    rotate([0,90,0])
    cylinder(r = rod_diameter/2 + 4 + 4, h = cube_size + 2);
    translate([-cube_size/2 - 1, -rod_diameter/2 - 4, 0])
    cube([cube_size + 2, rod_diameter + 8 + 4, rod_diameter/2 + 4]);
    }
}






translate([-cube_size/2 + 6,4,135])
rotate([95,0,0])
laser_housing();


difference(){
    translate([ -50, -25, 50])
    difference(){
        cube([12, 29, 85]);
        translate([0, 5, 0])
        cube([12, 19, 80]);

    }
hull(){
translate([-cube_size/2 + 6,4,135])
rotate([95,0,0])
laser_housing();
}
}

// laser housing 

module laser_housing(){
laser_radius = 6;
laser_height = 35;
wall_thickness = 2;
screw_hole_size = 1.6;

module screw_tabs() {
    // Screw tabs
    screw_tabs_width = 6;
    translate([-screw_tabs_width/2, laser_radius + wall_thickness + 3, laser_height/2])
    rotate([0, 90, 0]) 
    difference(){
    union(){
        // Round part
        cylinder(r=screw_hole_size + 3, h=screw_tabs_width, $fn=100);
        // Squre part
        translate([0, -4, 0])
        rotate([0, 0, 45])
        cylinder(r=2*screw_hole_size + 3, h=screw_tabs_width, $fn=4);
    }
    
    translate([0, 0, -.5])
       cylinder(r=screw_hole_size, h=screw_tabs_width + 1, $fn=100);
    };
}

module slice(){
    slice_width = 2;
    translate([-slice_width/2, 0, -.5])
    cube([slice_width, 20, laser_height + 1]);
}

union() {
    //Main tube
    difference(){
        union(){
            // Tube
            cylinder(r=laser_radius+wall_thickness, h=laser_height-5, $fn=100);
            screw_tabs();
        }
        translate([0, 0, -.5]) 
        cylinder(r=laser_radius, h=laser_height-4, $fn=100);
        slice();
    };
    


    // Tabs to keep end in place
    for(i = [1:1:4]) {
        rotate([0,0,i*90 + 45]) translate([6, 0, 0])cylinder(r=2, h=1, $fn=100);
    };
    
    
};

};