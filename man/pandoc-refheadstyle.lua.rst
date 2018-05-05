=======================
pandoc-refheadstyle.lua
=======================

--------------------------------------
Sets style of reference section header
--------------------------------------

:Author: Odin Kroeger
:Date: May 2, 2018
:Version: 0.1.5
:Manual section: 1


SYNOPSIS
========

pandoc [...] --lua-filter pandoc-refheadstyle.lua-0.1.5/pandoc-refheadstyle.lua [...]


DESCRIPTION
===========

``pandoc-refheadstyle.lua`` sets a custom style for the reference section
header, that is, if the metadata field ``reference-section-title`` has been
set to a non-empty value.

By default, the reference section header will be assigned the custom style
'Bibliography Heading'. But you can assign another style by setting the metadata
field ``reference-header-style`` to the name of a style of your choice.
If the style does not exist, it will be created.

``pandoc-refheadstyle.lua`` identifies the reference section header as the
first element, starting from the end of the document, that meets all of
the following four criteria:

    1. It's one of the last five top-level elements of the document.
    2. It's a level-one header.
    3. It has the ID 'bibliography'.
    4. It's header text is the one set in ``reference-section-title``.

A reference section header that was inserted by ``pandoc-citeproc``
will meet all of those criteria.


LICENSE
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


FURTHER INFORMATION
===================

<https://github.com/odkr/pandoc-refheadstyle.lua>


SEE ALSO
========

pandoc(1), pandoc-citeproc(1)
