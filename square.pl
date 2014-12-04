#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say);

use Data::Dumper;

{   package Square;
    use List::Util qw(sum);

    my %found;

    sub new {
        my ($class, $size) = @_;
        bless [ map [], 1 .. $size ], $class;
    }

    sub magic {
        my $self = shift;
        my $size = $self->size;
        return sum(1 .. $size ** 2) / $size;
    }

    sub used {
        my $self = shift;
        return grep defined, map @$_, @$self;
    }

    sub set {
        my ($self, $x, $y, $value) = @_;
        my $old = $self->[$x][$y];
        {
            local $self->[$x][$y];
            die if grep $_ && $_ == $value, $self->used;
        }
        $self->[$x][$y] = $value;
    }

    sub unset {
        my ($self, $x, $y) = @_;
        die unless $self->[$x][$y];
        undef $self->[$x][$y];
    }

    sub check {
        my $self  = shift;
        my $size  = $self->size - 1;
        my $magic = $self->magic;
        for my $column (@$self) {
            my $sum = sum(grep defined, @$column) // 0;
            return if $sum != $magic;
        }
        for my $row (0 .. $size) {
            my $sum = sum(grep defined, map $_->[$row], @$self) // 0;
            return if $sum != $magic;
        }
        my ($diag1, $diag2) = (0, 0);
        for my $i (0 .. $size) {
            $diag1 += $self->[$i][$i] // 0;
            $diag2 += $self->[$i][$size-$i] // 0;
        }
        return if $diag1 != $magic or $diag2 != $magic;
        return 1;
    }

    sub partial_check {
        my $self = shift;
        my $size  = $self->size;
        my $magic = $self->magic;
        for my $column (@$self) {
            my @relevant = grep defined, @$column;
            my $sum = sum(0, @relevant);
            return if $sum > $magic or @relevant == $size && $sum < $magic;
        }
        for my $row (0 .. $size - 1) {
            my @relevant = grep defined, map $_->[$row], @$self;
            my $sum = sum(0, @relevant);
            return if $sum > $magic or @relevant == $size && $sum < $magic;
        }
        my (@diagonal);
        for my $i (0 .. $size - 1) {
            push @{ $diagonal[0] }, $self->[$i][$i] if $self->[$i][$i];
            push @{ $diagonal[1] }, $self->[$i][$size-$i] if $self->[$i][$size-$i];
        }
        for my $d (0, 1) {
            my $sum = sum(0, @{ $diagonal[$d] });
            return if $sum > $magic or $size == @{ $diagonal[$d] } && $sum < $magic;
        }
        return 1;
    }

    sub size {
        my $self = shift;
        scalar @$self;
    }

    sub show {
        my $self = shift;
        my $size = $self->size;
        my $max = $size ** 2;
        my $width = length $max;
        $size--;
        for my $y (0 .. $size) {
            for my $x (0 .. $size) {
                printf " %${width}s", $self->[$x][$y] // '.';
            }
            print "\n";
        }
        print "\n";
    }

    sub first_empty {
        my $self = shift;
        my $size = $self->size - 1;
        for my $y (0 .. $size) {
            for my $x (0 .. $size) {
                return($x, $y) unless $self->[$x][$y];
            }
        }
    }

    sub fill {
        my $self = shift;
        my $size = $self->size;
        my @used = $self->used;
        my @free = grep { my $v = $_; not grep $v == $_, @used } 1 .. $size ** 2;
        if (!@free) {
            if ($self->check) {
                $self->show;
                $found{$self} = 1;
            }
        }
        for my $fr (@free) {
            my ($x, $y) = $self->first_empty;
            $self->set($x, $y, $fr);
            $self->partial_check and $self->fill;
            $self->unset($x, $y);
        }
    }

    sub success {
        my $self = shift;
        return $found{$self};
    }

}

my $square = 'Square'->new(3);

# Comment the following line to generate some squares.
$square->set(1, 0, 8);

$square->fill;
die "Not possible\n" unless $square->success;
