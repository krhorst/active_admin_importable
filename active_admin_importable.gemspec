# -*- encoding: utf-8 -*-
require File.expand_path('../lib/active_admin_importable/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Kevin Horst"]
  gem.email         = ["krhorst@gmail.com"]
  gem.description   = "CSV import for Active Admin"
  gem.summary       = "Add CSV import to Active Admin resources with one line."
  gem.homepage      = "http://github.com/krhorst/active_admin_importable"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "active_admin_importable"
  gem.require_paths = ["lib"]
  gem.version       = ActiveAdminImportable::VERSION
end
