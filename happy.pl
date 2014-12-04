#!/usr/bin/perl
use warnings;
use strict;

use DateTime;

my ($day, $month, $year) = (8, 3, 2014);

my $d;
do {{
    $d = 'DateTime'->new( year  => ++$year,
                          month => $month,
                          day   => $day
                        );
}} until 6 == $d->day_of_week;
print "$year\n";
