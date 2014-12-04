#!/usr/bin/perl
use warnings;
use strict;

use constant {
    W          => 'Washington DC',
    B          => 'Boston',
    LEAVE      => 1,
    READY      => 2,
    FLIGHT     => 1,
    TURNAROUND => .5,
    DEBUG      => !$#ARGV,
};

sub info {
    print STDERR "@_\n" if DEBUG;
}

my %events;
$events{$_}{&W}{&LEAVE}++ for 7, 8.25, 13, 14, 16.5;
$events{$_}{&B}{&LEAVE}++ for 9.5, 10, 13.5, 15, 16;

my %needed = ( &W => 0, &B => 0 );

sub needed {
    $needed{&W} + $needed{&B};
}

my %planes = ( &W => 0, &B => 0 );

while (my @timescale = sort { $a <=> $b } keys %events) {
    my $time = shift @timescale;
    for my $city (W, B) {

        if (my $ready = $events{$time}{$city}{&READY}) {
            info("\t$time $city: $planes{$city} + new $ready ready.");
            $planes{$city} += $ready;
        }

        if (my $leave = $events{$time}{$city}{&LEAVE} // 0) {
            my $missing = $leave - $planes{$city};
            $missing = 0 if $missing < 0;
            $needed{$city} += $missing;
            info("$missing more planes needed") if $missing;
            $events{$time + FLIGHT + TURNAROUND}{ W eq $city ? B : W }
                {&READY} += $leave;
            info("\t$time $city: $planes{$city} - $leave leaving");
            $planes{$city} -= $leave;
            $planes{$city} = 0 if $planes{$city} < 0;
        }
    }

    delete $events{$time};
}

for my $city (B, W) {
    print "$city: $needed{$city}\n";
}
