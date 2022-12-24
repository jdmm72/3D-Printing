// TemperatureTower.scad: Creates a stack of temperature tower objects.
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

// I used gaaZolee's smart temperature tower @ https://www.thingiverse.com/thing:2729076 for my own use, but you could use any you choose.

baseDiameter = 39;
baseHeight = 1.4;
towerHeight = 10;
temperatures = [240, 235, 230, 225, 220, 215, 205, 200, 195, 190];
towerFilePath = "SmartTemperatureTower.stl";

sortedTemperatures = reverseQuicksort(temperatures);

render() {
    makeBase();
    stackTowers();
}

module makeBase() {
    cylinder(d = baseDiameter, h = baseHeight, center = false);
}

function reverseQuicksort(list) =
    !(len(list) > 0) ? [] : let(
        pivot = list[floor(len(list) / 2)],
        lesser = [for (i = list) if (i > pivot) i],
        equal = [for (i = list) if (i == pivot) i],
        greater = [for (i = list) if (i < pivot) i]
    )
    concat(reverseQuicksort(lesser), equal, reverseQuicksort(greater)
);

module getNewTower(towerNumber, temperature) {
    translate([0, 0, baseHeight + (towerNumber) * towerHeight])
        difference() {
            union() {
                translate([- 125, - 105, 0])
                    import(towerFilePath);
                translate([- 6, - 5, .5])
                    cube([15, 2, 4]);
            }
            translate([7, - 4.75, 2.5])
                rotate([90, 0, 0])
                    scale([.375, .375, .375])
                        linear_extrude(1)
                            text(str(temperature), halign = "center", valign = "center");
        }
}

module stackTowers() {
    for (i = [0:1:len(sortedTemperatures) - 1]) {
        getNewTower(i, sortedTemperatures[i]);
    };
}
