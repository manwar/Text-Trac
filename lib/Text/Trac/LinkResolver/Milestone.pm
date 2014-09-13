package Text::Trac::LinkResolver::Milestone;

use strict;
use base qw( Text::Trac::LinkResolver );

our $VERSION = '0.16';

sub init {
    my $self = shift;
}

sub format_link {
    my ( $self, $match, $target, $label ) = @_;
    return $match if $self->_is_disabled;

    my $c = $self->{context};
    $label ||= $match;
    my ( $from, $to ) = ( $match =~ m/(\d+):(\d+)/ );

    my $url = $c->{trac_milestone_url} || $c->trac_url . "milestone/";
    $url .= $target;

    return sprintf '<a class="milestone" href="%s">%s</a>', $url, $label;
}

1;
