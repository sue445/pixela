# Pixela

[Pixela](https://pixe.la/) API client for Ruby

[![Gem Version](https://badge.fury.io/rb/pixela.svg)](https://badge.fury.io/rb/pixela)
[![CI activity of pixela-gem](https://pixe.la/v1/users/sue445/graphs/pixela-gem-ci?mode=badge)](https://pixe.la/v1/users/sue445/graphs/pixela-gem-ci.html)
[![test](https://github.com/sue445/pixela/actions/workflows/test.yml/badge.svg)](https://github.com/sue445/pixela/actions/workflows/test.yml)
[![Maintainability](https://qlty.sh/gh/sue445/projects/pixela/maintainability.svg)](https://qlty.sh/gh/sue445/projects/pixela)
[![Coverage Status](https://coveralls.io/repos/github/sue445/pixela/badge.svg)](https://coveralls.io/github/sue445/pixela)

[![CI activity of pixela-gem](https://pixe.la/v1/users/sue445/graphs/pixela-gem-ci)](https://pixe.la/v1/users/sue445/graphs/pixela-gem-ci.html)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pixela'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pixela

## Usage

```ruby
require "pixela"

client = Pixela::Client.new(username: "YOUR_NAME", token: "YOUR_TOKEN")

# register
client.create_user(agree_terms_of_service: true, not_minor: true)

# create graph
client.create_graph(graph_id: "test-graph", name: "graph-name", unit: "commit", type: "int", color: "shibafu")

# register value
require "date" 
client.create_pixel(graph_id: "test-graph", date: Date.today, quantity: 5) 
```

or

```ruby
# create graph
client.graph("test-graph").create(name: "graph-name", unit: "commit", type: "int", color: "shibafu")

# register value
client.graph("test-graph").pixel(Date.today).create(quantity: 5)
```


All methods are followings

https://sue445.github.io/pixela/Pixela/Client

## Configuration
```ruby
Pixela.config.debug_logger = Logger.new(STDOUT)
```

* `debug_logger`: Enable debug logging if `Logger` is set

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sue445/pixela.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
