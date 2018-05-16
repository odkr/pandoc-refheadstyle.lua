=======================
pandoc-refheadstyle.lua
=======================

``pandoc-refheadstyle.lua`` sets a custom style for the reference section
header, that is, if the metadata field ``reference-section-title`` has been
set to a non-empty value.

By default, the reference section header will be assigned the custom style
'Bibliography Heading'. But you can assign another style by setting the metadata
field ``reference-header-style`` to the name of a style of your choice.
If the style does not exist, it will be created.

See the `manual page <man/pandoc-refheadstyle.lua.rst>`_ for more details.

If you are using `panzer <https://github.com/msprev/panzer>`_ and need more
fine-grained control over which filter runs when, have a look at
`pandoc-refheadstyle <https://github.com/odkr/pandoc-refheadstyle>`_,
which runs as ordinary filter.


Installing ``pandoc-refheadstyle.lua``
======================================

You use ``pandoc-refheadstyle.lua`` **at your own risk**. You have been warned.

You need `Pandoc <https://www.pandoc.org/>`_ 2.0 or newer.
If you are using an older version of Pandoc, try
`pandoc-refheadstyle <https://github.com/odkr/pandoc-refheadstyle>`_,
which works with versions of Pandoc older than 2.0.

1. Download the `current release
   <https://codeload.github.com/odkr/pandoc-refheadstyle/tar.gz/v0.2.2>`_.
2. Unpack it.
3. Copy the whole directory to the ``filters``
   subdirectory of your Pandoc data directory.

Where your Pandoc data directory is located depends on your operating system.
``pandoc --version`` will tell you. Consult the Pandoc manual for details.

You may also want to copy the manual page to wherever your system stores manual
pages; typically, this is ``/usr/local/share/man/``.

If you are using a Unix-ish operating system, you can do all of the above by::

    PANDOC_DATA_DIR=$(pandoc --version |
        sed -n 's/^Default user data directory: //p')
    mkdir -p "${PANDOC_DATA_DIR:?}/filters"
    cd "${PANDOC_DATA_DIR:?}/filters"
    curl https://codeload.github.com/odkr/pandoc-refheadstyle.lua/tar.gz/v0.2.2 |
        tar -xz
    sudo cp pandoc-refheadstyle.lua-0.2.2/man/pandoc-refheadstyle.lua.1 \
        /usr/local/share/man/man1


Documentation
=============

See the `manual page <man/pandoc-refheadstyle.lua.rst>`_
and the source for details.


Contact
=======

If there's something wrong with ``pandoc-refheadstyle.lua``, `open an issue
<https://github.com/odkr/pandoc-refheadstyle.lua/issues>`_.


License
=======

Copyright 2018 Odin Kroeger

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


Further Information
===================

GitHub:
<https://github.com/odkr/pandoc-refheadstyle.lua>


See also
========

`pandoc-refheadstyle <https://github.com/odkr/pandoc-refheadstyle>`_
