#!/usr/bin/perl
# -*- encoding: utf-8 -*-
use warnings;
use strict;
use feature qw(say);

binmode DATA, 'utf8';

while (<DATA>) {
    my @words = split /[^\p{L}]+/;
    say join ' ', map { join q(),
                        sort { lc $a cmp lc $b }
                        split //
                    } @words;
}

__DATA__
To be or not to be – that is the question:
Whether ’tis nobler in the mind to suffer
The slings and arrows of outrageous fortune,
Or to take arms against a sea of troubles
And, by opposing, end them.
