#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

# Функция прочтения файла и сохранения его в массив
sub _task_5_read_conf {

    # Открываем файл
    my $conf_path = "tasks/files/conf.ini";
    if ( ! open FILE, "<", $conf_path ) {
        print "Can't open '$conf_path': $!";
    }

    # Если удалось открыть файл, читаем и сохраняем его в массив
    my @users;
    while ( chomp( my $file = <FILE> ) ) {
        push @users, $file;
    }

    # Закрытие файла
    close FILE;

    return @users;
}

# Вызов функции прочтения файла и сохранение результата в массив
my @users = &_task_5_read_conf;

# Вывод массива
printf "%s\n" x @users, @users;
