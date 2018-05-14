#!/usr/local/bin/lua
--- Sets the style of the reference section header.
--
-- @release 0.2.1
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

-- Constants
-- =========

-- Style to use if ``reference-header-style`` isn't set.
local REFHEADSTYLE = 'Bibliography Heading'


-- Boilerplate
-- ===========

local package = package

do
    local path_sep = package.config:sub(1, 1)
    local script_dir = PANDOC_SCRIPT_FILE:match('(.-)[\\/][^\\/]-$') or '.'
    local lua_vers = {}
    for _, v in ipairs({_VERSION:sub(5, 7), '5.3'}) do lua_vers[v] = true end
    for k in pairs(lua_vers) do
        package.path = package.path .. ';' .. 
            table.concat({script_dir, 'share', 'lua', k, '?.lua'}, path_sep)
        package.cpath = package.cpath .. ';' .. 
            table.concat({script_dir, 'lib', 'lua', k, '?.lua'}, path_sep)
    end
end

require 'pandocmeta'


-- Functions
-- =========

--- Sets the style of a header if it meets certain criteria.
--
-- Takes a header block and if and only if it has the id 'bibliography'
-- and the given title, set the given style as 'custom-style'.
--
-- @param header A header block (as Pandoc.Header)
-- @param title A title to match (as string)
-- @param style The style to assign of the above conditions are met.
--
-- @return nil If the given header doesn't match the criteria.
-- @return Otherwise, a block element,
--         with the given style set as 'custom-style' (as Pandoc.Div).
function set_refheadstyle (header, title, style)
    local id, classes, attributes = table.unpack(header.c[2])
    local content = header.c[3]
    if id == 'bibliography' and pandoc.utils.stringify(content) == title then
        attributes['custom-style'] = style
        return pandoc.Div(pandoc.Para(pandoc.Str(title)),
            pandoc.Attr(id, classes, attributes))
    end
end


--- Sets the style of the reference section header.
--
-- Takes a document and if and only if a reference section title has been set
-- via the ``reference-section-title`` metadata field, sets the style of that
-- header to the one set in the metadata field ``reference-header-style``.
-- If that field has not been set or is empty, sets it the the value of the
-- module constant REFHEADSTYLE.
--
-- Assumes that the reference section header:
-- (1) is of the type Header;
-- (2) has the ID 'bibliography';
-- (3) and has the text that has been set in ``reference-section-title``.
--
-- @param doc A Pandoc document (as Pandoc.Pandoc)
--
-- @return A Pandoc document (as Pandoc.Pandoc),
--         with the style of the reference header set --
--         if and only if a reference header was found.
-- @return nil If ``reference-section-title`` hasn't been set.
function Pandoc (doc)
    local meta = pandocmeta.totable(doc.meta)
    local title = meta['reference-section-title']
    local style = meta['reference-header-style'] or REFHEADSTYLE
    if not title then return end
    setter = function(header)
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
