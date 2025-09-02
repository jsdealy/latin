#!/usr/bin/perl
use File::Temp qw(tempfile tempdir);
use feature qw(say);
use feature qw(signatures);
no warnings qw(experimental::signatures);
use strict;
use open ':std', ':encoding(UTF-8)';
use utf8;
use warnings;
use feature 'state';
use 5.42.0;

my $initial_section = 1; 
my $single_quote_count = 1; 
my $double_quote_count = 1; 

sub convert_sidenote ($content) {
    state $notecount = 0;
    $notecount++;
    return '<label for="'.$notecount.'" class="margin-toggle sidenote-number"></label><input type="checkbox" id="'.$notecount.'" class="margin-toggle"/><span class="sidenote">'.$content.'</span>';
}

# paragraph mode <- 08/31/25 16:22:04 # 
$/ = '';

# getting the text <- 08/31/25 21:18:54 # 
my @textblocks = <>;

for (@textblocks) {
    # removing linebreaks terminated with \ <- 08/31/25 21:26:37 # 
    s/\\\s*\n/ /gm;
}

for (@textblocks) {
    # handling quotation marks <- 08/31/25 03:34:07 # 
    s/'/
	$single_quote_count*=-1;
	$single_quote_count == -1 ? "\x{2018}" : "\x{2019}" ;
    /xge;

    s/"/
	$double_quote_count*=-1;
	$double_quote_count == -1 ? "\x{201C}" : "\x{201D}" ;
    /xge;

    # making sections for tufte <- 08/30/25 23:20:21 # 
    if (m/^#/ and $initial_section==1) {
	$initial_section=0; print "<section>\n"
    } 
    elsif (m/^#/ and $initial_section==0) {
	print "</section>\n<section>\n"
    }; 

    # making lines <- 08/30/25 23:18:42 # 
    s|^([^#]\s*[^\s]+.*)$|<span class="line">$1<br></span>|gm; 

    # converting sidenote tags <- 08/30/25 23:18:52 # 
    s/\{>(.*?)\}/convert_sidenote($1)/sge;
    
    # converting newthought <- 08/30/25 23:18:52 # 
    s|\{\)(.*?)\}|<span class="newthought">$1</span>|sg;

    # printing or quitting if we reached the footer <- 08/31/25 03:35:09 # 
    if (not m/footer/) {print} else {last};
}

# final section closer <- 08/31/25 21:27:02 # 
print "</section>\n"
