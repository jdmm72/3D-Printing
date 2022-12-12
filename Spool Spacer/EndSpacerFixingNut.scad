// EndSpacerFixingNut.scad: Creates a 3-D printable fixing nut for the EndSpacerV2
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

nutDiameter = 24; // Outer diameter of nut
nutThickness = 10;  // Thickness of nut
threadDiameter = 18;  // Diameter of thread
threadPitch = 2.5;  // Pitch of thread

render() {
    difference() {
        cylinder(nutThickness, d = nutDiameter, $fn = 6, center = false);
        metric_thread(diameter = threadDiameter, pitch = threadPitch, length = nutThickness);
    }
}
