#!/usr/bin/perl
use warnings;
use strict;

my @fib = (0, 1);
until (0 == index $fib[1], '7') {
    push @fib, $fib[-1] + shift @fib;
}
print substr($fib[1], 2, 1), "\n";
