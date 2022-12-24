// pullyBlocl.scad: creates an 3/4 PVC mountable pully block for a high school project
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
fairleadDiameter = 5;
fairleadWidth = 2;
sheaveOuterRadius = 13.5;
sheaveInnerRadius = 11;
sheaveWidth = 10;
tolerance = .8;
wallThickness = 1;


render() {
    makeMountRings(mountingRingHeight, mountingRingRadius, mountingRingThickness);
    translate([0, mountingRingRadius + 10, 0])
        rotate([0, 90, 0])
            makeFairLead(fairleadDiameter);
    translate([0, mountingRingHeight + 2 * sheaveOuterRadius + fairleadDiameter, 0])
        rotate([180, 90, 0])
            makeBlock(sheaveInnerRadius, sheaveOuterRadius, sheaveWidth, wallThickness, fairleadDiameter, tolerance);
}

module makeBlock(innerRadius, outerRadius, width, cheekThickness, hookRadius, tolerance) {
    union() {
        difference() {
            union() {
                makeSheeve(innerRadius, outerRadius, width);
                translate([0, outerRadius / 2, (width + cheekThickness) / 2 + tolerance])
                    cube([outerRadius * 2, outerRadius * 2, cheekThickness], center = true);
                translate([0, outerRadius / 2, - (width + cheekThickness) / 2 - tolerance])
                    cube([outerRadius * 2, outerRadius * 2, cheekThickness], center = true);
                translate([- outerRadius, outerRadius * 1.5, - (width + 2 * cheekThickness) / 2 - tolerance])
                    cube([outerRadius * 2, cheekThickness, (width + 2 * cheekThickness + 2 * tolerance)]);
                cylinder(h = width + tolerance + cheekThickness, r = (innerRadius) / 2 - tolerance, center = true);
            }
            translate([0, outerRadius * 1.5 + cheekThickness / 2, 0])
                rotate([90, 0, 0])
                    cylinder(r = (fairleadWidth / 2) + tolerance, h = cheekThickness, center = true);
        }
        translate([0, outerRadius * 2.25, 0])
            rotate([0, 90, 0])
                makeHook(fairleadWidth, innerRadius, hookRadius);
    }
}

module makeHook(postRadius, length, hookRadius) {
    makeFairLead(hookRadius, postRadius);
    translate([0, - 2 * hookRadius, 0])
        rotate([90, 0, 0])
            cylinder(h = hookRadius * 2, r = postRadius, center = true);
    translate([0, - 3 * hookRadius, 0])
        rotate([90, 0, 0])
            cylinder(h = length / 3, r = postRadius * 1.375, center = true);
}

module makeSheeve(innerRadius, outerRadius, width) {
    difference() {
        translate([0, 0, - width / 4])
            union() {
                cylinder(h = width / 2, r1 = outerRadius, r2 = innerRadius, center = true);
                translate([0, 0, 2 * width / 4])
                    cylinder(h = width / 2, r1 = innerRadius, r2 = outerRadius, center = true);
            }
        cylinder(h = width, r = innerRadius / 2, center = true);
    }
}

module makeFairLead(fairleadDiameter, fairleadWidth) {
    rotate_extrude(convexity = 10)
        translate([fairleadDiameter, 0, 0])
            circle(r = fairleadWidth);
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
