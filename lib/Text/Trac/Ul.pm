package Text::Trac::Ul;
use strict;
use base qw(Text::Trac::BlockNode);

sub init {
    my $self = shift;
    $self->pattern(qr/(\s+) \* \s+ (.*)$/xms);
}

sub parse {
    my ( $self, $l ) = @_;
    my $c = $self->{context};
    my $pattern = $self->pattern;
    $l =~ $pattern or return $l;

    my $space = length($1);
    my $level = $c->ul->{level} || 0;
    $c->ul->{space} ||= 0;

    if ( $space > $c->ul->{space} ) {
        for ( 1 .. ( $space + 1 ) / 2 - $level ) {
            $l = '<ul>' . $l;
            $level++;
        }
    }
    elsif ( $space < $c->ul->{space} ) {
        for ( 1 .. ( $c->ul->{space} - $space ) / 2 ) {
            $l = '</li></ul>' . $l;
            $level--;
        }
        for ( 2 .. ( $c->ul->{space} - $space ) / 2 ) {
            $l =~ s!(</ul>|</li>) !$1</li> !;
        }
    }
    else {
        $l = "</li>$l";
    }

    $c->ul({ level => $level, space => $space });

    # parse inline nodes
    if ( $l =~ /$pattern/ ) {
        $l =~ s{ $pattern }{"<li>" . $self->replace($2)}xmsge;
    }

    if ( $c->hasnext and $c->nextline =~ /$pattern/ ){
        $self->parse($l);
    }
    else {
        for ( 1 .. $c->ul->{level} ){
            $l .= '</li></ul>';
        }
        $c->ul->{level} = 0;
        $c->ul->{space} = 0;
    }

    # parse inline nodes
    $c->htmllines($l);

    return;
}

1;
