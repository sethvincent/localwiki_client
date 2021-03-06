LocalwikiClient
===============
[![Build Status](https://travis-ci.org/codeforseattle/localwiki_client.png?branch=master)](https://travis-ci.org/codeforseattle/localwiki_client) [![Code Climate](https://codeclimate.com/github/codeforseattle/localwiki_client.png)](https://codeclimate.com/github/codeforseattle/localwiki_client)

Synopsis
--------

A helper client for the Localwiki API

http://localwiki.readthedocs.org/en/latest/api.html

Installation
------------

    $ gem install localwiki_client

Usage
-----

## Example

    require 'localwiki_client'

    # read access
    wiki = LocalwikiClient.new 'seattlewiki.net'
    wiki.site.name
    => SeattleWiki
    wiki.count(:user)
    => 47
    map = wiki.fetch(:map, 'Luna Park Cafe')
    => #<Localwiki::Map>
    map.page
    => '/api/page/Luna_Park_Cafe'
    map.single_point?
    => true
    [map.lat, map.long]
    => [47.570641, -122.370919]

    # write access
    wiki = LocalwikiClient.new 'seattlewiki.net', 'myusername', 'myapikey'
    json = {name: 'Current Events', content: 'Coming Soon!'}.to_json
    response = wiki.create(:page, json)
    response.status
    => 201

More examples scripts can be found in the [examples folder](https://github.com/codeforseattle/localwiki_client/tree/master/examples).

Features / Problems
-------------------

* \#create, #read (#fetch), #update, #delete provide basic CRUD functionality
* \#list fetches all (or with a limit) of a specific type of resource
* \#fetch_version retrieves version history for a resource
* a few helper methods exist, more to come
* \#count, #page_by_name, #unique_authors


Compatibility & Quality
-----------------------

Continuous Integration using [Travis-CI](https://travis-ci.org/codeforseattle/localwiki_client). Supported Rubies:

 * 2.0.0
 * 1.9.3
 * jruby-19mode
 * rbx-19mode

Coverage using SimpleCov is about 100%. Run with:

    rake coverage

Static Analysis using [Code Climate](https://codeclimate.com/github/codeforseattle/localwiki_client)


Contributing
------------

* To get your improvements included, please fork and submit a pull request.
* Bugs and/or failing tests are very appreciated.
* See [Contributing to localwiki_client gem](https://github.com/codeforseattle/localwiki_client/wiki/Contributing-to-localwiki_client-gem) for additional details.

Contributors
------------
* Seth Vincent
* Brandon Faloona
* Helen Canzler
* Jerry Frost
* Matt Adkins

LICENSE
-------

(The MIT License)

Copyright (c) 2013 Brandon Faloona, Seth Vincent

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
