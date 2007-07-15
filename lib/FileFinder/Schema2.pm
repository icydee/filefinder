package FileFinder::Schema2;
#
# $HeadURL: svn+ssh://dev.horivert.com/var/svn/payex/vertex/trunk/lib/Horivert/Vertex/Schema.pm $
# $LastChangedRevision: 989 $
# $LastChangedDate: 2006-12-22 15:58:51 +0000 (Fri, 22 Dec 2006) $
# $LastChangedBy: gsultan $
#

use strict;

use base qw(DBIx::Class::Schema);

__PACKAGE__->load_classes(qw(DocTree DocMain DocPic));

1;
