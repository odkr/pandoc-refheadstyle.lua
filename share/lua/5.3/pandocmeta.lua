#!/usr/local/bin/lua
--- Converts Pandoc metadata types to a multidimensional table.
--
-- @usage
--      pandocmeta = require 'pandocmeta'
--
--      function Meta (meta)
--          local table = pandocmeta.totable(meta)
--      end
--
--
-- @module pandocmeta
-- @release 0.4-0
-- @author Odin Kroeger
-- @copyright 2018 Odin Kroeger
-- @license MIT

-- Boilerplate
-- ===========

local io = io
local package = package

local pairs = pairs
local print = print
local tostring = tostring
local type = type

local P = {}
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
                            elseif type(word.c) == 'table' then
                                for _, v in pairs(word.c) do
                                     string = string .. v
                                end
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
    -- Takes metadata of Pandoc document, i.e., a `pandoc.MetaBlocks`,
    -- `pandoc.MetaInlines`, `pandoc.MetaMap`, or `pandoc.MetaList` and
    -- converts it to a, possibly multi-dimensional, table, where each
    -- value is either a string or a boolean.
    --
    -- Caveats:
    --  Does not convert numbers to intenger
    --  (there's no way to be sure that this is what you want).
    --
    -- @param meta A Pandoc metadata block
    --  (as `pandoc.Meta` or any of the above).
    --
    -- @treturn table The given metadata.
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
