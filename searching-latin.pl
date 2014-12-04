#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use WWW::Mechanize;
use HTML::Parser;

my $text;

sub extract_p_text {
    my ($tagname, $attr, $self) = @_;
    {   no warnings 'uninitialized';
        return if 'p' ne $tagname or 'idTextStore' ne $attr->{id};
    }

    $self->handler(text => sub { $text = shift }, 'dtext');
    $self->handler(end  => sub { shift->eof }, 'self');
}


my $n = 1865;

my $mech = 'WWW::Mechanize'->new;
$mech->get('http://www.blindtextgenerator.com/lorem-ipsum');
my $html = $mech->content;

my $parser = 'HTML::Parser'->new(api_version => 3);
$parser->handler(start => \&extract_p_text, 'tagname,attr,self');
$parser->parse($html);

my @words = split /[^[:alpha:]]+/, $text;
my $index = $n % @words;
say $words[--$index];
