require 'csv'
class CsvDb
  class << self
    def convert_save(target_model, csv_data, role = :default, &block)
      csv_file = csv_data.read
      parser_class = (RUBY_VERSION=='1.8.7') ? FasterCSV : CSV
      parser_class.parse(csv_file, :headers => true, :header_converters => :symbol ) do |row|
        data = row.to_hash
        if data.present?
          if (block_given?)
             block.call(target_model, data)
           else
             target_model.create!(data, :as => role)
           end
         end
      end
    end
  end
end