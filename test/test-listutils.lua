#!/usr/bin/env lua
local t = require 'tapered'

package.path = '../src/?.lua;' .. package.path
local lu = require 'listutils'

local base = {1,2,3,4,5,6,7,8,9,10}
local each = {}
local ins = function (x)
  each[#each + 1] = x
end
lu.foreach(ins, base)
t.same(base, each, 'foreach produces a new list based on param list')

local letters = {'a', 'b', 'c'}
each = {}
local letnum = function(let, num)
  each[#each + 1] = let .. tostring(num)
end
lu.foreach_withindex(letnum, letters)
t.same({'a1', 'b2', 'c3'}, each,
       'foreach_withindex produces a new list based on param list')

local square = function (x) return x*x end
t.same(lu.map(square, base), {1, 4, 9, 16, 25, 36, 49, 64, 81, 100},
       'map returns a set of squared items from a list')
t.same(lu.map(square, {}), {}, 'map an empty list returns an empty list')

local squareifeven = function (x)
  if x % 2 == 0 then
    return x*x
  end
end
t.same(lu.map(squareifeven, base), {4, 16, 36, 64, 100},
       'map should *not* lead to a sparse array even if used like filter')

local add = function (x, y) return x+y end
local sub = function (x, y) return x-y end
t.is(lu.foldl(add, 0, base), 55, 'foldl(add, 0, {1..10}) is 55')
t.is(lu.reduce(add, 0, base), 55, 'reduce(add, 0, {1..10}) is 55')
t.is(lu.foldr(add, 0, base), 55, 'foldr(add, 0, {1..10}) is 55')
t.is(lu.foldr(sub, 55, base), 0, 'foldr(sub, 55, {1..10}) is 0')
t.is(lu.foldl(sub, 0, {}), 0, 'foldl with an empty list returns accumulator')
t.is(lu.foldr(sub, 0, {}), 0, 'foldr with an empty list returns accumulator')
t.is(lu.reduce(sub, 0, {}), 0, 'reduce with an empty list returns accumulator')

local oddp = function (x) return x % 2 ~= 0 end
local evenp = function (x) return x % 2 == 0 end
t.same(lu.filter(oddp, base), {1,3,5,7,9},
       'filter(oddp, {1..10}) is {1,3,5,7,9}')
t.same(lu.filter(evenp, base), {2,4,6,8,10},
       'filter(evenp, {1..10}) is {2,4,6,8,10}')
t.same(lu.filter(evenp, {}), {}, 'filter an empty list returns empty list')
local odds, evens = lu.partition(oddp, base)
t.same({odds, evens}, {{1,3,5,7,9}, {2,4,6,8,10}},
       'partition(oddp, {1..10}) returns {1,3,5,7,9}, {2,4,6,8,10}')
t.same({lu.partition(oddp, {})}, {{}, {}},
       'partition an empty list returns two empty lists')

t.is(lu.all(oddp, odds), true, 'all(oddp, odds) returns true')
t.is(lu.all(oddp, {1,3,5,6}), false, 'all(oddp, {1,3,5,6}) returns false')
t.is(lu.all(evenp, evens), true, 'all(evenp, evens) returns true')
t.is(lu.all(evenp, {2,4,6,7}), false, 'all(evenp, {2,4,6,7}) returns false')
t.ok(lu.all(evenp, {}), 'all on an empty list returns true')

t.is(lu.any(oddp, odds), true, 'any(oddp, odds) returns true')
t.is(lu.any(oddp, evens), false, 'any(oddp, evens) returns false')
t.is(lu.any(evenp, evens), true, 'any(evenp, evens) returns true')
t.is(lu.any(evenp, odds), false, 'any(evenp, odds) returns false')
t.nok(lu.any(evenp, {}), 'any on an empty list returns false')

t.is(lu.member(1, odds), true, 'member(1, odds) returns true')
t.is(lu.member(1, evens), false, 'member(1, evens) returns false')
t.nok(lu.member(1, {}), 'member on an empty list is always false')

local z = lu.zip({1, 2, 3}, {'a', 'b', 'c'})
local y = {{1, 'a'}, {2, 'b'}, {3, 'c'}}
t.same(z, y,
       "zip({1,2,3}, {'a','b','c'}) returns {{1,'a'}, {2,'b'}, {3,'c'}}")

z = lu.zip({1, 2, 3, 4}, {'a', 'b'})
y = {{1, 'a'}, {2, 'b'}}
t.same(z, y, "zip({1,2,3,4}, {'a','b'}) returns {{1,'a'}, {2,'b'}}")
z = lu.zip({}, {})
t.same(z, {}, 'zip on two empty lists returns an empty list')

t.same(lu.stitch({'a', 'b', 'c'}, {'ey', 'bee', 'cee'}),
       {a = 'ey', b = 'bee', c = 'cee'},
       'stitch returns a hash of two list parameters')
t.same(lu.stitch({'a', 'b', 'c', 'd', 'e'}, {'ey', 'bee'}),
       {a = 'ey', b = 'bee'},
       'stitch ignores items past the length of either table')
t.same(lu.stitch({}, {}), {}, 'stitch on two empty lists returns an empty list')

base = {5, 4, 3, 2, 1, 10, 9, 8, 7, 6}
t.is(lu.max(base), 10, 'max finds largest element in a list')
t.is(lu.max({}), nil, 'max on an empty list returns nil')
t.is(lu.min(base), 1, 'min finds smallest element in a list')
t.is(lu.min({}), nil, 'min on an empty list returns nil')

t.is(lu.sum(base), 55, 'sum adds a list of numbers')
t.is(lu.sum({}), 0, 'sum on an empty list returns 0')
t.is(lu.product(base), 3628800, 'product multiplies a list of numbers')
t.is(lu.product({}), 1, 'product on an empty list return 1')

t.done()
