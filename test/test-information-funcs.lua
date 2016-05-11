#!/usr/bin/env lua
local t = require 'tapered'

package.path = '../src/?.lua;' .. package.path
local lu = require 'listutils'
local hu = require 'hashutils'

t.is(lu.author(), 'Peter Aronoff',
     "listutils author() should be 'Peter Aronoff'")
t.is(lu.version(), '2.0.0',
     "listutils version() should be '2.0.0'")
t.is(lu.license(), 'BSD 3-Clause',
     "listutils license() should be 'BSD 3-Clause'")
t.is(lu.url(), "https://bitbucket.org/telemachus/tableutils",
      "listutils url() should be 'https://bitbucket.org/telemachus/tableutils'")

t.is(hu.author(), 'Peter Aronoff',
     "hashutils author() should be 'Peter Aronoff'")
t.is(hu.version(), '2.0.0',
     "hashutils version() should be '2.0.0'")
t.is(hu.license(), 'BSD 3-Clause',
     "hashutils license() should be 'BSD 3-Clause'")
t.is(hu.url(), "https://bitbucket.org/telemachus/tableutils",
     "hashutils url() should be 'https://bitbucket.org/telemachus/tableutils'")

t.done()
