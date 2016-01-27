require 'roo'

class CsvDb
  class << self
    def convert_save(target_model, file, &block)
      spreadsheet = open_spreadsheet(file)
      # spreadsheet.force_encoding(Encoding::UTF_8)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        data = Hash[[header, spreadsheet.row(i)].transpose]
        if data.present?
          if (block_given?)
             block.call(target_model, data)
           else
             target_model.create!(data)
           end
         end
        
      end
    end

    def open_spreadsheet(file)
        case File.extname(file.original_filename)
          when '.csv' then Roo::CSV.new(file.path)
          when '.xlsx' then Roo::Excelx.new(file.path)
          else raise "Unknown file type: #{file.original_filename}"
        end
    end

  end
end