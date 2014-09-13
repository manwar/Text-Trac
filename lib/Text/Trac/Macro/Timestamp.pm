package Text::Trac::Macro::Timestamp;

use strict;
use warnings;

our $VERSION = '0.16';

sub process {
    my $class = shift;
    return '<b>' . localtime(time) . '</b>';
}

1;
