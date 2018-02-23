# Soft Delete

> In a production app, you should probably never really delete anything.

[source](https://twitter.com/theebeastmaster/status/966870021099180034)

A soft-delete marks a record as deleted, and keeps it in the database
for historical reference.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "soft_delete-workbar", require: "soft_delete"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install soft_delete-workbar

## Usage

Safely "delete" records from your database without losing them permanently.

* Add SoftDelete to a model
  ```
  class MyModel < ActiveRecord::Base
    include SoftDelete
  end
  ```
* Add a `deleted_at` column to the model's database table
  ```
  rails g migration AddSoftDeleteToMyModels deleted_at:timestamp
  ```
* Safely call `MyModel#delete` without losing the record forever

## Methods

Please see the `SoftDelete` module and the associated tests for a description of
the methods that will be added to your model.

* `.not_deleted` - records without a deleted_at timestamp
* `.deleted` - records with a deleted_at timestamp
* `#delete` - set the deleted_at timestamp
* `#delete!` - delete the record from the database
* `#destroy` - set the deleted_at timestamp, and run callbacks
* `#destroy!` - delete the record from the database, and run callbacks
* `#restore` - set the deleted_at timestamp to nil

It will be necessary to exclude deleted records when querying the model.
Use the `not_deleted` scope that now exists on the model.

```ruby
class MyModelsController < ApplicationController
  def index
    @my_models = MyModel.not_deleted
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/workbar-dev/soft_delete.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).
