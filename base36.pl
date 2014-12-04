#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say);

use Math::Base::Convert qw{ cnv };


say cnv('CONTESTCODING', [0 .. 9, 'A' .. 'Z'], 10);
