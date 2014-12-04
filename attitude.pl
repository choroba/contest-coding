#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say);


use constant {
    MAX =>  26,
    SUM => 100,
};

use bigint;


{   my %cache = (0 => 1);
    sub count_all {
        my $n = shift;

        return $cache{$n} if exists $cache{$n};

        my $sum = 0;
        for my $first (1 .. MAX) {
            last if $first > $n;

            no warnings 'recursion';
            $sum += count_all($n - $first);
        }
        return $cache{$n} = $sum;
    }
}


say count_all(SUM);
