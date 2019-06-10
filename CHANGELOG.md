## Unreleased
[full changelog](http://github.com/sue445/pixela/compare/v1.3.1...master)

## v1.3.1
[full changelog](http://github.com/sue445/pixela/compare/v1.3.0...v1.3.1)

* Add `is_secret` and `publish_optional_data` to `create_graph` and `update_graph`
  * https://github.com/sue445/pixela/pull/57
  * https://github.com/a-know/Pixela/releases/tag/v1.12.0
  * https://github.com/a-know/Pixela/releases/tag/v1.11.0

## v1.3.0
[full changelog](http://github.com/sue445/pixela/compare/v1.2.0...v1.3.0)

* Add `Pixela::Client#graphs_url`
  * https://github.com/sue445/pixela/pull/55
  * https://github.com/a-know/Pixela/releases/tag/v1.11.0
* Fixed doc link
  * https://github.com/sue445/pixela/pull/56

## v1.2.0
[full changelog](http://github.com/sue445/pixela/compare/v1.1.0...v1.2.0)

* Add `Pixela::Client#get_graph_stats` and `Pixela::Graph#stats`
  * https://github.com/sue445/pixela/pull/53
  * https://github.com/a-know/Pixela/releases/tag/v1.10.0

## v1.1.0
[full changelog](http://github.com/sue445/pixela/compare/v1.0.1...v1.1.0)

* Add `Pixela::Client#get_pixel_dates` and `Pixela::Graph#pixel_dates`
  * https://github.com/sue445/pixela/pull/49
  * https://github.com/a-know/Pixela/releases/tag/v1.8.0

## v1.0.1
[full changelog](http://github.com/sue445/pixela/compare/v1.0.0...v1.0.1)

### Features
* Add `self_sufficient` arg to `create_graph` and `update_graph`
  * https://github.com/sue445/pixela/pull/45
  * https://github.com/a-know/Pixela/releases/tag/v1.7.0

## v1.0.0
[full changelog](http://github.com/sue445/pixela/compare/v0.5.2...v1.0.0)

### :warning: Breaking changes :warning:
* Drop support ruby 2.2
  * https://github.com/sue445/pixela/pull/42

### Features
* Add `optional_data` to `create_pixel` and `update_pixel`
  * https://github.com/sue445/pixela/pull/43
  * https://github.com/a-know/Pixela/releases/tag/v1.6.0
* Returns parsed json instead of json string in `get_pixel`
  * https://github.com/sue445/pixela/pull/44
  
### Refactorings
* Refactor: `Pixela::Client#connection`
  * https://github.com/sue445/pixela/pull/37

## v0.5.2
[full changelog](http://github.com/sue445/pixela/compare/v0.5.1...v0.5.2)

* Add `timezone` to `create_graph` and `update_graph`
  * https://github.com/sue445/pixela/pull/34
  * https://github.com/a-know/Pixela/releases/tag/v1.4.0

## v0.5.1
[full changelog](http://github.com/sue445/pixela/compare/v0.5.0...v0.5.1)

* Arguments of `Pixela::Client#update_graph` and `Pixela::Graph#update` change to optional
  * https://github.com/sue445/pixela/pull/28
  * https://github.com/a-know/Pixela/releases/tag/v1.3.1
* Add `Pixela::Graph#delete`
  * https://github.com/sue445/pixela/pull/27
* Update API link
  * https://github.com/sue445/pixela/pull/26

## v0.5.0
[full changelog](http://github.com/sue445/pixela/compare/v0.4.0...v0.5.0)

* Add mode to graph_url
  * https://github.com/sue445/pixela/pull/25
  * https://github.com/a-know/Pixela/releases/tag/v1.3.0

## v0.4.0
[full changelog](http://github.com/sue445/pixela/compare/v0.3.0...v0.4.0)

* Support webhook API
  * https://github.com/sue445/pixela/issues/23
  * https://github.com/sue445/pixela/pull/24
  * https://github.com/a-know/Pixela/releases/tag/v1.2.0

## v0.3.0
[full changelog](http://github.com/sue445/pixela/compare/v0.2.0...v0.3.0)

* Support purgeCacheURLs
  * https://github.com/sue445/pixela/issues/20
  * https://github.com/sue445/pixela/pull/22
  * https://github.com/a-know/Pixela/releases/tag/v1.1.0

## v0.2.0
[full changelog](http://github.com/sue445/pixela/compare/v0.1.1...v0.2.0)

* Impl resource methods
  * https://github.com/sue445/pixela/pull/17

## v0.1.1
[full changelog](http://github.com/sue445/pixela/compare/v0.1.0...v0.1.1)

* Add default value to date args
  * https://github.com/sue445/pixela/pull/14

## v0.1.0
* first release
