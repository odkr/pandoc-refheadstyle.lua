---
title: PANDOC-REFHEADSTYLE.LUA(1)
author: Odin Kroeger
date: May 2, 2019
---

# NAME

pandoc-refheadstyle.lua - sets a custom style for the reference section


# SYNOPSIS

**pandoc** **--lua-filter** *pandoc-refheadstyle.lua*


# DESCRIPTION

**pandoc-refheadstyle.lua** sets a custom style for the reference section
header, but only if the metadata field `reference-section-title` has been
set to a non-empty value.

By default, the reference section header will be assigned the custom style
"Bibliography Heading". But you can assign another style by setting the
metadata field `reference-header-style` to the name of a style of your choice.
If the style does not exist, it will be created.

The reference section header is, by stipulation, the first header, starting
from the end of the document and ignoring the reference section itself, that
has the ID "bibliography" and the text of which is the one set in
`reference-section-title`. (Headers inserted by **pandoc-citeproc** meet
these criteria.)


# CAVEATS

**pandoc-refheadstyle.lua** starts looking for a reference header at the
end of document but changes direction whenever it descends the document's
abstract syntax tree. That is, it will prefer the first header within the
last top-level block to the last header within the last top-level block.


# SEE ALSO

pandoc(1), pandoc-citeproc(1)
