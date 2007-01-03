package Horivert::Vertex::Grid;
#
# $HeadURL: svn+ssh://dev.horivert.com/var/svn/payex/vertex/trunk/lib/Horivert/Vertex/Grid.pm $
# $LastChangedRevision: 952 $
# $LastChangedDate: 2006-12-04 09:11:52 +0000 (Mon, 04 Dec 2006) $
# $LastChangedBy: icydee $
#

use strict;
use warnings;
use Data::Pageset;

our @ISA = qw(Exporter);
our @EXPORT_OK = qw(grid_order_by);

sub grid_order_by {
    my ($c, $prefix, $default) = @_;
    my ($sortDir, $sortCol);

    if ($c->session->{$prefix.'_sortCol'} and $c->session->{$prefix.'_sortDir'}) {
        $sortDir = $c->session->{$prefix.'_sortDir'} eq 'asc' ? 'ASC' : 'DESC';
        $sortCol = $c->session->{$prefix.'_sortCol'};
        return "$sortCol $sortDir";
    }
    return $default;
}

1;
