#!/usr/bin/perl
use strict;
use warnings;

# Binary search implementation in Perl
# Time complexity: O(log n)
# Space complexity: O(1)
#
# @param array_ref Reference to the sorted array to search in
# @param target The value to find
# @return The index of the target if found, -1 otherwise
sub binary_search {
    my ($array_ref, $target) = @_;
    my $left = 0;
    my $right = scalar(@$array_ref) - 1;

    while ($left <= $right) {
        my $mid = $left + int(($right - $left) / 2);
        if ($array_ref->[$mid] == $target) {
            return $mid;
        } elsif ($array_ref->[$mid] < $target) {
            $left = $mid + 1;
        } else {
            $right = $mid - 1;
        }
    }
    return -1;
}

# Check if file path is provided
die "Please provide a file path as an argument\n" unless @ARGV == 1;

# Read numbers from file
open(my $fh, '<', $ARGV[0]) or die "Could not open file '$ARGV[0]': $!\n";
my @numbers = map { chomp; $_ } <$fh>;
close($fh);

# Example target value
my $target = 42;

my $result = binary_search(\@numbers, $target);
if ($result != -1) {
    print "Found $target at index $result\n";
} else {
    print "$target not found in the array\n";
}
