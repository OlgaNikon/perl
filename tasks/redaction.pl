#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

# ОбЪявление необходимых параметров
my $conf_path = "tasks/newsletter/";
my @bad_words_dictionary;

# Открытие файла для получения неприличных слов
if ( ! open FILE, "<", $conf_path . "bad_words.ini" ) {
    print "Can't open 'bad_words.ini in directory $conf_path ': $!";
}

# Если удалось открыть файл, сохраняем в массив неприличные слова
while ( <FILE> ) {
    chomp;
    push @bad_words_dictionary, split;
}

# Закрытие файла
close FILE;

# Открываем файл для чтения скрипта
print "Введите название файла для чтения\n";
chomp( my $file_name = <STDIN> );
if ( ! open FILE, "<", $conf_path . $file_name ) {
    print "Can't open '$file_name in directory $conf_path ': $!";
}

# Если удалось открыть файл, считаем общее количество слов, сохраняем слово и его количество повторовов
# так же проверяем слова с переносом на другую строку
my $count_words = 0;
my $part_word;
my %hash_words;
while ( <FILE> ) {
    chomp;
    my @words = split;
    $count_words += @words;

    if ( defined( $part_word ) ) {
        $words[0] = $part_word . $words[0];
        $part_word = undef;
        $count_words--;
    }

    for my $word ( @words ) {
        if ( $word =~ m/ - $ /x ) {
            $part_word = $word;
            $part_word =~ s/ - //x;
        } else {
            $hash_words{$word} = exists $hash_words{$word} ? $hash_words{$word} + 1 : 1;
        }
    }
}

# Закрытие чтение файла
close FILE;

# Вывод общего количества слов
print "Всего слов: $count_words\n";

# Выводим слова, которые повторяются больше двух раз и так же правярает слова на приличность
my @bad_words_script;
foreach my $key ( sort {$hash_words{$b} <=> $hash_words{$a}} keys %hash_words ) {
    my $value = $hash_words{$key};
    if ( $value > 2 ) {
        print "$key $value\n";
    }
    if ( grep( m/ ^ $key $ /x, @bad_words_dictionary ) ) {
        push @bad_words_script, $key;
    }
}

# Выводим не приличные слова
print @bad_words_script > 0 ? "В тексе есть следующие неприличные слова: @bad_words_script"
    : "В тексте нет не приличных слов";
