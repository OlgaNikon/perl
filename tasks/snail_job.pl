#!/usr/bin/perl
use strict;
use warnings;

# Константы
my $DAY_IN_SPRINT = 10;

# Получаем данные введенное при запуске программы
my $tech_debt = $ARGV[0];
my $snail_speed = $ARGV[1];
my $backlog_speed = $ARGV[2];

# Вычесления для определения количества спринтов необходимых для закрытия техдолга
my $result = ( $snail_speed > $backlog_speed ) ?
    int( $tech_debt / ( ( $snail_speed - $backlog_speed ) * $DAY_IN_SPRINT ) ) : 0;
print $result ? "Справится за $result спринтов" : "Не справится!";
