package Text::Trac::Text;
use strict;

our $VERSION = '0.16';

sub new {
    my $class = shift;
    my %args = @_;
    my $self = {
        context => $args{context},
        html => '',
    };
    bless $self,$class;
}

sub parse {
    my $self = shift;
    $self->{html} = '';
    my $text = shift or return;
    $self->{html} = $text;
}

sub html { $_[0]->{html}; }

1;
