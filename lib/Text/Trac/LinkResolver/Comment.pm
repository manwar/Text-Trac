package Text::Trac::LinkResolver::Comment;

use strict;
use base qw( Text::Trac::LinkResolver );

our $VERSION = '0.16';

sub init {
    my $self = shift;
    $self->{pattern} = '!?(?<!&)comment:ticket:\d+:\d+';
}

sub format_link {
    my ( $self, $match, $target, $label ) = @_;
    return $match if $self->_is_disabled;

    my $c = $self->{context};
    $label ||= $match;
    my ( $rev,$commentId ) = ( $match =~ m/(\d+):(\d+)/ );

    my $url = $c->{trac_ticket_url} || $c->trac_url . 'ticket/';
    $url .= $rev;
    $url .= "#comment:$commentId";
    return sprintf '<a class="ticket" href="%s">%s</a>', $url, $label;
}

1;
