# frozen_string_literal: true

require_relative 'csv_parser'
def calculate_ema(data, period)
  ema_values = []

  data.each_with_index do |point, index|
    if index.zero?
      ema_values << point[:price].to_f
    else
      k = 2.0 / (period + 1)
      previous_ema = ema_values.last
      current_price = point[:price].to_f
      ema = (current_price - previous_ema) * k + previous_ema
      ema_values << ema
    end
  end

  ema_values
end

data = CsvParser.new(input_file: 'USD_RUB.csv', headers: true).data
candles = data.map do |row|
  { date: row[0], price: row[1].to_f }
end.reverse

ema_values = calculate_ema(candles, 20)
ema_values.each_with_index do |ema, index|
  puts "EMA #{candles[index][:date]}: #{ema}"
end
