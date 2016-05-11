#!/usr/bin/env lua
local t = require 'tapered'

package.path = '../src/?.lua;' .. package.path
local lu = require 'hashutils'

local sort = table.sort

local base = {a = 1, b = 2, c = 3, d = 4, e = 5, f = 6,}
local each = {}
local function ins(k, v)
  each[k] = v
end

lu.foreach(ins, base)
t.same(base, each, 'foreach produces a new hash based on param hash')

local function square_val(k, v, mapped) mapped[k] = v*v end
local function concat_key(k, v, mapped) mapped[k .. k] = v end
local vals = function(k, v, mapped) mapped[#mapped + 1] = v end
t.same(lu.map(square_val, base), {a = 1, b = 4, c = 9, d = 16, e = 25, f = 36,},
       'map can square a set of hash values')
t.same(lu.map(concat_key, base),
       {aa = 1, bb = 2, cc = 3, dd = 4, ee = 5, ff = 6,},
       'map can concatenate a set of hash keys')
local val_res = lu.map(vals, base)
sort(val_res)
t.same(val_res, {1,2,3,4,5,6}, 'map can extract the values from a hash')
t.same(lu.map(square_val, {}), {}, 'map an empty hash returns an empty hash')

local function add(acc, _, v) return acc + v end

t.is(lu.reduce(add, 0, base), 21, 'reduce(add, 0, vals of 1..6) is 21')
t.is(lu.reduce(add, 0, {}), 0, 'reduce with an empty hash returns accumulator')

local function isodd(_, v) return v % 2 ~= 0 end
local function iseven(_, v) return v % 2 == 0 end

t.same(lu.filter(isodd, base), {a = 1, c = 3, e = 5},
       'filter(isodd, {a = 1 .. f = 6}) is {a = 1, c = 3, e = 5}')
t.same(lu.filter(iseven, base), {b = 2, d = 4, f = 6},
       'filter(iseven, {a = 1 .. f = 6}) is {b = 2, d = 4, f = 6}')
t.same(lu.filter(iseven, {}), {}, 'filter an empty hash returns empty hash')

local odds, evens = lu.partition(isodd, base)
t.same({odds, evens}, {{a = 1, c = 3, e = 5}, {b = 2, d = 4, f = 6}},
       'partition(isodd, {a = 1 .. f = 6}) returns correct hashes')
t.same({lu.partition(isodd, {})}, {{}, {}},
       'partition an empty hash returns two empty hashes')

t.ok(lu.all(isodd, odds), 'all(isodd, odds) returns true')
t.nok(lu.all(isodd, {a = 1, b = 3, c = 6}),
     'all(isodd, {a = 1, b = 3, c = 6}) returns false')
t.ok(lu.all(iseven, evens), 'all(iseven, evens) returns true')
t.nok(lu.all(iseven, {a = 1, b = 3, c = 6}),
     'all(iseven, {a = 1, b = 3, c = 6}) returns false')
t.ok(lu.all(iseven, {}), 'all on an empty hash returns true')

local isoddsafe = function(v)
  if type(v) == 'number' then
    return v % 2 ~= 0
  end
end

local isevensafe = function(v)
  if type(v) == 'number' then
    return v % 2 == 0
  end
end

t.ok(lu.any(isoddsafe, odds), 'any(isodd, odds) returns true')
t.nok(lu.any(isoddsafe, evens), 'any(isodd, evens) returns false')
t.ok(lu.any(isevensafe, evens), 'any(iseven, evens) returns true')
t.nok(lu.any(isevensafe, odds), 'any(iseven, odds) returns false')
t.nok(lu.any(isevensafe, {}), 'any on an empty hash returns false')

t.ok(lu.isval(1, {b = 2, a = 1}), 'isval(1,{b=2, a=1}) returns true')
t.nok(lu.isval(4, {b = 2, a = 1}), 'isval(4,{b=2, a=1}) returns false')
t.ok(lu.iskey('b', {b = 2, a = 1}), "iskey('b',{b=2, a=1}) returns true")
t.nok(lu.iskey('f', {b = 2, a = 1}), "iskey('f',{b=2, a=1}) returns false")
t.nok(lu.isval(1, {}), 'isval on an empty hash is always false')
t.nok(lu.iskey(1, {}), 'iskey on an empty hash is always false')

local keys = lu.keys({a = 1, b = 2, c = 3})
local vals = lu.values({a = 1, b = 2, c = 3})
sort(keys); sort(vals)
t.same(keys, {'a', 'b', 'c'},
       "keys({a = 1, b = 2, c = 3}) returns {'a', 'b', 'c'}")
t.same(vals, {1, 2, 3}, 'values({a = 1, b = 2, c = 3}) returns {1, 2, 3}')

t.done()
