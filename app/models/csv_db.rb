require 'csv'
class CsvDb
  class << self
    def convert_save(target_model_klass, csv_data, &block)
      csv_file = csv_data.read
      CSV.parse(csv_file, :headers => true, header_converters: :symbol ) do |row|
        if(block_given?)
            block.call(target_model_klass, row.to_hash)
         else
           target_model_klass.create!(row.to_hash)
         end
      end
    end
  end
end