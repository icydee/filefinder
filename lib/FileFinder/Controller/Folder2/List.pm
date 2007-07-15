package FileFinder::Controller::Folder2::List;
#
# $HeadURL: svn+ssh://dev.horivert.com/var/svn/payex/vertex/trunk/lib/Horivert/Vertex/Controller/User/List.pm $
# $LastChangedRevision: 989 $
# $LastChangedDate: 2006-12-22 15:58:51 +0000 (Fri, 22 Dec 2006) $
# $LastChangedBy: gsultan $
#

use strict;
use warnings;

use base 'Catalyst::Controller';

#
# Display the folders
#
# URI /folder2/list
#
sub list : Path {
    my ($self, $c) = @_;

    $c->stash->{template} = "folder2/list.tt";

    my $root_folder = $c->model('DBIC2::DocTree')->find(1);
    die unless $root_folder;

    my $dir = {};

    recurse_dir($c, $dir, $root_folder);

    $c->stash->{folders} = $dir;
    $c->stash->{root_folder} = $root_folder;
    $c->stash->{dir} = $dir;
    $c->stash->{test1} = scalar(@{$dir->{children}});
}

#
# Recurse directory
#
sub recurse_dir {
    my ($c, $dir, $parent) = @_;

    $c->stash->{dirref} = $dir;
    $dir->{parent}      = $parent;
    @{$dir->{children}} = $parent->children;

    $c->stash->{debug} .= "children = [".join('][', @{$dir->{children}})."]\n";
    $c->stash->{debug} .= "search for parent ".$parent->id."\n";
}

1;
