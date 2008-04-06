package Text::Trac::Blockquote;

use strict;
use base qw( Text::Trac::BlockNode );

sub init {
    my $self = shift;
    $self->pattern(qr/^(?:>|\s+(?![*\s]|[\daiAI]\.\ +).+$)/);
    $self->block_nodes([ qw( heading p ul ol ) ]);
}

sub parse {
    my ( $self, $l ) = @_;
    my $c = $self->{context};
    my $pattern = $self->pattern;
    return if $l =~ /::$/;

    if ( $l =~ /^(>+).+/ ) {
        my $depth = length $1;
        my $blockquote_depth = 0;
        for ( @{$c->in_block_of} ) {
            $blockquote_depth++ if $_ eq 'blockquote';
        }

        if ( $depth > $blockquote_depth ) {
            for ( 1 .. $depth ) {
                $c->htmllines('<blockquote class="citation">');
                push @{$c->in_block_of}, 'blockquote';
            }
        }
    }
    else {
        $c->htmllines('<blockquote>');
        push @{$c->in_block_of}, 'blockquote';
    }

    $c->unshiftline;
    while( $c->hasnext ){
        last if( $c->nextline =~ /^\s*$/ );
        my $l = $c->shiftline;

        if ( $l =~ /^(>+).+/ ) {
            my $depth = length $1;
            my $blockquote_depth = 0;
            for ( @{$c->in_block_of} ) {
                $blockquote_depth++ if $_ eq 'blockquote';
            }

            if ( $depth < $blockquote_depth ) {
                $c->unshiftline;
                last;
            }
        }

        # parse other block nodes
        my $block_parsers = $self->_get_matched_parsers('block', $l);
        for my $parser ( @{$block_parsers} ){
            $l = $parser->parse($l);
        }

        # parse inline nodes
        my $inline_parsers = $self->_get_matched_parsers('inline', $l) if $l;
        for my $parser ( @{$inline_parsers} ){
            $l = $parser->parse($l);
        }

        $c->htmllines($l);
    }

    if ( @{$c->in_block_of} and $c->in_block_of->[-1] eq 'blockquote' ) {
        pop @{$c->in_block_of};
        $c->htmllines('</blockquote>');
    }

    return $l;
}


1;
