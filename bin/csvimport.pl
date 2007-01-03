#!/usr/bin/perl
#
# $HeadURL: https://svn.oucs.ox.ac.uk/projects/alumni-email/branches/devel3/catalyst-oxford-alumniemail/bin/expire-sessions.pl $
# $LastChangedRevision: 381 $
# $LastChangedDate: 2006-05-19 09:10:50 +0100 (Fri, 19 May 2006) $
# $LastChangedBy: chrisa $
#

use strict;
use warnings;

use lib q[/var/sandbox/filefinder/lib];

use Data::Dumper;
use Template;
use Text::CSV;
use FileFinder::Schema;
use FileFinder::Schema::Folder;
use FileFinder::Schema::Document;

my $verbose = @ARGV && ($ARGV[0] eq "-v" || $ARGV[0] eq "--verbose");

#
# Read in the Folder.CSV file
#
open FFH, "<../root/data/Folder.CSV" or die "Cannot open Folder.CSV\n";

my $csv = Text::CSV->new({binary => 1});
my @columns;

my $schema = FileFinder::Schema->connect('dbi:mysql:dbname=filefinder', 'payex', 'payex56');

print "###schema = $schema\n";

my $folder_rs = $schema->resultset('Folder');

#
# ignore the first line
#
my $line = <FFH>;

while ($line = <FFH>) {
    if ($csv->parse($line)) {
        @columns = $csv->fields();
        print "## ".scalar(@columns)." ## $line";

        #
        # Create a Folder object
        #
        $folder_rs->create({
            id          => $columns[0]+1,
            parent      => $columns[1]+1,
            description => $columns[2],
            node_level  => $columns[3],
        });
    }
    else {
        print "ERROR: $line";
    }
}
close FFH;

#
# Read in the Documents.CSV file
#
open FFH, "<../root/data/Document.CSV" or die "Cannot open Document.CSV\n";

$csv = Text::CSV->new({binary => 1});

my $document_rs = $schema->resultset('Document');

#
# ignore the first line
#
my $line = <FFH>;

while (my $line = <FFH>) {
    if ($csv->parse($line)) {
        @columns = $csv->fields();
        print "## ".scalar(@columns)." ## $line";

        # remove the '.zip' from the zipfilename
        $columns[7] =~ s/(.*)\.zip/$1/;
        
        #
        # Create a Document object
        #
        $document_rs->create({
            id              => $columns[0]+1,
            folder          => $columns[1]+1,
            description     => $columns[2],
#            date            => $columns[3],
            type            => $columns[4],
            archived        => $columns[5],
            filename        => $columns[6],
            zipfilename     => $columns[7],
#            last_accessed   => $columns[8],
#            last_modified   => $columns[9],
            archive_flag    => $columns[10],
            full_path       => $columns[11],
            comments        => $columns[12],
        });
    }
    else {
        print "ERROR: $line";
    }
}
close FFH;



1;
