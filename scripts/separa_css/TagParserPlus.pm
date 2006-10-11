package TagParserPlus;

$VERSION = 0.01;

use HTML::TagParser;
@ISA = qw(HTML::TagParser);

use strict;

sub newSafe {
    my $self = shift;
    my $tpl = shift;
    my $parsed;

    print "parsing: $tpl\n";
    eval {
	$parsed = TagParserPlus->new( $tpl );
    };
    if($@) {
        print "EXCEPTION: $@!";
    }
    return $parsed;
}

sub getAllElements {
    my $self = shift;
    my $key  = lc(shift);
    my $val  = shift;

    my $flat = $self->{flat};
    my $out  = [];
    for ( my $i = 0 ; $i <= $#$flat ; $i++ ) {
        my $elem = HTML::TagParser::Element->new( $flat, $i );
        push( @$out, $elem );
    }
    return unless wantarray;
    @$out;
}

sub getAllElementsByAttribute {
    my $self = shift;
    my $attr = shift;

    my $out = [];
    my @elems = $self->getAllElements();
    foreach my $elem (@elems){
	if($elem->getAttribute($attr)){
	    push (@$out, [ ($elem, split(" ",$elem->getAttribute($attr)) ) ]);
	    #print ref $elem;
	}
    }
    return $out;
}

sub getAllUniqueElementsByAttribute {
    my $self = shift;
    my $attr = shift;

    my $out = {};
    my @elems = $self->getAllElements();
    foreach my $elem (@elems){
	if($elem->getAttribute($attr)){
	    foreach my $attr (split(" ",$elem->getAttribute($attr)) ){
		$out->{$attr} = 1;
	    }
	    #print ref $elem;
	}
    }
    return $out;
}

sub getAllIds {
    my $self = shift;
    return $self->getAllElementsByAttribute("id");
}

sub getAllClasses {
    my $self = shift;
    return $self->getAllElementsByAttribute("class");
}

sub getAllUniqueClasses {
    my $self = shift;
    return $self->getAllUniqueElementsByAttribute("class");
}

sub getAllUniqueIds {
    my $self = shift;
    return $self->getAllUniqueElementsByAttribute("id");
}


