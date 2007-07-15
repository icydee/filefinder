package FileFinder::Controller::Folder2;
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
# URI /folder2/(folder id)/xxx/yyy
#
sub folder_path : PathPart('folder2') Chained('/') CaptureArgs(1) {
    my ($self, $c, $folder2_id) = @_;

    if ($folder2_id) {
        my $folder2 = $c->model('DBIC2::DocTree')->find($folder2_id);
        if ($folder2) {
            $c->stash->{folder2} = $folder2;
            return;
        }
    }
    #
    # Must decide at some point how to handle such errors
    #
    die "no such folder2 [$folder2_id]";
}

1;
