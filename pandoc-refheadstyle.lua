#!/usr/local/bin/lua
--- Sets the style of the reference section header.
--
-- @release 0.1.1
-- @author Odin Kroeger
-- @copyright 2018 Odin Kroeger
--
-- @see main For details.
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

-- The style to use for the reference header
-- if ``reference-header-style`` isn't set or empty.
REFHEADSTYLE = 'Bibliography Heading'

-- Where to start looking for the reference section header (from the end).
LASTNELEMS = 5


__STRICT = true


--- Converts a Pandoc.MetaInline value to a string.
--
-- @param meta A Pandoc.MetaInline value.
--
-- @return The text contained in that object as string.
function metatostr (meta)
    local string = ''
    for _, v in ipairs(meta) do
        if v.t == 'Str' and v.c ~= nil then
            string = string .. v.c
        elseif v.t == 'Space' then
            string = string .. ' '
        else
            string = string .. metatostr(v)
        end
    end
    return string
end


--- Returns simple metadata fields.
--
-- @param doc A Pandoc document (as Pandoc.Pandoc).
--
-- @return Metadata fields (as table).
function get_meta (doc)
    local meta = {}
    for k, v in pairs(doc.meta) do
        if v and v.t == 'MetaInlines' then
            meta[k] = metatostr(v)
        end
    end
    return meta
end


--- Sets the style of the reference section header.
--
-- Takes a document and if and only if a reference section title has been set
-- via the ``reference-section-title`` metadata field, sets the style of that
-- header to the one set in the metadata field ``reference-header-style``.
-- If that field has not been set or is empty, sets it the the value of the
-- global variable REFHEADSTYLE.
--
-- Assumes that the reference section header:
--  * is one of the last N elements of the document,
--    where N is the value of the global variable LASTNELEMS;
--  * is a top-level header;
--  * has the ID 'bibliography';
--  * and has the text that has been set in ``reference-section-title``.
--
-- @param doc A Pandoc document (as Pandoc.Pandoc)
--
-- @return nil If ``reference-section-title`` has not been set or is empty,
--             or if no reference header could be found.
-- @return A Pandoc document, with the style of the reference header set
--         (as Pandoc.Pandoc)
function main (doc)
    local meta = get_meta(doc)
    local title = meta['reference-section-title']
    local style = meta['reference-header-style'] or REFHEADSTYLE
    if not title then return end
    local last = #doc.blocks
    local stop = math.max(last - LASTNELEMS, 1)
    for i = last, stop, -1 do
        local element = doc.blocks[i]
        if element.t == 'Header' and element.c[1] == 1 then
            local id, classes, attributes = table.unpack(element.c[2])
            local paragraph = element.c[3]
            if id == 'bibliography' and
               pandoc.utils.stringify(paragraph) == title
            then
                doc.blocks[i] = pandoc.Div(pandoc.Para(pandoc.Str(title)),
                    pandoc.Attr(id, classes, {['custom-style']=style}))
                return doc
            end
        end
    end
end

return {{Pandoc = main}}
