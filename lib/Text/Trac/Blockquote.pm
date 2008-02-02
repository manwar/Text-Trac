package Text::Trac::Blockquote;

use strict;
use base qw( Text::Trac::BlockNode );

sub init {
    my $self = shift;
    $self->pattern(qr/^\s+([^\s\*\daiAI].+)$/);
    $self->block_nodes([ qw( heading p ul ol ) ]);
}

sub parse {
    my ( $self, $l ) = @_;
    my $c = $self->{context};
    my $pattern = $self->pattern;
    return if $l =~ /::$/;

    $c->htmllines('<blockquote>');
    push @{$c->in_block_of}, 'blockquote';

    $c->unshiftline;
    while($c->hasnext){
        last if($c->nextline =~ /^$/);
        my $l = $c->shiftline;

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

    pop @{$c->in_block_of};
    $c->htmllines('</blockquote>');

    return $l;
}


1;
