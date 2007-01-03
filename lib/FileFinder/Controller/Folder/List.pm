package FileFinder::Controller::Folder::List;
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
# URI /folder/list
#
sub list : Path {
    my ($self, $c) = @_;

    $c->stash->{template} = "folder/list.tt";

    my $root_folder = $c->model('DBIC::Folder')->find(1);
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
    
    $c->stash->{debug} .= "search for parent ".$parent->id."\n";

#    foreach my $child ($parent->children) {
#        push(@{$dir->{children}}, $child);
##        recurse_dir($c, ${$dir->{children}}[-1], $child);
#    }
#    my $children_rc = $c->model('DBIC::Folder')->search(
#        {
#            parent => $parent->id,
#        },
#        {
#            order_by => ['description ASC'],
#        },
#        
#    );
#
#    while (my $child = $children_rc->next) {
#        $c->stash->{debug} .= "push child ".$child->id."\n";
#        push(@{$dir->{children}}, $child);
#        recurse_dir($c, ${$dir->{children}}[-1], $child);
#    }
}

1;
