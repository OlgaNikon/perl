#!/usr/bin/perl
use strict;
use warnings;

# ОбЪявление необходимых параметров
my %user_prms = (
    "Andrey" => "1234",
    "Any"    => "5678",
    "Dima"   => "0000",
    "Olga"   => "1234",
);
my $find = 0;

# Получаем данные из окружения
my $user_name = $ENV{user_name};
my $user_password = $ENV{user_password};

# Проверяем есть ли в объявленном хеше имя полученноое из окружения и совпадает ли пароль для этого именни
if (exists($user_prms{$user_name})) {
    if ($user_password eq $user_prms{$user_name}) {
        $find = 1;
    }
}

# Выводим сообщение в зависмости от того, нашли ли имя в предыдущем блоке и совпали ли пароли
if ($find == 1) {
    print "Добро пожаловать $user_name!";
} else {
    print "Неверный логин или пароль.";
}
