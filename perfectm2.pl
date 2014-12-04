#!/usr/bin/perl
use warnings;
use strict;
use integer;
use feature qw(say);

# Should be pretty fast.

my $perfect = 0;
my $p       = 2;
my @primes  = 2;
my %prime_counts;

while ($perfect < 4) {
    my @factors = factorize($p);
    if (1 == @factors and $p > $primes[-1]) {
        push @primes, $p;
    }

    my $product = sum_subsets(@factors);
    if ($product == $p) {
        $perfect++;
        my %local_primes;
        $local_primes{$_}++ for @factors;

        while (my ($prime, $count) = each %local_primes) {
            $prime_counts{$prime} = $local_primes{$prime}
                if $local_primes{$prime} > ($prime_counts{$prime} // 0);
        }
    }

} continue {
    $p++;
}


my $clm = 1;
while (my ($prime, $count) = each %prime_counts) {
    $clm *= $prime for 1 .. $count;
}
say $clm;


sub sum_subsets {
    my @numbers = @_;
    my $binary  = 1;
    my $sum     = 1; # Always a divisor.
    my %seen;

  SUBSET: while (1) {
        my @zero_ones = split //, sprintf '%b', $binary++;
        unshift @zero_ones, (0) x (@numbers - @zero_ones);
        last SUBSET unless grep ! $_, @zero_ones;

        my $divisor = 1;
        $divisor *= $numbers[$_] for grep $zero_ones[$_], 0 .. $#zero_ones;
        next SUBSET if exists $seen{$divisor};

        undef $seen{$divisor};
        $sum += $divisor;
    }
    return $sum;
}


sub factorize {
    my ($n)         = @_;
    my $prime_index = 0;
    my ($f, @factors);

    while ($n > 1) {
        $f = $primes[$prime_index] // ($f + 1);

        if ($n % $f) {
            $prime_index++;

        } else {
            push @factors, $f;
            $n /= $f;
        }
    }
    return @factors;
}
