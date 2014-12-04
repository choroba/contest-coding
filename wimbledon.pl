#!/usr/bin/perl
use warnings;
use strict;

{   package Wimbledon;

    use constant DEBUG => 0;

    sub new {
        bless { current_game  => [0, 0],
                current_set   => [0, 0],
                current_match => [0, 0],
              }, shift
    }

    sub lose {
        my $self = shift;
        die if exists $self->{winner};
        $self->point(1);
    }

    sub win {
        my $self = shift;
        die if exists $self->{winner};
        $self->point(0);
    }

    sub point {
        my ($self, $player) = @_;
        $self->{current_game}[$player] += 1;
        $self->{points}[$player] += 1;
        if ((exists $self->{tie} ? 7 : 4) == $self->{current_game}[$player]) {
            $self->{current_game} = [0, 0];
            $self->game($player);
        }
    }

    sub game {
        my ($self, $player) = @_;
        my $opponent = ($player + 1) % 2;
        print "Game for player $player.\n" if DEBUG;
        $self->{current_set}[$player] += 1;
        if (6 == $self->{current_set}[$player] && 4 >= $self->{current_set}[$opponent]
            or
            7 == $self->{current_set}[$player] && 5 == $self->{current_set}[$opponent]
            or exists $self->{tie}
           ) {
            if (exists $self->{tie}) {
                print "Tiebreak end.\n" if DEBUG;
                delete $self->{tie};
            }
            $self->{current_set} = [0, 0];
            $self->set($player);
        } elsif (6 == $self->{current_set}[$player] and 6 == $self->{current_set}[$opponent]) {
            undef $self->{tie};
            print "Tiebreak.\n" if DEBUG;
        }
    }

    sub set {
        my ($self, $player) = @_;
        my $opponent = ($player + 1) % 2;
        print "Set for player $player.\n" if DEBUG;
        $self->{current_match}[$player] += 1;
        if (3 == $self->{current_match}[$player]) {
            print "Player $player wins the match.\n" if DEBUG;
            $self->{winner} = $player;
        }
    }

    sub Win {
        my ($self, $count) = @_;
        $self->win for 1 .. $count;
    }

    sub Lose {
        my ($self, $count) = @_;
        $self->lose for 1 .. $count;
    }

    sub Win4_3 {
        my ($self, $count) = @_;
        $self->Lose(3), $self->Win(4) for 1 .. $count;
    }

}

my $w = 'Wimbledon'->new;

# Random:
#
# until (exists $w->{winner}) {
#     my $ball = ('win', 'lose')[int rand 2];
#     $w->$ball;
# }

$w->Lose(2 * 4 * 6); # sets: 0:2
for (1 .. 3) {
    $w->Lose(4 * 5); # 0:5
    $w->Win4_3(6);   # 6:5
    $w->Lose(4);     # 6:6
    $w->Lose(6);     # Tie 0:6
    $w->Win(7);      # Tie 7:6
}

die unless exists $w->{winner};
my $points = 0;
$points += $w->{points}[$_] for 0, 1;
my $percent = $w->{points}[ $w->{winner} ] / $points;
print $percent, "\n";
