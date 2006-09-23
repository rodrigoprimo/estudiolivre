#!/usr/bin/perl -w

use strict;

my $x = <>;
while ($x =~ /(\('(.+?)',\d+\))/g) {
    my $pat = $1;
    # "Áreas"
    if ($2 =~ /^(.{1,4})reas$/) {
	print "INSERT INTO `search_total` VALUES $pat;\n";
	print "# " , map({ ord($_), " " } split //, $1);
	print "\n";
    }
}
