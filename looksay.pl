#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say);

my $length = 8;
my $start  = 3;

$start =~ s/ ( (.) \2* ) / length($1) . $2 /xeg for 1 .. $length - 1;
say $start;
