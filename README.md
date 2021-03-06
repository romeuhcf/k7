# K7

[![Build Status](https://travis-ci.org/romeuhcf/k7.svg?branch=master)](https://travis-ci.org/romeuhcf/k7)
[![Coverage Status](https://coveralls.io/repos/github/romeuhcf/k7/badge.svg?branch=master)](https://coveralls.io/github/romeuhcf/k7?branch=master)
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'k7', git: 'https://github.com/romeuhcf/k7.git'
```

And then execute:

    $ bundle

## Usage

Have an observer:
```
class MyObserver
  def on_request(request)
    # do something with request
  end

  def on_response(response, _request)
    # do something with response and related request
  end
end
```

Register it:
```
K7.register_observer(:request, MyObserver.new, :on_request)
K7.register_observer(:response, AnotherObserver.new, :on_response)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/romeuhcf/k7.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
