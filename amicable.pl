#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say);

sub sum_divisors {
    my $n   = shift;
    my $sum = 0;
    $sum += $_ for grep 0 == $n % $_, 1 .. $n - 1;
    return $sum;
}

my $a1    = 0;
my $count = 0;
my $a2;
while ($count != 3) {
    $a1++;
    $a2 = sum_divisors($a1);
    if ($a1 == sum_divisors($a2) and $a1 < $a2) {
        $count++;
    }
}
say $a1 + $a2;
