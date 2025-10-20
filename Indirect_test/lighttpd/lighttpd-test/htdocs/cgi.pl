#!/usr/bin/env perl
use strict;
use warnings;

print "Content-Type: text/plain\r\n\r\n";

# Query string 파싱
my $query = $ENV{'QUERY_STRING'} || '';

if ($query =~ /env=(\w+)/) {
    my $env_var = $1;
    print "$env_var: " . ($ENV{$env_var} || '') . "\n";
} elsif ($query =~ /internal-redir/) {
    print "Status: 200\r\n";
    print "X-Sendfile: /index.html\r\n\r\n";
} else {
    print "CGI Script Running\n";
    print "SCRIPT_NAME: " . ($ENV{'SCRIPT_NAME'} || '') . "\n";
    print "PATH_INFO: " . ($ENV{'PATH_INFO'} || '') . "\n";
}
