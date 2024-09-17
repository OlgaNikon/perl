#!/usr/bin/perl
use strict;
use warnings;

my $tech_debt = $ARGV[0];
my $snail_speed = $ARGV[1];
my $backlog_speed = $ARGV[2];
my $result = $tech_debt / (($snail_speed - $backlog_speed) * 10);
my $mask = $result >> 31;
my $sprint = (($result + $mask) ^ $mask);
my $temp = ($sprint + int($result)) % 2;
my %results = (
    1 => "Не справится!",
    0 => "Справится за $sprint спринтов",
);
print $temp;
print $results{$temp};
