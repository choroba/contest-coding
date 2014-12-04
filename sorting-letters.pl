#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';

# Using Guttman Rosler transform.

say join ' ',
    map { substr $_, 1 }
    sort
    map "\L$_\E$_",
    grep /[[:alpha:]]/,
    split ' ',
    <DATA>;

__DATA__
A g ? u D n 9 b q Z - S j P x 8 w h B ! f
