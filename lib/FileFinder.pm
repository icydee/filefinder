package FileFinder;
#
# $HeadURL: svn+ssh://dev.horivert.com/var/svn/payex/vertex/trunk/lib/FileFinder.pm $
# $LastChangedRevision: 989 $
# $LastChangedDate: 2006-12-22 15:58:51 +0000 (Fri, 22 Dec 2006) $
# $LastChangedBy: gsultan $
#

use strict;

use Catalyst qw(-Debug Static::Simple Session Session::Store::DBIC Session::State::Cookie FormValidator FillInForm I18N::DBIC AutoSession);

our $VERSION = '0.01';


__PACKAGE__->config(
    name        => 'FileFinder',
    root        => '/var/sandbox/filefinder/root/',
    session     => {
        dbic_class      => 'DBIC::Session',
        expires         => 3600,
    },
    'View::TT' => {
        EVAL_PERL       => 1,
    },
    'I18N::DBIC'    => {
        lexicon_model   => 'DBIC::Lexicon',
        cache           => 'on_demand',
    },

    static => {
        dirs    => ['data', 'static', 'static/images', 'static/css', 'static/javascript'],
    },

    AutoSession => {
        prefix_scalar   => 'sess_',
        prefix_list     => 'sesl_',
        exclude     => [qw(logged_in_user logged_in_username)],
    },
);

__PACKAGE__->setup;

sub auto: Private {
    my ($self, $c) = @_;

    return 1;
}

sub default : Private {
    my ( $self, $c ) = @_;
    $c->stash->{template} = "main.tt";
}



sub end : Private {
    my ($self, $c) = @_;

    # Add some bad error handling
    if ( scalar @ {$c->error} ) {
      use CGI::Carp;
      warn "FileFinder Catalyst error: \n";
      foreach my $e (@{$c->error}) {
        warn "FileFinder Catalyst error: :: $e\n";
      }
    }

    $c->forward('FileFinder::View::TT') unless $c->res->output;
}
1;
