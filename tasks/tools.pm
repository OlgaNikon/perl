package tools;
use strict;
use warnings FATAL => 'all';
use XML::LibXML;
use JSON::PP;

my $conf_path = "tasks/files/";

# Вввод числа и прверка, что введенное значение является числом
sub calculator_check_number {
    print "Введите число\n";
    while ( ) {
        chomp( my $number = <STDIN> );
        if ( $number =~ m/ ^ ( -? \d+ ) $/x ) {
            return $number;
        } else {
            print "Ошибка, $number не математическим выражением, введите выражение\n";
        }
    }
}

# Функция проверки логина и пароля
sub task_4_check_login_and_password {
    my ( $user_name, $user_password ) = @_;

    # Проверяем что данные не пустые и корректные
    my $find = 1;
    if ( !defined( $user_name ) || $user_name =~ m/ \W | ^ $ /x ) {
        print "Не указано имя пользователя\n";
        $find = 0;
    }
    if ( !defined( $user_password ) || $user_password =~ m/ \W | ^ $ /x ) {
        print "Не указан пароль\n";
        $find = 0;
    }

    # ОбЪявление необходимых параметров
    my %user_prms = (
          "Andrey" => "1234"
        , "Anna"   => "5678"
        , "Dima"   => "0000"
        , "Olga"   => "1234"
    );

    # Проверяем совпадает ли имя и пароль
    if ( $find == 1 && exists( $user_prms{$user_name} ) && $user_password eq $user_prms{$user_name} ) {
        return 1;
    }

    return 0;
}

# Функция прочтения файла и сохранения его в массив
sub task_5_read_conf {
    my $file_name = shift @_;

    # Открываем файл
    if ( ! open FILE, "<", $conf_path . $file_name ) {
        print "Can't open '$conf_path': $!";
    }

    # Если удалось открыть файл, читаем и сохраняем его в массив
    my @users;
    while ( my $file = <FILE> ) {
        chomp( $file );
        push @users, $file;
    }

    # Закрытие файла
    close FILE;

    return @users;
}

