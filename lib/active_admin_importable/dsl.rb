module ActiveAdminImportable
  module DSL
    def active_admin_importable(view: 'admin/csv/upload_csv', &block)
      action_item :edit, :only => :index do
        link_to "Import #{active_admin_config.resource_name.to_s.pluralize}", :action => 'upload_csv'
      end

      collection_action :upload_csv do
        render view
      end

      collection_action :import_csv, :method => :post do
        CsvDb.convert_save(active_admin_config.resource_class, params[:dump][:file], self, &block)
        redirect_to collection_path, notice: "CSV imported successfully!"
      end
    end

    def define_import_for(name='records', **options, &block)
      options[:action] ||= "import_#{name}"
      options[:form_action] ||= "upload_#{name}"
      options[:view] ||= "admin/csv/upload"
      options[:encoding] ||= "utf-8"

      action_item :edit, :only => :index do
        link_to options[:action].titleize, :action => options[:form_action]
      end

      collection_action(options[:form_action]) do
        render options[:view], :locals => { :target_action => options[:action] }
      end

      collection_action(options[:action], :method => :post) do
        CsvDb.convert_save(active_admin_config.resource_class, params[:dump][:file], self, encoding: options[:encoding], &block)
        redirect_to collection_path, notice: "CSV imported successfully!"
      end
    end
  end
end
