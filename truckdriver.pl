#!/usr/bin/perl
use warnings;
use strict;
use List::Util qw(min);


{   package Truck;

    use constant {VISITED  => 0,
                  AIM      => 1,
                  DISTANCE => 2
                 };

    sub new {
        my $class = shift;
        return bless \@_, $class;
    }

    sub visited  { shift->[VISITED]  }
    sub aim      { shift->[AIM]      }
    sub distance { shift->[DISTANCE] }

    sub uniq {
        my $self = shift;
        my %uniq;
        @uniq{ @{ $self->[VISITED] } } = ();
        return keys %uniq;
    }

    sub step {
        my ($self, $step) = @_;
        my $distance = ($self->[DISTANCE] -= $step);
        die if $distance < 0;
        push @{ $self->[VISITED] }, $self->[AIM] unless $distance;
        return not $distance;
    }

    sub show {
        my $self = shift;
        print join '->', @{ $self->[VISITED] };
        print ' (', $self->[DISTANCE], ' ', $self->[AIM], ")\n";
    }
}


{   package Distance;

    my %distance
        = ( Washington => { Pittsburgh   => 245,
                            Richmond     => 108,
                            Philadelphia => 142,
                          },
            Pittsburgh => { Richmond     => 345,
                            Philadelphia => 304,
                          },
            Richmond   => { Philadelphia => 248 },
          );

    # Make symmetric.
    for my $from (keys %distance) {
        for my $to (keys %{ $distance{$from} }) {
            $distance{$to}{$from} = $distance{$from}{$to};
        }
    }

    sub towns { keys %distance }

    sub distance { $distance{+shift}{+shift} }

}


sub start_trucks {
    my ($start, $visited) = @_;
    my @trucks;
    for my $town (grep $start ne $_, Distance::towns()) {
        push @trucks, 'Truck'->new([ @$visited ], $town, Distance::distance($start, $town));
    }
    return @trucks;
}

my $speed = 60;

my $time = 0;
my $start = 'Washington';
my @trucks = start_trucks($start, []);

my $found = 0;
while (not $found) {
    my $step = min grep $_ > 0, map $_->distance, @trucks;
    $time += $step;
    my @new;
    for my $truck (@trucks) {
        if ($truck->step($step)) {
            my $stop = $truck->aim;
            if ($stop eq $start and $truck->uniq == Distance::towns()) {
                print int($time / $speed), 'h ', $time % $speed, "m\n"
                    unless $found;
                # Uncomment to see the route:
                # $truck->show;
                $found = 1;
            }
            # Start new trucks from the reached town.
            push @new, start_trucks($stop, $truck->visited);
            undef $truck;
        }
    }
    @trucks = (@new, grep defined, @trucks);
}
