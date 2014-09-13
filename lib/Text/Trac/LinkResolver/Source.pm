package Text::Trac::LinkResolver::Source;

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
    my ( $file, $rev ) = ( $target =~ m/([^#]+)(?:#(\d+))?/ );

    my $url = $c->{trac_source_url} || $c->trac_url . "browser/";
    $url .= $file;
    $url .= "?rev=$rev" if $rev;

    return sprintf '<a class="source" href="%s">%s</a>', $url, $label;
}

1;
