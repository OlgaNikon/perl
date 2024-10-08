#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use lib 'C:/first/tasks/';
use tools;

# Вввод числа математической операции
my $result = tools::calculator_check_number();
my $result_expression = $result;
my $last_action = "";
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
        my $number = _calculator_pro_check_number();

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

        if ( ( $action eq "/" || $action eq "*" ) && ( $last_action eq "+" || $last_action eq "-" ) ) {
            $result_expression = "( $result_expression )";
        }

        $result_expression .= " $action $number";
        $last_action = $action;

        # Вывод предрезультата
        print "$result\n";
    } else {
        print "Ошибка, $action не математическим действием\n";
    };
}
