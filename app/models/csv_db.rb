require 'csv'
class CsvDb
  class << self
    def convert_save(target_model, csv_data, controller_instance, &block)
      csv_file = csv_data.read
      current_row = 0
      failed_rows = []

      ::CSV.parse(csv_file, :headers => true, header_converters: :symbol) do |row|
        begin
          current_row += 1
          data = row.to_hash
          if data.present?
            if (block_given?)
               block.call(target_model, data, controller_instance)
             else
               target_model.create!(data)
             end
           end
         rescue => e
           puts "FAILED TO PARSE ROW #{current_row}"
           failed_rows << current_row
           puts e.inspect
         end
      end

      puts "FAILED TO PARSE ROWS #{failed_rows}" if failed_rows.any?
    end
  end
end
