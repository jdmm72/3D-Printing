// handCrank.scad: creates an 3/4 PVC mountable hand crank for a high school project
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

spoolHeight = 22;
spoolRadius = 10;
diskHeight = 2;
diskRadius = 15;
axleRadius = 5;
axleHeight = spoolHeight + diskHeight + 25;
handleLength = 30;
clearance = spoolHeight + diskHeight + axleHeight / 4;
bracketRadius = axleRadius + .8;
bracketThickness = 5;
mountingRingRadius = 13.5;

render() {
    rotate([0, 0, 90])
        makeSpool(spoolHeight, spoolRadius, diskHeight, diskRadius, axleRadius, axleHeight);
    translate([0, 0, axleHeight / 2])
        rotate([0, 0, 270])
            makeHandle(axleRadius, handleLength, diskRadius - axleRadius);
    translate([0, 0, - clearance / 2])
        makeBracket(clearance, bracketRadius, bracketThickness, diskRadius * 2);
    translate([0, - mountingRingRadius * 4 + 9 * bracketThickness / 8, 0])
        rotate([0, 90, 0])
            makeMountRings((diskRadius * 2) * (3^.5), mountingRingRadius, bracketThickness);
}

module makeMountRings(height, innerRadius, thickness) {
    difference() {
        union() {
            cylinder(h = height, r = innerRadius + thickness, center = true);
            translate([0, - innerRadius, 0])
                cube([innerRadius, innerRadius * 2, height], center = true);
            rotate([0, 90, 0])
                translate([0, 4 * innerRadius - bracketThickness / 2, 0])
                    union() {
                        translate([0, - diskRadius * 2 - mountingRingRadius, mountingRingRadius])
                            cube([(diskRadius * 2) * (3^.5), mountingRingRadius + bracketThickness, bracketThickness * 2
                                ], center = true);
                        translate([0, - diskRadius * 2 - mountingRingRadius, - mountingRingRadius]
                        )
                            cube([(diskRadius * 2) * (3^.5), mountingRingRadius + bracketThickness, bracketThickness * 2
                                ], center = true);
                    }
        }
        union() {
            cylinder(h = height, r = innerRadius, center = true);
            translate([0, - innerRadius, 0])
                cube([innerRadius / 2, innerRadius * 2, height], center = true);
            translate([0, - innerRadius - 1.75 * thickness, 0])
                rotate([0, 90, 0])
                    cylinder(r = 2, h = innerRadius * 14, center = true);
        }
    }
}



module makeBracket(clearance, bracketRadius, bracketThickness, armLength) {
    makeBracketArm(bracketRadius, bracketThickness, armLength);
    translate([0, 0, clearance])
        makeBracketArm(bracketRadius, bracketThickness, armLength);
    translate([0, - armLength * (3^.5) + bracketRadius * 3 + bracketThickness / 2, clearance / 2])
        cube([armLength * (3^.5), bracketThickness, clearance + bracketThickness], center = true);
}

module makeBracketArm(bracketRadius, bracketThickness, armLength) {
    difference() {
        union() {
            translate([0, - armLength + 2 * bracketRadius, 0])
                rotate([0, 0, 90])
                    cylinder(h = bracketThickness, r = armLength, center = true, $fn = 3);
            cylinder(h = bracketThickness, r = bracketRadius * 2, center = true);
        }
        cylinder(h = bracketThickness, r = bracketRadius, center = true);
    }
}

module makeHandle(handleRadius, handleLength, handleOffset) {
    cylinder(h = handleLength / 2, r = handleRadius, center = true);
    translate([handleOffset / 2, 0, handleLength / 4])
        rotate([0, 90, 0])
            cylinder(h = handleOffset, r = handleRadius, center = true);
    translate([handleOffset, 0, handleLength / 2])
        cylinder(h = handleLength / 2, r = handleRadius, center = true);
    translate([0, 0, handleLength / 4])
        sphere(handleRadius);
    translate([handleOffset, 0, handleLength / 4])
        sphere(handleRadius);
}


module makeSpool(spoolHeight, spoolRadius, diskHeight, diskRadius, axleRadius, axleHeight) {
    cylinder(h = spoolHeight, r = spoolRadius, center = true);
    translate([0, 0, (spoolHeight + diskHeight) / 2])
        cylinder(h = diskHeight, r = diskRadius, center = true);
    translate([0, 0, - (spoolHeight + diskHeight) / 2])
        cylinder(h = diskHeight, r = diskRadius, center = true);
    cylinder(h = axleHeight, r = axleRadius, center = true);
    translate([spoolRadius, 0, 0])
        rotate([90, 0, 0])
            rotate_extrude(convexity = 10) translate([3, 0, 0])circle(r = 1);
}
