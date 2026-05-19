# itamae-plugin-recipe-daddy

An [itamae](https://github.com/itamae-kitchen/itamae) recipe collection for setting up common server components.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itamae-plugin-recipe-daddy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install itamae-plugin-recipe-daddy

## Recipes

| Recipe | Description |
|--------|-------------|
| `daddy::mysql::server` | Install and start MySQL server (RHEL 7/8/9) |
| `daddy::mysql::client` | Install MySQL client and devel packages (RHEL 7/8/9) |
| `daddy::nginx::install` | Build nginx from source with RTMP module and Passenger |
| `daddy::bazel::install` | Install Bazel via yum repo |
| `daddy::memcached::install` | Install and start memcached |
| `daddy::redis::install` | Install and start Redis |
| `daddy::opencv::install` | Build and install OpenCV from source |
| `daddy::python::install` | Build and install Python 3 from source |
| `daddy::wkhtmltopdf::install` | Install wkhtmltopdf |

## Supported OS

- RHEL 7 / CentOS 7
- RHEL 8 / AlmaLinux 8
- RHEL 9 / AlmaLinux 9

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ichylinux/itamae-plugin-recipe-daddy.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
