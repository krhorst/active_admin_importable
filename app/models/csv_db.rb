require 'csv'
require 'digest'
class CsvDb
  class << self
    def convert_save(target_model, csv_data, controller_instance, &block)
      csv_file = csv_data.read
      md5 = ::Digest::MD5.new
      md5 << csv_file
      ::Rails.logger.info("STARTING IMPORT: #{md5}")
      current_row = 0
      failed_rows = []

      ::CSV.parse(csv_file, :headers => true, header_converters: :symbol) do |row|
        begin
          current_row += 1
          ::Rails.logger.info("IMPORT: #{md5} - IMPORTING ROW: #{current_row}")
          data = row.to_hash

          if data.present?
            if (block_given?)
               block.call(target_model, data, controller_instance)
             else
               target_model.create!(data)
             end
           end
         rescue ::ArgumentError => e
           ::Rails.logger.error("IMPORT: ##{md5} FAILED TO PARSE ROW #{current_row}")
           failed_rows << current_row
           ::Rails.logger.error(e.message)
         end
      end

      if failed_rows.any?
        ::Rails.logger.error("IMPORT: #{md5} FAILED TO PARSE ROWS #{failed_rows}")
      else
        ::Rails.logger.info("IMPORT: #{md5} FINISHED")
      end
    end
  end
end
