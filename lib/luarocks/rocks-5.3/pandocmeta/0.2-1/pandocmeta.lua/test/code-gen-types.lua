--- Tests whether code-generated types are recognised.
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
local script_dir = string.match(PANDOC_SCRIPT_FILE, '(.-)[\\/][^\\/]-$') or '.'
local module_dir = table.concat({script_dir, '..', 'src', '?.lua'}, path_sep)
package.path = package.path .. ';' .. module_dir

require 'pandocmeta'

function Pandoc()
    a_string = pandoc.MetaString('This is a string.')
    a_bool = pandoc.MetaBool(true)
    meta = pandoc.Meta({a_string=a_string, a_bool=a_bool})
    meta_t = pandocmeta.totable(meta)
    assert(meta_t['a_string'] == 'This is a string.')
    assert(meta_t['a_bool'] == true)
end
