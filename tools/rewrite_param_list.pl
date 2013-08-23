#!/usr/bin/perl

open(READ, "< $ARGV[0]") or die ; 
open(WRITE, "> $ARGV[0]".".tmp") or die ; 

sub my_list {
	my $ret=""; 
	foreach my $elem (split(/, \$/, shift)) {
		$ret.="<dd>".$elem.",</dd>"; 
	}
	return $ret; 
}

while(<READ>) {
	s/\<span\ class\=\"method\-args\"\>\(\ \$(.*)\)\<\/span\>/"<span class=\"method-args\">(<dl>".my_list($1)."<\/dl>)<\/span>"/gex;
	#s/\<span\ class(.*)<\/span\>/"<span class=\"method-args\">(<dl>".my_list($1)."<\/dl>)<\/span>"/gex;
	print WRITE; 
}

close READ or die ; 
close WRITE or die; 
unlink($ARGV[0]) or die ; 
link($ARGV[0].".tmp", $ARGV[0]) or die ; 
unlink($ARGV[0].".tmp") or die ; 

