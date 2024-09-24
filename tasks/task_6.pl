#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

# Функция прочтения файла и сохранения его в хеш
sub _task_6_read_conf {

    # Открываем файл
    my $conf_path = "tasks/files/conf_with_errors.ini";
    if ( ! open FILE, "<", $conf_path ) {
        print "Can't open '$conf_path': $!";
    }

    # Если удалось открыть файл, читаем, форматируем строки и проверяем на соответствия, сохраняем в хеш
    my %users;
    while ( my $line = <FILE> ) {
        $line =~ s/ \s //xg;
        if ( $line =~ m/ ( ^ \#{0} \w* ) = ( \w* ) /x ) {
            $users{$1} = $2;
        }
    }

    # Закрытие файла
    close FILE;

    return %users;
}

# Вызов функции прочтения файла и сохранение результата в хеш
my %users = &_task_6_read_conf;

# Вывод хеша
while ( ( my $key, my $value ) = each %users ) {
    print "$key => $value\n";
}
