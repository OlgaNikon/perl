#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use lib 'C:/first/tasks/';
use tools;

# Получаем данные
my ( $action, $user_name, $user_password ) = @ARGV;
my $file_name = "conf.ini";

# Вызываем функию для регистрации или входа или удаления или смена пароля
if ( defined( $action ) && $action eq "log" && defined( $user_name ) && defined( $user_password ) ) {
    tools::task_8_login;
} elsif ( defined( $action ) && $action eq "reg" && defined( $user_name ) && defined( $user_password ) ) {
    # Вызов функции для проверки корректности логина и пароля
    my $check_usr_name_password = tools::task_9_check_user_name( $user_name );
    $check_usr_name_password *= tools::task_9_check_user_password( $user_password );

    # Если логин и пароль прошел проверку вызываем функию для регистрации
    if ( $check_usr_name_password == 1 ) {
        tools::task_8_reg_user( $file_name, $user_name, $user_password );
    } else {
        print "Ошибка, введите корректное имя и пароль";
    }
} elsif ( defined( $action ) && $action eq "del" && defined( $user_name ) ) {
    tools::task_10_del_user( $file_name, $user_name );
} elsif ( defined( $action ) && $action eq "change_passwd" && defined( $user_name ) && defined( $user_password ) ) {
    tools::task_11_change_password( $file_name, $user_name, $user_password );
} else {
    print "###################################################################################\n" .
        "# script usage\n" .
        "# action=reg user_name=NAME user_password=PASSWD - registration new user in system\n" .
        "# action=log user_name=NAME user_password=PASSWD - login in system\n" .
        "# action=del user_name=NAME - remove user from system\n" .
        "# action=change_passwd user_name=NAME user_password=PASSWD - change user password\n" .
        "###################################################################################";
}
