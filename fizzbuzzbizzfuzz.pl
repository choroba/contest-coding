#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say);

for my $n (1 .. 100) {
    my $p;

    $n % 3    or  $p = print 'Fizz';
    $n % 5    or  $p = print 'Buzz';
    $n =~ /3/ and $p = print 'Bizz';
    $n =~ /5/ and $p = print 'Fuzz';

    say $p ? q() : $n;
}

