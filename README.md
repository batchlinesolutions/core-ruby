# BatchlineSolutions

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add bls-core

If bundler is not being used to manage dependencies, install the gem by
executing:

    $ gem install bls-core

## Getting Started

### Setup Work

```
require "bls/core"

Bls::Core.configure do |config|
  config.client_id = "XXXXXX"
  config.client_secret = "YYYYYY"
  config.environment = "preview"
end
```

### Usage

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and the created tag, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Testing

For `rspec`, add the following line to your `spec/rails_helper.rb` or
`spec/spec_helper` if `rails_helper` does not exist:

```
require "bls/core/rspec"
```

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/[USERNAME]/core-ruby. This project is intended
to be a safe, welcoming space for collaboration, and contributors are expected
to adhere to the [code of conduct](https://github.com/[USERNAME]/core-ruby/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the BatchlineSolutions project's codebases, issue
trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/core-ruby/blob/main/CODE_OF_CONDUCT.md).
