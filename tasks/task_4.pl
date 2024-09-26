#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use lib 'C:/first/tasks/';
use tools;

# Получаем данные из окружения
my $user_name = $ENV{user_name};
my $user_password = $ENV{user_password};

# Вызываем функцию проверки логина и пароля на корректность и на совподение
my $find = tools::task_4_check_login_and_password( $user_name, $user_password );

# Выводим сообщение в зависмости от того, нашли ли логин и совпали ли пароли
if ( $find == 1 ) {
    print "Добро пожаловать $user_name!\n";
} else {
    print "Неверный логин или пароль.\n";
}
