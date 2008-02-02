package Text::Trac::P;
use strict;
use base qw(Text::Trac::BlockNode);
use Text::Trac::Text;

sub parse {
    my ( $self, $l ) = @_;
    my $c = $self->{context};

    if( !@{$c->in_block_of} or $c->in_block_of->[-1] ne 'p' ){
        $c->htmllines('<p>');
        push @{$c->in_block_of}, 'p';
    }

    # define block parsers called.
    $self->block_nodes( [ qw( blockquote hr ) ]);
    $self->block_parsers( $self->_get_parsers('block') );

    $c->unshiftline;
    while($c->hasnext){
        last if( $c->nextline  =~ /^$/ );
        my $l = $c->shiftline;

        # parse other block nodes
        my $parsers = $self->_get_matched_parsers('block', $l);
        if( grep { ref($_) ne 'Text::Trac::P' } @{$parsers} ){
            #$c->htmllines($l);
            $c->htmllines('</p>');
            pop @{$c->in_block_of};
            $c->unshiftline;
            last;
        }

        # parse inline nodes
        #$parsers = $self->_get_matched_parsers('inline', $l);
        #for ( @{$parsers} ){
        #    $l = $_->parse($l);
        #}
        $l = $self->replace($l);
        $c->htmllines($l);
    }

    if( @{$c->in_block_of} and $c->in_block_of->[-1] eq 'p' ){
        $c->htmllines('</p>');
        pop @{$c->in_block_of};
    }

    return;
}

1;
