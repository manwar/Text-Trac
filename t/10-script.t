use strict;
use warnings;
use Test::More tests => 4;

#use Test::Differences qw(eq_or_diff);
use File::Temp qw(tempdir);
use Path::Tiny qw(path);

my $dir = tempdir( CLEANUP => 1 );

subtest usage => sub {
	plan tests => 1;
	my $out = qx{$^X script/trac2html};
	like $out, qr{Usage: script/trac2html};

	#diag $out;
};

subtest padre_debian => sub {
	plan tests => 1;
	my $out  = qx{$^X script/trac2html --infile t/corpus/padre_debian.trac --outfile $dir/debian.html};
	my $html = path("$dir/debian.html")->slurp_utf8;
	like $html, qr{<h1 id="DebianInstallationInstructions">Debian Installation Instructions</h1>}, 'h1';
};

subtest padre_fedora => sub {
	plan tests => 1;
	my $out  = qx{$^X script/trac2html --infile t/corpus/padre_fedora.trac --outfile $dir/fedora.html};
	my $html = path("$dir/fedora.html")->slurp_utf8;
	like $html, qr{<h1 id="FedoraInstallationInstructions">Fedora Installation Instructions</h1>}, 'h1';
};

subtest padre_mandriva => sub {
	plan tests => 1;
	my $out
		= qx{$^X script/trac2html --infile t/corpus/padre_download_mandriva.trac --outfile $dir/download_mandriva.html};
	my $html_generated = path("$dir/download_mandriva.html")->slurp_utf8;
	my $html_expected  = path('t/expected/padre_download_mandriva.html')->slurp_utf8;

	#eq_or_diff $html_generated, $html_expected, 'Mandriva';
	is $html_generated, $html_expected, 'Mandriva';
};

