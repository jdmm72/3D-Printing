// Boxes.scad: Utilities to use in creating box objects in OpenSCAD
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

module testMakeRoundedBox() {
    makeRoundedBox(30, 30, 30, 10);
}

module makeRoundedBox(width, depth, height, radius) {
    verify(width, "width");
    verify(depth, "depth");
    verify(height, "height");
    verify(radius, "radius");

    translate([- (width / 2 - radius), - (depth / 2 - radius), - (height / 2 - radius)]) hull() {
        for (x = [0:1]) {
            for (y = [0, 1]) {
                for (z = [0, 1]) {
                    translate([x * (width - 2 * radius), y * (depth - 2 * radius), z * (height - 2 * radius)]) sphere(r
                    = radius);
                }
            }
        }
    }
}
