use strict;
use warnings;
use Test::More tests => 3;
use File::Temp qw(tempdir);
use Path::Tiny qw(path);

my $dir = tempdir( CLEANUP => 1 );

subtest usage => sub {
	plan tests => 1;
	my $out = qx{$^X script/trac2html.pl};
	like $out, qr{Usage: script/trac2html.pl};
	#diag $out;
};

subtest padre_debian => sub {
	plan tests => 1;
	my $out = qx{$^X script/trac2html.pl --infile t/corpus/padre_debian.trac --outfile $dir/debian.html};
	my $html = path("$dir/debian.html")->slurp_utf8;
	like $html, qr{<h1 id="DebianInstallationInstructions">Debian Installation Instructions</h1>}, 'h1';
};

subtest padre_fedora => sub {
	plan tests => 1;
	my $out = qx{$^X script/trac2html.pl --infile t/corpus/padre_fedora.trac --outfile $dir/fedora.html};
	my $html = path("$dir/fedora.html")->slurp_utf8;
	like $html, qr{<h1 id="FedoraInstallationInstructions">Fedora Installation Instructions</h1>}, 'h1';
};

