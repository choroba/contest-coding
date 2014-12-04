#!/usr/bin/perl
use warnings;
use strict;

use Math::BigInt;

sub generate {
    my $length = shift;
    my $n  = 1;
    my $ch = q();
    while ($length >= length $ch) {
        $ch .= $n++;
    }
    my $last;
    $last = chop $ch until $length == length $ch;
    $ch++ if 4 < $last;
    return $ch;
}

my $length = 100;

my $ch = generate($length);
$ch = 'Math::BigInt'->new($ch);
my $denominator = 'Math::BigInt'->new('1' . ('0' x $length));
my @divisors = (2, 5);
my %div = map { $_ => 0 } @divisors;

for my $d (@divisors) {
    while (0 == $ch % $d) {
        $ch /= $d;
        $denominator /= $d;
        $div{$d}++;
#        last if $denominator % $d;
        last if $div{$d} == $length;
    }
}

print "$ch / $denominator\n";
