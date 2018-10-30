require 'csv'
class CsvDb
  class << self
    def convert_save(target_model, csv_data, &block)
      line = 0
      csv_file = csv_data.read
      CSV.parse(csv_file, :headers => true, header_converters: :symbol ) do |row|
        begin
          line += 1
          data = row.to_hash
          if data.present?
            if (block_given?)
               block.call(target_model, data)
             else
               target_model.create!(data)
             end
           end
         rescue
           return {line: line, message: $ERROR_INFO.message}
         end
      end
    end
  end
end
