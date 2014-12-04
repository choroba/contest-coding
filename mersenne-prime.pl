#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say);

sub is_prime {
    my $n = shift;
    return 0 if $n <= 1;
    for my $p (2 .. sqrt $n) {
        return 0 if 0 == $n % $p;
    }
    return 1;
}

sub mersenne { -1 + 2 ** shift }

my $base = 0;
while (1) {
    next unless is_prime($base);
    last if not is_prime(mersenne($base));
} continue {
    $base++;
}

say mersenne($base);
