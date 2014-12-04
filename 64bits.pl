#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use bigint;
use Math::Prime::Util qw{ is_prime };

my $n = 2 ** 64 + 1;
$n += 2 until is_prime($n);
say $n;
