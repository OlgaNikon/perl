#!/usr/bin/perl
use strict;
use warnings;

# Константы
my $DAY_IN_SPRINT = 10;
my $BIT_OPERATION = 31;

# Получаем данные введенное при запуске программы
my $tech_debt = $ARGV[0];
my $snail_speed = $ARGV[1];
my $backlog_speed = $ARGV[2];

# Вычесления для определения количества спринтов необходимых для закрытия техдолга
my $temp_result = $tech_debt / ( ( $snail_speed - $backlog_speed ) * $DAY_IN_SPRINT );
my $mask = $temp_result >> $BIT_OPERATION;
my $sprint = ( ( $temp_result + $mask ) ^ $mask );
my $result = ( $sprint + int( $temp_result ) ) % 2;
my %results = (
    1 => "Не справится!",
    0 => "Справится за $sprint спринтов",
);

# Вывод результата
print $results{$result};
