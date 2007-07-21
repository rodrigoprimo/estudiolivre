#!/usr/bin/perl -w

use strict;

$ENV{'PWD'} =~ /repo.?$/ or die;

opendir(DIR, ".") or die $!;

while (my $file = readdir(DIR)) {
	my ($thumb, $id, $userId, $name) = $file =~ /^(thumb_)?(\d+)_(\d+)-(.+)$/
		or next;
		
	mkdir($id, 02755);
	link $file, "$id/$file";
	unlink $file;
	symlink "$id/$file", $file;
	
}

closedir(DIR);

system("chown -R nobody:nobody .");
