module ActiveAdminImportable
  module DSL
    def active_admin_importable(options = {}, &block)

      action_item :edit, :only => :index do
        link_to "Import #{active_admin_config.resource_name.to_s.pluralize}", :action => 'upload_csv'
      end

      collection_action :upload_csv do
        render "admin/csv/upload_csv"
      end

      collection_action :import_csv, :method => :post do
        role = resources_configuration[:self][:role]
        CsvDb.convert_save(active_admin_config.resource_class, params[:dump][:file], options.merge(:role=>role), &block)
        flash[:notice] = "#{active_admin_config.resource_name.to_s} imported successfully!"
        redirect_to :action => :index
      end
    end
  end
end