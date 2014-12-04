#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say state);


sub next_prime {
    state @primes;
    if (not @primes) {
        @primes = (2);
    } else {
        my $p = $primes[-1] + 1;
        $p++ while 0 < grep 0 == $p % $_, @primes;
        push @primes, $p;
    }
    return $primes[-1];
}


sub decompose {
    my $number = shift;
    my @divisors;
    while (1 < $number) {
        my $prime = next_prime();
        while (0 == $number % $prime) {
            $number /= $prime;
            push @divisors, $prime;
        }
    }
    return @divisors;
}


my $number = shift // 3300;
say join ' ', decompose($number);
