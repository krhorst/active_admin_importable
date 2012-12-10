# ActiveAdminImportable

CSV imports for Active Admin with one line of code.

## Installation

Add this line to your application's Gemfile:

    gem 'active_admin_importable', :git => "git://github.com/krhorst/active_admin_importable.git"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_admin_importable

## Usage

Add the following line into your active admin resource:

   active_admin_importable

The Import button should now appear. Click it and upload a CSV file with a header row corresponding to your model attributes. Press submit. Profit.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
