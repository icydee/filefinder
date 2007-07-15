#!/usr/bin/perl
#
# $HeadURL: https://svn.oucs.ox.ac.uk/projects/alumni-email/branches/devel3/catalyst-oxford-alumniemail/bin/expire-sessions.pl $
# $LastChangedRevision: 381 $
# $LastChangedDate: 2006-05-19 09:10:50 +0100 (Fri, 19 May 2006) $
# $LastChangedBy: chrisa $
#

#
# Convert multi-page tiff files into separate tiff files
#

use strict;
use warnings;

use lib q[/var/sandbox/filefinder/lib];

use File::Find;

#
# Recurse directories
#
find(\&wanted, "../root/data");

my $count = 0;

sub wanted {
    my $filename = $_;
    if ($filename =~ m/\.tif$/) {
        print "FILE: $filename [$count]\n";
        $count++;
#        `tiffsplit $filename`;
#        sleep(1);
    }
    else {
#        print "DIR:  $filename\n";
    }
}

print "there are $count new tif files\n";
1;
