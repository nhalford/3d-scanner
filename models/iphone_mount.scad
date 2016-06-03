cube_size = 30;
rod_diameter = 12.8;
tab_width = 4; 
gap_width = 5;
rod_height = 30;
wall_width = 4;

module rod_holder(){
    difference(){
    union(){
        difference(){
        translate([-tab_width - gap_width/2, 0, 15])
        cube([2 * tab_width + gap_width, 25, 15]);
            
        translate([-50, 25/2 + 5,15 + 15/2])
        rotate([0, 90, 0])
        cylinder(r=2.8, h = 100, $fn=100);
            
        }
        cylinder(r=rod_diameter/2 + wall_width, h=30, $fn=100);
    }
    cylinder(r=rod_diameter/2, h=31, $fn=100);
    translate([-2.5, 0, 0])
    cube([5, 30, rod_height]);
    }
}

rod_holder();



translate([-10/2, -4 - rod_diameter/2 - 4,0]){
difference(){
cube([10, wall_width*2, 60]);
translate([2, wall_width/2, 31])
cube([6, wall_width , 30]);
}
}
translate([-40,-35-rod_diameter/2 -40 ,0]){
    difference(){
        cube([80, 35, 4]);
        translate([4, 4,0])
        cube([80-2*4, 35-2*4, 4]);
    }
}




translate([-2, -rod_diameter/2 - 35, 0]){
cube([4, 35, 4]);
translate([74/4,0,0])
cube([4, 35, 4]);
translate([-74/4,0,0])
cube([4, 35, 4]);
}

translate([-40,-35-rod_diameter/2,0])
cube([80, 4, 8]);

// top piece
translate([-40,-35-rod_diameter/2, 0]){
    difference(){
        cube([80, 35, 4]);
        translate([4, 4,0])
        cube([80-2*4, 35-2*4, 4]);
    }
}
translate([0,-35-rod_diameter/2 -40,0])
cube([5, 3, 29]);