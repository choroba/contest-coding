#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };


{   package Langton::Ant;
    use Moo;

    use constant DIRECTION => ( [ 0, -1],
                                [ 1,  0],
                                [ 0,  1],
                                [-1,  0],
                              );


    has direction => ( is      => 'rwp',
                       default => sub { 0 },
                       coerce  => sub { $_[0] % 4 },
                     );


    has black => ( is      => 'rwp',
                   default => sub { {} },
                 );


    has X => ( is      => 'rwp',
               default => sub { 0 },
             );


    has Y => ( is      => 'rwp',
               default => sub { 0 },
             );


    sub coordinates {
        my $self = shift;
        return join ',', $self->X, $self->Y
    }


    sub left {
        my $self = shift;
        $self->_set_direction(1 + $self->direction);
    }


    sub right {
        my $self = shift;
        $self->left for 1 .. 3;
    }


    sub _step {
        my $self = shift;
        my ($x, $y) = ($self->X, $self->Y);
        my $direction = (DIRECTION)[$self->direction];
        $self->_set_X($x + $direction->[0]);
        $self->_set_Y($y + $direction->[1]);
    }


    sub is_black {
        my $self = shift;
        return exists $self->black->{ $self->coordinates }
    }


    sub _flip {
        my $self  = shift;
        my $black = $self->black;
        my $coord = $self->coordinates;
        if ($self->is_black) {
            delete $black->{$coord};
        } else {
            undef $black->{$coord};
        }
        $self->_set_black($black);
    }


    sub move {
        my $self = shift;
        $self->_flip;
        if ($self->is_black) {
            $self->right;
        } else {
            $self->left;
        }
        $self->_step;
    }


    sub count_black {
        my $self = shift;
        return scalar keys %{ $self->black }
    }
}


{   package Langton::Ant::Debug;
    use Moo;
    extends 'Langton::Ant';


    sub move {
        my $self = shift;
        $self->SUPER::move;
        $self->show;
        print "\n";
    }

    sub show {
        my $self  = shift;
        my $black = $self->black;
        my ($min_x, $min_y) = split ',', each %$black;
        my ($max_x, $max_y) = ($min_x, $min_y);
        for my $coord (keys %$black) {
            my ($x, $y) = split /,/, $coord, 2;
            $min_x = $x if $x < $min_x;
            $min_y = $y if $y < $min_y;
            $max_x = $x if $x > $max_x;
            $max_y = $y if $y > $max_y;
        }
        for my $y ($min_y .. $max_y) {
            for my $x ($min_x .. $max_x) {
                print exists $black->{"$x,$y"} ? 'X' : '-';
            }
            print "\n";
        }
    }
}


my $ant = 'Langton::Ant'->new;
$ant->move for 1 .. 1000;
say $ant->count_black;
