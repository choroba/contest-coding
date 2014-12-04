#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say);

# The algorithm just iterates over triangular numbers and counts how
# many of them were also perfect squares. I was originally thinking of
# using the formula s(i) = t(i) + t(i-1), but I was not able to come
# to a solution, and the simple solution is fast enough, so no need to
# elaborate more.

my $n = 6;

my $i = my $j = 1;
while ($n > 0) {
    $n-- if int sqrt $i == sqrt $i;
    $i += 1 + $j++;
}
say $i - $j;
