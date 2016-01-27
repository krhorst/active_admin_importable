module ActiveAdminImportable
  module DSL
    def active_admin_importable(options = {}, &block)
      action_item :only => :index, :if => options[:if] do
        link_to "Import #{active_admin_config.resource_name.to_s.pluralize}", :action => 'upload_spreadsheet'
      end

      collection_action :upload_spreadsheet, :if => options[:if] do
        render "admin/csv/upload_spreadsheet"
      end

      collection_action :import_spreadsheet, :method => :post, :if => options[:if] do
        CsvDb.convert_save(active_admin_config.resource_class, params[:dump][:file], &block)
        redirect_to :action => :index, :notice => "#{active_admin_config.resource_name.to_s} imported successfully!"
      end
    end
  end
end
