#!/usr/bin/perl
use warnings;
use strict;

# Create a hash of all the letters, then process the text char by char
# removing keys from the hash. The final number of keys is the output
# (BTW, jkqv).

my $string = 'Of the twenty six letters in the alphabet, how many of them '
           . 'do not appear in this puzzle - excluding the reminder below?';

my %letters;
undef @letters{'a' .. 'z'};
delete $letters{$_} for split //, $string;
print scalar keys %letters, "\n";
