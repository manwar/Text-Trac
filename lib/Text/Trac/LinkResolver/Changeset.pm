package Text::Trac::LinkResolver::Changeset;

use strict;
use base qw( Text::Trac::LinkResolver );

sub init {
    my $self = shift;
    $self->{pattern} = '!?\[\d+\]|(?:\b|!)r\d+\b(?!:\d)';
}

sub format_link {
    my ( $self, $match, $target, $label ) = @_;
    return $match if $self->_is_disabled;

    my $c = $self->{context};
    $label ||= $match;
    my ( $rev ) = ( $match =~ m/(\d+)/ );

    my $url = $c->{trac_changeset_url} || $c->trac_url . "changeset/";
    $url .= $rev;
    return sprintf '<a class="changeset" href="%s">%s</a>', $url, $label;
}

1;
