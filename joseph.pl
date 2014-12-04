#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say);

my @comrades = ('x') x 40;
my $pos = 6;
for (1 .. 39){
    $comrades[$pos % 40] = '-';
    for (1 .. 7) {
        1 until "x" eq $comrades[ ++$pos % 40 ];
    }
}
say 1 + ($pos % 40);
