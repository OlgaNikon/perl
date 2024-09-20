#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

# Объявление массива для сортировки
my @array = ( 13, -5, 0, 15, 37, 26, 9, 1, -1, 12, 15, 23, 23, -10 );

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
print "Массив после сортировки: @array\n";

# Вввод значения для поиска по массиву
print "Введите число для поиска\n";
my $search;
while ( chomp( $search = <STDIN> ) ) {
    if ( $search =~ m/ ^ -? \d+ $ /x ) {
        last;
    } else {
        print "Ошибка, $search не является чилом, введите число\n";
    };
}

# Поиск значения по массиву
my $low = 0;
my $high = @array;
my $index = -1;
while ( $low < $high ) {
    my $middle = int( ( $high - $low ) / 2 ) + $low;
    if ( $array[$middle] == $search ) {
        $index = $middle;
        last;
    } elsif ( $array[$middle] < $search ) {
        $low = $middle + 1;
    } else {
        $high = $middle - 1;
    }
}

# Вывод результата
if ( $index == -1 ) {
    print "Число $search не было найдено в массиве @array\n";
} else {
    print "Число $search было найдено в массиве @array под индексом $index";
}
