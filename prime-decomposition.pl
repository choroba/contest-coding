#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say state);

# The program uses an iterator next_prime. It returns the next prime
# every time it is called. The number 3310 (you can use a different
# number as the command line argument) is divided by each prime while it
# is divisible, until the result is 1. All the primes that succesfully
# divided the number are then printed out.

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
