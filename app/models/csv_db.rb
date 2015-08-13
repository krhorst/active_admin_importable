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

    def convert_save(target_model, csv_data, options, &block)
      csv_file = remove_bom(csv_data.read)
      parser_class = (RUBY_VERSION=='1.8.7') ? FasterCSV : CSV
      begin
        target_model.transaction do
          parser_class.parse(csv_file, :headers => true, :header_converters => :symbol ) do |row|
            append_row(target_model, row, options, block)
          end
        end
      ensure
        if options[:reset_pk_sequence]
          target_model.reset_pk_sequence!
        end
      end
    end

    def append_row(target_model, row, options, block)
      data = row.to_hash
      if data.present?
        if (block_given?)
          block.call(target_model, data)
        else
          role = options[:role] || :default
          if key_field = options[:find_by]
            create_or_update! target_model, data, key_field
          else
            if role == :default
              target_model.create!(data)
            else
              target_model.create!(data, :as => role) # Old version ActiveRecord
            end
          end
        end
      end
    end

    def create_or_update!(target_model, values, key_field)
      key_value = values[key_field]
      scope = target_model.where(key_field => key_value)
      if obj = scope.first
        obj.update_attributes!(values)
      else
        scope.create!(values)
      end
    end
  end
end