#!/usr/bin/perl
use strict;
use warnings;

my @users_list = ("Ivan", "Stepan", "Alena");
my $find = 0;
chomp(my $user_name = <STDIN>);
for my $user_from_list (@users_list) {
    print "Processing with user $user_name from @users_list\n";
    if ($user_name eq $user_from_list) {
        $find = 1;
    }
}

if ($find == 1) {
    print "Добро пожаловать, $user_name!";
} else {
    print "Ты кто такой, $user_name?!";
}
