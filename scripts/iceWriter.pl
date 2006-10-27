#!/usr/bin/perl 

use strict;
require XML::Simple;

$ARGV[0] and $ARGV[1] and $ARGV[2] or die 'must supply action username password';

my $user = $ARGV[1];
my $pass = $ARGV[2];

my $xs = new XML::Simple();
my $ref = $xs->XMLin('icecast.xml');

my $action = $ARGV[0];

if ($action == 'add') {
    add();
} elsif ($action == 'update') {
    update();
}

sub add {

# bonus pra depois, saber se ta conectado e tal, quantos ouvindo, etc...
#$my $auth;
#$auth->{'type'} = 'url';
#$auth->{'option'} = {'listener_add' => {'value' => 'http://estudiolivre.org/elIce.php?action=listener_add'},
#		     'listener_remove' => {'value' => 'http://estudiolivre.org/elIce.php?action=listener_remove'},
#		     'mount_add' => {'value' => 'http://estudiolivre.org/elIce.php?action=mount_add'},
#		     'mount_remove' => {'value' => 'http://estudiolivre.org/elIce.php?action=mount_remove'}
#		 };

    my $new_point = {'mount-name' => "/$user",
		     #'authentication' => $auth,
		     'password' => $pass};

    my $mounts = $ref->{mount};
    
    $mounts->[@$mounts] = $new_point;
    $ref->{mount} = $mounts;
    
    open my $fh, '>:encoding(utf8)', 'icecast.xml' or die "open(): $!";
    
    my $xml = $xs->XMLout($ref, NoAttr => 1, RootName => 'icecast', OutputFile => $fh);
    
    exit 1;
}

sub update {

#		 };

    my $new_point = {'mount-name' => "/$user",
		     #'authentication' => $auth,
		     'password' => $pass};

    # TODO percorrer e mudar a senha onde mount-name == $user 
    # $ref->{mount};
    
    
    open my $fh, '>:encoding(utf8)', 'icecast.xml' or die "open(): $!";
    
    my $xml = $xs->XMLout($ref, NoAttr => 1, RootName => 'icecast', OutputFile => $fh);
    
    exit 1;
}
