#!/usr/bin/perl
use warnings;
use strict;

# The text is processed line by line. Each line is split into groups
# of alphabetic or non-alphabetic characters. Then, in each group,
# repeated letters are reduced and vowels preceded by anything are
# removed using regular expressions.

use Text::Unaccent::PurePerl qw{ unac_string };

binmode DATA,   'utf8';
binmode STDOUT, 'utf8';

while (my $line = <DATA>) {
    $line = unac_string($line);
    for (split /([[:alpha:]]+)/, $line) {
        s/(.)\1/$1/g;
        s/(?<=.)[aeiouy]//ig;
        print;
    }
}

__DATA__
Friends, Romans, countrymen, lend me your ears!
I come to bury Caesar, not to praise him.
The evil that men do lives after them,
The good is oft interrèd with their bones:
So let it be with Caesar. The noble Brutus
Hath told you Caesar was ambitious;
If it were so, it was a grievous fault,
And grievously hath Caesar answered it.
Here, under leave of Brutus and the rest -
For Brutus is an honourable man,
So are they all, all honourable men -
Come I to speak in Caesar’s funeral.
