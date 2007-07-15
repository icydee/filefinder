package FileFinder::Model::DBIC2;
#
# $HeadURL: svn+ssh://dev.horivert.com/var/svn/payex/vertex/trunk/lib/FileFinder/Model/DBIC.pm $
# $LastChangedRevision: 952 $
# $LastChangedDate: 2006-12-04 09:11:52 +0000 (Mon, 04 Dec 2006) $
# $LastChangedBy: icydee $
#

use strict;

use base qw(Catalyst::Model::DBIC::Schema);

# TODO:
# The connection information here should be taken from the config file
#

__PACKAGE__->config(
    schema_class    => 'FileFinder::Schema2',
    connect_info    => [
        'DBI:mysql:host=localhost;database=docs2manage2',
        'payex',
        'payex56',
        { AutoCommit => 1 },
        ],
    );

1;
