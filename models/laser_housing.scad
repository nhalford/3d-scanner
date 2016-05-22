laser_radius = 6;
laser_height = 35;
wall_thickness = 2;
screw_hole_size = 1.6;

module screw_tabs() {
    // Screw tabs
    screw_tabs_width = 5;
    translate([-screw_tabs_width/2, laser_radius + wall_thickness + 3, laser_height/2])
    rotate([0, 90, 0]) 
    difference(){
    union(){
        // Round part
        cylinder(r=screw_hole_size + 3, h=screw_tabs_width);
        // Squre part
        translate([0, -4, 0])
        rotate([0, 0, 45])
        cylinder(r=2*screw_hole_size + 3, h=screw_tabs_width, $fn=4);
    }
    
    translate([0, 0, -.5])
       cylinder(r=screw_hole_size, h=screw_tabs_width + 1);
    };
}

module slice(){
    cube([2, 10, laser_height + 1]);
}

union() {
    //Main tube
    difference(){
        union(){
            // Tube
            cylinder(r=laser_radius+wall_thickness, h=laser_height-5);
            screw_tabs();
        }
        translate([0, 0, -.5]) cylinder(r=laser_radius, h=laser_height-4);
        slice();
    };
    


    // Tabs to keep end in place
    for(i = [1:1:4]) {
        rotate([0,0,i*90 + 45]) translate([6, 0, 0])cylinder(r=2, h=1);
    };
    
    
};