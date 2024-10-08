#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

# Вввод значений для математической операции
print "Введите число действие число через пробелы\n";
my $param1;
my $action;
my $param2;
while ( chomp( my $entered_value = <STDIN> ) ) {
    if ( $entered_value =~ m/ ^ ( -? \d+ ) \h ( [ \+ \- \/ \* ]{1} ) \h ( -? \d+ ) $ /x ) {
        $param1 = $1;
        $action = $2;
        $param2 = $3;
        last;
    } else {
        print "Ошибка, $entered_value не математическим выражением, введите выражение\n";
    };
}

# Вычисление результата выражения
my $result;
if ( $action eq "+" ) {
    $result = $param1 + $param2;
} elsif ( $action eq "-" ) {
    $result = $param1 - $param2;
} elsif ( $action eq "/" ) {
    $result = $param1 / $param2;
} else {
    $result = $param1 * $param2;
}

# Очистка экрана
system 'cls';

# Вывод результата
print "$param1 $action $param2 = $result";
