package CSSPlus;

$VERSION = 0.01;

use CSS;
@ISA = qw(CSS);

use strict;

sub printStyles {
    my $self = shift;
    foreach my $style (@{$self->{styles}}){
	my $algo=$style->selectors();
	print $algo."\n";
    }
    
}

sub getAllSelectors {
    my $self = shift;
    
    my $out = {};
    foreach my $style (@{$self->{styles}}){
	my @selectors = split( ",",$style->selectors() );
	$out->{$style} = \@selectors;
    }

    return $out;
}

sub getProperties {
    my $self = shift;
    return $self->{properties};
}

sub parseAllIdsClasses {
    my $self = shift;
    foreach my $style (@{$self->{styles}}){
	my @selectors = split( ",",$style->selectors() );
	my @ids;
	my @classes;
	foreach my $sel (@selectors){
	    while ($sel =~ /\#([^\s:]+)/g) {
		push @ids, $1;
	    }
	    while ($sel =~ /\.([^\s:]+)/g) {
		push @classes, $1;
	    }
	    
	}
	if(@ids){
	    push(@{$self->{ids}}, [$style,@ids]);
	}
	if(@classes){
	    push(@{$self->{classes}}, [$style,@classes]);
	}
    }

}

# cria dois hashes, um classesPairs e outro idsPairs.
# esses hashes relacionam os ids ou as classes com todos 
# os estilos (unicos) que contém esse string nos selectors.
sub parseAllIdsClassesUsingPairs {
    my $self = shift;
    foreach my $style (@{$self->{styles}}){
	my @selectors = split( ",",$style->selectors() );
	foreach my $sel (@selectors){
	    while ($sel =~ /\#([^\s:]+)/g) {
		my $id = $1;
		my $used = 0;
		#checa se esse mesmo estilo já está associado com esse elemento
		foreach my $inside_style (@{$self->{classesPairs}->{$id}}){
		    if($inside_style->to_string() eq $style->to_string()){		      
			$used=1;
		    }
		}
		#se ainda nao estiver...
		if(!$used){
		    push(@{$self->{idsPairs}->{$id}},$style);
		    
		}
	    }
	    while ($sel =~ /\.([^\s:]+)/g) {
		my $class = $1;
		my $used = 0;
		#checa se esse mesmo estilo já está associado com esse elemento
		foreach my $inside_style (@{$self->{classesPairs}->{$class}}){
		    if($inside_style->to_string() eq $style->to_string()){		      
			$used=1;
		    }
		}
		#se ainda nao estiver...
		if(!$used){
		    push(@{$self->{classesPairs}->{$class}},$style);
		}	       
	    }
	    
	}
    }
}

sub getAllIds {
    my $self = shift;
    if(!$self->{ids}){
	$self->parseAllIdsClasses();
    }
    return $self->{ids};
}

sub getAllClasses {
    my $self = shift;
    if(!$self->{classes}){
	$self->parseAllIdsClasses();
    }
    return $self->{classes};
}

sub getAllIdsPairs {
    my $self = shift;
    if(!$self->{idsPairs}){
	$self->parseAllIdsClassesUsingPairs();
    }
    return $self->{idsPairs};
}

sub getAllClassesPairs {
    my $self = shift;
    if(!$self->{classesPairs}){
	$self->parseAllIdsClassesUsingPairs();
    }
    return $self->{classesPairs};
}
