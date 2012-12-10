require 'active_admin_importable'
require 'rails'

module ActiveAdminImportable
  class Engine < Rails::Engine

    config.mount_at = '/'

  end
end