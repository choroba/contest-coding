#!/usr/bin/perl
use warnings;
use strict;

use Time::Piece;

my $t = 'Time::Piece'->strptime('3000 12 25', '%Y %m %d');
print $t->fullday, "\n";
