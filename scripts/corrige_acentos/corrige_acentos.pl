#!/usr/bin/perl -w

use strict;
use DBI;

our $dbh = DBI->connect("dbi:mysql:mapsys:localhost","root",`cat /etc/senha_mysql`)
    or die "cant connect";

our %charMap = ('Á' => "a",
		'Í' => "i",
		'?' => "x");

our %mapChar = map { $charMap{$_} => $_ } keys %charMap;

our %wordList;

foreach my $char (keys %charMap) {
    $wordList{$char} = getDictionary($charMap{$char});
}

my %tables = getDatabaseStructure();

foreach my $table (keys %tables) {
    my $query = "select * from $table";
    my $sth = $dbh->prepare($query);
    $sth->execute;
    my @fields = @{$tables{$table}};
    my $pkey = shift @fields;
    while (my $row = $sth->fetchrow_hashref) {
	foreach my $field (@fields) {
	    my $newText = &convert($row->{$field}) || '';
	    if (defined $row->{$field} and $newText ne $row->{$field}) {
		my $sth2 = $dbh->prepare("update $table set $field=? where $pkey=?");
		$sth2->execute($newText, $row->{$pkey});
	    }
	}
    }
}

sub getDatabaseStructure {
    my %struct;

    my $sth = $dbh->prepare("show databases");
    $sth->execute;

    while (my $row = $sth->fetchrow_hashref) {
	next if $row->{Database} =~ /^test|information_schema|mysql$/;
	my $db = $row->{Database};
	
	$dbh->do("use $db");
	
	my $sth2 = $dbh->prepare("show tables");
	$sth2->execute;
	while (my $row2 = $sth2->fetchrow_hashref) {
	    my $table = $row2->{"Tables_in_".$db};
	    
	    my ($pkey, @fields);
	    
	    my $sth3 = $dbh->prepare("describe $table");
	    $sth3->execute;
	    my $valid = 1;
	    while ($valid and my $row3 = $sth3->fetchrow_hashref) {
		if ($row3->{Key} eq 'PRI') {
		    if ($pkey) {
			undef @fields;
			undef $pkey;
			$valid = 0;
		    }
		    $pkey = $row3->{Field};
		} elsif ($row3->{Type} =~ /char|text/) {
		    push @fields, $row3->{Field};
		}
	    }
	    
	    if ($pkey && @fields) {
		$struct{$db . '.' . $table} = [$pkey, @fields];
	    }
	}
    }

    return %struct;
}

sub getDictionary {
    my $dict = shift;
    my $file = 'dict_' . $dict . '.txt';

    open ARQ, $file
	or die "can't open $file";
    
    my @dict;
    while (my $word = <ARQ>) {
	chomp $word;
	push @dict, $word
	    if $word =~ /\S/;
    }

    close ARQ;

    return \@dict;
}

sub addWord {
    my $dict = shift;
    my $word = shift;

    my $file = 'dict_' . $dict . '.txt';

    open ARQ, ">>$file"
	or die;
    print ARQ $word, "\n";
    close ARQ;

    push @{$wordList{$mapChar{$dict}}}, $word;    
}

sub convert {
    my $text = shift || '';

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

    return askWord($text, $pos);
}

sub askWord {
    my $text = shift;
    my $pos = shift;

    my $before = substr($text,$pos-20,20);
    my $after  = substr($text,$pos+2,20);

    my $suggestion = '';
    if ($before =~ /([a-z]+)$/i) {
	$suggestion .= $1;
    }
    $suggestion .= '?';
    if ($after =~ /^([a-z]+)/i) {
	$suggestion .= $1;
    }

    print $before, "?", $after, "\n";
    print "pattern ($suggestion) : ";
    my $word = <>;
    print "char: ";
    my $char = <>;

    chomp $word;
    chomp $char;

    $word ||= $suggestion;

    addWord($char, $word);
    return $mapChar{$char};
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
