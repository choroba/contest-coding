#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say);

my $n = 6;

my $i = my $j = 1;
while ($n > 0) {
    $n-- if int sqrt $i == sqrt $i;
    $i += 1 + $j++;
}
say $i - $j;
