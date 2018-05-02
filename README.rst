=======================
pandoc-refheadstyle.lua
=======================

``pandoc-refheadstyle`` sets a custom style for the reference section header,
but only if the metadata field ``reference-section-title`` has been set to a
non-empty value.

By default, the reference section header will be assigned the custom style
'Bibliography Heading'. But you can change what style is assigned by setting
the metadata field ``reference-header-style`` to the name of a style of
your choice. If the style does not exist, it will be created.

See the `manual page <man/pandoc-refheadstyle.lua.rst>`_ for more details.

If you are using `panzer <https://github.com/msprev/panzer>`_ and need more
fine-grained control over when which filter is applied, have a look at
`pandoc-refheadstyle <https://github.com/odkr/pandoc-refheadstyle>`_,
a Python version of this script that runs as ordinary filter.


Installing ``pandoc-refheadstyle.lua``
======================================

You use ``pandoc-refheadstyle.lua`` **at your own risk**. You have been warned.

You need `Pandoc <https://www.pandoc.org/>`_ 2.0 or newer.
If you are using an older Pandoc version, have a look at
`pandoc-refheadstyle <https://github.com/odkr/pandoc-refheadstyle>`_,
which works with older versions of Pandoc.

Download the `current release
<https://codeload.github.com/odkr/pandoc-refheadstyle/tar.gz/v0.1.0>`_
and copy it to the ``filters`` subdirectory of your Pandoc data directory.

You can do this by::

    curl https://codeload.github.com/odkr/pandoc-refheadstyle.lua/tar.gz/v0.1.0 | tar -xz
    cd pandoc-refheadstyle.lua-0.1.0
    mkdir -p ~/.pandoc/filters
    cp pandoc-refheadstyle.lua ~/.pandoc/filters
    # Copy the man page.
    sudo cp man/pandoc-refheadstyle.lua.1 /usr/local/share/man/man1


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
