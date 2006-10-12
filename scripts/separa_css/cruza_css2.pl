#!/usr/bin/perl

use strict;
use Term::ANSIColor qw(:constants);
use CSSPlus;
use TagParserPlus;

my $theme='estudiolivre';


######CSS STUFF
my $css = CSSPlus->new();
$css->read_file($theme.'Total.css');

=pod
#anda pelo css vendo as classes
print "Classes\n";
my $selec = $css->getAllIds();

foreach my $style (@$selec){
    shift @$style;
    foreach my $elem (@$style){
	print "\t".$elem." - ".@$style."\n";
    }
}
=cut

my $classes = $css->getAllClassesPairs();
my $ids = $css->getAllIdsPairs();

=pod
# anda pelo css vendo os Ids, cada um associado a um array com os estilos que os contém
print "Classes\n";
my $selec = $css->getAllClassesPairs();
foreach my $id (sort keys %$selec){
    print "\t".$id."\n";
    foreach my $style (@{$selec->{$id}}){
	print "\t\t".$style->to_string()."\n";
    }
}
=cut

######TPLs INTRO
## esse pega os tpls de um tema especifico
#chomp(my @tpls = `find ../../src/templates/styles/$theme |grep \.tpl`);
## esse pega os tpls da raiz
chomp(my @tpls = `find ../../src/templates |grep -v styles |grep \.tpl`);

#@tpls = ("../../src/templates/styles/estudiolivre/tiki-user_preferences.tpl");
my %tpls_parsed;

foreach my $tpl (@tpls){
    if(my $parse = TagParserPlus->newSafe( $tpl )){
	$tpls_parsed{$tpl} = $parse;
    }
}

# anda pelos tpls vendo os tags
foreach my $tpl_parsed (keys %tpls_parsed) {


    $tpl_parsed =~ /.*\/(.*)/; #esse eh para quando usar tpl da raiz
    #$tpl_parsed =~ /.*$theme\/(.*)/; #esse eh para tpls de temas
    my $current_tpl_name = $1;
    #$current_tpl_name =~ /.*\/(.*)/; #esse eh para tpls de temas
    my $current_css_name = $1;
    $current_css_name =~ s/.tpl//;
    $current_css_name.=".css";


    my $css = CSS->new();
    my $a = $tpls_parsed{$tpl_parsed}->getAllClasses();
    my $b = $tpls_parsed{$tpl_parsed}->getAllUniqueClasses();
    if(@$a){
	print BOLD,$1."\n\t",RESET;
	print UNDERLINE,"Classes:",RESET;
	print "\t";
	foreach my $class (keys %$b){
	    print "$class, ";
	    if($classes->{$class}){
		foreach my $cur_style (@{$classes->{$class}}){
		    my $used = 0;
		    foreach my $inside_styles (@{$css->{styles}}){
			if($inside_styles->to_string() eq $cur_style->to_string()){
			    $used=1;
			}
		    }
		    if(!$used){
			push(@{$css->{styles}},$cur_style);
		    }
		}
	    }
	}
    }
    my $a = $tpls_parsed{$tpl_parsed}->getAllIds();
    my $b = $tpls_parsed{$tpl_parsed}->getAllUniqueIds();
    if(@$a){
	print "\n\t";
	print UNDERLINE,"Ids:",RESET;
	print "\t";
	foreach my $id (keys %$b){
	    print "$id, ";
	    if($ids->{$id}){
		foreach my $cur_style (@{$ids->{$id}}){
		    my $used = 0;
		    foreach my $inside_styles (@{$css->{styles}}){
			if($inside_styles->to_string() eq $cur_style->to_string()){
			    $used=1;
			}
		    }
		    if(!$used){
			push(@{$css->{styles}},$cur_style);
		    }
		}
	    }
	}
    }
    print "\n";
    if($css->output()){
	#print "----------\n";
	#print $css->output('CSS::Adaptor::Pretty');
	#print "----------\n";
	#print "\n";
	print YELLOW,"> css/".$current_css_name."\n",RESET;
	open(FILE,">css/".$current_css_name) || die "$!: $current_css_name";
	print FILE $css->output('CSS::Adaptor::Pretty');
	close(FILE);

	open(FILE,">tpl/".$current_tpl_name) || die "$!: $current_tpl_name";
	print FILE "{css}\n";
	print $tpl_parsed."\n";
	close(FILE);
	system("cat $tpl_parsed >> tpl/$current_tpl_name");

    }else{
	print "----------\n";
	print "SEM CSS!\n";
	print "----------\n";
    }
}



=pod


my $selec = $css->getAllClasses();
print "Classes\n";
foreach my $i (keys %$selec){
    foreach my $j (@{$selec->{$i}}){
	print "\t".$j."\n";
    }
}



