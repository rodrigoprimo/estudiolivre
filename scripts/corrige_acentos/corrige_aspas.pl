#!/usr/bin/perl -w

use strict;
use DBI;

our $dbh = DBI->connect("dbi:mysql:estudiolivre_teste:localhost","root")
    or die "cant connect";

my $query = "select * from tiki_pages";
my $sth = $dbh->prepare($query);
$sth->execute;

while (my $row = $sth->fetchrow_hashref) {
    my $newText = &convert($row->{'data'});
    
    if (defined $row->{'data'} and $newText ne $row->{'data'}) {
	my $sth2 = $dbh->prepare("update tiki_pages set `data`=? where pageName=?");
	$sth2->execute($newText, $row->{'pageName'});
    }
}

sub convert {
    my $text = shift || '';

    my $patt = join '', map { chr($_) } (239,191,189);

    $text =~ s/$patt\?+/\"/g;

    return $text;
}
