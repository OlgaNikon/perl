#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use lib 'C:/first/tasks/';
use tools;

my $conf_path = "tasks/files/";

# Получение данных
my $file_name = shift @ARGV;
my $document = "";

# Проверка формата файла и вызов функции для парсинга в зависимости от формата
if ( $file_name =~ m/ .xml $ /x ) {
    $document = tools::parse_pro_xml( $file_name );
} elsif ( $file_name =~ m/ .json $ /x ) {
    $document = tools::parse_pro_json( $file_name );
} else {
    print "enter file xml or json";
}

# Вывод результата
print $document;
