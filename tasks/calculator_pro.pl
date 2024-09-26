#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
# BEGIN {
#     push(@INC, "C:/first/tasks/");
# }
use lib 'C:/first/tasks/';
use tools;

# Вввод числа математической операции
my $result = tools::calculator_check_number();
my $result_expression = $result;
while ( ) {

    # Ввод операции +-*/ или = для завершения вычислений
    print "Введите дейстивие +-/* или = для завершения вычислений\n";
    chomp( my $action = <STDIN> );

    # Введен ли символ для окончания вычислений, если окончание, то вывод результата
    if ( $action =~ m/ ^ = $ /x ) {
        print "$result_expression = $result\n";
        last;
    } elsif ( $action =~ m/ ^ [ \+ \- \/ \* ] $ /x ) {

        # Вввод числа математической операции
        my $number = tools::calculator_check_number();

        # Вычисление результата выражения
        if ( $action eq "+" ) {
            $result = $result + $number;
        } elsif ( $action eq "-" ) {
            $result = $result - $number;
        } elsif ( $action eq "/" ) {
            if ( $number == 0 ) {
                print "Ошибка, нельзя делить на ноль\n";
                next;
            }
            $result = $result / $number;
        } else {
            $result = $result * $number;
        }
        $result_expression .= " $action $number";

        # Вывод предрезультата
        print "$result\n";
    } else {
        print "Ошибка, $action не математическим действием\n";
    };
}
