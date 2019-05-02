# pandoc-refheadstyle.lua

`pandoc-refheadstyle.lua` sets a custom style for the reference section
header, but only if the metadata field ``reference-section-title`` has been
set to a non-empty value.

By default, the reference section header will be assigned the custom style
"Bibliography Heading". But you can assign another style by setting the
metadata field `reference-header-style` to the name of a style of your choice.
If the style does not exist, it will be created.

The reference section header is, by stipulation, the first header, starting
from the end of the document and ignoring the reference section itself, that
has the ID "bibliography" and the text of which is the one set in
`reference-section-title`. (Headers inserted by `pandoc-citeproc` meet
these criteria.)

## Synposis

**pandoc** **--lua-filter** *pandoc-zotxt.lua*


## Caveats

`pandoc-refheadstyle.lua` starts looking for a reference header at the
end of document but changes direction whenever it descends the document's
abstract syntax tree. That is, it will prefer the first header within the
last top-level block to the last header within the last top-level block.


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
3. Copy the whole repository directory to the `filters` sub-directory
   of your Pandoc data directory    
   (`pandoc --version` will tell you where your Pandoc data directory is).
4. Move the file `pandoc-refheadstyle.lua` from the repository directory
   up into the `filters` directory.

If you're using a POSIX-compliant operating system and have 
[curl](https://curl.haxx.se/) or [wget](https://www.gnu.org/software/wget/),
you can (probably) do all of the above by copy-pasting the
following instructions into a terminal:

```sh
    (
        set -Cefu
        NAME=pandoc-refheadstyle.lua VERSION=0.2.6
        REPOSITORY="${NAME:?}-${VERSION:?}"
        ARCHIVE="v$VERSION.tar.gz"
        ARCHIVE_URL="https://github.com/odkr/$NAME/archive/v${VERSION:?}.tar.gz"
        PANDOC_FILTERS="${HOME:?}/.pandoc/filters"
        mkdir -p "${PANDOC_FILTERS:?}" && cd -P "$PANDOC_FILTERS" && {
            curl -LsS "$ARCHIVE_URL" >"$ARCHIVE" || ERR=$?
            [ "${ERR-0}" -eq 127 ] && wget -q -nc -O "$ARCHIVE" "$ARCHIVE_URL"
            tar -xzf "$ARCHIVE"
            mv "$REPOSITORY/pandoc-refheadstyle.lua" .
            rm -f "$ARCHIVE" "$REPOSITORY"
        }
        exit
    )
```


## Test suite

For the test suite to work, you need Zotero and the sources that are cited
in the test documents. You can import those sources from the files
`items.rdf` in the directory `test`.

To run the test suite, just say:

```sh
    make test
```

There is also a test for using Zotero item IDs as citation keys.
But since item IDs are particular to the database used, you
need to adapt this test yourself. Have a look at `key.md` and
`key-is.txt` in `test`. Once you've adapted those to your database,
you can run the test by:

```sh
    make test-key
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