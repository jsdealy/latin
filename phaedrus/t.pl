#!/usr/bin/perl
use File::Temp qw(tempfile tempdir);
use feature qw(say);
use feature qw(signatures);
no warnings qw(experimental::signatures);
use strict;
use warnings;
use feature 'state';

my $initial_section = 1; 

sub convert_sidenote ($content) {
    state $notecount = 0;
    return '<label for="'.$notecount.'" class="margin-toggle sidenote-number"></label><input type="checkbox" id="'.$notecount++.'" class="margin-toggle"/><span class="sidenote">'.$content.'</span>';
}


while(<>) {
    if (m/^#/ and $initial_section==1) {
	$initial_section=0; print "<section>\n"
    } 
    elsif (m/^#/ and $initial_section==0) {
	print "</section>\n<section>\n"
    }; 

    s/(^[^#].*)(?<=[^\s]\s?$)/$1<br>/; 
    s/\[>(.*)\]/convert_sidenote($1)/ge;
    print;
}


print "</section>\n"

