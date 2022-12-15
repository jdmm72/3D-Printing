// Hinges.scad: Utilities to use in creating hinge objects in OpenSCAD
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

use <../Libraries/Verifier.scad>

module testPrintInPlaceHinge() {
    makePrintInPlaceHinge(24, 5, .8, 3.2, 180);
}

module makePrintInPlaceHinge(width, segments, separation, radius, degree) {
    segmentWidth = (width / segments);
    correctedSegmentWidth = segmentWidth - separation;

    verify(width, "width");
    verify(separation, "separation");
    verify(radius / 2, "radius/2");
    verify(segmentWidth, "segmentWidth");
    verify(correctedSegmentWidth / 2, "correctedSegmentWidth/2");

    translate([0, 0, - (2 * segmentWidth)]) union() {
        for (it = [0 : 2 : segments - 1]) {
            translate([0, 0, segmentWidth * it]) cylinder(h = correctedSegmentWidth, r = radius, center = true);
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
                translate([0, 0, segmentWidth * it]) cylinder(h = correctedSegmentWidth, r = radius, center = true);
                rotate([0, 0, degree]) translate([radius / 2, 0, segmentWidth * it]) cube([radius, radius * 2,
                    correctedSegmentWidth], center = true);
            }
            translate([0, 0, - correctedSegmentWidth / 2]) cylinder(h = width, r = (radius + separation) / 2, center =
            false);
        }
    }
}
