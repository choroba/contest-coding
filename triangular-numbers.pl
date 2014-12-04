#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';

my ($n, $step, $sum);
$sum += $n * ($n > 100) while ($n += $step++) < 1000;
say $sum;
