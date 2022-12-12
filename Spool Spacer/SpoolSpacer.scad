// SpoolSpacer.scad: Creates a 3-D printable spool spacer for Creality Ender 3 Neo.
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

innerDiameter = 32; // Inner Diameter of the spacer that sits on spool holder.
outerDiameter = 53; // Outer Diameter of spacer that touches spool
spacerWidth = 85; // Width of spacer
rimWidth = 2; // Width of the stopping rim on spacer
rimDiameter = 63; // Diameter of the stopping rim on spacer

render() {
    difference() {
        difference() {
            union() {cylinder(h = spacerWidth, d = outerDiameter, center = false);
                cylinder(h = rimWidth, d = rimDiameter, center = false);
            }
            union() {
                cylinder(h = spacerWidth, d = innerDiameter, center = false);
                translate([- rimDiameter / 2, 0, 0]) cube([rimDiameter, rimDiameter, spacerWidth]);
            }
        }
        translate([0, - (outerDiameter + innerDiameter)/4, 1]) scale([.5, .5, 1]) rotate([0, 180, 0]) linear_extrude(1) text(str(
        "diameter=", outerDiameter), halign = "center", valign = "center");
    }
}