package FileFinder::Schema::Document;
#
# $HeadURL: svn+ssh://dev.horivert.com/var/svn/payex/vertex/trunk/lib/Horivert/Vertex/Schema/User.pm $
# $LastChangedRevision: 989 $
# $LastChangedDate: 2006-12-22 15:58:51 +0000 (Fri, 22 Dec 2006) $
# $LastChangedBy: gsultan $
#

use strict;

use base qw(DBIx::Class);

__PACKAGE__->load_components(qw(PK::Auto Core));
__PACKAGE__->table('document');
__PACKAGE__->add_columns(qw(id folder description date type archived filename zipfilename last_accessed last_modified archive_flag full_path comments));
__PACKAGE__->set_primary_key('id');

__PACKAGE__->belongs_to('folder' => 'FileFinder::Schema::Folder');

1;
