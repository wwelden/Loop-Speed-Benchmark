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

r = rand(10000)             # Get a random number 0 <= r < 10k
a = Array.new(10000, 0)     # Array of 10k elements initialized to 0

10000.times do |i|          # 10k outer loop iterations
  100000.times do |j|       # 100k inner loop iterations, per outer loop iteration
    a[i] = a[i] + j % input # Simple sum
  end
  a[i] += r                 # Add a random value to each element in array
end

puts a[r]                   # Print out a single element from the array
