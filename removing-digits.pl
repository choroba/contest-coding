#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say);


sub is_prime {
    my $n = shift;
    for my $i (2 .. sqrt $n) {
        return if 0 == $n % $i;
    }
    return 1;
}


my @short_primes = (2, 3, 5, 7);

while (1) {
    my @long_primes;
    for my $short (@short_primes) {
        for my $digit (1, 3, 7, 9) {
            my $new = $short . $digit;
            push @long_primes, $new if is_prime($new);
        }
    }
    last unless @long_primes;
    @short_primes = @long_primes;
}

say $short_primes[-1];
