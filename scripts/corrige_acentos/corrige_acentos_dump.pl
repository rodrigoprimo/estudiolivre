#!/usr/bin/perl -w

use strict;

our %charMap = ('Á' => "a",
		'Í' => "i",
		'?' => "x");

our %mapChar = map { $charMap{$_} => $_ } keys %charMap;

our %wordList;

foreach my $char (keys %charMap) {
    $wordList{$char} = getDictionary($charMap{$char});
}

our $line;
while ($line = <>) {
    print &convert($line);
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
	or die $file;
    print ARQ $word, "\n";
    close ARQ;

    push @{$wordList{$mapChar{$dict}}}, $word;    
}

sub convert {
    my $text = shift || '';

    #so muda esse padrao do banco pro dump
    my @patt1 = (195, 63);

    my @patt2 = (226, 128, 63);

    my $buf = '';
    my $changed = 0;
    for (my $i=0; $i<length($text)-1; $i++) {
	if (substr($text,$i,1) =~ /\s/) {
	    print STDERR $buf, "\n", substr($line, 0, 80), "\n" if $changed;
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

    print STDERR $buf, "\n", substr($line, 0, 80), "\n" if $changed;

    return $text;
}

sub getReplacement {
    my $text = shift;
    my $pos = shift;

    foreach my $repl (keys %wordList) {
	my @patterns = @{$wordList{$repl}};
	foreach my $patt (sort { length($b) <=> length($a) } @patterns) {
	    my ($before, $after) = split /\?/, $patt;
	    return $repl
		if testWord($text, $pos, $before, $after);
	}
    }

    return $mapChar{'a'};
    return undef;
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

    if (!$after && !$before) { 
	return 0;
    }

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
