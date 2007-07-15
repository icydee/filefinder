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
use FileFinder::Schema2;
#use FileFinder::Schema::Folder;
#use FileFinder::Schema2::DocTree;

my $schema  = FileFinder::Schema->connect('dbi:mysql:dbname=filefinder', 'payex', 'payex56');
my $schema2 = FileFinder::Schema2->connect('dbi:mysql:dbname=docs2manage2', 'payex', 'payex56');

my $doc_tree_rs = $schema2->resultset('DocTree');
my $doc_main_rs = $schema2->resultset('DocMain');
my $doc_pic_rs  = $schema2->resultset('DocPic');

my $folder = $schema->resultset('Folder')->find(1);

recurse_children($doc_tree_rs, $doc_main_rs, $folder);

sub recurse_children {
    my ($doc_tree_rs, $doc_main_rs, $folder) = @_;
    return if $folder->id == 832;

    $doc_tree_rs->create({
        DOCTREENODE_ID  => $folder->id,
        DOCGROUP_ID     => 1,
        PARENTNODE_ID   => $folder->parent_id ? $folder->parent_id : -1,
        NODENAME        => $folder->description,
    });

    #
    # Get all documents in this folder
    #
    my $document_rs = $schema->resultset('Document')->search({folder => $folder->id});
    while (my $document = $document_rs->next) {
        $doc_main_rs->create({
            DOC_ID          => $document->id,
            DATEENTERED     => '2007-07-14 00:00:00',
            DATEOFDOC       => '2007-07-14 00:00:00',
            UPDATEDATETIME  => '2007-07-14 00:00:00',
            IMPORTANCE      => $document->description,
            DOCGROUP_ID     => 1,
            DOCTREENODE_ID  => $folder->id,
            DOCUSER_ID      => 1,
        });

        #
        # Get all the pages for this document
        #
        my $dir = "/var/sandbox/filefinder/root/data/".$document->zipfilename;

        if (opendir DIR, $dir) {
            my @files = map "$dir/$_", sort grep /^x...\.tif$/, readdir DIR;
            closedir DIR;

            my $page = 1;
            for my $file (@files) {
                my $docs2dir = sprintf("%08d", int($document->id / 100) * 100);
                my $docs2file = sprintf("%09d_%04d", $document->id, $page);
                `mkdir /var/sandbox/filefinder/root/data/docs2-2/$docs2dir`;
                `cp $file /var/sandbox/filefinder/root/data/docs2-2/$docs2dir/$docs2file`;
                print "[$docs2dir][$docs2file]\n";

                $doc_pic_rs->create({
                    DOC_ID          => $document->id,
                    DOCNUM         => $page,
                    SRCFILENAME     => 'TIF1',
                    UPDATEDATETIME  => '2007-07-14 00:00:00',
                    ISDBSTORAGE     => 0,
                });

                $page++;
            }
        }
        else {
            print "WARNING: can't open dir $dir\n";
        }
    }

    #
    # Now recurse all children
    #
    for my $child_folder ($folder->children) {
        recurse_children($doc_tree_rs, $doc_main_rs, $child_folder);
    }
}


#my $folder_rs   = $schema->resultset('Folder')->search;
#
#while (my $folder = $folder_rs->next) {
#    next if $folder->id == 0;
#    $doc_tree_rs->create({
#        DOCTREENODE_ID  => $folder->id,
#        DOCGROUP_ID     => 1,
#        PARENTNODE_ID   => $folder->parent_id ? $folder->parent_id : -1,
#        NODENAME        => $folder->description,
#    });
#
#    #
#    # Get all documents in this folder
#    #
#    my $document_rs = $schema->resultset('Document')->search({folder => $folder->id});
#    while (my $document = $document_rs->next) {
#        $doc_main_rs->create({
#            DOC_ID          => $document->id,
#            DATEENTERED     => '2007-07-14 00:00:00',
#            DATEOFDOC       => '2007-07-14 00:00:00',
#            UPDATEDATETIME  => '2007-07-14 00:00:00',
#            IMPORTANCE      => $document->description,
#            DOCGROUP_ID     => 1,
#            DOCTREENODE_ID  => $folder->id,
#            DOCUSER_ID      => 1,
#        });
#    }
#}

1;
