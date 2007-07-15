package FileFinder::Schema2::DocPic;
#
# $HeadURL: svn+ssh://dev.horivert.com/var/svn/payex/vertex/trunk/lib/Horivert/Vertex/Schema/User.pm $
# $LastChangedRevision: 989 $
# $LastChangedDate: 2006-12-22 15:58:51 +0000 (Fri, 22 Dec 2006) $
# $LastChangedBy: gsultan $
#

use strict;

use base qw(DBIx::Class);

__PACKAGE__->load_components(qw(Core));
__PACKAGE__->table('DOCPIC');
__PACKAGE__->add_columns(qw(DOC_ID DOCNUM DOCNAME DOCNOTES SRCFILENAME DOCPIC UPDATEDATETIME ISDBSTORAGE COMPRESSIONLEVEL));
__PACKAGE__->set_primary_key('DOC_ID');


1;
