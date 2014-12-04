#!/usr/bin/perl
use warnings;
use strict;

my $threshold = my $diff = 100_000;
my @fibonacci = (0, 1);
my @closest;

while (1) {
    my $f = shift @fibonacci;
    push @fibonacci, $f + $fibonacci[0];
    my $d = abs($threshold - $f);
    last if $diff < $d;

    @closest = () if $d < $diff;
    push @closest, $f;
    $diff = $d;
}
print "@closest\n";
