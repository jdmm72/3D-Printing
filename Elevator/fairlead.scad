// fairlead.scad: creates an fairlead for a high school project
// Copyright (C) 2022  Jeremy Mynhier
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

// render variables
$fa = 1;  // $fa minimum angle = 360/$fa
$fs = 0.1;  // $fs minimum size of fragment, set to print size/2

mountingRingHeight = 27;
mountingRingRadius = 13.5;
mountingRingThickness = 5;

render() {
    makeMountRings(mountingRingHeight, mountingRingRadius, mountingRingThickness);
    translate([0, mountingRingRadius + 10, 0])
        rotate([0, 45, 0])
            makeFairLead();
}

module makeFairLead() {
    rotate_extrude(convexity = 10)
        translate([5, 0, 0])
            circle(r = 2);
}

module makeMountRings(height, innerRadius, thickness) {
    difference() {
        union() {
            cylinder(h = height, r = innerRadius + thickness, center = true);
            translate([0, - innerRadius, 0])
                cube([height / 2, height, height], center = true);
        }
        union() {
            cylinder(h = height, r = innerRadius, center = true);
            translate([0, - innerRadius, 0])
                cube([height / 4, height, height], center = true);
            translate([0, - height / 2 - 1.75 * thickness, 0])
                rotate([0, 90, 0])
                    cylinder(r = 2, h = innerRadius * 14, center = true);
        }
    }
}
