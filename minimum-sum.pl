#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say);

# Solution: I walk the triangle from the bottom. To each number, the
# minimum of its possible adjacent numbers is added. That way, the
# minimal sum can be retrieved from the top number.

use List::Util qw(min);

my @triangle;
while (<DATA>) {
    unshift @triangle, [ split ];
}

for my $row_idx (1 .. $#triangle) {
    my $row      = $triangle[$row_idx];
    my $previous = $triangle[$row_idx - 1];

    for my $i (0 .. $#$row) {
        my @indices   = grep $_ >= 0 && $_ <= $i + 2, $i - 1 .. $i + 1;
        my $min       = min(map $previous->[$_], @indices);
        my ($min_idx) = grep $previous->[$_] == $min, @indices;
        $row->[$i] += $min;
    }
}
say $triangle[-1][0];

__DATA__
7
9 8
3 2 6
7 1 5 5
9 4 8 2 4
6 3 2 9 7 5
7 2 4 8 5 1 9
4 2 9 3 8 5 2 8
8 2 4 8 5 9 2 7 3
