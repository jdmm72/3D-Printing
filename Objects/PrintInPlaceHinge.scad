// PrintInPlaceHinge.scad: Library to create a print in place hinge.
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

render() {
    makeHinge(30, 5, .2, 6, 180);
    translate([12, 0, 0]) cube([12, 12, 5.8], center = true);
    translate([12, 0, 12]) cube([12, 12, 5.8], center = true);
    translate([12, 0, 0]) cube([12, 12, 5.8], center = true);
    translate([12, 0, 24]) cube([12, 12, 5.8], center = true);
    translate([19.5, 0, 12])cube([3, 12, 30], center = true);
    translate([- 12, 0, 6]) cube([12, 12, 5.8], center = true);
    translate([- 12, 0, 18]) cube([12, 12, 5.8], center = true);
    translate([- 19.5, 0, 12])cube([3, 12, 30], center = true);
}

module makeHinge(width, segments, separation, radius, degree) {

    segmentWidth = (width / segments);

    correctedSegmentWidth = segmentWidth - separation;

    for (it = [0 : 2 : segments - 1]) {
        translate([0, 0, segmentWidth * it]) cylinder(h = correctedSegmentWidth, r = 6, center = true);
        if (it % 2 == 0) {
            translate([radius / 2, 0, segmentWidth * it]) cube([radius, radius * 2, correctedSegmentWidth], center =
            true);
        } else {
            rotate([0, 0, degree]) translate([radius / 2, 0, segmentWidth * it]) cube([radius, radius * 2,
                correctedSegmentWidth], center = true);
        }
    }
    translate([0, 0, - correctedSegmentWidth / 2]) cylinder(h = width - separation, r = radius / 2, center = false);

    difference() {
        for (it = [1 : 2 : segments - 1]) {
            translate([0, 0, segmentWidth * it]) cylinder(h = correctedSegmentWidth, r = 6, center = true);
            rotate([0, 0, degree]) translate([radius / 2, 0, segmentWidth * it]) cube([radius, radius * 2,
                correctedSegmentWidth], center = true);
        }
        translate([0, 0, - correctedSegmentWidth / 2]) cylinder(h = width, r = radius / 2 + separation, center = false);
    }
}
