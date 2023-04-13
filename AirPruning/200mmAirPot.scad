// 200mmAirPot.scad: OpenSCAD routine to create a 200 mm air pot.
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

bottomRadius = 90;
topRadius = 100;
height = 235;
skinThickness = 1.2;
holeRadius = 5.4;
holeDegrees = 22.5;
drainHoleRadius = 5;
chamferSize = 10;

// render variables
$fa = $preview ? 12 : 1;  // $fa minimum angle = 360/$fa
$fs = $preview ? 2 : 0.1;  // $fs minimum size of fragment, set to print size/2

difference() {
    cylinder(h = height, r1 = bottomRadius, r2 = topRadius);
    union() {
        translate([0, 0, skinThickness * 2])
            cylinder(h = height - skinThickness * 2, r1 = bottomRadius - skinThickness, r2 = topRadius - skinThickness);
        for (j = [chamferSize:holeRadius * 3:height]) {
            for (i = [0:holeDegrees:180]) {
                rotate([0, 0, holeDegrees / 2 * j])
                    translate([0, 0, j + skinThickness + holeRadius])
                        rotate([0, - 90, i])
                            cylinder(h = topRadius * 2, r = holeRadius, center = true, $fn = 3);
            }
        }
        cylinder(h = height, r = drainHoleRadius);
    }
}

rotate_extrude(angle = 360)
    translate([bottomRadius - chamferSize, 0, 0])
        difference() {
            square(chamferSize);
            rotate([0, 0, 45])
                square(2 * chamferSize);
}
