## Unreleased
[full changelog](http://github.com/sue445/pixela/compare/v3.6.0...master)

## [v3.6.0](https://github.com/sue445/pixela/releases/tag/v3.6.0)
[full changelog](http://github.com/sue445/pixela/compare/v3.5.1...v3.6.0)

* Add specific pixel methods
  * https://github.com/sue445/pixela/pull/140

## [v3.5.1](https://github.com/sue445/pixela/releases/tag/v3.5.1)
[full changelog](http://github.com/sue445/pixela/compare/v3.5.0...v3.5.1)

* Release gem from GitHub Actions
  * https://github.com/sue445/pixela/pull/122

## [v3.5.0](https://github.com/sue445/pixela/releases/tag/v3.5.0)
[full changelog](http://github.com/sue445/pixela/compare/v3.4.0...v3.5.0)

* Add `Pixela::Client::GraphMethods#get_graph_today` and `Pixela::Graph#today`
  * https://github.com/sue445/pixela/pull/117
  * https://github.com/a-know/Pixela/releases/tag/v1.32.0

## [v3.4.0](https://github.com/sue445/pixela/releases/tag/v3.4.0)
[full changelog](http://github.com/sue445/pixela/compare/v3.3.0...v3.4.0)

* Add `appearance`, `less_than` and `greather_than` to `Pixela::Client::GraphMethods#graph_url` and `Pixela::Graph#url`
  * https://github.com/sue445/pixela/pull/115
  * https://github.com/a-know/Pixela/releases/tag/v1.30.0

## v3.3.0
[full changelog](http://github.com/sue445/pixela/compare/v3.2.0...v3.3.0)

* Add `Pixela::Client::GraphMethods#get_graph_latest` and `Pixela::Graph#latest`
  * https://github.com/sue445/pixela/pull/110
  * https://github.com/a-know/Pixela/releases/tag/v1.29.0

## v3.2.0
[full changelog](http://github.com/sue445/pixela/compare/v3.1.0...v3.2.0)

* Add `Pixela::Client::PixelMethods#create_pixels` and `Pixela::Pixel#create_multi`
  * https://github.com/sue445/pixela/pull/105
  * https://github.com/a-know/Pixela/releases/tag/v1.28.0

## v3.1.0
[full changelog](http://github.com/sue445/pixela/compare/v3.0.0...v3.1.0)

* Add `Pixela::Client#add_pixel` and `Pixela::Client#subtract_pixel`
  * https://github.com/sue445/pixela/pull/101
  * https://github.com/a-know/Pixela/releases/tag/v1.26.0

## v3.0.0
[full changelog](http://github.com/sue445/pixela/compare/v2.2.1...v3.0.0)

* :bomb: **[BREAKING CHANGE]** Support faraday v2+ and drop support ruby < 2.6
  * https://github.com/sue445/pixela/pull/91

## v2.2.1
[full changelog](http://github.com/sue445/pixela/compare/v2.2.0...v2.2.1)

* Enable MFA requirement for gem releasing
  * https://github.com/sue445/pixela/pull/88

## v2.2.0
[full changelog](http://github.com/sue445/pixela/compare/v2.1.0...v2.2.0)

* Add `Pixela::Client#get_graph_def` and `Pixela::Graph#def`
  * https://github.com/sue445/pixela/pull/83
  * https://github.com/a-know/Pixela/releases/tag/v1.21.0
* Add `Pixela::Client#get_pixels` and `Pixela::Graph#pixels`
  * https://github.com/sue445/pixela/pull/84
  * https://github.com/a-know/Pixela/releases/tag/v1.21.0

## v2.1.0
[full changelog](http://github.com/sue445/pixela/compare/v2.0.0...v2.1.0)

* Add `Pixela::Client#update_profile`
  * https://github.com/sue445/pixela/pull/81
  * https://github.com/a-know/Pixela/releases/tag/v1.20.0

## v2.0.0
[full changelog](http://github.com/sue445/pixela/compare/v1.5.0...v2.0.0)

### :warning: Breaking changes :warning:
* Remove Channel and Notification
  * https://github.com/sue445/pixela/pull/75
  * https://github.com/a-know/Pixela/releases/tag/v1.19.0
* Drop support for faraday v0.x
  * https://github.com/sue445/pixela/pull/77
* Drop support for ruby 2.3
  * https://github.com/sue445/pixela/pull/78

## v1.5.0
[full changelog](http://github.com/sue445/pixela/compare/v1.4.2...v1.5.0)

* Add `Pixela::Client#run_stopwatch` and `Pixela::Graph#run_stopwatch`
  * https://github.com/sue445/pixela/pull/74
  * https://github.com/a-know/Pixela/releases/tag/v1.18.0

## v1.4.2
[full changelog](http://github.com/sue445/pixela/compare/v1.4.1...v1.4.2)

* Support `remind_by` of Notification
  * https://github.com/sue445/pixela/pull/72
  * https://github.com/a-know/Pixela/releases/tag/v1.17.0

## v1.4.1
[full changelog](http://github.com/sue445/pixela/compare/v1.4.0...v1.4.1)

* Support faraday v1.0
  * https://github.com/sue445/pixela/pull/63

## v1.4.0
[full changelog](http://github.com/sue445/pixela/compare/v1.3.1...v1.4.0)

* Support Channel and Notification API
  * https://github.com/sue445/pixela/pull/59
  * https://github.com/a-know/Pixela/releases/tag/v1.13.0

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
