package FileFinder::Schema::Folder;
#
# $HeadURL: svn+ssh://dev.horivert.com/var/svn/payex/vertex/trunk/lib/Horivert/Vertex/Schema/User.pm $
# $LastChangedRevision: 989 $
# $LastChangedDate: 2006-12-22 15:58:51 +0000 (Fri, 22 Dec 2006) $
# $LastChangedBy: gsultan $
#

use strict;

use base qw(DBIx::Class);

__PACKAGE__->load_components(qw(Tree::AdjacencyList Core));
__PACKAGE__->table('folder');
__PACKAGE__->add_columns(qw(id parent_id description node_level));
__PACKAGE__->set_primary_key('id');

__PACKAGE__->parent_column('parent_id');

__PACKAGE__->has_many('documents' => 'FileFinder::Schema::Document', 'folder');

1;
