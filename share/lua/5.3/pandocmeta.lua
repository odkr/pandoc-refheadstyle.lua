#!/usr/local/bin/lua
--- Converts Pandoc metadata types to a multidimensional table.
--
-- @release 0.2-1
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


-- Boilerplate
-- ===========

local io = io
local package = package

local P = {['pairs'] = pairs, ['print'] = print,
    ['tostring'] = tostring, ['type'] = type,}

if _REQUIREDNAME == nil then
    pandocmeta = P
else
    _G[_REQUIREDNAME] = P
end

local _ENV = P


-- Function
-- ========

do
    local newline = (function()
        if package.config:sub(1,1) == '\\\\' then
            return '\r\n'
        else
            return '\n'
        end
    end)()

    local handlers = {
        ['MetaList'] = 'R',
        ['MetaMap'] = 'R',
        ['MetaBlocks'] = function(blocks)
                local string = ''
                for i, para in pairs(blocks) do
                    if i > 1 then string = string .. newline end
                    for _, word in pairs(para.c) do
                        if type(word) == 'table' then
                            if word.c == nil then
                                string = string .. ' '
                            else
                                string = string .. word.c
                            end
                        else
                            string = string .. tostring(word)
                        end
                    end
                end
                return string
            end,
        ['MetaInlines'] = function(inlines)
                local string = ''
                for _, v in pairs(inlines) do
                    if v.t == 'Str' and v.c ~= nil then
                        string = string .. v.c
                    elseif v.t == 'Space' then
                        string = string .. ' '
                    end
                end
                return string
            end
    }

    local types = {
        ['boolean'] = 'U',
        ['string'] = 'U',
        ['table'] = function(v)
                local handler = handlers[v.t]
                if handler == 'R' then
                    return totable(v)
                elseif handler ~= nil then
                    return handler(v)
                else
                    io.stderr:write(tostring(v.t) ..
                        ': unknown metadata type.\n')
                end
            end
    }

    --- Converts Pandoc metadata types to a multidimensional table.
    --
    -- Takes metadata of Pandoc document, i.e., a MetaBlocks, a MetaInlines,
    -- a MetaMap, or a MetaList and converts it to a, possibly multi-
    -- dimensional, table, where each value is either a string or a boolean.
    --
    -- Caveats:
    --  Does *not* support MetaString and MetaBool
    --  (but that doesn't appear to be necessary).
    --  Does not convert numbers to intenger
    --  (there's no way to be sure that this is what you want).
    --
    -- @param meta A Pandoc metadata block
    --             (as Pandoc.Meta or any of the above).
    --
    -- @return The given metadata as a table.
    function totable (meta)
        if meta == nil then return end
        local tab = {}
        for k, v in pairs(meta) do
            local handler = types[type(v)]
            if handler == 'U' then
                tab[k] = v
            elseif handler ~= nil then
                tab[k] = handler(v)
            else
                io.stderr:write(tostring(v.t) ..
                    ': unknown metadata type.\n')
            end
        end
        return tab
    end
end

return P
