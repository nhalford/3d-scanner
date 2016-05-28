triangle_height = 40;
triangle_width = 40;
side_length = sqrt(2) * triangle_height;
beam_width = 5;
smaller_side_length = side_length - beam_width* (1 + sqrt(2))*sqrt(2);

module triangle(side, z){
    difference() {
        translate([0, 0, -side/sqrt(2)])
        rotate([45, 0, 0])
        cube([z, side, side]);
        
        // Cut off bottom
        translate([-500, -500, -1000])
        cube([1000, 1000, 1000]);
    };
};

module truss(){
    difference(){
        triangle(side_length, triangle_width);
        // hollow out triangle cross section
        translate([-0.5, 0, beam_width])

        triangle(smaller_side_length, triangle_width + 1);
        
        translate([beam_width, -500, , beam_width])
        cube([triangle_width - beam_width*2, 1000, triangle_height- beam_width*(2)]);
        
        //hollow base
        translate([beam_width, 0, -(beam_width*(sqrt(2)))])
        triangle(side_length, triangle_width - 2*beam_width);
    }
};

module notch(){
    translate([-500, -beam_width/4, 0])
    cube([1000, beam_width/2, beam_width/2]);
};

module hook(){
    translate([-beam_width/2,-1.5,0]) union()
    {
    cube([beam_width,3,3]);
    translate([0,0,3]) rotate([-45,0,0]) cube([beam_width,3,4]);
    }
}

//hook();
truss();
translate([0,beam_width / 2,beam_width / 2]) translate([smaller_side_length / 2, -triangle_width, 0]) rotate([45,0,0]) rotate(180) hook();
translate([0,-beam_width / 2,beam_width / 2]) translate([smaller_side_length / 2, triangle_width, 0]) rotate([-45,0,]) hook();
//difference(){
//    truss();
//    notch();
//};

