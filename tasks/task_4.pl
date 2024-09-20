#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

# Функция проверки логина и пароля
sub _task_4_check_login_and_password {
    # ОбЪявление необходимых параметров
    my %user_prms = (
          "Andrey" => "1234"
        , "Anna"   => "5678"
        , "Dima"   => "0000"
        , "Olga"   => "1234"
    );
    my ($user_name, $user_password) = @_;

    # Проверяем совпадает ли имя и пароль
    if ( $user_password eq $user_prms{$user_name} ) {
        return 0;
    }

    return -1;
}

# Получаем данные из окружения
my $user_name = $ENV{user_name};
my $user_password = $ENV{user_password};

# Проверяем что данные из окружения есть и они не пустые и корректные
my $find = 1;
if ( !defined( $user_name ) || $user_name =~ m/ \W | ^ $ /x ) {
    print "Не указано имя пользователя\n";
    $find = -1;
}
if ( !defined( $user_password ) || $user_password =~ m/ \W | ^ $ /x ) {
    print "Не указан пароль\n";
    $find = -1;
}

# Если данные из окружения корректные вызывает для них функцию проверки логина и пароля
if ( $find != -1 ) {
    $find = &_task_4_check_login_and_password( $user_name, $user_password );
}

# Выводим сообщение в зависмости от того, нашли ли логин и совпали ли пароли
if ( $find == 0 ) {
    print "Добро пожаловать $user_name!\n";
} else {
    print "Неверный логин или пароль.\n";
}
