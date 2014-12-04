#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say);

# I didn't golf the solution.

my $hole_count = 18;
my $sum        = 72;
my @holes      = (3, 4, 5);

my $start      = @holes;
push @holes, 3 until @holes == $hole_count;

my $tmp_sum = 0;
$tmp_sum += $_ for @holes;

say 0 and exit if $tmp_sum > $sum;

my $i     = $start;
my $fours = 0;      # Only 4's can be changed to something else.
while ($tmp_sum < $sum) {
    $tmp_sum++;
    $fours += (1, -1, 0)[$holes[$i]++ - 3];
    say 0 and exit if $holes[$i] > 5;
    $i = $start if ++$i > $#holes;
}

# A half of the hours changes to 3's, the other half to 5's.
$fours-- if $fours % 2;
say 1 + $fours / 2;
