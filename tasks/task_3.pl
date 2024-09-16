#!/usr/bin/perl
use strict;
use warnings;

my %user_prms = (
    "Andrey" => "1234",
    "Any"    => "5678",
    "Dima"   => "0000",
    "Olga"   => "1234",
);
my $user_name = $ENV{user_name};
my $user_password = $ENV{user_password};
my $find = 0;
if (exists($user_prms{$user_name})) {
    if ($user_password eq $user_prms{$user_name}) {
        $find = 1;
    }
}
if ($find == 1) {
    print "Добро пожаловать $user_name!";
} else {
    print "Неверный логин или пароль.";
}
