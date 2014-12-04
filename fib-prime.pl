#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ state say };

# Solution: Repeat 11 times: using an iterator, a Fibonacci number is
# generated until it is a prime.

sub fibonacci {
    state $seq = [0, 1];
    push @$seq, $seq->[1] + (my $first = shift @$seq);
    return $first;
}


sub is_prime {
    my $n = shift;
    return 0 if $n < 2;
    for my $d (2 .. sqrt $n) {
        return 0 if 0 == $n % $d;
    }
    return 1;
}


my $f;
for (1 .. 11) {
    do { $f = fibonacci() } until is_prime($f);
}

say length $f;
