#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say);

sub increases {
    my @digits = split //, shift;
    for my $i (0 .. $#digits - 1) {
        return 0 if $digits[$i] >= $digits[$i + 1];
    }
    return 1;
}

my $count = 0;
for my $n (1000 .. 9999) {
    $count++ if increases($n);
}
say $count;
