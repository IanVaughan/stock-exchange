#!/usr/bin/env ruby

require './point'
require './csv_parser'
require './analiser'
require 'pry'

filename = 'sx5e_index.csv'
points = CsvParser.parse(filename)
Analiser.analysis(points)

