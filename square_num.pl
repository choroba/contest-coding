#!/usr/bin/perl -l
use warnings;
use strict;

use POSIX qw(ceil);

my $exceed = 5;
print ceil sqrt 10 ** $exceed;
