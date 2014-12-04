#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';

# Needs 64 bit.

my $n = 10000000000000000000;
say length($n) - length sprintf '%x', $n;
