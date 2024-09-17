#!/usr/bin/perl
use strict;
use warnings;

# ОбЪявление необходимых параметров
my @users_list = ( "Ivan", "Stepan", "Alena" );
my $find = 0;

# Получаем имя введенное при запуске программы и выводим его не экран
# my $user_name = $ARGV[0];
# print $user_name;

# Получаем данные из окружения
my $user_name = $ENV{user_name};
my $user_password = $ENV{user_password};

# Поиск по имени из окружения в объявленном массиве
for my $user_from_list ( @users_list ) {
    print "Processing with user $user_name from @users_list\n";
    if ( $user_name eq $user_from_list ) {
        $find = 1;
    }
}

# Выводим сообщение в зависмости от того, нашли ли имя в предыдущем блоке
if ( $find == 1 ) {
    print "Добро пожаловать, $user_name!\nТвой пароль $user_password";
} else {
    print "Ты кто такой, $user_name?!";
}
