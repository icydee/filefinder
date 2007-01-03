package FileFinder::Schema::Session;
#
# $HeadURL: svn+ssh://dev.horivert.com/var/svn/payex/vertex/trunk/lib/Horivert/Vertex/Schema/Session.pm $
# $LastChangedRevision: 952 $
# $LastChangedDate: 2006-12-04 09:11:52 +0000 (Mon, 04 Dec 2006) $
# $LastChangedBy: icydee $
#

use strict;

use base qw(DBIx::Class);

__PACKAGE__->load_components(qw(Core));
__PACKAGE__->table('session');
__PACKAGE__->add_columns(qw(id session_data expires));
__PACKAGE__->set_primary_key('id');

1;
