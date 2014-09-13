package Text::Trac::Pre;

use strict;
use base qw(Text::Trac::BlockNode);

our $VERSION = '0.16';

sub init {
    my $self = shift;
    $self->pattern(qr/^{{{$/xms);
    return $self;
}

sub parse {
    my ( $self, $l ) = @_;
    my $c = $self->{context};
    my $pattern = $self->pattern;
    $l =~ /$pattern/ or return $l;
    my $match = $1;

    if ( $l =~ /^{{{$/ ){
        $c->htmllines('<pre class="wiki">');
    }

    while($c->hasnext){
        my $l = $c->shiftline;
        if ( $l =~ /^}}}$/) {
            $c->htmllines('</pre>');
            last;
        }
        else {
            $c->htmllines($self->escape($l));
        }
    }

    return;
}


1;
