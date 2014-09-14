use strict;
use warnings;
use Test::More tests => 1;

my $out = qx{$^X script/trac2html.pl};
like $out, qr{Usage: script/trac2html.pl};
#diag $out;
