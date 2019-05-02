--- Sets the style of the reference section header.
--
-- @script pandoc-refheadstyle.lua
-- @release 0.2.8
-- @author Odin Kroeger
-- @copyright 2018 Odin Kroeger
-- @license MIT
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to
-- deal in the Software without restriction, including without limitation the
-- rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
-- sell copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
-- FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
-- IN THE SOFTWARE.

-- Constants
-- =========

-- Style to use if ``reference-header-style`` isn't set.
local REFHEADSTYLE = 'Bibliography Heading'


-- Shorthands
-- ==========

local stringify = pandoc.utils.stringify
local Attr      = pandoc.Attr
local Div       = pandoc.Div
local Para      = pandoc.Para
local Str       = pandoc.Str


-- Functions
-- =========

--- Sets the style of a header if it meets certain criteria.
--
-- Takes a header block and if and only if it has the id 'bibliography'
-- and the given title, set the given style as 'custom-style'.
--
-- @tparam Pandoc.Header header A header block
-- @tparam string title A title to match
-- @tparam string style The name of the style to assign.
--
-- @return A block element, with the given style set as
--  'custom-style' (as `Pandoc.Div`) or `nil` if the header
--  doesn't match the criteria.
function set_refheadstyle (header, title, style)
    local id, classes, attributes = table.unpack(header.c[2])
    if id == 'bibliography' and stringify(header.c[3]) == title then
        attributes['custom-style'] = style
        return Div(Para(Str(title)), Attr(id, classes, attributes))
    end
end


--- Sets the style of the reference section header.
--
-- Takes a document and if and only if a reference section title has been set
-- via the 'reference-section-title' metadata field, sets the style of that
-- header to the one set in the metadata field 'reference-header-style'.
-- If that field has not been set or is empty, sets it the the value of the
-- module constant `REFHEADSTYLE`.
--
-- Assumes that the reference section header:
--
-- 1. is of the type Header;
-- 2. has the ID 'bibliography';
-- 3. and has the text that has been set in 'reference-section-title'.
--
-- @tparam pandoc.Pandoc doc A Pandoc document.
-- @treturn pandoc.Pandoc A Pandoc document with the style of the reference 
--  header set if and only if one was found or `nil`.
function Pandoc (doc)
    local stringify = pandoc.utils.stringify
    local meta = doc.meta
    if not meta['reference-section-title'] then return end
    local title = stringify(meta['reference-section-title'])
    local style
    if not meta['reference-header-style'] then
        style = REFHEADSTYLE
    else
        style = stringify(meta['reference-header-style'])
    end
    local setter = function(header)
        return set_refheadstyle(header, title, style)
    end
    for i = #doc.blocks, 1, -1 do
        local element = doc.blocks[i]
        if element.t == 'Header' then
            local header = set_refheadstyle(element, title, style)
            if header ~= nil then
                doc.blocks[i] = header
                return doc
            end
        elseif not (element.t == 'Div' and element.c[1][1] == 'refs') then
            doc.blocks[i] = pandoc.walk_block(element, {Header = setter})
        end
    end
    return doc
end
