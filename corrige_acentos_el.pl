#!/usr/bin/perl -wl

use strict;
use DBI;

my $dbh = DBI->connect("dbi:mysql:mapsys:localhost","root")
    or die "cant connect";

our %wordList = ('Á' => [ qw(COMUNIT?RIA ?CUSTICO EST? FORMUL?RIO ?frica ?lbum P?GINA
				R?DIO ?rea ?rvore ?udio ?gua ?frika ?caros ?lvares amap?
				?ustria burocr?tico calend?rio cinematogr?fic di?rio f?brica
				 dram?tic gr?fic inform?tic infom?tic it?lia j? m?quinas
				 pal?cio priorit?rio program?tic respons?vel s?bado
				 semin?rio secret?ri tumbalal? tupinamb? van:?) ],

		 'Í' => [ qw(ESPEC?FICOS GARANT?A IL?CITOS IMPL?CITAS M?DIAS ?ndia ?ndice
				?ndice POL?TICA V?DEO MULTIM?DI ?cones ?ndios bras?lia
				 ?ris ?talo cec?lia incr?vel pa?s l?ngua log?stica
				 per?odo poss?vel sapuca? a?) ]);

#my ($x) = $dbh->selectrow_array("select data from tiki_pages where pageName='teste'");

my %tables = ('tiki_pages' => [ qw(page_id pageName description data comment) ],
	      'tiki_categories' => [ qw(categId name description) ],
	      'tiki_forums' => [ qw(forumId name description) ],
	      'tiki_comments' => [ qw(threadId data) ]);

#%tables = ('tiki_pages' => [ qw(page_id pageName) ]);

foreach my $table (keys %tables) {
    my $query = "select * from $table";
    my $sth = $dbh->prepare($query);
    $sth->execute;
    my @fields = @{$tables{$table}};
    my $pkey = shift @fields;
    while (my $row = $sth->fetchrow_hashref) {
	foreach my $field (@fields) {
	    my $newText = &convert($row->{$field});
	    if ($newText ne $row->{$field}) {
		my $sth2 = $dbh->prepare("update $table set $field=? where $pkey=?");
		$sth2->execute($newText, $row->{$pkey});
	    }
	}
    }
}

sub convert {
    my $text = shift;

    my @patt1 = (195, 63);
    my @patt2 = (226, 128, 63);

    my $buf = '';
    my $changed = 0;
    for (my $i=0; $i<length($text)-1; $i++) {
	if (substr($text,$i,1) =~ /\s/) {
	    print $buf if $changed;
	    $buf = '';
	    $changed = 0;
	} else {
	    $buf .= substr($text,$i,1);
	}
	if (ord(substr($text,$i,1)) == $patt1[0] && ord(substr($text,$i+1,1)) == $patt1[1]) {
	    my $repl = getReplacement($text, $i);
	    if ($repl) {
		substr $text, $i, 2, $repl;
	    } else {
		$changed = 1;
	    }
	} elsif (ord(substr($text,$i,1)) == $patt2[0] && ord(substr($text,$i+1,1)) == $patt2[1] && ord(substr($text,$i+2,1)) == $patt2[2]) {
	    substr $text, $i+2, 1, chr(157);
	}
    }

    print $buf if $changed;

    return $text;
}

sub getReplacement {
    my $text = shift;
    my $pos = shift;

    foreach my $repl (keys %wordList) {
	my @patterns = @{$wordList{$repl}};
	foreach my $patt (@patterns) {
	    my ($before, $after) = split /\?/, $patt;
	    return $repl
		if testWord($text, $pos, $before, $after);
	}
    }

    return 0;
}

sub testWord {
    my $text = shift;
    my $pos = shift;
    my $before = shift;
    my $after = shift;

    if ($after && lc(substr($text, $pos+2, length($after))) ne lc($after)) {
	return 0;
    }

    if ($before) {
	my $s = length($before);
	if ($s && lc(substr($text, $pos-$s, $s)) ne lc($before)) {
	    return 0;
	}
    }

    return 1;
}
