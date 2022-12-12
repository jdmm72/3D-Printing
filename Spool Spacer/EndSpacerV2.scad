// EndSpacerV2.scad: Creates a 3-D printable end spool spacer for Creality Ender 3 Neo.
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

// You will need to include the following in the directory that this source resides in.
// It can be found at https://dkprojects.net/openscad-threads/threads.scad
use <threads.scad>;

// render variables
$fa = 1;  // $fa minimum angle = 360/$fa
$fs = 0.1;  // $fs minimum size of fragment, set to print size/2

shaftDiameter = 25; // Length of the solid shaft, in bolt terms, the grip
shaftLength = 100; // Diameter of the solid shaft
threadDiameter = 18; // Diameter of the threaded portion
threadLength = 30; // Length of the threaded portion
threadPitch = 2.5; // Pitch of the threaded portion
diskDiameter = 75; // Diameter of the stopping disk
diskThickness = 2; // Thickness of the stopping disk
nutDiameter = 25; // Diameter of the hexagon handle
nutThickness = 10; // Thickness of the hexagon handle

render() {
    cylinder(h = diskThickness, d = diskDiameter, center = false);
    cylinder(h = shaftLength, d = shaftDiameter, center = false);
    translate([0, 0, shaftLength]) metric_thread(diameter = threadDiameter, pitch = threadPitch, length = threadLength);
    translate([0, 0, - nutThickness]) cylinder(nutThickness, d = nutDiameter, $fn = 6, center = false);
}
