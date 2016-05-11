# tableutils version history

## *1.0.0-1* (July 29, 2015)

+ Initial public release

## *1.0.1-1* (December 5, 2015)

+ Test coverage stats are now thanks to [codecov][codecov].
+ Latest stable Lua in the 5.3 series is 5.3.2, so we test against that now.

[codecov]: https://codecov.io

## *2.0.0-1* (May 1, 2016)

+ The informational fields are now functions that return strings. This is to
  prevent them from violating Lua recommendations about variables such as
  `_VERSION`. (I've bumped the major version number since this is technically
  an API change, though for most users it will not require any changes on their
  end.)

## *2.0.0-2* (May 1, 2016)

+ The rockspec for 2.0.0-1 was pointing at the wrong tar.gz target.
+ I realized, just a tiny bit too late, that the internal `version` function
  should not track the rockspec variant. It has nothing to do with the code
  itself, which should be separate.

Would you rather view the [documentation][d]?

[d]: /README.md
---

(c) 2013-2016 Peter Aronoff. BSD 3-Clause license; see [LICENSE.md][l] for
details.

[l]: /LICENSE.md
