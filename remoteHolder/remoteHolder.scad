// remoteHolder: OpenSCAD routine to create a holder for a TV remote.
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

// render variables
$fa = 1;  // $fa minimum angle = 360/$fa
$fs = 0.1;  // $fs minimum size of fragment, set to print size/2

width = 50.08;  // width of remote
depth = 190.08; // Length of remote
height = 20.08; // height of remote
armDepth = 20; // Width of holding arms on holder
skinThickness = 2.08; // Thickness of arms and baseplate

plateDepth = (depth + armDepth) / 2 + skinThickness;

bottomXOffset = 0;
bottomYOffset = - plateDepth / 2 + (armDepth + skinThickness) / 2;
bottomZOffset = (height + skinThickness) / 2;

verify(width, "width");
verify(depth, "depth");
verify(height/2, "height/2");
verify(armDepth, "armDepth");
verify(skinThickness/2, "skinThickness/2");
verify(plateDepth, "plateDepth");
verify(bottomXOffset, "bottomXOffset");
verify(bottomYOffset, "bottomYOffset");
verify(bottomZOffset, "bottomZOffset");


render() {
    makeBasePlate(width, plateDepth, skinThickness);
    makeBottomBox(width, armDepth, height, skinThickness, bottomXOffset, bottomYOffset, bottomZOffset);
    makeArm(width, armDepth, height, skinThickness, 0, - bottomYOffset + skinThickness / 2, height / 2);
}

module makeBasePlate(x, y, z) {
    cube([x + 2 * z, y, z], center = true);
}

module makeBottomBox(x, y, z, thickness, xOffset, yOffset, zOffset) {
    translate([xOffset, yOffset, zOffset])
        difference() {
            cube([x + 2 * thickness, y + thickness, z + 2 * thickness], center = true);
            translate([0, thickness, 0])
                cube([x, y, z], center = true);
        }
}

module makeArm(x, y, z, thickness, xOffset, yOffset, zOffset) {
    verify((x + 2 * thickness) / 3, "(x + 2 * thickness) / 3");
    translate([xOffset, yOffset - thickness, zOffset + thickness / 2])
        difference() {
            makeBottomBox(x, y + thickness, z, thickness, 0, 0, 0);
            union() {
                cube([(x + 2 * thickness) / 3, y + 2 * thickness, z + 2 * thickness], center = true);
                translate([0, - y, 0])
                    cube([x + 2 * thickness, y + thickness, z + 2 * thickness], center = true);
            }
        }
}
