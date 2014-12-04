#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say);

# Solution: I just keep an array that represents the number of
# bacteria in each generation. For each step, every bacteria moves to
# the older generations, and possibly generates new bacteria. I had to
# switch to the 'bignum' as the numbers were too high for a standard
# integer.

use List::Util qw( sum );
use bigint;

my $generations = 100;
my $lifespan    = 5;
my @bacteria    = (1, (0) x ($lifespan - 1));

for (1 .. $generations) {
    my @next = (0) x $lifespan;
    for my $generation (0 .. $lifespan - 2) {

        $next[0]               += $generation * $bacteria[$generation];
        $next[$generation + 1]  = $bacteria[$generation];
    }

    @bacteria = @next;
}

say sum(@bacteria);
