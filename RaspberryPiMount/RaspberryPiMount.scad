// RaspberryPiMount.scad: Mount for Raspberry Pi to Ender 3 Neo in OpenSCAD
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

rpiLength = 95;
rpiWidth = 64;
rpiHeight = 35;
fasteningScrewHoleDiameter = 4;
basePlateThickness = 5;
basePlateWidth = 20;
snapWidth = 3.5;
snapMountThickness = 1.5;
snapMountLength = 27;
railWidth = 27;

render() {
    makeMount(rpiWidth, rpiHeight, basePlateThickness, basePlateWidth);
    translate([rpiWidth / 2 - basePlateThickness / 2 - snapWidth * 2, - rpiHeight / 2 - basePlateThickness +
        snapMountThickness, 0])
        rotate([0, 0, 180])
            makeRailAttachment(snapWidth, snapMountLength, snapMountThickness, basePlateWidth, railWidth);
}


module makeMount(width, height, thickness, plateWidth) {
    difference() {
        union() {
            cube([width + 2 * thickness, height + 2 * thickness, plateWidth], center = true);
            translate([0, (height + plateWidth) / 2, 0])
                cube([3 * thickness, plateWidth, plateWidth], center = true);
        }
        union() {
            cube([width, height, plateWidth], center = true);
            translate([0, (height + plateWidth) / 2, 0])
                cube([thickness, plateWidth, plateWidth], center = true);
            translate([0, (height + plateWidth + thickness) / 2, 0])
                rotate([0, 90, 0])
                    cylinder(d = 3, h = 3 * thickness, center = true);
        }
    }
}

module makeRailAttachment(snapWidth, snapLength, snapThickness, height, railWidth) {
    translate([railWidth / 2, snapLength + snapThickness, - height / 2])
        rotate([0, 0, 270])
            union() {
                makeRailSnap(snapWidth, snapLength, snapThickness, height);
                translate([0, 2 * snapThickness - railWidth, height])
                    rotate([180, 0, 0])
                        makeRailSnap(snapWidth, snapLength, snapThickness, height);
                translate([snapLength, - railWidth + snapThickness, 0])
                    cube([snapThickness * 2, railWidth, height]);
            }
}

module makeRailSnap(snapWidth, snapLength, snapThickness, height) {
    difference() {
        union() {
            cube([snapWidth, snapWidth, height]);
            cube([snapLength, snapThickness, height]);
        }
        rotate([0, 0, 45])
            cube([snapWidth * 2, snapWidth * 2, height]);
    }
}
