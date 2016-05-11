# tableutils [![Build Status](https://drone.io/bitbucket.org/telemachus/tableutils/status.png)](https://drone.io/bitbucket.org/telemachus/tableutils/latest) [![codecov.io](http://codecov.io/bitbucket/telemachus/tableutils/coverage.svg?branch=master)](http://codecov.io/bitbucket/telemachus/tableutils?branch=master)

Convenience methods for processing and testing tables. One set of utility
methods for list-like tables and another for hash-like tables.

In all methods below, the term 'list' or 'hash' refers to a Lua table. Lua
tables can be list-like, ordered by integers, or hash-like, unordered
collections of key-value pairs.[^1] They can also be a combination of both
types at once. However, the methods here are designed only for pure list- or
hash-like tables. Also, all list-like tables are assumed to start at 1, which
is the norm in Lua.

## listutils

Unless otherwise specified, all listutils functions process lists in the order
`list[1]` to `list[#list]`. To access these methods, use `require 'listutils'`.

+ `foreach(func, list)`

	Applies a function to every item in a list. No return value.

+ `foreach_withindex(func, list)`

	Like `foreach` except that the inner function receives two arguments:
	an item from the list and the items's index, in that order. No return
	value.

+ `map(func, list)`

	Returns a new list containing the result of applying a function to
	every item in a list.

+ `foldl(func, accumulator, list)`

	Returns a single value produced by repeatedly applying a function to
	the items in a list. The function receives two arguments and should
	return a single value. The initial arguments are `accumulator` and
	`list[1]`.  The return value of each function call becomes the first of
	the two values for subsequent calls.

	`reduce` is provided as an alias for `foldl`.

+ `foldr(func, accumulator, list)`

	Returns a single value produced by repeatedly applying a function to
	the items in a list in the order `list[#list]` to `list[1]`. The
	function receives two arguments and should return a single result. The
	first two arguments are `accumulator` and `list[#last]`. The return
	value of each function call becomes the first of the two values for
	subsequent calls.

+ `filter(func, list)`

	Returns a new list containing all items from a list which return `true`
	for a function.

+ `partition(func, list)`

	Returns two new lists, the first containing all the items from a list
	that return `true` for a function and the second containing all the
	items that return `false`.

+ `all(func, list)`

	Returns `false` if any item in a list returns `false` for a function.
	Otherwise, returns `true`.

	Thus, `all` returns `true` if called on an empty list.

+ `any(func, list)`

	Returns `true` if any item in a list returns `true` for a function.
	Otherwise, returns `false`.

	Thus, `any` returns `false` if called on an empty list.

+ `member(element, list)`

	Returns `true` if any of the items in a list are equal to an element.
	Otherwise, returns `false`. `member` uses `==` to test for equality.

+ `zip(list1, list2)`

	Returns a new list composed of sublists of pairs of items formed by
	joining the first item in `list1` with the first item in `list2` and so
	on. If the two lists are of unequal length, the return value will only
	extend as far as the shorter of the two; extra values in either lists
	are ignored.

+ `stitch(list1, list2)`

	Returns a hash-like table using `list1` for keys and `list2` for
	values. If the two lists are of unequal length, the return value will
	only have as many pairs as the shorter of the two; extra values are
	ignored.

+ `max(list)`

	Returns the largest item in list. Items are compared using `>`, so for
	all intents and purposes, the function is only designed for numbers.
	Returns nil if given an empty list.

+ `min(list)`

	Returns the smallest item in list. Items are compared using `<`, so for
	all intents and purposes, the function is only designed for numbers.
	Returns nil if given an empty list.

+ `sum(list)`

	Returns a sum of the contents of a list. The method uses `+`, so the
	list should only contain numbers. Returns 0 if the list is empty.

+ `product(list)`

	Returns a product of the contents of a list. The method uses `*`, so
	the list should only contain numbers. Returns 1 if the list is empty.

## hashutils

