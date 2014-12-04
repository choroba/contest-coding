#!/usr/bin/perl
use warnings;
use strict;

# Solution: The simplest one, brute force. Count the number of factors
# for each number starting from 2 until you find the solution.

sub factors {
    my $n = shift;
    my $factors = 2;
    for my $i (2 .. $n - 1) {
        $factors++ if 0 == $n % $i;
    }
    return $factors;
}


my $n = 2;
while (1) {
    my $f = factors($n);
    last if $f >= 10;
    $n++;
}

print "$n\n";
