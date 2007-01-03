package FileFinder::Controller::Folder;
#
# $HeadURL: svn+ssh://dev.horivert.com/var/svn/payex/vertex/trunk/lib/Horivert/Vertex/Controller/User.pm $
# $LastChangedRevision: 990 $
# $LastChangedDate: 2006-12-22 17:10:23 +0000 (Fri, 22 Dec 2006) $
# $LastChangedBy: icydee $
#

use strict;
use warnings;

use base 'Catalyst::Controller';

# TODO:
# Decide what to do about errors, such as the user_id being invalid
#

#
# In a Part Path URI obtain the user object
#
# URI /folder/(folder id)/xxx/yyy
#
sub folder_path : PathPart('folder') Chained('/') CaptureArgs(1) {
    my ($self, $c, $folder_id) = @_;

    if ($folder_id) {
        my $folder = $c->model('DBIC::Folder')->find($folder_id);
        if ($folder) {
            $c->stash->{folder} = $folder;
            return;
        }
    }
    #
    # Must decide at some point how to handle such errors
    #
    die "no such folder [$folder_id]";
}

1;
