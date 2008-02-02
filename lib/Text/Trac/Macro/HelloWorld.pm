package Text::Trac::Macro::HelloWorld;

use strict;
use warnings;

sub process {
    my ( $class, $c, @args ) = @_;
    return "Hello World, args = " . join ', ', @args;
}

1;
