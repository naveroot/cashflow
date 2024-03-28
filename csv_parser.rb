# frozen_string_literal: true

require 'csv'
class CsvParser
  attr_reader :data

  def initialize(input_file:, **options)
    @data = CSV.parse(File.read(input_file), headers: options[:headers])
  end
end
