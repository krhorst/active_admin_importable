module ActiveAdminImportable
  module DSL
    def active_admin_importable(&block)
      action_item :only => :index do
        link_to "Import #{active_admin_config.resource_name.to_s.pluralize}", :action => 'upload_csv'
      end

      collection_action :upload_csv do
        @page_title="Upload CSV"
        render "admin/csv/upload_csv"
      end

      collection_action :import_csv, :method => :post do
        result = CsvDb.convert_save(active_admin_config.resource_class, params[:dump][:file], &block)
        if result.class == TrueClass
          flash[:notice] = "CSV uploaded successfully!"
          redirect_to :action => :index
        else
          flash[:error] = (result.class == ActiveModel::Errors ? result.full_messages.join("; ") : "The upload failed.")
          render 'admin/csv/upload_csv'
        end
      end
    end
  end
end