To access these methods, use `require 'hashutils'`.

+ `foreach(func, hash)`

	Applies a function to the key, value pairs in a hash. The function
	receives two arguments each iteration: a key and a value, in that
	order.  No return value.
	

+ `map(func, hash)`

	Returns a table formed by applying a function to the key, value pairs
	in a hash. Unlike `map` in listutils, the function receives three
	arguments: a key, a value, and the table that `map` will eventually
	return. As a result this `map` is more flexible than the one in
	listutils. It can return a hash-like table, a list-like table, or
	a mixed table.

+ `reduce(func, accumulator, hash)`

	Returns a single value produced by repeatedly applying a function to
	the key, value pairs in a hash. The function receives three arguments
	and should return a single value. Each call to the function receives an
	accumulator, a key, and a value, in that order. The initial function
	call receives the original accumulator argument passed to `reduce`.
	Each subsequent call receives the result of the previous call as the
	current accumulator.

+ `filter(func, hash)`

	Returns a new hash containing all key, value pairs from a hash which
	return `true` for a function.

+ `partition(func, hash)`

	Returns two new hashes, the first containing all key, value pairs from
	a hash that return `true` for a function and the second containing all
	key, value pairs that return `false`.

+ `all(func, hash)`

	Returns `false` if any item in a hash returns `false` for a function.
	Otherwise, returns `true`.

	Thus, `all` returns `true` if called on an empty hash.

+ `any(func, hash)`

	Returns `true` if any item in a hash returns `true` for a function.
	Otherwise, returns `false`.

	Thus, `any` returns `false` if called on an empty hash.

+ `iskey(element, hash)`

	Returns `true` if any key in a hash is equal to an element. Otherwise,
	returns `false`. `iskey` uses `==` to test for equality.

+ `isval(element, hash)`

	Returns `true` if any value in a hash is equal to an element.
	Otherwise, returns `false`. `isval` uses `==` to test for equality.

+ `keys(hash)`

	Returns a list-like table containing the keys from a hash.

+ `values(hash)`

	Returns a list-like table containing the values from a hash.

## Varia

The module provides four informational functions that return strings. Both sub-modules export the same four functions.

+ `version() -- 2.0.0`

+ `author() -- Peter Aronoff`

+ `url() -- https://bitbucket.org/telemachus/tapered`

+ `license() -- BSD 3-Clause`

## Credits/See Also

I think I first got the idea for a utility library like this from
[Underscore.js][underscorejs]. But I also looked at [Penlight][penlight] and
Underscore for Lua. (There are two versions of Underscore for Lua, and both
appear to be unmaintained. The older one is [Marcus Irven's underscore.lua][mu],
and a more recent one is [JT Archie's underscore-lua][jtu]. Irven's version
hasn't been updated in six years, and it was never uploaded to LuaRocks.
Archie's was uploaded to LuaRocks, but it is explicitly deprecated in favor of
[Moses][m]. In any case, I was only aware of Irven's version when writing
tableutils. I only discovered Archie's version much later.) I also took some
ideas from Perl's built-in methods and those found in [List::Util][lu]. After
writing tableutils, I discovered [Moses][m], a "utility library for functional
programming in Lua".

[underscorejs]: http://underscorejs.org
[penlight]: https://github.com/stevedonovan/Penlight
[mu]: https://github.com/mirven/underscore.lua
[jtu]: https://github.com/jtarchie/underscore-lua
[lu]: http://perldoc.perl.org/List/Util.html
[m]: https://github.com/Yonaba/Moses

All mistakes are mine. See [version history][c] for release details.

[c]: /CHANGES.md

---

(c) 2013-2016 Peter Aronoff. BSD 3-Clause license; see [LICENSE.md][li] for
details.

[li]: /LICENSE.md

[^1]: This isn't quite true. The truth is that *all* Lua tables are unordered collections of key-value pairs. However, if the keys are consecutive integers, then it is easy enough to treat such a table as if it were ordered.
