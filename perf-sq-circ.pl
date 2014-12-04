#!/usr/bin/perl
use warnings;
use strict;

# Solution: First, a graph is constructed that represents all possible
# pairs of numbers. It is then walked recursively. Surprisingly, a
# solution is found in less than 3 seconds, and slightly modified, it
# can generate all the possible sequences starting at a given number
# in less than 5 minutes on my machine.


my $max = 40;

my $max_sq = 2 * $max - 1;
my %squares;
$squares{$_ ** 2} = 1 for 2 .. sqrt $max_sq;

my %follow;
for my $square (keys %squares) {
    for my $i (1 .. $max) {
        my $j = $square - $i;
        next if $max < $j or $j <= $i;
        push @{ $follow{$i} }, $j;
        push @{ $follow{$j} }, $i;
    }
}

my $first = 1;
visit($first, 0, {});
die "Not found\n";

sub visit {
    my ($node, $depth, $visited) = @_;
    if ($max - 1 == $depth and exists $squares{$node + $first}) {
        print join(' ', sort { $visited->{$a} <=> $visited->{$b} }
                        keys %$visited), " $node\n";
        exit;
    }
    for my $neighbour (@{ $follow{$node} }) {
        next if exists $visited->{$neighbour};
        visit($neighbour, $depth + 1, { %$visited, $node => $depth });
    }
}
