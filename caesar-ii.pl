#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say state);

main('bird');


INIT {
    package My::Crypt;

    use constant CHARS => ord('z') - ord('a');

    my $_char = sub {
        my ($char, $n) = @_;
        $n += ord $char;
        while (($char le 'Z' and $n > ord 'Z')
            or
            ($char ge 'a' and $n > ord 'z')) {
            $n -= CHARS + 1;
        }
        return chr $n;
    };


    sub new {
        my ($class, $word) = @_;
        bless { word => $word, n => 0 }, $class;
    }


    sub following {
        my $self = shift;
        my $n = ++$self->{n};
        return join q(), map { $_char->($_, $n) } split //, $self->{word};
    }


    sub key {
        my $self = shift;
        return ('a', $self->decrypt('a'));
    }


    sub decrypt {
        my ($self, $string) = @_;
        my $n = 1 + CHARS - $self->{n};
        $n += CHARS while $n < 0;
        $string =~ s/([[:alpha:]])/$_char->($1, $n)/ge;
        return $string;
    }
}


sub main {
    my $known = lc shift;
    state $encrypted = do { local $/; <DATA> };
    my %candidates;
    undef $candidates{lc $_} for grep length $known eq length,
                                      $encrypted =~ /([[:alpha:]]+)/g;
    die "Known not found\n" unless %candidates;

    my $iter = 'My::Crypt'->new(lc $known);

    while ((my $try = lc $iter->following) ne $known) {
        if (exists $candidates{$try}) {
            say 'Key: ', join ' -> ', $iter->key;
            print $iter->decrypt($encrypted);
        }
    }
}


=head1 Author

E. Choroba, 2013

=cut

__DATA__
OVSTLZ ohk illu zlhalk mvy zvtl ovbyz pu zpslujl dpao opz svun, aopu
ihjr jbyclk vcly h joltpjhs clzzls pu dopjo ol dhz iyldpun h
whyapjbshysf thsvkvyvbz wyvkbja. Opz olhk dhz zbur bwvu opz iylhza,
huk ol svvrlk myvt tf wvpua vm cpld sprl h zayhunl, shur ipyk, dpao
kbss nylf wsbthnl huk h ishjr avw-ruva.
