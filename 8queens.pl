#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say);

{   package Queen;

    sub new {
        my ($class, $x, $y) = @_;
        return bless [$x // 0, $y // 0], $class;
    }

    sub step {
        my ($self) = @_;
        my ($x, $y) = map $self->[$_], 0, 1;
        if (++$x > 7) {
            $x = 0;
            $y++;
            if ($y > 7) {
                undef $_[0];
                return;
            }
        }
        $self->[0] = $x;
        $self->[1] = $y;
    }

    sub position {
        my $self = shift;
        return (('a' .. 'h')[$self->[0]] . ($self->[1] + 1));
    }

}


{   package Board;

    sub new { bless [ map [ map 0, 1 .. 8 ] , 1 .. 8 ], shift }

    sub place {
        my ($self, $x, $y) = @_;
        $self->_set_squares($x, $y, 1);
    }

    sub remove {
        my ($self, $x, $y) = @_;
        $self->_set_squares($x, $y, -1);
    }

    sub free {
        my ($self, $x, $y) = @_;
        return not $self->[$x][$y];
    }

    sub _set_square {
        my ($self, $x, $y, $add) = @_;
        ($_ < 0 or $_ > 7) and return for $x, $y;
        $self->[$x][$y] += $add;
    }

    sub _set_squares {
        my ($self, $x, $y, $add) = @_;
        $self->[$x][$y] += $add;
        for my $distance (1 ..7) {
            $self->_set_square(@$_, $add) for [$x + $distance, $y],
                                              [$x - $distance, $y],
                                              [$x,             $y + $distance],
                                              [$x,             $y - $distance],
                                              [$x + $distance, $y + $distance],
                                              [$x + $distance, $y - $distance],
                                              [$x - $distance, $y + $distance],
                                              [$x - $distance, $y - $distance];

        }
    }
}



my $board = 'Board'->new;
my @queens;

while (@queens < 8) {
    my $queen = 'Queen'->new(@{ $queens[-1] // [0, 0] }); # Start after the last queen.
    $queen->step until not $queen or $board->free(@$queen);

    if ($queen) {
        push @queens, $queen;
        $board->place(@$queen);

    } else {
        while (1) {
            my $queen = pop @queens;
            $board->remove(@$queen);

            do { $queen->step }
                while $queen and not $board->free(@$queen);

            if ($queen) {
                $board->place(@$queen);
                push @queens, $queen;
                last;
            }
        }
    }

}

my $i = 1;
say join ' ', $i++, $_->position for @queens;
