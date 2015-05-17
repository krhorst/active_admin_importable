module ActiveAdminImportable
  module DSL
    def active_admin_importable(&block)
      action_item :only => :index do
        link_to "Import #{active_admin_config.resource_name.to_s.pluralize}", :action => 'upload_spreadsheet'
      end

      collection_action :upload_spreadsheet do
        render "admin/csv/upload_spreadsheet"
      end

      collection_action :import_spreadsheet, :method => :post do
        CsvDb.convert_save(active_admin_config.resource_class, params[:dump][:file], &block)
        redirect_to :action => :index, :notice => "#{active_admin_config.resource_name.to_s} imported successfully!"
      end
    end
  end
end