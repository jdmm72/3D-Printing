// Ender3NeoDrawer.scad: Creates a 3-D printable drawer for the Creality Ender 3 Neo 3-D printer.
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
$fa = 6;  // $fa minimum angle = 360/$fa
$fs = 0.1;  // $fs minimum size of fragment, set to print size/2

// toolbox variables
cornerRadius = 10;  // corner radius for rounded corners
width = 103;  // width of toolbox
height = 45;  // height of toolbox
length = 120;  // length of toolbox
wallThickness = 2;  // wall thickness of toolbox

// rail variables
railThickness = 4;  // rail thickness of toolbox
leftRailHeight = 45;  // top z coordinate of left rail
rightRailHeight = 35;  // top z coordinate of right ril
railDepth = 70;  // starting y coordinate of rails

// cutout variables
cutoutXSize = 7;  // X dimension of cutout on left side of toolbox
cutoutZSize = 15; // z dimension of cutout of left side of toolbox

// decoration variables
text = "My Tules";  // Text to be reverse embossed on front of toolbox
horizontalAlignment = "center";

render() {
    embossText(text, horizontalAlignment){
        removeNotch(railThickness, cutoutXSize, cutoutZSize, railDepth){
            addRails(railDepth, leftRailHeight, rightRailHeight, railThickness, length, width){
                buildDrawer(cornerRadius, width, height, length, wallThickness);
            };
        }
    }
}

module embossText(text, horizontalAlignment) {
    difference() {
        children();
        translate([width / 2, 1, height / 2]) rotate([90, 0, 0]) linear_extrude(1) text(text, halign = horizontalAlignment);
    }
}

module buildDrawer(r, width, height, length, wallThickness) {
    removeDrawerInterior(r, width, height, length, wallThickness){
        buildTray(r, width, height, length);
    }
}

module removeDrawerInterior(r, width, height, length, wallThickness) {
    difference() {
        children();
        translate([wallThickness, wallThickness, wallThickness]) buildTray(r - wallThickness, width - (2 * wallThickness
        ), height - wallThickness, length - (2 * wallThickness));
    }
}

module removeNotch(railThickness, cutoutXSize, cutoutZSize, railDepth) {
    difference() {
        children();
        translate([railThickness, 0, height - cutoutZSize]) cube([cutoutXSize, railDepth, cutoutZSize]);
    }
}

module addRails(railDepth, leftRailHeight, rightRailHeight, railThickness, drawerLength, drawerWidth) {
    translate([railThickness, 0, 0]) children();
    translate([0, railDepth, leftRailHeight - railThickness]) cube([railThickness, drawerLength - railDepth,
        railThickness]);
    translate([drawerWidth + railThickness, railDepth, rightRailHeight - railThickness]) cube([railThickness,
            drawerLength - railDepth, railThickness]);
}

module buildTray(r, width, height, length) {
    createFrame(r, width, height, length);
    fillTray(r, width, height, length);
}

module fillTray(r, width, height, length) {
    translate([0, r, r]) cube([width, length - r, height - r]);
    translate([r, 0, r]) cube([width - (2 * r), r, height - r]);
    translate([r, r, 0]) cube([width - (2 * r), length - r, r]);
}

module createFrame(r, width, height, length) {
    roundedCorner(r, r, r, r, - 90, 0, 0, length - r);
    roundedCorner(r, r, r, r, 0, 0, 0, height - r);
    roundedCorner(r, r, r, r, 0, 90, 0, width - (2 * r));
    roundedCorner(width - r, r, r, r, - 90, 0, 0, length - r);
    roundedCorner(width - r, r, r, r, 0, 0, 0, height - r);
}

module roundedCorner(x, y, z, radius, x_rotation, y_rotation, z_rotation, height) {
    translate([x, y, z]) sphere(radius);
    translate([x, y, z]) rotate([x_rotation, y_rotation, z_rotation]) cylinder(height, r = radius, center = false);
}
