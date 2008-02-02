package Text::Trac::LinkResolver::Attachment;

use strict;
use base qw( Text::Trac::LinkResolver );

sub init {
    my $self = shift;
}

sub format_link {
    my ( $self, $match, $target, $label ) = @_;
    return $match if $self->_is_disabled;

    my $c = $self->{context};
    $label ||= $match;

    my ( $type, $name, $file ) = ( $match =~ m/attachment:([^:]+):([^:]+):([^:\]\s]+)/ );
    my $url = $c->{trac_attachment_url} || $c->trac_url . "attachment/";
    $url .= "$type/$name/$file";

    return sprintf '<a class="attachment" href="%s">%s</a>', $url, $label;
}

1;
