#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };


use constant {
    STRING => 'Contest Coding',
    SEARCH => 'tsetnoC',
};


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


sub find_first {
    my %to_characters;
    my %to_numbers;
    for my $i (0 .. length(STRING) - 1) {
        my $char = substr STRING, $i, 1;
        $to_characters{$i} = $char;
        push @{ $to_numbers{$char} }, $i;
    }

    my @chars = split //, SEARCH;
    my %char_count;
    $char_count{$_}++ for @chars;

    # Repeated characters are picked from left, the others from right.
    my @search_num = map { splice @{ $to_numbers{$_} },
                                  $char_count{$_} > 1 ? 0 : -1,
                                  1
                         } @chars;

    my (@prefix, @suffix);
    for my $remaining (sort { $a <=> $b } map @$_, values %to_numbers) {
        if ($remaining < $search_num[0]) {
            push @prefix, $remaining;
        } else {
            push @suffix, $remaining;
        }
    }
    return (@prefix, @search_num, @suffix)
}


say to_order(to_lehmer(find_first()));