# Функция прочтения файла и сохранения его в хеш
sub task_6_read_conf {
    my $file_name = shift @_;

    # Открываем файл
    if ( ! open FILE, "<", $conf_path . $file_name ) {
        print "Can't open '$conf_path': $!";
    }

    # Если удалось открыть файл, читаем, форматируем строки и проверяем на соответствия, сохраняем в хеш
    my %users;
    while ( my $line = <FILE> ) {
        $line =~ s/ \s //xg;
        if ( $line =~ m/ ( ^ \#{0} \w* ) = ( [\w!@#\$%^&*()]* ) /x ) {
            $users{$1} = $2;
        }
    }

    # Закрытие файла
    close FILE;

    return %users;
}

# Функция проверки логина и пароля, что не пустые
sub task_8_check_login_and_password {
    my ( $user_name, $user_password ) = @_;

    # Проверяем что данные не пустые и корректные
    if ( !defined( $user_name ) || $user_name =~ m/ \W | ^ $ /x ) {
        print "Не указано имя пользователя\n";
        return 0;
    }
    if ( !defined( $user_password ) || $user_password =~ m/ \W | ^ $ /x ) {
        print "Не указан пароль\n";
        return 0;
    }
    return 1
}

# Функция для входа пользователя
sub task_8_login {

}

# Функция для регистрации нового пользователя
sub task_8_reg_user {
    my ( $file_name, $user_name, $user_password ) = @_;

    my %users = &task_6_read_conf( $file_name );

    if ( exists( $users{$user_name} ) ) {
        print "Пользователь с таким логином уже зарегистрирован\n";
    } else {
        $users{$user_name} = $user_password;
        &task_8_rewrite_config( $file_name, %users );
        print "Пользователь зарегистрирован\n";
    }
}

# Функция для сохранения/удаления пользователя
sub task_8_rewrite_config {
    my ( $file_name, %users ) = @_;

    if ( ! open FILE, ">", $conf_path . $file_name ) {
        print "Can't open '$file_name': $!";
    }

    while ( ( my $key, my $value ) = each %users ) {
        print FILE "$key=$value\n";
    }

    close FILE;
}

# Функция для проверки имя пользователя на валидность
sub task_9_check_user_name {
    my $user_name = shift @_;

    if ( !defined( $user_name ) || ! ( $user_name =~ m/ ^ [A-Za-z]+ [A-Za-z0-9_-]* [A-Za-z0-9]+ $ /x ) ) {
        print "Имя пользователя либо не указано, либо указано не верно. Используйте только буквы цифры и символы -_\n";
        return 0;
    }

    return 1;
}

# Функция для проверки пароля пользователя на валидность
sub task_9_check_user_password {
    my $user_password = shift @_;

    if ( !defined( $user_password ) || length( $user_password ) < 8 ) {
        print "Пароль должен быть не короче 8 символов\n";
    } elsif ( ! ( $user_password =~ m/ ^ [A-Za-z]+ /x ) ) {
        print "Пароль должен начинаться с буквы\n";
    } elsif ( ! ( $user_password =~ m/ [!@#\$%^&*()] /x ) ) {
        print "Пароль должен содержать хоты бы один символ !@#\$%^&*()\n";
    } elsif ( ! ( $user_password =~ m/ [A-Z]+ /x ) ) {
        print "Пароль должен содержать хоты бы один символ в верхнем регистре\n";
    } elsif ( ! ( $user_password =~ m/ \d+ /x ) ) {
        print "Пароль должен содержать хоты бы одну цифру\n";
    } else {
        return 1;
    }

    return 0;
}

sub task_10_del_user {
    my ( $file_name, $user_name ) = @_;

    my %users = &task_6_read_conf( $file_name );

    if ( defined( $user_name ) && exists( $users{$user_name} ) ) {
        delete $users{$user_name};
        &task_8_rewrite_config( $file_name, %users );
        print "Пользователь удален\n";
    } else {
        print "Пользователь с таким именем не существует\n";
    }
}

# Функция для изменения пароля
sub task_11_change_password {
    my ( $file_name, $user_name, $user_password ) = @_;

    my %users = &task_6_read_conf( $file_name );

    if ( defined( $user_name ) && exists( $users{$user_name} ) ) {
        my $check_passwd = &task_9_check_user_password( $user_password );
        if ( $check_passwd == 1 ) {
            $users{$user_name} = $user_password;
            &task_8_rewrite_config( $file_name, %users );
            print "Пароль изменен\n";
        }
    } else {
        print "Пользователь с таким именем не существует\n";
    }
}

# Функция для парсинга xml
sub parse_pro_xml {
    my $file_name = shift @_;

    # Чтение и парсинг xml
    my $document = XML::LibXML->new->parse_file( $conf_path . $file_name );

    # форматируем результат
    $document =~ s/ < [^>]* > //gx;
    $document =~ s/ \s+ / /gx;

    return $document;
}

# Функция для парсинга json
sub parse_pro_json {
    my $file_name = shift @_;

    # Открываем файл
    if ( ! open FILE, "<", $conf_path . $file_name ) {
        print "Can't open '$file_name in directory $conf_path ': $!";
    }

    # Если удалось открыть файл, читаем и сохраняем его в строку
    my $json_string = "";
    while ( my $file = <FILE> ) {
        chomp( $file );
        $json_string .= $file;
    }

    # Закрытие файла
    close FILE;

    # парсинг json
    my $document = JSON::PP->new->encode( $json_string );

    # форматируем результат
    $document =~ s/ \\+ \"+ \w* \\+ \"+ \h+ :+ //gx;
    $document =~ s/ {+ | }+ | \[+ | \]+ | \\+ | \"+ | ,+ //gx;
    $document =~ s/ \s+ / /gx;

    return $document;
}

1;