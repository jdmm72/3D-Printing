// 16500 4 Pack.scad: OpenSCAD routine to create a 16500 battery holder.
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

use <../Libraries/Hinges.scad>
use <../Libraries/Verifier.scad>
use <../Libraries/Utilities.scad>

// render variables
$fa = 1;  // $fa minimum angle = 360/$fa
$fs = 0.1;  // $fs minimum size of fragment, set to print size/2

bodyHeight = 56;
lidHeight = 10;
floorHeight = 2;
ceilingHeight = 2;
wallThickness = 2;
separationThickness = 1;
cellDiameter = 19.2;
latchWidth = 10;
latchDepth = 1;
latchTolerance = 0.2;
hingeSegments = 5;
hingeSeparation = 0.84;
hingeRadius = 3.2;
hingeDegree = 270;
text = "16500";
textHorizontalAlignment = "center";
textVerticalAlignment = "center";

bodyWidth = (cellDiameter + wallThickness) * 2 + separationThickness;
totalBodyHeight = bodyHeight + floorHeight;
totalLidHeight = lidHeight + ceilingHeight;
hingeSegmentHeight = bodyWidth / hingeSegments;
correctedHingeSegmentHeight = hingeSegmentHeight - hingeSeparation;

render() {
    translate([bodyWidth, 0, bodyHeight + floorHeight]) rotate([0, 180, 0]) union() {
        makeBody(cellDiameter, wallThickness, bodyHeight, floorHeight, separationThickness);
        translate([0, bodyWidth * 2 + hingeRadius * 3, 0]) rotate([180, 0, 0]) reverseEmbossText(text, bodyWidth / 2,
            bodyWidth / 2, - lidHeight - (ceilingHeight + separationThickness) / 2, 1, 180, 0, 180,
        textHorizontalAlignment, textVerticalAlignment)
        {
            translate([0, bodyWidth, 0]) rotate([180, 0, 0])makeLid(lidHeight, ceilingHeight, bodyWidth, wallThickness);
            translate([bodyWidth / 2, (latchDepth - latchTolerance) / 2, latchWidth / 2 - latchTolerance * 2 / 2])
                rotate([90, 0, 0])
                    union() {
                        makeLatch(latchWidth, latchDepth, latchTolerance);translate([0, latchWidth / 2 + 2 *
                            latchTolerance - 1, 1 - latchTolerance]) cube([latchWidth - latchTolerance, 1, 1], center =
                        true);
                    }
        };
        translate([bodyWidth / 2, bodyWidth + hingeRadius * 1.5, 0]) rotate([90, 90, - 90]) makeHinge(bodyWidth,
        hingeSegments, hingeSeparation, hingeRadius, hingeDegree);
    }
}

module makeHinge(bodyWidth, hingeSegments, hingeSeparation, hingeRadius, hingeDegree) {
    difference() {
        rotate([0, 0, - hingeDegree / 2])
            union() {
                makePrintInPlaceHinge(bodyWidth, hingeSegments, hingeSeparation, hingeRadius, hingeDegree);
                for (it = [0 : 2 : hingeSegments - 1]) {
                    translate([hingeRadius * 2, 0, (it - 2) * hingeSegmentHeight]) cube([hingeRadius * 2, hingeRadius *
                        2, correctedHingeSegmentHeight], center = true);
                }
                for (it = [1 : 2 : hingeSegments - 1]) {
                    rotate([0, 0, hingeDegree])translate([hingeRadius * 2, 0, (it - 2) * hingeSegmentHeight]) cube([
                            hingeRadius * 2, hingeRadius * 2, correctedHingeSegmentHeight], center = true);
                }
            }
        union() {
            translate([- hingeRadius * 6, hingeRadius * 1.5, - bodyWidth / 2])
                cube([hingeRadius * 6, hingeRadius * 6, bodyWidth]);
            translate([- hingeRadius * 6, - (hingeRadius * 6 + hingeRadius * 1.5), - bodyWidth / 2]) cube([hingeRadius *
                6, hingeRadius * 6, bodyWidth]);
        }
    }
}



module makeLatch(latchWidth, latchDepth, latchTolerance) {
    verify(latchWidth / 2, "latchWidth/2");
    verify(latchDepth, "latchDepth");
    verify(latchTolerance, "latchTolerance");
    difference() {
        cube([latchWidth - latchTolerance, latchWidth - latchTolerance, latchDepth - latchTolerance], center = true);
        cube([latchWidth / 2 + latchTolerance, latchWidth / 2 + latchTolerance, latchDepth - latchTolerance], center =
        true);
    }
}



module makeLid(lidHeight, ceilingHeight, width, wallThickness) {
    verify(lidHeight, "lidHeight");
    verify(ceilingHeight, "ceilingHeight");
    verify(width, "width");
    verify(wallThickness, "wallThickness");
    difference() {
        cube([width, width, lidHeight + ceilingHeight]);
        translate([wallThickness, wallThickness, 0]) cube([width - wallThickness * 2, width - wallThickness * 2,
                    lidHeight + ceilingHeight - wallThickness * 2]);
    }
}

module makeBody(diameter, wallThickness, bodyHeight, floorHeight, separation) {
    verify(diameter / 2, "diameter/2");
    verify(wallThickness, "wallThickness");
    verify(bodyHeight, "bodyHeight");
    verify(floorHeight, "floorHeight");
    verify(separation, "separation");
    difference() {
        cube([(diameter + wallThickness) * 2 + separation, (diameter + wallThickness) * 2 + separation, bodyHeight +
            floorHeight]);
        union() {

            translate([diameter / 2 + wallThickness, diameter / 2 + wallThickness, 0]) makeFourPack(bodyHeight, diameter
            , separationThickness);
            translate([bodyWidth / 2, latchDepth / 2, (latchWidth + latchTolerance) / 2]) rotate([90,
                0, 0])  makeLatch(latchWidth, latchDepth, 0);
        }
    }
}

module makeFourPack(height, diameter, separation) {
    verify(height, "height");
    verify(diameter, "diameter");
    verify(separation, "separation");
    makeCell(height, diameter);
    translate([diameter + separation, 0, 0]) makeCell(height, diameter);
    translate([0, diameter + separation, 0]) makeCell(height, diameter);
    translate([diameter + separation, diameter + separation, 0]) makeCell(height, diameter);
}

module makeCell(height, diameter) {
    verify(height, "height");
    verify(diameter, "diameter");
    cylinder(h = height, d = diameter, center = false);
}
