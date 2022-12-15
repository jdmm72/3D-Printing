// Verifier.scad: Verifies numbers against printer magic number
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

printerMagicNumber = .04;
magicNumber = round(printerMagicNumber * 100);

module verify(number, parameter) {
    if (round(number * 100) % magicNumber != 0) {
        echo(str("Remainder of ", round(number * 100) % magicNumber, " when parameter \"", parameter, "\" (", number, ") ",
        " is divided by printer magic number of ", printerMagicNumber, "."));
        assert(false, str("Verification Failed: ", parameter));
    }
}