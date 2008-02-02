package Text::Trac::LinkResolver::Report;

use strict;
use base qw( Text::Trac::LinkResolver );

sub init {
    my $self = shift;
    $self->{pattern} = '!?\{\d+\}';
}

sub format_link {
    my ( $self, $match, $target, $label ) = @_;
    return $match if $self->_is_disabled;

    my $c = $self->{context};
    $label  ||= $match;
    my ( $rev ) = ( $match =~ m/(\d+)/ );


    my $url = $c->{trac_report_url} || $c->trac_url . "report/";
    $url .= $rev;
    return sprintf '<a class="report" href="%s">%s</a>', $url, $label;
}

1;
