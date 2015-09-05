# ActiveAdminImportable

CSV imports for Active Admin with one line of code.

## Installation

Add this line to your application's Gemfile:

    gem 'active_admin_importable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_admin_importable

## Usage

Add the following line into your active admin resource:


   active_admin_importable

The Import button should now appear. Click it and upload a CSV file with a header row corresponding to your model attributes. Press submit. Profit.

## Custom Import Behavior

Need to do something special with the import? active_admin_importable accepts an optional block that will be called on each row, replacing the default functionality ( calling create! on the associated model). The associated model and a hash of the current row will get passed into the block. For example:

```
ActiveAdmin.register Product do
   active_admin_importable do |model, hash|
      store = Store.find_by_name(hash[:store_name])
      hash[:store_id] = store.id
      hash.delete(:store_name)
      model.create!(hash)
   end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
