/*
 * Lidlskop accessoies
 * Model Skylux 70/700
 *
 * License: MIT
 * Michael Arbet (c) 2023 - 2024
 */

include <threads.scad>

// Front lens assembly diameter is 83 nad legth 40
front_dia=83.5;  // real front diameter is 83.15
front_wall=4;     // match the lens assembly
front_length=40;   // lenght of brim
thread_length=3;

$fn=128;

out_dia=front_dia+2*front_wall;

// simple tube definition
// just a hollow cylinder
module tube(height,dia_in,dia_out) {
    difference() {
        cylinder(height,d=dia_out);
        cylinder(height,d=dia_in);

    }
}

// Common base to to various lens caps
//  includes key rim for a screw head
//  protruding from the lens assembly
module base(height,dia,front_wall) {
    difference() {
        tube(height, dia, dia+2*front_wall);
        translate( [front_dia/2-2,0,height-11] ) cylinder(11,d=7);
    }
}

// Lens cap
module cap() {
    cylinder(1,d=out_dia);
    base(front_length+1,front_dia,front_wall);
}

// Lens cap with opening for astrosolar foil
module cap_astrosolar() {
    tube(1,front_dia-10,out_dia);
    base(front_length+1,front_dia,front_wall);
}

// Front element with M77 filter thread
module front_m77() {
    difference() {
        cylinder(1,d=out_dia);
        cylinder(1,d=77.5);
    }
    translate([0,0,1])
        ScrewHole(76.35, thread_length, pitch=0.75) cylinder(thread_length,d=out_dia);
}

// Lens cap with M77x0.75 filter thread
module cap_m77() {
    front_m77();
    base(front_length+thread_length+1,front_dia,front_wall);
}

module demo() {
    translate([-50,0,0]) cap_m77();
    translate([0,83,0]) cap();
    translate([50,0,0]) cap_astrosolar();
}

// Uncomment the part you need to render

//demo();  // All things on the plate to show off
//brim(12,front_dia,wall);   // brim test-print
cap_astrosolar();
//cap_m77();
