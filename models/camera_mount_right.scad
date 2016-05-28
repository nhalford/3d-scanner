ri = 65; // 65mm radius of turntable
ro = ri + 40*2.2; // outer radius
h = 5;

// r1 = outer radius, r2 = inner radius
module platform_half(r1, r2)
{
    difference()
    {
    difference()
    {
        cylinder(r=r1, h=h, $fn=200);
        translate([0,0,-0.05*h]) cylinder(r=r2, h=1.1*h, $fn=200);
    }
    translate([-ro,0,-2*h]) cube(2*ro);
}
}

// r1 = outer radius, r2 = inner radius
module platform(r1, r2) {
    difference()
    {
        platform_half(r1, r2);
        union()
        {
            rotate(40) platform_half(1.1*r1, 0.9*r2);
        }
    }
}

module mount()
{
    include <camera_mount.scad>
}

module tab(r)
{
    for (i=[0:1])
    {
        translate([0,i*15*r/16,0])
    union()
    {
    cube([r/8,r/16,h]);
    translate([r/8,-r/32,0]) rotate(90) cube([r/8,r/16,h]);
    }
}
//    difference()
//    {
//        cube([4,0.8*r, 2*h / 5]);
//        union() {
//            translate([-0.05,-0.08*r/7,-0.05*h/2]) cube([4.1,1.1*0.8*r/7,1.2*h/2]);
//            translate([-0.05,2*0.8*r/7,-0.05*h/2]) cube([4.1,0.8*r/7,1.2*h/2]);
//            translate([-0.05,4*0.8*r/7,-0.05*h/2]) cube([4.1,0.8*r/7,1.2*h/2]);
//            translate([-0.05,6*0.8*r/7,-0.05*h/2]) cube([4.1,1.1*0.8*r/7,1.2*h/2]);
//
//
//        }
//    }
}

//tab(0.8*(ro-ri));
platform(ro, ri);    
rotate(-70) translate([-20,-(ri + ro)/2,h]) mount();

rotate(90) translate([0,ri + 0.125*(ro - ri), 0]) tab(0.75*(ro - ri));