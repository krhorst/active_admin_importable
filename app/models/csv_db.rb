require 'csv'
class CsvDb
  class << self
    def convert_save(model_name, csv_data, &block)
      csv_file = csv_data.read
      target_model = model_name.pluralize.classify.constantize
      CSV.parse(csv_file, :headers => true, header_converters: :symbol ) do |row|
        data = row.to_hash
        if data.present?
          if (block_given?)
             block.call(target_model, data)
           else
             target_model.create!(data)
           end
         end
      end
    end
  end
end