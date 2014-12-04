#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';

sub is_palindrome {
    my $n = shift;
    return $n eq reverse $n;
}

sub max_palindrom_prime {
    my $max  = shift;
    my $sqrt = sqrt $max;
    my @primes = (2);
  PRIME: # Find the smaller primes to divide the larger primes.
    for my $p (3 .. $sqrt) {
        my $s = sqrt $p;
        not($p % $_) and next PRIME for grep $_ <= $s, @primes;
        push @primes, $p;
    }

  PRIME:
    for my $r (reverse 10_000 .. $max) {
        next unless is_palindrome($r);
        not($r % $_) and next PRIME for @primes;
        return $r;
    }
}

say max_palindrom_prime(99_999);
