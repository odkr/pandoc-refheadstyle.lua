# pandoc-refheadstyle.lua

`pandoc-refheadstyle.lua` sets a custom style for the reference section
header.

See the [manual page](man/pandoc-refheadstyle.lua.md) for details.


## Installing `pandoc-refheadstyle.lua`

You use `pandoc-refheadstyle.lua` **at your own risk**. You have been warned.

### Requirements

You need [Pandoc](https://www.pandoc.org/) 2.0 or later. If you are using an 
older version of Pandoc, you may want to try 
[pandoc-refheadstyle](https://github.com/odkr/pandoc-refheadstyle),
which works with versions of Pandoc older than 2.0 (but also requires 
[Python](https://www.python.org/) 2.7 and is unmaintained).


### Installation

1. Download the 
   [latest release](https://github.com/odkr/pandoc-refheadstyle.lua/releases/latest).
2. Unpack it.
3. Move `pandoc-refheadstyle.lua` from the repository directory to the
   `filters` sub-directory of your Pandoc data directory
   (`pandoc --version` will tell you where that is).

### POSIX-compliant systems

If you have [curl](https://curl.haxx.se/) or 
[wget](https://www.gnu.org/software/wget/), you can (probably)
install `pandoc-refheadstyle.lua` by copy-pasting the
following instructions into a bourne shell:

```sh
(
    set -Cefu
    NAME=pandoc-zotxt.lua VERSION=0.3.5
    REPOSITORY="${NAME:?}-${VERSION:?}"
    URL="https://github.com/odkr/$NAME/archive/v${VERSION:?}.tar.gz"
    MAN_PATH="/usr/local/share/man/man1"
    PANDOC_FILTERS="${HOME:?}/.pandoc/filters"
    mkdir -p "${PANDOC_FILTERS:?}" && cd -P "$PANDOC_FILTERS" && {
        {
            curl -LsS "$URL" || ERR=$?
            [ "${ERR-0}" -eq 127 ] && wget -q -nc -O - "$URL"
        } | tar xz
        mv "$REPOSITORY/pandoc-zotxt.lua" .
        [ -d "$MAN_PATH" ] && \
            sudo cp "${REPOSITORY:?}/man/pandoc-zotxt.lua.1" "$MAN_PATH"
    }
    exit
)
```

This will also try to copy the manual page to `/usr/local/share/man/man1`;
this is why the system asks you for a password.


## Test suite

For the test suite to work, you need [Pandoc](https://www.pandoc.org/) 2.7.2 
and [pandoc-citeproc](https://github.com/jgm/pandoc-citeproc) 0.16.1.3.
The test suite may or may not work with other versions of Pandoc and
`pandoc-citeproc`.

To run the test suite, just say:

```sh
    make test
```

## Documentation

See the [manual page](man/pandoc-refheadstyle.lua.md)
and the source for details.


## Contact

If there's something wrong with `pandoc-refheadstyle.lua`, 
[open an issue](https://github.com/odkr/pandoc-refheadstyle.lua/issues).


## License

Copyright 2018, 2019 Odin Kroeger

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


## Further Information


GitHub:
    <https://github.com/odkr/pandoc-refheadstyle.lua>