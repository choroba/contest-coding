#!/usr/bin/perl
use warnings;
use strict;

my $string = 'Of the twenty six letters in the alphabet, how many of them '
           . 'do not appear in this puzzle - excluding the reminder below?';

my %letters;
undef @letters{'a' .. 'z'};
delete $letters{$_} for split //, $string;
print scalar keys %letters, "\n";
