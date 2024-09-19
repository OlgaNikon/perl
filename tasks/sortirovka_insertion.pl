#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

# Объявление массива для сортировки
#my @array = ( 13, -5, 0, 15, 37, 26, 9, 1, -1, 12, 15, 23, 23, -10 );
chomp( my @array = <STDIN> );

# Вывод не отсортированного массива
print "Массив до сортировки: @array\n";

# Сортируем массив
for ( my $i = 1; $i < @array; $i++ ) {
    my $current = $array[$i];
    my $j = $i;
    while ( $j > 0 && $array[$j - 1] >= $current ) {
        $array[$j] = $array[$j - 1];
        $j--;
    }
    $array[$j] = $current;
}

# Вывод отсортированного массива
print "Массив после сортировки: @array";
