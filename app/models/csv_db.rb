require 'csv'
class CsvDb
  class << self
    def char_code(c)
      c.respond_to?(:ord) ? c.ord : c
    end

    def has_bom(file_data)
      char_code(file_data[0]) == 0xEF &&
          char_code(file_data[1]) == 0xBB &&
          char_code(file_data[2]) == 0xBF
    end

    def remove_bom(file_data)
      has_bom(file_data) ? file_data[3..-1] : file_data
    end

    def convert_save(target_model, csv_data, role = :default, &block)
      csv_file = remove_bom(csv_data.read)
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