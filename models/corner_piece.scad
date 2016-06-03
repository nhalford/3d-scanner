cube_size = 30;
rod_diameter = 12.8;
tab_width = 4; 
gap_width = 5;
rod_height = 30;
wall_width = 4;

module rod_holder(){
    translate([0,0,rod_diameter/2])
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
translate([0,0,rod_diameter/2 + wall_width])
union() {
    rotate([0, 0, 45])
    rod_holder();

    rotate([90,0,0])
    rod_holder();
  
    rotate([0,90,0])
    rotate([0, 0, 90])
    rod_holder();
}

translate([-(rod_diameter + 8)/2,-(rod_diameter + 8)/2,0])
cube(rod_diameter +8);
difference(){
    rotate([-20,0,45])
    translate([-3.5, 0,15])
    cube([7, 50, 4]);
    translate([-50,-50,-100])
    cube(100);

}
    rotate([0,0,45])
    translate([-3.5, 0,0])
    cube([7, 44, 4]);