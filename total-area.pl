#!/usr/bin/perl
use warnings;
use strict;


=head1 Some math.

           A = 2 * P
 (a * b) / 2 = 2 * (a + b + c)
  a * b      = 4 * (a + b+ c)                 (1)

Euclid's formula: There are p, q > 0 such that

 a = p^2 - q^2
 b = 2 * p * q
 c = p^2 + q^2                                (2)

From (1) and (2):
   (p^2 - q^2) * 2 * p * q = 4 * (p^2 - q^2 + 2 * p * q + p^2 + q^2)
   (p^2 - q^2) * 2 * p * q = 4 * (2 * p^2 + 2 * p * q)
   (p^2 - q^2) *     p * q = 4 * p^2 + 4 * p * q
 (p + q) * (p - q) * p * q = 4 * p * (p + q)

We can divide both sides of the equation with (p + q), because p, q > 0.

           (p - q) * p * q = 4 * p
           (p - q) *     q = 4                (3)
               p * q - q^2 = 4
               p           = (4 + q^2) / q    (4)

We know that 4 = 2 * 2 = 1 * 4. From (3):

 q in {1, 2, 4}                               (5)

=cut

{   package Triangle;

    sub new {
        my ($class, $p, $q) = @_;
        return bless [$p, $q], $class;
    }

    sub _sides {
        my $self = shift;
        my ($p, $q) = @$self;
        return ($p ** 2 - $q ** 2, 2 * $p * $q, $p ** 2 + $q ** 2);
    }

    sub area {
        my $self = shift;
        my ($x, $y) = $self->_sides;
        return $x * $y / 2;
    }

}

for my $q (1, 2, 4) {                # See (5) above.
    my $p = (4 + $q ** 2) / $q;      # See (4) above.
    my $t = 'Triangle'->new($p, $q);
    print $t->area, "\n";
}
