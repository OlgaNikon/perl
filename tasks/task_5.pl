#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use lib 'C:/first/tasks/';
use tools;

# Вызов функции прочтения файла и сохранение результата в массив
my @users = tools::task_5_read_conf( "conf.ini" );

# Вывод массива
printf "%s\n" x @users, @users;
