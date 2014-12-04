#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

=head1 Solution

The algorithm works in three steps:

1. It finds the first permutation that contains the given substring.

2. It converts the permutation to its Lehmer code.

3. It converts the Lehmer code into the sequence position.

=cut

sub to_lehmer {
    my @seq = @_;
    for my $i (0 .. $#seq) {
        $seq[$_] > $seq[$i] and $seq[$_]-- for $i .. $#seq;
    }
    return @seq
}


sub to_order {
    my @lehmer     = @_;
    my $order      = 0;
    my $fact_radix = 1;
    for my $i (0 .. $#lehmer) {
        $fact_radix *= $i if $i;
        $order      += $fact_radix * $lehmer[-$i - 1];
    }
    return 1 + $order
}


sub explode {
    my ($n, $infix) = @_;
    if ($n < $#{$infix}) {
        my $inners = splice @$infix, $n, 1, undef;
        my @perm;
        for my $inner (@$inners) {
            splice @$infix, $n, 1, $inner;
            push @perm, @{ explode($n + 1, [@$infix]) };
        }
        return \@perm

    } else {
        my $last = pop @$infix;
        return [ map [ @$infix, $_ ], @$last ]
    }
}


sub wrap {
    my ($candidate, $to_numbers) = @_;
    my (@prefix, @suffix);
    for my $remaining ( sort { $a <=> $b }
                        grep { my $x = $_; not grep $x == $_, @$candidate }
                        map @$_,
                        values %$to_numbers) {
        if ($remaining < $candidate->[0]) {
            push @prefix, $remaining;
        } else {
            push @suffix, $remaining;
        }
    }
    return [ @prefix, @$candidate, @suffix ]
}


sub compare {
    my $i = 0;
    $i++ while $a->[$i] == $b->[$i];
    $a->[$i] <=> $b->[$i]
}


sub not_repeated {
    my $seq = shift;
    my %uniq;
    undef @uniq{@$seq};
    return @$seq == keys %uniq
}


sub find_first {
    my ($string, $search) = @_;
    my %to_numbers;
    for my $i (0 .. length($string) - 1) {
        my $char = substr $string, $i, 1;
        push @{ $to_numbers{$char} }, $i;
    }

    my @infix = map [@{ $to_numbers{$_} }], split //, $search;
    my @perm  = grep not_repeated($_), @{ explode(0, [@infix]) };
    my @full  = sort compare map wrap($_, \%to_numbers), @perm;
    return @{ $full[0] }
}


say to_order(to_lehmer(find_first('Contest Coding', 'tsetnoC')));


exit unless @ARGV;


use Test::More;


is_deeply([ find_first('abaca', 'aa') ],
          [ qw[ 0 1 2 4 3 ] ],
          'aa');

is_deeply([ find_first('abaca', 'ab') ],
          [ qw[ 0 1 2 3 4 ] ],
          'ab');

done_testing();
