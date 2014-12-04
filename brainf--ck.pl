#!/usr/bin/perl
use warnings;
use strict;

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
