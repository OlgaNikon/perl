#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

# Вввод значений для математической операции
print "Введите число действие число\n";
my $result_expression = "";
my $result = 0;
while ( chomp( $_ = <STDIN> ) ) {

    # Введен ли символ для окончания вычислений, если окончание, то вывод результата
    if ( /^=$/ ) {
        $result_expression =~ s/^\( | \)$//g;
        print "$result_expression = $result\n";
        last;
    } elsif ( /^(-?\d+ )?([\+\-\/\*]{1}) (-?\d+)$/ ) {

        # Определение введна первая строка с двумя переменными или уже последующие строки
        if ( defined( $1 ) ) {
            $result = $1;
            $result_expression .= $1;
        }

        # Вычисление результата выражения
        if ( $2 eq "+" ) {
            $result = $result + $3;
        } elsif ( $2 eq "-" ) {
            $result = $result - $3;
        } elsif ( $2 eq "/" ) {
            if ( $3 == 0 ) {
                print "Ошибка, нельзя делить на ноль\n";
                next;
            }
            $result = $result / $3;
        } else {
            $result = $result * $3;
        }
        $result_expression = "( " . $result_expression . " $2 $3 )";

        # Вывод предрезультата
        print "$result\n";
    } else {
        print "Ошибка, $_ не математическим выражением, введите выражение\n";
    };
}
