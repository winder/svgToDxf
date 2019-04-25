# Copyright (c) 2019 Brad Tarratt

# Purpose:
# This makefile simply runs a command with Inkscape to convert a file from svg to
# eps, and then runs another command with pstoedit to convert it from eps to
# dxf.  You can easily convert a whole directory with "make", or just one file
# with "make something.dxf".  Make will only convert SVG files that are newer
# than their DXF counterparts (or if the DXF is not yet made).

# Requirements:
# You will need to install Inkscape, pstoedit and gmake and make sure they are
# added to your PATH. On most linux distributions you should be able to use apt
# or similar to install the packages, on MacOSX you may need to use something
# like ports to install pstoedit then manually add the PATH.

# License:
# The MIT License (MIT)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

SVGS=$(wildcard *.svg)
DXFS=$(patsubst %.svg,%.dxf,$(SVGS))

all: $(DXFS)

$(DXFS) : %.dxf : %.eps
	pstoedit -dt -f 'dxf:-polyaslines -mm' "$<" "$@"

%.eps : %.svg
	inkscape -f "$<" -E "$@" 

clean:
	rm -fr *.dxf *.eps