#    print $tpls_parsed{$tpl_parsed}->getAllElementsByAttribute("id");

#    exit 0;
#    my @allIds=$tpls_parsed{$tpl_parsed}->getAllElementsByAttribute("id");
#    print $tpls_parsed{$tpl_parsed}->getAllIds()."\n";
#    print "\t".@allIds."\n";


foreach my $tpl (keys 
%
    my @elems = $tpls_parsed{$tpl}->getElements();
    print "\t";
    foreach my $elem (@elems){
	print $elem->tagName().", ";
    }
    print "\n";
}



#my $test = HTML::TagParser->new('src/templates/styles/estudiolivre/tiki.tpl');
#my $telems = &getElements($test);
#print @$telems;
#foreach my $telem (@$telems){
#    print $telem->tagName()."\n";
#}

sub getElements {
    my ($self) = @_;

    my $flat = $self->{flat};
    my $out  = [];
    for ( my $i = 0 ; $i <= $#$flat ; $i++ ) {
        my $elem = HTML::TagParser::Element->new( $flat, $i );
        push( @$out, $elem );
    }
    return $out;
}



##############

#foreach my $value (values %$test){
#    print $value."\n";
    foreach my $item (@{$test->{'flat'}}){
	foreach my $sub_item (@$item){
	    print $sub_item."\n";
	}
    }
#}

#################

###################
open(CSS, "src/styles/".$theme."_naoComprimido.css");
while(my $line = <CSS>){
    chomp;
    my ($ruleName) = $line =~ /(.*?)\{/;
    if($ruleName){
	print $1."\n";
    }
}

my %theme_tpl;

print GREEN,"por ordem do arquivo\n",RESET;
foreach my $tpl (@tpls) {
    my %tpl_css_class;
    my %tpl_css_id;

    open(TPL,$tpl);
    print BOLD,"\t$tpl",RESET;

    while (my $line = <TPL>){
	chomp;
	while($line =~ /\<(.*?)\>/g){
	    my $tag = $1;
	    my ($tagName) = $tag =~ /(\S*)/;
	    if($tagName !~ m|/|){
		print "\t\t",GREEN,$tagName,RESET,"\n";		
		my ($id) = $tag =~ /.*id\=\"(.*?)\".*/;	    
		my ($class) = $tag =~ /.*class\=\"(.*?)\".*/;
		if($id) {
		    print GREEN,UNDERLINE,"\t\t\t$id\n",RESET;
		    $tpl_css_id{$tagName}->{$id}=1;
		    
		}
		if($class) {
		    print GREEN,BOLD,"\t\t\t$class\n",RESET;
		    $tpl_css_class{$tagName}->{$class}=1;
		}
	    }
	}
    }

#    print RED,"\tids por tagName\n",RESET;
#    foreach my $tagName (keys %tpl_css_id){
#	print RED,UNDERLINE,"\t\t$tagName",RESET,"\n";
#	    foreach my $hid (keys %{$tpl_css_id{$tagName}}){
#		print UNDERLINE,"\t\t\t$hid\n",RESET;
#	    }
#    }
#    print RED,"\tclasses por tagName\n",RESET;
#    foreach my $tagName (keys %tpl_css_class){
#	print RED,BOLD,"\t\t$tagName",RESET,"\n";
#	    foreach my $hclass (keys %{$tpl_css_class{$tagName}}){
#		print BOLD,"\t\t\t$hclass\n",RESET;
#	    }
#    }

    close(TPL);
    $theme_tpl{$tpl}->{'id'}=\%tpl_css_id;
    $theme_tpl{$tpl}->{'class'}=\%tpl_css_class;
}


print "estrutura criada, acesso...\n";
foreach my $theme_tpls_key (keys %theme_tpl){
    print "\t$theme_tpls_key";
    my $tpl_css_id=$theme_tpl{$theme_tpls_key}->{'id'};
    my $tpl_css_class=$theme_tpl{$theme_tpls_key}->{'class'};
    print RED,"\t\tids por tagName\n",RESET;
    foreach my $tagName (keys %{$tpl_css_id}){
	print RED,UNDERLINE,"\t\t\t$tagName",RESET,"\n";
	    foreach my $hid (keys %{$tpl_css_id->{$tagName}}){
		print UNDERLINE,"\t\t\t\t$hid\n",RESET;
	    }
    }
    print RED,"\t\tclasses por tagName\n",RESET;
    foreach my $tagName (keys %{$tpl_css_class}){
	print RED,BOLD,"\t\t\t$tagName",RESET,"\n";
	    foreach my $hclass (keys %{$tpl_css_class->{$tagName}}){
		print BOLD,"\t\t\t\t$hclass\n",RESET;
	    }
    }
}
=cut
