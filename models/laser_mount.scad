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
            rotate(20) platform_half(1.1*r1, 0.9*r2);
        }
    }
}

module tab(r)
{
    for (i=[0:1])
    {
        translate([0,i*15*r/16-0.125*r/16,0])
    scale([1,1.25,1.25]) union()
    {
    cube([r/8,r/16,h]);
    translate([1.1*r/8,-r/32,0]) rotate(90) cube([r/8,1.3*r/16,h]);
    }
}
//    difference()
//    {
//        cube([4,0.8*r, 1.1*h / 2]);
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

module housing()
{
    include <laser_housing.scad>
}

module mounts()
{
    union()
    {
       translate([-5,-30,0]) difference()
        {
     cube([10,30,15]);
            translate([5,-1,20]) rotate([90,0,180]) cylinder(r=8,h=32,$fn=100);
        }
    translate([0,-30,20]) rotate([90,0,180]) housing();
    
    translate([15,0,0])
    {
        translate([-5,-30,0]) {
            difference() {
                cube([10,30,30]);
                translate([5,-1,35]) rotate([90,0,180]) cylinder(r=8,h=32,$fn=100);
            }
        }
    translate([0,-30,35]) rotate([90,0,180]) housing();
    }
}
}

module tab2(r)
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
}

//mounts();

//difference()
//{
//tab(ro);
//tab2(ro);
//}

rotate(-80) translate([-7.5,-(ri+ro)/2 + 15,0]) mounts();

difference()
{
platform(ro, ri);
    union()
    {
        rotate(110) translate([-0.4,ri + 0.125*(ro - ri), -0.05*h]) translate([-0.4,0,0]) tab(0.75*(ro - ri));
        rotate(90) translate([0.4,ri + 0.125*(ro - ri), 1.05*h])  rotate([0,180,0]) tab(0.75*(ro - ri));
    }
}

//translate([-0.4,0,0]) scale ([1.1,1,1]) tab(ro, ri);
//        rotate(90) translate([0,ri + 0.125*(ro - ri), h + 1.1*h/4]) rotate([0,180,0])  tab(0.75*(ro - ri));
