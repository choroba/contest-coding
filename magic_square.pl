#!/usr/bin/perl
use warnings;
use strict;

my $sq;
my ($x, $y) = (0, 4);
for my $num (1 .. 81) {
    $sq->[$x][$y] = $num++;
    my ($m, $n) = ($x - 1, $y + 1);
    $_ %= 9 for $m, $n;
    ($m, $n) = (($x + 1) % 9, $y) if defined $sq->[$m][$n];
    ($x, $y) = ($m, $n);
}
printf +('%3d' x 9) . "\n", @$_ for @$sq;
