#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say);

# Solution: The number can start with 2, 3, 5, or 7 (single digit
# primes). The following digit can be 1, 3, 7, or 9 (numbers ending in
# 5 are divisible by 5).  The program tries to add each digit to each
# shorter prime, if the result is a prime, it is stored for the next
# round. The program ends if there are no primes for the next round.

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
