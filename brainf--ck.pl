#!/usr/bin/perl
use warnings;
use strict;

=head1 Comments

In standard brainf**k specifications, comma is used instead of the
quote to read input. Also, if you want to use the quote, you cannot
use it in comments in the code. Moreover, the editor you use replaces
multiple - signs with n- and m-dashes. I had to expand them back to
minuses to get the programme right.

The behaviour of the interpreter was not specified for cases like
negative data byte, programme counter, or data pointer.

I also tested the interpreter on the following programme:

 ,>,[-<+>]<.

It reads two bytes from input and writes their sum to the output,
e.g. for the string "01", it returns "a" (as 48 + 49 = 97).

If you set the environment variable BF_DEBUG to 1, the interpreter
outputs PC and DP after each tick to stderr.

You need the Switch::Plain module (easily installable by "cpan
Switch::Plain").

=cut

use Switch::Plain;


{   my $buffer;
    sub get_input {
        if (! length $buffer) {
            $buffer = <>;
        }
        return ord substr $buffer, 0, 1, q();
    }
}


sub matching_right {
    my ($pc, @programme) = @_;
    my $nested = 1;
    until (']' eq $programme[$pc] and $nested == 0) {
        ++$pc;
        die "Matching ] not found.\n" if $pc > $#programme;

        ++$nested if '[' eq $programme[$pc];
        --$nested if ']' eq $programme[$pc];
    }
    return $pc;
}


sub matching_left {
    my ($pc, @programme) = @_;
    my $nested = 1;
    until ('[' eq $programme[$pc] and $nested == 0) {
        --$pc;
        die "Matching [ not found.\n" if $pc < 0;

        ++$nested if ']' eq $programme[$pc];
        --$nested if '[' eq $programme[$pc];
    }
    return $pc;
}


my $file = shift;
die "Programme not found.\n" unless -f $file;

open my $PROG, '<', $file or die $!;
my @programme = split //, do { local $/ ; <$PROG> };
close $PROG;

my @data;
my ($dp, $pc) = (0, 0);

while ($pc < @programme) {
    sswitch ($programme[$pc]) {
        case '>': { $dp++; }
        case '<': { if ($dp > 0) { $dp--; } else { die "Negative data pointer\n"; } }
        case '+': { $data[$dp]++; }
        case '-': { $data[$dp]-- if $data[$dp] > 0; }
        case '.': { print chr $data[$dp]; }
        case ",": { $data[$dp] = get_input(); }
        case '[': { $pc = matching_right($pc, @programme) if 0 == $data[$dp]; }
        case ']': { $pc = matching_left( $pc, @programme) if 0 != $data[$dp]; }
    };
    $pc++;
    warn "DP: $dp\tPC: $pc\n" if $ENV{BF_DEBUG};
}
