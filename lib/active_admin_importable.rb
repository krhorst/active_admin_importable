require "active_admin_importable/version"
require 'active_admin_importable/engine'
require 'active_admin_importable/dsl'

::ActiveAdmin::DSL.send(:include, ActiveAdminImportable::DSL)

