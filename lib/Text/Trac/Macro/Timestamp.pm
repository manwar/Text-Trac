package Text::Trac::Macro::Timestamp;

use strict;
use warnings;

sub process {
    my $class = shift;
    return '<b>' . localtime(time) . '</b>';
}

1;
