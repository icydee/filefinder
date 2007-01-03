package Horivert::Vertex::Validate;
#
# $HeadURL: svn+ssh://dev.horivert.com/var/svn/payex/vertex/trunk/lib/Horivert/Vertex/Validate.pm $
# $LastChangedRevision: 952 $
# $LastChangedDate: 2006-12-04 09:11:52 +0000 (Mon, 04 Dec 2006) $
# $LastChangedBy: icydee $
#

use strict;
use warnings;

# TODO:
# We need to document exactly what this module does!
#

sub stash {
    my ($c) = @_;

    #
    # Flag errors on missing fields
    #
    for my $missing ($c->form->missing) {
        $c->stash->{missing}{$missing} = 1;
    }

    #
    # Flag errors on invalid fields
    #
    for my $invalid ($c->form->invalid) {
        for my $constraint (@{$c->form->invalid($invalid)}) {
            $c->stash->{invalid}{$invalid}{$constraint} = 1;
        }
    }
}

1;
