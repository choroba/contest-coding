#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say);

use Memoize;


sub is_prime {
    my $n = shift;
    for my $i (2 .. sqrt $n) {
        return 0 if 0 == $n % $i;
    }
    return 1
}

my %coin = map { $_ => undef } grep is_prime($_), 2 .. 19;

memoize('combinations');
sub combinations {
    my $n = shift;
    return [] if $n <= 1;

    my @result;
    for my $i (2 .. $n / 2) {
        my $r1 = combinations($i);
        my $r2 = combinations($n - $i);
        for my $c1 (@$r1) {
            for my $c2 (@$r2) {
                push @result, join ':', sort { $a <=> $b }
                                        split /:/, "$c1:$c2";
            }
        }
    }
    push @result, $n if exists $coin{$n};

    my %uniq;
    undef @uniq{@result};
    return [keys %uniq];
}


my $n = shift;
my $c = combinations($n);

say 0 + @$c;
