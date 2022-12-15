// Utilities.scad: Utilities to use in creating objects in OpenSCAD
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

module testEmbossCube() {
    text = "test";
    width = 54;
    depth = 54;
    height = 54;
    horizontalAlignment = "center";
    verticalAlignment = "center";
    embossText(text, 27, 27, - 1, 1, 180, 0, 180, horizontalAlignment, verticalAlignment){
        embossText(text, 27, 55, 27, 1, 90, 0, 180, horizontalAlignment, verticalAlignment){
            embossText(text, 0, 27, 27, 1, 90, 0, 270, horizontalAlignment, verticalAlignment){
                embossText(text, 54, 27, 27, 1, 90, 0, 90, horizontalAlignment, verticalAlignment){
                    embossText(text, 27, 27, 54, 1, 0, 0, 0, horizontalAlignment, verticalAlignment){
                        embossText(text, 27, 0, 27, 1, 90, 0, 0, horizontalAlignment, verticalAlignment){
                            cube([width, depth, height]);
                        };
                    };
                };
            };
        };
    };
}

module testReverseEmbossCube() {
    text = "test";
    width = 54;
    depth = 54;
    height = 54;
    horizontalAlignment = "center";
    verticalAlignment = "center";
    reverseEmbossText(text, 27, 27, 1, 1, 180, 0, 180, horizontalAlignment, verticalAlignment){
        reverseEmbossText(text, 27, 53, 27, 1, 90, 0, 180, horizontalAlignment, verticalAlignment){
            reverseEmbossText(text, 1, 27, 27, 1, 90, 0, 270, horizontalAlignment, verticalAlignment){
                reverseEmbossText(text, 53, 27, 27, 1, 90, 0, 90, horizontalAlignment, verticalAlignment){
                    reverseEmbossText(text, 27, 27, 53, 1, 0, 0, 0, horizontalAlignment, verticalAlignment){
                        reverseEmbossText(text, 27, 1, 27, 1, 90, 0, 0, horizontalAlignment, verticalAlignment){
                            cube([width, depth, height]);
                        };
                    };
                };
            };
        };
    };
}

module reverseEmbossText(text, xCenter, yCenter, zCenter, cutDepth, xRotation, yRotation, zRotation, horizontalAlignment
, verticalAlignment) {
    difference() {
        children();
        embossText(text, xCenter, yCenter, zCenter, cutDepth, xRotation, yRotation, zRotation, horizontalAlignment,
        verticalAlignment);
    }
}

module embossText(text, xCenter, yCenter, zCenter, textDepth, xRotation, yRotation, zRotation, horizontalAlignment,
verticalAlignment) {
    children();
    translate([xCenter, yCenter, zCenter])
        rotate([xRotation, yRotation, zRotation])
            linear_extrude(textDepth)
                text(text, halign = horizontalAlignment, valign = verticalAlignment);
}