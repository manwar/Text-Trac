package Text::Trac::Macro;
use strict;
use base qw(Text::Trac::InlineNode Class::Accessor::Fast);
use UNIVERSAL::require;
use Text::ParseWords qw(quotewords);

our $VERSION = '0.16';

__PACKAGE__->mk_accessors( 'pattern' );

sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
    return $self;
}

sub parse {
    my ( $self, $name, $args, $match ) = @_;
    my $c = $self->{context};

    my @args  = quotewords( ',\s*', 0, $args ) if $args;
    map { s/^\s+|\s+$//g } @args;

    foreach my $class ("Text::Trac::Macro::$name", $name) {
        if ( $class->require ) {
            $match = $class->process( $c, @args ) || '';
            last;
        }
    }

    return $match;
}

1;
