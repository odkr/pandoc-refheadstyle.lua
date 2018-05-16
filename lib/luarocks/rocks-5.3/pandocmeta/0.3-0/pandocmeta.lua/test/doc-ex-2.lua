--- Tests the second example for a YAML header in the Pandoc documentation.
--
-- @author Odin Kroeger
-- @copyright 2018 Odin Kroeger
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

local package = package
local path_sep = package.config:sub(1, 1)
local script_dir = PANDOC_SCRIPT_FILE:match('(.-)[\\/][^\\/]-$') or '.'
local module_dir = table.concat({script_dir, '..', 'src', '?.lua'}, path_sep)
package.path = package.path .. ';' .. module_dir

local pandocmeta = require 'pandocmeta'

function Pandoc (doc)
    meta = pandocmeta.totable(doc.meta)
    assert(meta['title'] == 'The document title')
    assert(meta['author'][1]['name'] == 'Author One')
    assert(meta['author'][1]['affiliation'] == 'University of Somewhere')
    assert(meta['author'][2]['name'] == 'Author Two')
    assert(meta['author'][2]['affiliation'] == 'University of Nowhere')
end
