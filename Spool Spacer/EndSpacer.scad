// EndSpacer.scad: Creates a 3-D printable end spool spacer for Creality Ender 3 Neo.
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

plugDiameter1 = 27;
plugDiameter2 = 26;
plugHeight = 20;
plugDiskHeight = 2;
plugDiskDiameter = 65;
spacerHeight = 40;
spacerDiameter = 65;

render() {
    cylinder(h = plugHeight, d1 = plugDiameter1, d2 = plugDiameter2, center = false);
    cylinder(h = plugDiskHeight, d = plugDiskDiameter, center = false);
    difference() {
        cylinder(h = 30, d1 = plugDiskDiameter, d2 = spacerDiameter, center = false);
        cylinder(h = spacerHeight, d1 = plugDiskDiameter - plugDiskHeight, d2 = spacerDiameter - plugDiskHeight, center
        = false);
    }
}
