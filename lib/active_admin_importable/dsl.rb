module ActiveAdminImportable
  module DSL
    def active_admin_importable(args = {}, &block)
      action_item :edit, :only => :index do
        args[:title] ||= active_admin_config.resource_name.to_s.pluralize
        link_to "Import #{args[:title]}", :action => 'upload_csv'
      end

      collection_action :upload_csv do
        render "admin/csv/upload_csv"
      end

      collection_action :import_csv, :method => :post do
        args[:title] ||= active_admin_config.resource_name.to_s.pluralize
        CsvDb.convert_save(active_admin_config.resource_class, params[:dump][:file], &block)
        redirect_to :action => :index, :notice => "#{args[:title]} imported successfully!"
      end
    end
  end
end
