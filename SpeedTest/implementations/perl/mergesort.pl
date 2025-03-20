#!/usr/bin/env perl
use strict;
use warnings;

sub merge {
    my ($arr, $left, $right) = @_;
    my ($i, $j, $k) = (0, 0, 0);

    while ($i < @$left && $j < @$right) {
        if ($left->[$i] <= $right->[$j]) {
            $arr->[$k] = $left->[$i];
            $i++;
        } else {
            $arr->[$k] = $right->[$j];
            $j++;
        }
        $k++;
    }

    while ($i < @$left) {
        $arr->[$k] = $left->[$i];
        $i++;
        $k++;
    }

    while ($j < @$right) {
        $arr->[$k] = $right->[$j];
        $j++;
        $k++;
    }
}

sub mergeSort {
    my ($arr) = @_;

    if (@$arr <= 1) {
        return;
    }

    my $mid = int(@$arr / 2);
    my @left = @$arr[0 .. $mid - 1];
    my @right = @$arr[$mid .. @$arr - 1];

    mergeSort(\@left);
    mergeSort(\@right);

    merge($arr, \@left, \@right);
}

sub generateRandomArray {
    my ($size) = @_;
    return [map { int(rand(10000)) } 1 .. $size];
}

my $ARRAY_SIZE = 1000;
my $ITERATIONS = 100;

for (1 .. $ITERATIONS) {
    my $arr = generateRandomArray($ARRAY_SIZE);
    mergeSort($arr);
}
