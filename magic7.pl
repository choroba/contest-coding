#!/usr/bin/perl
use warnings;
use strict;

# Use a 2-member array (sliding window). Until the second member
# starts with a 7, repeat the following: add the two members, remove
# the first member from the array and append the result. At the end,
# output the third digit of the second member of the array.

my @fib = (0, 1);
until (0 == index $fib[1], '7') {
    push @fib, $fib[-1] + shift @fib;
}
print substr($fib[1], 2, 1), "\n";
