# Dbmgr

`dbmgr` is a command line tool for backing up and restoring development databases. I created this
because my inexperience led me to run `docker-compose down` on our MySQL image causing me to
_unexpectedly_ lose my development database. Since that day, I've found `dbmgr` to be very useful
in:
- Sharing databases between developers on our team
- Provisioning new developers with a working database

## Installation

```
$ gem install dbmgr
```

## Usage

#### Backup
```
dbmgr mysql backup --options
```

#### Restore
```
dbmgr mysql restore --options
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test`
to run the tests. You can also run `bin/console` for an interactive prompt that will allow you
to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new
version, update the version number in `version.rb`, and then run `bundle exec rake release`, which
will create a git tag for the version, push git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/callahanrts/dbmgr.
This project is intended to be a safe, welcoming space for collaboration, and contributors are
expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

