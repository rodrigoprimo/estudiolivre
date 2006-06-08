#!/usr/bin/perl -wl

use strict;
use DBI;

my $dbh = DBI->connect("dbi:mysql:estudiolivre_teste:localhost","root")
    or die "cant connect";

our %map = ('195-63' => 'Á');

my ($tit) = $dbh->selectrow_array("select pageName from tiki_pages where page_id=19");

print length($tit);
print $tit;

print ord(substr($tit,0,1)), " ", ord(substr($tit,1,2));

foreach my $pair (keys %map) {
    my $pattern = join('', map { chr($_) } split(/-/, $pair));
    print length($pattern);
    my $dest = $map{$pair};
    print length($dest);
    $tit =~ s/$pattern./$dest/;
}

print ord(substr($tit,0,1)), " ", ord(substr($tit,1,2));
print length($tit);
print $tit;

#$dbh->do("update tiki_pages set pageName=".$dbh->quote($tit)." where page_id=19");






