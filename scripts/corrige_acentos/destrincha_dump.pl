#!/usr/bin/perl -w

use strict;

my %problems = getProblems('import_errors.log');

my $lineNum = 0;
my $countErrors = 0;
my $currentDb;
my $linesExpanded = 0;

open ARQ, ">faltando.sql" or die $!;

while (my $line = <>) {

    if ($line =~ /^use \`(.+)\`;/i) {
	$currentDb = $1;
	print ARQ $line;
    }

    $lineNum++;

    $problems{$lineNum} or print($line) && next;

    print STDERR $countErrors++, " ", $lineNum, " ", $linesExpanded, " ", scalar localtime;

    $line =~ /^(INSERT INTO \`(.+?)\` VALUES )/
	or print($line) && next;

    my $begin = $1;
    my $table = $2;
    if ($table !~ /^tiki_searchindex|search_total|cache$/ &&
	$currentDb !~ /_teste$/) {
	print STDERR " - $currentDb.$table\n";
    } else {
	print STDERR " - $currentDb.$table - skipped\n";
	print $line;
	next;
    }

    $linesExpanded = 0;

    $line =~ s/^.+?\(/\(/o;

    my $buf = '';
    my $i = 0;

    substr($line, $i, 1) eq '('
	or die;

    while (substr($line, $i, 1) ne ';') {

	if (substr($line, $i, 1) eq ',') {
	    $i++;
	    substr($line, $i, 1) eq '('
		or die;
	}

	while ((my $thisChar = substr($line, $i, 1)) ne ')') {
	    
	    $buf .= $thisChar;
	    $i++;
	    
	    if (substr($line, $i, 1) eq "'") {
		
		my ($newBuf, $newPos) = &getString($line, $i);
		$buf .= $newBuf;
		$i = $newPos;
		
	    } else {
		
		my ($newBuf, $newPos) = &getValue($line, $i);
		$buf .= $newBuf;
		$i = $newPos;

	    }
	}
	
	$buf .= substr($line, $i++, 1);
	
	print ARQ $begin, $buf, ";\n";

	print $begin, $buf, ";\n";
	$linesExpanded++;
	$buf = '';
    }
}

close ARQ;

# returns string and new position
sub getString {
    my $line = shift;
    my $pos = shift;
    
    if (substr($line, $pos, 1) ne "'") {
	return ('', $pos);
    }

    my $buf = "'";
    $pos++;
    my $thisChar;
    my $slashCount = 0;

    while (substr($line, $pos, 1) ne "'" or $slashCount %2) {
	$buf .= $thisChar = substr($line, $pos++, 1);
	if ($thisChar eq '\\') {
	    $slashCount++;
	} else {
	    $slashCount=0;
	}
    }

    substr($line, $pos, 1) eq "'" or die;

    $buf .= substr($line, $pos++, 1);

    return ($buf, $pos);    
}

sub getValue {
    my $line = shift;
    my $pos = shift;

    if (substr($line, $pos, 4) eq 'NULL') {
	return ('NULL', $pos+4);
    }

    my $buf = '';
    while ((my $thisChar = substr($line, $pos, 1)) =~ /\d|\./o) {
	$buf .= $thisChar;
	$pos++;
    }

    substr($line, $pos, 1) =~ /,|\)/o
	or die substr($line, $pos-20, 40);

    return ($buf, $pos);
}

sub getProblems {
    my $file = shift;

    open ARQ, $file
	or die "can't open $file";

    my %problems;

    while (my $line = <ARQ>) {
	$line =~ /at line (\d+)/
	    or die;

	$problems{$1} = 1;
    }

    return %problems;
}
    
