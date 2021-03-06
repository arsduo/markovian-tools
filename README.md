[![Code Climate](https://codeclimate.com/github/arsduo/markovian-tools/badges/gpa.svg)](https://codeclimate.com/github/arsduo/markovian-tools)
[![Test Coverage](https://codeclimate.com/github/arsduo/markovian-tools/badges/coverage.svg)](https://codeclimate.com/github/arsduo/markovian-tools/coverage)
[![Build Status](https://travis-ci.org/arsduo/markovian-tools.svg)](https://travis-ci.org/arsduo/markovian-tools)

# Markovian::Tools

A set of tools for using the Markovian Markov chain library.

Details to come!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'markovian-tools'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install markovian-tools

## Usage

Fuller documentation will come shortly. For now, let's see how we can use Markovian to build some tweets from a Twitter archive we've downloaded:

```ruby
> path = #{path_to_twitter_archive}
 => path_to_twitter_archive
# Note: the Twitter namespace is called Tweeter to avoid conflicts with the Twitter gem.
> importer = Markovian::Tools::Importers::Tweeter::CsvImporter.new(path)
 => #<Markovian::Importers::Twitter::CsvImporter:0x007fd0ca3282a8 @path=path_to_twitter_archive>
# now assemble the chain of tweets -- this may take a few seconds to compile
> chain = importer.chain
 => #<Markovian::Chain:0x007fd0ca03df70 ...>
# Now, we can build some text!
> Markovian::TextBuilder.new(chain).construct("markov")
=> "markov chains a lot better than a month, i've been here half an hour of night when you can get behind belgium for the offline train journey"
```

Exactly!

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/arsduo/markovian-tools. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

