#!/usr/bin/perl
use warnings;
use strict;


{   package Square;

    use List::Util qw(sum);

    use constant SUM => 15;

    sub new {
        my ($class, $size) = @_;
        my $self;
        push @$self, [ map undef, 1 .. $size ] for 1 .. $size;
        bless $self, $class;
    }


    sub set {
        my ($self, $x, $y, $value) = @_;
        $self->[$x][$y] = $value;
    }


    sub unset {
        my ($self, $x, $y) = @_;
        undef $self->[$x][$y];
    }


    sub show {
        my $self = shift;
        for my $y (0 .. $#$self) {
            for my $x (0 .. $#$self) {
                print $self->[$x][$y] // '.', ' ';
            }
            print "\n";
        }
        print "\n";
    }


    sub first_free {
        my $self = shift;
        for my $y (0 .. $#$self) {
            for my $x (0 .. $#$self) {
                return ($x, $y) unless defined $self->[$x][$y];
            }
        }
        return undef;
    }


    sub check {
        my $self = shift;
        my $size  = @$self;

        for my $column (@$self) {
            my @relevant = grep defined, @$column;
            my $sum = sum(0, @relevant);
            return if $sum > SUM or @relevant == $size && $sum < SUM;
        }
        for my $row (0 .. $size - 1) {
            my @relevant = grep defined, map $_->[$row], @$self;
            my $sum = sum(0, @relevant);
            return if $sum > SUM or @relevant == $size && $sum < SUM;
        }
        my (@diagonal);
        for my $i (0 .. $size - 1) {
            push @{ $diagonal[0] }, $self->[$i][$i] if $self->[$i][$i];
            push @{ $diagonal[1] }, $self->[$i][$size-$i-1] if $self->[$i][$size-$i-1];
        }
        for my $d (0, 1) {
            my $sum = sum(0, @{ $diagonal[$d] });
            return if $sum > SUM or $size == @{ $diagonal[$d] } && $sum < SUM;
        }
        return 1;
    }


    sub fill {
        my $self = shift;
        my ($x, $y) = $self->first_free;
        $self->show, exit unless defined $x;
        for my $try (1 .. SUM) {
            $self->set($x, $y, $try);
            $self->check and $self->fill;
            $self->unset($x, $y);
        }
    }

}

my $s = 'Square'->new(3);
$s->set(1, 0, 8);
$s->fill;
