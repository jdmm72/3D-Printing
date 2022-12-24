// carriage.scad: creates an elevator carriage for a high school project
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

ringHeight = 5;
ringInnerRadius = 15;
ringThickness = 5;

carriageSideSize = 40;

render() {
    translate([carriageSideSize / 2, 0, 0]) makeCarriage(carriageSideSize);
    translate([- ringInnerRadius, 0, (carriageSideSize - ringThickness) / 2])
        makeTowerRing(ringHeight, ringInnerRadius, ringThickness);
    translate([- ringInnerRadius, 0, - (carriageSideSize - ringThickness) / 2])
        makeTowerRing(ringHeight, ringInnerRadius, ringThickness);
    translate([carriageSideSize / 2, 0, (carriageSideSize + ringInnerRadius) / 2])
        rotate([90, 0, 0])
            makeTowerRing(ringHeight, ringInnerRadius / 2, ringThickness);
}

module makeCarriage(sideSize) {
    difference() {
        cube([sideSize, sideSize, sideSize], center = true);
        union() {
            cube([sideSize, sideSize - 10, sideSize - 10], center = true);
            cube([sideSize - 10, sideSize, sideSize - 10], center = true);
        }
    }
}

module makeTowerRing(height, innerRadius, thickness)
difference() {
    cylinder(h = height, r = innerRadius + thickness, center = true);
    cylinder(h = height, r = innerRadius, center = true);
}
