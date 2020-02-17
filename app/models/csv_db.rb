require 'csv'
require 'rchardet'

class CsvDb
  class << self
    def convert_save(target_model, csv_data, validator, &block)
      csv_file = csv_data.read
      encoding = CharDet.detect(csv_file)['encoding']
      csv_file.encode!('UTF-8', encoding)

      dataset = CSV.parse(csv_file, :headers => true, header_converters: :symbol)
      validator.call(dataset) if validator.present?

      dataset.each do |row|
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
