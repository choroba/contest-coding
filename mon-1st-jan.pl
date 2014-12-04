#!/usr/bin/perl
use warnings;
use strict;

use DateTime;

my $count = 0;

for my $year (0 .. 2014) {
    my $dt = 'DateTime'->new( year  => $year,
                              month => 1,
                              day   => 1,
                            );
    $count++ if 1 == $dt->day_of_week;
}

print "$count\n";

=head1 Monday 1st January

Find the number of years between 0 AD to 2014 AD that have began (on
the 1st January) on a Monday.

=cut
