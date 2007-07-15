package FileFinder::Schema2::DocTree;
#
# $HeadURL: svn+ssh://dev.horivert.com/var/svn/payex/vertex/trunk/lib/Horivert/Vertex/Schema/User.pm $
# $LastChangedRevision: 989 $
# $LastChangedDate: 2006-12-22 15:58:51 +0000 (Fri, 22 Dec 2006) $
# $LastChangedBy: gsultan $
#

use strict;

use base qw(DBIx::Class);

__PACKAGE__->load_components(qw(Tree::AdjacencyList Core));
__PACKAGE__->table('DOCTREE');
__PACKAGE__->add_columns(qw(DOCTREENODE_ID DOCGROUP_ID PARENTNODE_ID NODENAME));
__PACKAGE__->set_primary_key('DOCTREENODE_ID');

__PACKAGE__->parent_column('PARENTNODE_ID');

#__PACKAGE__->has_many('documents' => 'FileFinder::Schema2::Documents', 'folder');

1;
