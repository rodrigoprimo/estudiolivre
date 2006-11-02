#!/usr/bin/perl 

use strict;
require XML::Simple;

$ARGV[0] and $ARGV[1] and $ARGV[2] or die 'must supply action username password';

our $user = $ARGV[1];
our $pass = $ARGV[2];

our $xs = new XML::Simple();
our $ref = $xs->XMLin('/etc/icecast2/icecast.xml');

open ARQ, '>/etc/icecast2/icecast.xml' or die "open(): $!";
our $fh = \*ARQ;

my $action = $ARGV[0];

if ($action eq 'add') {
    add();
} elsif ($action eq 'update') {
    update();
}

close ARQ;

`sudo killall -HUP icecast2 >/tmp/ret`;

exit 0;

sub add {


#    my $auth;
#    $auth->{'type'} = 'url';
#    $auth->{'option'} = {'listener_add' => {'value' => 'http://estudiolivre.org/elIce.php'},
#			 'listener_remove' => {'value' => 'http://estudiolivre.org/elIce.php'},
#			 'mount_add' => {'value' => 'http://estudiolivre.org/elIce.php'},
#			 'mount_remove' => {'value' => 'http://estudiolivre.org/elIce.php'}
#		     };

    my $new_point = {'mount-name' => "/$user",
#		     'authentication' => $auth,
		     'password' => $pass};

    my $mounts = $ref->{mount};
    
    $mounts->[@$mounts] = $new_point;
    $ref->{mount} = $mounts;

    my $xml = $xs->XMLout($ref, NoAttr => 1, RootName => 'icecast', OutputFile => $fh);

}

sub update {

    foreach my $mount (@{$ref->{mount}}) {
		if ($mount->{'mount-name'} eq "/$user") {
		    $mount->{'password'} = $pass;
		}
    }
    
    my $xml = $xs->XMLout($ref, NoAttr => 1, RootName => 'icecast', OutputFile => $fh);

}
