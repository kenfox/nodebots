
projection() Wheel(size=40);

module Wheel(size=30, $fa=5, $fs=1) {
    hole = 5;
    thickness = 5;
    is_large = size >= 40;

    num_spokes = (is_large) ? 8 : 4;
    inner = (is_large) ? 10 : 6;
    outer = 5;
    spoke = 9;

    difference() {
        union() {
            difference() {
                cylinder(r=hole+inner, h=thickness);
                cylinder(r=hole, h=thickness*5, center=true);
            }
            difference() {
                cylinder(r=size, h=thickness);
                cylinder(r=size-outer, h=thickness*5, center=true);
            }
            for (r=[0:360/num_spokes:359]) {
                rotate([0,0,r])
                    translate([-spoke/2, hole+1, 0])
                        cube([spoke, size-hole-outer+1, thickness]);
            }
        }
        Servo_Mounts(is_large, thickness);
    }
}

module Servo_Mounts(is_large, thickness) {
    small_servo_mount = [20,32];
    large_servo_mount = [32,50];

    for (side=[1,-1]) {
        if (is_large) {
            for (i=large_servo_mount) {
                translate([0, side*i/2, 0])
                    cylinder(d=2, h=thickness*5, center=true);
            }
        }
        else {
            for (i=small_servo_mount) {
                translate([0, side*i/2, 0])
                    cylinder(d=2, h=thickness*5, center=true);
            }
        }
    }
}
