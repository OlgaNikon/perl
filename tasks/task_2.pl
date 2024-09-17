#!/usr/bin/perl
use strict;
use warnings;

my @users_list = ("Ivan", "Stepan", "Alena");
my $find = 0;
# my $user_name = $ARGV[0];
# print $user_name;
my $user_name = $ENV{user_name};
my $user_password = $ENV{user_password};
for my $user_from_list (@users_list) {
    print "Processing with user $user_name from @users_list\n";
    if ($user_name eq $user_from_list) {
        $find = 1;
    }
}

if ($find == 1) {
    print "Добро пожаловать, $user_name!\nТвой пароль $user_password";
} else {
    print "Ты кто такой, $user_name?!";
}
