#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say);

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
