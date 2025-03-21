#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';
use B::JIT;
use List::Util 'sum';

# Check if argument is provided
die "Please provide a number as command line argument\n" unless @ARGV == 1;

# Check if argument is a valid non-zero integer
my $input = $ARGV[0];
die "Please provide a valid non-zero integer\n" unless $input =~ /^\d+$/ && $input > 0;

# Initialize random number generator
my $r = int(rand(10000));
my @a = (0) x 10000;

# Pre-calculate modulo sums for better performance
my @mod_sums = (0) x $input;
for my $i (0 .. $input - 1) {
    $mod_sums[$i] = sum(map { $_ % $input } 0 .. 99999);
}

# Fill the array using pre-calculated sums
for my $i (0 .. 9999) {
    $a[$i] = $mod_sums[$i % $input] + $r;
}

say $a[$r];
