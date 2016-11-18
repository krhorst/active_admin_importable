module ActiveAdminImportable
  module DSL
    def active_admin_importable(options={}, &block)
      action_item :only => :index do
        link_name = options[:name] || "Import #{active_admin_config.resource_name.to_s.pluralize}"
        link_to link_name, :action => 'upload_csv'
      end

      collection_action :upload_csv do
        render 'admin/csv/upload_csv'
      end

      collection_action :import_csv, :method => :post do
        ActiveRecord::Base.transaction do
          CsvDb.convert_save(active_admin_config.resource_class, params[:dump][:file], &block)
        end
        redirect_to :action => :index, :notice => "#{active_admin_config.resource_name.to_s} imported successfully!"
      end
    end
  end
end
