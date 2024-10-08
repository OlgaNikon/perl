#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use XML::LibXML;

my $conf_path = "tasks/files/";

# Получение данных
my $file_name = shift @ARGV;

# Чтение файла
my $document = XML::LibXML->new->parse_file( $conf_path . $file_name );
$document =~ s/ < [^>]* > //gx;
$document =~ s/ \s+ / /gx;

# Вывод результата
print $document;
