package Text::Trac::Hr;

use strict;
use base qw(Text::Trac::BlockNode);

our $VERSION = '0.16';

sub init {
    my $self = shift;
    $self->pattern(qr/^----$/xms);
    return $self;
}

sub parse {
    my ( $self, $l ) = @_;
    my $c = $self->context;
    my $pattern = $self->pattern;
    $l =~ $pattern or return;

    $l =~ s{ $pattern }{<hr />}xmsg;

    $c->htmllines($l);
}

1;
