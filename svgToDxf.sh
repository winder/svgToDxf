#! /bin/bash
#
# Copyright (c) 2014 Will Winder
# Modified by Andrey Orst 11.13.2018

# Purpose:
# This script simply runs a command with Inkscape to convert a file from svg to
# eps, and then runs another command with pstoedit to convert it from eps to
# dxf.

# Requirements:
# You will need to install Inkscape and pstoedit and make sure they are both
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

function svgToEps()
{
  if test $# -lt 1 ; then
    echo "You need to pass in a filename." ; return
  fi

  epsfile="${1%.*}.eps"

  echo "inkscape -f '$1' -E '$epsfile'"
  inkscape -f "$1" -E "$epsfile" >/dev/null 2>&1
}

function svgToDxf()
{
  if test $# -lt 1 ; then
    echo "You need to pass in a filename." ; return
  fi

  base="${1%.*}"
  epsfile="${base}.eps"
  dxffile="${base}.dxf"

  svgToEps "$1"
  echo "pstoedit -dt -f 'dxf:-polyaslines -mm' '${epsfile}' '${dxffile}'"
  pstoedit -dt -f 'dxf:-polyaslines -mm' "${epsfile}" "${dxffile}" >/dev/null 2>&1
  rm "$epsfile"
}

# Run the function
svgToDxf "$1"
