require 'csv'

class CsvParser
  def self.parse(filename)
    points = []

    CSV.foreach(filename) do |row|
      unless row.any? { |r| r == '#N/A' }
        points << Point.new(extract_data(row))
      end
    end

    points.sort_by! { |p| p.date }

    position = 0
    points.each { |p| p.position = position += 1 }
  end

  def self.extract_data(raw_row)
    raw_date, *raw_numbers = raw_row
    [convert_date(raw_date), *raw_numbers.map(&:to_f)]
  end

  def self.convert_date raw_date
    month, day, year = raw_date.split('/').map(&:to_i)
    Date.new(year, month, day)
  end
end
