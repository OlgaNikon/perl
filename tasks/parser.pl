#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use XML::LibXML;

my $conf_path = "tasks/files/";

# Получение данных
my $file_name = shift @ARGV;

# Чтение файла
my $document = XML::LibXML->new->parse_file( $conf_path . $file_name );

# Вывод результата
print $document;
