#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say state);

my %is_prime = (2 => 1);

$|--; # No buffering, for easier debugging and checking.

sub add_primes {
    my $length = shift;
    $is_prime{$_} = is_prime($_) for 2 * $length - 1; # 2 * $length is not a prime.
}


sub is_prime {
    my $n = shift;
    for my $d (2 .. sqrt $n) {
        return 0 if 0 == $n % $d;
    }
    return 1;
}


my %follow;


sub add_following {
    my $length = shift;
    for my $i (1 .. $length) {
        if ($is_prime{$length + $i}) {
            push @{ $follow{$i}      }, $length;
            push @{ $follow{$length} }, $i;
        }
    }
}


my $length = shift;
my $sum    = shift;
for my $prev (1 .. $length - 2) {
    add_primes($prev);
    add_following($prev);
}

my $first  = 1;

while (1) {
    add_primes($_), add_following($_) for $length - 1, $length;
    warn $length;
    visit($first, $length, {}, time);

  NEXT:
    $length += 2; # For odd numbers no solution is possible:
                  # there would have been two odd neighbours.
}

sub visit {
    my ($node, $depth, $visited, $time) = @_;
    goto NEXT if time - $time > 30;
    if (0 == $depth and $is_prime{$node + $first}) {
        $sum += $length;
        print "$length ($sum): ",
            join(' ', sort { $visited->{$a} <=> $visited->{$b} }
                      keys %$visited), " $node\n";

        goto NEXT;
    }
    for my $neighbour (@{ $follow{$node} }) {
        next if exists $visited->{$neighbour};
        no warnings 'recursion';
        visit($neighbour, $depth - 1, { %$visited, $node => $depth }, $time);
    }
}
