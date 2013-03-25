require 'csv'
class CsvDb
  class << self
    def convert_save(model_name, csv_data)
      csv_file = csv_data.read
      CSV.parse(csv_file, :headers => true, header_converters: :symbol ) do |row|
        target_model = model_name.classify.constantize
        if( target_model.respond_to? 'import_from_hash' ) 
          target_model.import_from_hash( row.to_hash )
        else
          target_model.create!(row.to_hash)
        end
      end
    end
  end
end