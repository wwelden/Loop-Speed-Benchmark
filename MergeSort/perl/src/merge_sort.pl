#!/usr/bin/perl
use strict;
use warnings;
use v5.10;

# Implementation of merge sort algorithm in Perl
# Time complexity: O(n log n)
# Space complexity: O(n)

# Helper function to merge two sorted arrays
sub merge {
    my ($left, $right) = @_;
    my @result;
    my ($i, $j) = (0, 0);
    my $left_len = scalar @$left;
    my $right_len = scalar @$right;

    # Compare elements from both arrays and merge them
    while ($i < $left_len && $j < $right_len) {
        if ($left->[$i] <= $right->[$j]) {
            push @result, $left->[$i];
            $i++;
        } else {
            push @result, $right->[$j];
            $j++;
        }
    }

    # Copy remaining elements from left array
    while ($i < $left_len) {
        push @result, $left->[$i];
        $i++;
    }

    # Copy remaining elements from right array
    while ($j < $right_len) {
        push @result, $right->[$j];
        $j++;
    }

    return \@result;
}

# Main merge sort function
sub merge_sort {
    my ($arr) = @_;
    my $len = scalar @$arr;

    return $arr if $len <= 1;

    # Split array into two halves
    my $mid = int($len / 2);
    my @left = @$arr[0 .. $mid - 1];
    my @right = @$arr[$mid .. $len - 1];

    # Recursively sort both halves
    my $left_sorted = merge_sort(\@left);
    my $right_sorted = merge_sort(\@right);

    # Merge the sorted halves
    return merge($left_sorted, $right_sorted);
}

# Function to check if an array is sorted
sub is_sorted {
    my ($arr) = @_;
    for (my $i = 1; $i < scalar @$arr; $i++) {
        return 0 if $arr->[$i-1] > $arr->[$i];
    }
    return 1;
}

# Function to read numbers from file
sub read_numbers_from_file {
    my ($filename) = @_;
    my @numbers;
    open(my $fh, '<', $filename) or die "Cannot open file: $!";
    while (my $line = <$fh>) {
        chomp $line;
        push @numbers, $line if $line =~ /^-?\d+$/;
    }
    close $fh;
    return \@numbers;
}

# Function to write numbers to file
sub write_numbers_to_file {
    my ($filename, $numbers) = @_;
    open(my $fh, '>', $filename) or die "Cannot open file: $!";
    foreach my $num (@$numbers) {
        say $fh $num;
    }
    close $fh;
}

# Main function for command-line interface
sub main {
    die "Please provide an input file path" if @ARGV < 1;

    my $filename = $ARGV[0];
    my $numbers = read_numbers_from_file($filename);

    if (@$numbers > 0) {
        my $sorted = merge_sort($numbers);
        write_numbers_to_file("sorted_data.txt", $sorted);
    }
}

# Test suite
sub run_tests {
    my @test_cases = (
        {
            name => "Empty array",
            input => [],
            expected => [],
            test => sub {
                my ($input, $expected) = @_;
                my $result = merge_sort($input);
                return scalar @$result == 0;
            }
        },
        {
            name => "Single element",
            input => [1],
            expected => [1],
            test => sub {
                my ($input, $expected) = @_;
                my $result = merge_sort($input);
                return scalar @$result == 1 && $result->[0] == 1;
            }
        },
        {
            name => "Two elements",
            input => [2, 1],
            expected => [1, 2],
            test => sub {
                my ($input, $expected) = @_;
                my $result = merge_sort($input);
                return $result->[0] == 1 && $result->[1] == 2;
            }
        },
        {
            name => "Multiple elements",
            input => [5, 3, 8, 4, 2],
            expected => [2, 3, 4, 5, 8],
            test => sub {
                my ($input, $expected) = @_;
                my $result = merge_sort($input);
                for (my $i = 0; $i < scalar @$expected; $i++) {
                    return 0 if $result->[$i] != $expected->[$i];
                }
                return 1;
            }
        },
        {
            name => "Duplicate elements",
            input => [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5],
            expected => [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9],
            test => sub {
                my ($input, $expected) = @_;
                my $result = merge_sort($input);
                for (my $i = 0; $i < scalar @$expected; $i++) {
                    return 0 if $result->[$i] != $expected->[$i];
                }
                return 1;
            }
        },
        {
            name => "Negative numbers",
            input => [-3, 1, -4, 1, -5, 9, -2, 6, -5, 3, -5],
            expected => [-5, -5, -5, -4, -3, -2, 1, 1, 3, 6, 9],
            test => sub {
                my ($input, $expected) = @_;
                my $result = merge_sort($input);
                for (my $i = 0; $i < scalar @$expected; $i++) {
                    return 0 if $result->[$i] != $expected->[$i];
                }
                return 1;
            }
        },
        {
            name => "Large array",
            input => [],
            expected => [],
            test => sub {
                my @large_array = reverse(1..1000);
                my $result = merge_sort(\@large_array);
                return is_sorted($result);
            }
        },
        {
            name => "Strings",
            input => ["banana", "apple", "cherry"],
            expected => ["apple", "banana", "cherry"],
            test => sub {
                my ($input, $expected) = @_;
                my $result = merge_sort($input);
                for (my $i = 0; $i < scalar @$expected; $i++) {
                    return 0 if $result->[$i] ne $expected->[$i];
                }
                return 1;
            }
        }
    );

    print "Running tests...\n";
    my $all_passed = 1;

    foreach my $test_case (@test_cases) {
        my $passed = $test_case->{test}->($test_case->{input}, $test_case->{expected});
        printf "%s: %s\n", $test_case->{name}, $passed ? "PASSED" : "FAILED";
        $all_passed = 0 unless $passed;
    }

    return $all_passed;
}

# Run tests if DEBUG is set
if ($ENV{DEBUG}) {
    if (run_tests()) {
        print "All tests passed!\n";
    } else {
        print "Some tests failed!\n";
    }
} else {
    main();
}
