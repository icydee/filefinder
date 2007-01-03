package FileFinder::Controller::Folder::Content;
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
# URI /folder/xxx/content
#
sub content : PathPart('content') Chained('/folder/folder_path') Args(0) {
    my ($self, $c) = @_;

    $c->stash->{template}   = "folder/content.tt";
    my $folder = $c->stash->{folder};
    my $parent = $folder;
        
    #
    # Get all the parent folders
    #
    my @folders = ();
    while ($parent->id != 1) {
        unshift(@folders, $parent);
        $parent = $parent->parent();
    }
    unshift(@folders, $parent);
    $c->stash->{breadcrumb} = \@folders;
    
    #
    # Show all the children folders in this folder
    #
    my @children = sort {$a->description cmp $b->description} $folder->children;
    $c->stash->{children} = \@children;
    
    #
    # Show all the documents in this folder
    #
    my @documents = sort {$a->description cmp $b->description} $folder->documents;
    $c->stash->{documents} = \@documents;
}

1;
