#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok('Text::Trac');
}

diag("Testing Text::Trac $Text::Trac::VERSION, Perl $], $^X");
