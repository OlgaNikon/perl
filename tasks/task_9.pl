#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use lib 'C:/first/tasks/';
use tools;

# Получаем данные
my ( $action, $user_name, $user_password ) = @ARGV;
my $file_name = "conf.ini";

# Вызываем функию для регистрации или входа
if ( $action eq "log" ) {
    tools::task_8_login;
} elsif ( $action eq "reg" ) {
    # Вызов функции для проверки корректности логина и пароля
    my $check_usr_name_password = tools::task_9_check_user_name( $user_name );
    $check_usr_name_password *= tools::task_9_check_user_password( $user_password );

    # Если логин и пароль прошел проверку вызываем функию для регистрации
    if ( $check_usr_name_password == 1 ) {
        tools::task_8_reg_user( $file_name, $user_name, $user_password );
    } else {
        print "Ошибка, введите корректное имя и пароль";
    }
} else {
    print "Ошибка, неизвестное значение $action\n";
}
