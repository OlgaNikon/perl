#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use lib 'C:/first/tasks/';
use tools;

# Вызов функции прочтения файла и сохранение результата в хеш
my %users = tools::task_6_read_conf( "conf_with_errors.ini" );

# Вывод хеша
while ( ( my $key, my $value ) = each %users ) {
    print "$key => $value\n";
}
