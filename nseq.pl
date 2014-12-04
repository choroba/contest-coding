#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say);

my %billion = ( 'Short scale' => 1e9,
                'Long scale'  => 1e12,
              );

while (my ($scale, $n) = each %billion) {
    say "$scale: ", $n * 4 + 2;
}
