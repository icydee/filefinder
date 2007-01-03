package Horivert::Vertex::ResultSet;
#
# $HeadURL: svn+ssh://dev.horivert.com/var/svn/payex/vertex/trunk/lib/Horivert/Vertex/ResultSet.pm $
# $LastChangedRevision: 952 $
# $LastChangedDate: 2006-12-04 09:11:52 +0000 (Mon, 04 Dec 2006) $
# $LastChangedBy: icydee $
#

use strict;
use warnings;
use Data::Pageset;

our @ISA = qw(Exporter);
our @EXPORT_OK = qw(result_set_to_page_set);

sub result_set_to_page_set {
    my ($result_set, $pages_per_set, $mode) = @_;
    my ($pager);

    $pager = $result_set->pager;
    my $page_set = Data::Pageset->new({
        total_entries       => $pager->total_entries,
        entries_per_page    => $pager->entries_per_page,
        current_page        => $pager->current_page,
        pages_per_set       => $pages_per_set,
        mode                => $mode,
    });
    return $page_set;
}

1;
