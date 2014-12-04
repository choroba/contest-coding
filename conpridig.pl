#!/usr/bin/perl
# Author: E. Choroba

use warnings;
use strict;
use feature qw(say);

my $prime_iterator = do {
    my $prime = 1;
    sub { 1 until prime($prime += 2); $prime; }
};


sub prime {
    my $p = shift;
    0 == $p % $_ and return for 3 .. sqrt $p;
    return 1;
}


my @digits = 2;
my $count = 1;

push @digits, split //, $prime_iterator->() while $count++ < 100;

my $max = -1;
for my $i (0 .. $#digits - 4) {
    my $sum = 0;
    $sum += $_ for @digits[$i .. $i + 4];
    $max = $sum if $sum > $max;
}

say $max;

