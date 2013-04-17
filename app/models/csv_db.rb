require 'csv'
class CsvDb
  class << self
    def convert_save(model_name, csv_data, &block)
      csv_file = csv_data.read
      target_model = model_name.pluralize.classify.constantize
      CSV.parse(csv_file, :headers => true, header_converters: :symbol ) do |row|
        if(block_given?)
            block.call(target_model, row.to_hash)
         else
             target_model.create!(row.to_hash)
         end
      end
    end
  end
end