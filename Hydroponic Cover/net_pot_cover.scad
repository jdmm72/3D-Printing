// net_pot_cover.scad: OpenSCAD routine to create a hydroponic net pot cover.
// Copyright (C) 2023  Jeremy Mynhier
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

innerDiameter = 75;
innerHeight = 5;
outerDiameter = 89;
outerHeight = 1;

render() {
    cylinder(h = innerHeight, d = innerDiameter, center = false);
    cylinder(h = outerHeight, d = outerDiameter, center = false);
}