require 'csv'
class CsvDb
  class << self
    def convert_save(target_model, csv_data, &block)
      csv_file = csv_data.read
      result = false
      CSV.parse(csv_file, :headers => true, header_converters: :symbol ) do |row|
        data = row.to_hash
        if data.present?
          if (block_given?)
            block.call(target_model, data)
          else
            target_object = target_model.find_by_id(row[:id]) || target_model.new
            target_model.column_names.each do |key|
              key = key.to_sym
              if data.keys.include?(key)
                value = row[key]
                target_object.send "#{key}=", value if value != nil
              end
            end
            result = target_object.save ? true : target_object.errors
          end
        end
      end
      result
    end
  end
end
