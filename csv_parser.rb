require 'csv'

class CsvParser
  def self.parse(filename)
    [].tap do |points|
      CSV.foreach(filename) do |row|
        unless row.any? {|r| r == '#N/A'}
          points << Point.new(row)
        end
      end
    end
  end
end
