#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say);

my $rank = 3;

my %count;
while (<DATA>) {
    $count{ lc $_ }++ for grep /[[:alpha:]]/, split //;
}

my %letter;
while (my ($ltr, $cnt) = each %count) {
    push @{ $letter{$cnt} }, $ltr;
}

say @{ $letter{(sort { $b <=> $a } keys %letter)[ $rank - 1 ]} };

__DATA__
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse
vitae justo est, sed ultricies lacus. Praesent adipiscing adipiscing
sapien, iaculis lacinia lectus suscipit eu. Nullam eget scelerisque
mi. In eget fermentum nunc. Etiam eu diam a nunc auctor viverra. Nulla
leo nunc, placerat in iaculis ut, convallis ac tellus. Praesent
ultrices lacinia facilisis. Vivamus dolor massa, vulputate bibendum
egestas sed, euismod sit amet nulla. Aliquam erat volutpat.

Nunc hendrerit euismod massa ut scelerisque. Pellentesque et diam eget
mi ultricies aliquam eget vitae augue. Nunc risus turpis, pellentesque
nec ornare vel, posuere vitae arcu. Mauris commodo lacinia
felis. Praesent feugiat condimentum velit, a euismod nisl euismod
et. Suspendisse potenti. Sed eu imperdiet nibh.
