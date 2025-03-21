#!/usr/bin/env ruby

# Check if argument is provided
if ARGV.length != 1
  $stderr.puts "Please provide a number as command line argument"
  exit 1
end

# Check if argument is a valid non-zero integer
begin
  input = Integer(ARGV[0])
  if input == 0
    $stderr.puts "Please provide a non-zero integer"
    exit 1
  end
rescue ArgumentError
  $stderr.puts "Please provide a valid integer"
  exit 1
end

# Initialize random number generator
r = rand(10000)
a = Array.new(10000, 0)

# Pre-calculate the modulo sums for better performance
mod_sums = Array.new(input, 0)
input.times do |i|
  mod_sums[i] = (0...100000).sum { |j| j % input }
end

# Fill the array using the pre-calculated sums
10000.times do |i|
  a[i] = mod_sums[i % input] + r
end

puts a[r]
