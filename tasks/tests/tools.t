#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use lib 'C:/first/tasks/';
use tools;

# Объявление необходимых данных для тестов
my %users_init = (
     "Alina"   => "qw1234fg"
    , "Anna"   => "5678"
    , "Andrey" => "1234"
    , "Petr"   => "hjk364dfgh"
);
my $conf_path = "tasks/files/";
my $file_name = "test_user_prms.ini";
if ( ! open FILE, ">", $conf_path . $file_name ) {
    print "Can't open '$file_name': $!";
}

while ( ( my $key, my $value ) = each %users_init ) {
    print FILE "$key=$value\n";
}

close FILE;

# Тесты метода test_calculator_check_number
subtest 'test_calculator_check_number' => sub {
    # Объявление данных, которые будет считываться как со стандартного ввода.
    # Пользователь сразу ввел корректные данные
    my $input = "20\n";
    open my $in, "<", \$input or print "Cannot open STDIN $!";
    local *STDIN = $in;

    # Вызываем метод и проверяем результат
    is( tools::calculator_check_number( ), 20, "test_calculator_check_number for input = $input" );

    # Объявление данных, которые будет считываться как со стандартного ввода.
    # Пользователь сначала ввел не корректные данные
    $input = "4234gsdf\n-5\n";
    open $in, "<", \$input or print "Cannot open STDIN $!";
    local *STDIN = $in;

    # Вызываем метод и проверяем результат
    is( tools::calculator_check_number( ), -5, "test_calculator_check_number for input = $input" );

    close $in;
};

# Тесты метода task_4_check_login_and_password
subtest 'task_4_check_login_and_password' => sub {
    # Проверка результата для корректных имени и пароля.
    # Пароль в хеше для данного имени совпадает
    is( tools::task_4_check_login_and_password( "Anna", "5678" ), 1,
        "task_4_check_login_and_password for name = Anna and passwd = 5678" );

    # Проверка результата для не корректного пароля
    is( tools::task_4_check_login_and_password( "Anna", undef ), 0,
        "task_4_check_login_and_password for name = Anna and passwd = undef" );

    # Проверка результата для не корректного имени
    is( tools::task_4_check_login_and_password( "", "5678" ), 0,
        "task_4_check_login_and_password for name = '' and passwd = 5678" );

    # Проверка результата для корректных имени и пароля.
    # Пароль в хеше для данного имени не совпадает
    is( tools::task_4_check_login_and_password( "Petr", "5678" ), 0,
        "task_4_check_login_and_password for name = Petr and passwd = 5678" );
};

# Тесты метода task_5_read_conf
subtest 'task_5_read_conf' => sub {
    # Объявление массива, который должен быть на выходе при вывозе метода
    my @array = ( "Alina=qw1234fg", "Andrey=1234", "Anna=5678", "Petr=hjk364dfgh" );

    # Проверка, что используемый файл существует
    ok( -e $conf_path . $file_name, "task_5_read_conf $file_name exists" );

    # Вызов метода и сохрание результата
    my @result_array = tools::task_5_read_conf( $file_name );

    # Проверка, что актульаный и ожидаемый результаты совпадают
    ok( eq_array( sort @result_array, sort @array ), "task_5_read_conf" );
};

# Тесты метода task_6_read_conf
subtest 'task_6_read_conf' => sub {
    # Объявление хеша, который должен быть на выходе при вывозе метода
    my %hash = (
         "Alina"   => "qw1234fg"
        , "Anna"   => "5678"
        , "Andrey" => "1234"
        , "Petr"   => "hjk364dfgh"
    );

    # Проверка, что используемый файл существует
    ok( -e $conf_path . $file_name, "task_6_read_conf $file_name exists" );

    # Вызов метода и сохрание результата
    my %result_hash = tools::task_6_read_conf( $file_name );

    # Проверка, что актульаный и ожидаемый результаты совпадают
    ok( eq_hash( \%result_hash, \%hash ), "task_6_read_conf" );
};

# Тесты метода task_8_check_login_and_password
subtest 'task_8_check_login_and_password' => sub {
    # Проверка результата для корректных имени и пароля.
    is( tools::task_8_check_login_and_password( "Anna", "5678" ), 1,
        "task_8_check_login_and_password for name = Anna and passwd = 5678" );

    # Проверка результата для не корректного пароля
    is( tools::task_8_check_login_and_password( "Anna", undef ), 0,
        "task_8_check_login_and_password for name = Anna and passwd = undef" );

    # Проверка результата для не корректного имени
    is( tools::task_8_check_login_and_password( "", "5678" ), 0,
        "task_8_check_login_and_password for name = '' and passwd = 5678" );
};

# subtest 'task_8_login' => sub {
# };

# Тесты метода task_8_rewrite_config
subtest 'task_8_rewrite_config' => sub {
    # Объявление хеша, который должен быть на выходе при вывозе метода
    my %users_result = (
         "Alina"   => "qw1234fg"
        , "Anna"   => "5678"
        , "Andrey" => "Hvjk*h123f"
        , "Petr"   => "hjk364dfgh"
    );

    # Проверка, что используемый файл существует
    ok( -e $conf_path . $file_name, "task_8_rewrite_config $file_name exists" );

    # Вызов метода и считываение обновленных данных
    tools::task_8_rewrite_config( $file_name, %users_result );
    my %users = tools::task_6_read_conf( $file_name );

    # Проверка, что актульаный и ожидаемый результаты совпадают и не совпадают с исходными данными
    #is_deeply( \%users, \%users_result, "task_8_rewrite_config" );
    ok( eq_hash( \%users, \%users_result ), "task_8_rewrite_config for name = Andrey and password = Hvjk*h123f" );
    ok( !eq_hash( \%users, \%users_init ), "task_8_rewrite_config for name = Andrey and password = Hvjk*h123f" );

    # Возврат тестовых данных в исходное состояние
    tools::task_8_rewrite_config( $file_name, %users_init );
};

# Тесты метода task_8_reg_user
subtest 'task_8_reg_user' => sub {
    # Объявление хеша, который должен быть на выходе при вывозе метода
    my %users_result = (
         "Alina"   => "qw1234fg"
        , "Anna"   => "5678"
        , "Andrey" => "1234"
        , "Petr"   => "hjk364dfgh"
        , "Vlad"   => "klm2347%fjjK"
    );

    # Проверка, что используемый файл существует
    ok( -e $conf_path . $file_name, "task_8_reg_user $file_name exists" );

    # Вызов метода и считываение обновленных данных
    tools::task_8_reg_user( $file_name, "Alina", "1234" );
    my %users = tools::task_6_read_conf( $file_name );

    # Проверка, что данные не изменились, так как данное имя уже существует
    ok( eq_hash( \%users, \%users_init ), "task_8_reg_user for name = Alina and password = 1234" );

    # Вызов метода и считываение обновленных данных
    tools::task_8_reg_user( $file_name, "Vlad", "klm2347%fjjK" );
    %users = tools::task_6_read_conf( $file_name );

    # Проверка, что актульаный и ожидаемый результаты совпадают и не совпадают с исходными данными
    ok( !eq_hash( \%users, \%users_init ), "task_8_reg_user for name = Vlad and password = klm2347%fjjK" );
    ok( eq_hash( \%users, \%users_result ), "task_8_reg_user for name = Vlad and password = klm2347%fjjK" );

    # Возврат тестовых данных в исходное состояние
    tools::task_8_rewrite_config( $file_name, %users_init );
};

# Тесты метода task_9_check_user_name
subtest 'task_9_check_user_name' => sub {
    # Проверка результата для валидного имени
    is( tools::task_9_check_user_name( "Olga" ), 1, "task_9_check_user_name for name = Olga" );
    is( tools::task_9_check_user_name( "my-name" ), 1, "task_9_check_user_name for name = my-name" );

    # Проверка результата для не валидного имени
    is( tools::task_9_check_user_name( "my#name" ), 0, "task_9_check_user_name for name = my#name" );
    is( tools::task_9_check_user_name( "" ), 0, "task_9_check_user_name for name = ''" );
};

# Тесты метода task_9_check_user_password
subtest 'task_9_check_user_password' => sub {
    # Проверка результата для валидного пароля
    is( tools::task_9_check_user_password( "M1234\$5678" ), 1, "task_9_check_user_password for password = M1234\$5678" );

    # Проверка результата для не валидного пароля
    is( tools::task_9_check_user_password( "" ), 0, "task_9_check_user_password for password = ''" );
    is( tools::task_9_check_user_password( "12345678" ), 0, "task_9_check_user_password for password = 12345678" );
    is( tools::task_9_check_user_password( "k12345678" ), 0, "task_9_check_user_password for password = k12345678" );
    is( tools::task_9_check_user_password( "k1234567*8" ), 0, "task_9_check_user_password for password = k1234567*8" );
    is( tools::task_9_check_user_password( "ksdfghjM&l" ), 0, "task_9_check_user_password for password = ksdfghjM&l" );
};

# Тесты метода task_10_del_user
subtest 'task_10_del_user' => sub {
    # Объявление хеша, который должен быть на выходе при вывозе метода
    my %users_result = (
         "Alina"   => "qw1234fg"
        , "Anna"   => "5678"
        , "Andrey" => "1234"
    );

    # Проверка, что используемый файл существует
    ok( -e $conf_path . $file_name, "task_10_del_user $file_name exists" );

    # Вызов метода и считываение обновленных данных
    tools::task_10_del_user( $file_name, "Mila" );
    my %users = tools::task_6_read_conf( $file_name );

    # Проверка, что данные не изменились, так как данное имя не существует
    ok( eq_hash( \%users, \%users_init ), "task_10_del_user for name = Mila" );

    # Вызов метода и считываение обновленных данных
    tools::task_10_del_user( $file_name, "Petr" );
    %users = tools::task_6_read_conf( $file_name );

    # Проверка, что актульаный и ожидаемый результаты совпадают и не совпадают с исходными данными
    ok( eq_hash( \%users, \%users_result ), "task_10_del_user for name = Petr" );
    ok( !eq_hash( \%users, \%users_init ), "task_10_del_user for name = Petr" );

    # Возврат тестовых данных в исходное состояние
    tools::task_8_rewrite_config( $file_name, %users_init );
};

# Тесты метода task_11_change_password
subtest 'task_11_change_password' => sub {
    # Объявление хеша, который должен быть на выходе при вывозе метода
    my %users_result = (
         "Alina"   => "qw1234fg"
        , "Anna"   => "5678"
        , "Andrey" => "L1234^5678n"
        , "Petr"   => "hjk364dfgh"
    );

    # Проверка, что используемый файл существует
    ok( -e $conf_path . $file_name, "task_11_change_password $file_name exists" );

    # Вызов метода и считываение обновленных данных
    tools::task_11_change_password( $file_name, "Mila", "L1234^5678n" );
    my %users = tools::task_6_read_conf( $file_name );

    # Проверка, что данные не изменились, так как данное имя не существует
    ok( eq_hash( \%users, \%users_init ), "task_11_change_password for name = Mila and password = L1234^5678n" );

    # Вызов метода и считываение обновленных данных
    tools::task_11_change_password( $file_name, "Andrey", "1234" );
    %users = tools::task_6_read_conf( $file_name );

    # Проверка, что данные не изменились, так как пароль не валидный
    ok( eq_hash( \%users, \%users_init ), "task_11_change_password for name = Andrey and password = 1234" );

    # Вызов метода и считываение обновленных данных
    tools::task_11_change_password( $file_name, "Andrey", "L1234^5678n" );
    %users = tools::task_6_read_conf( $file_name );

    # Проверка, что актульаный и ожидаемый результаты совпадают и не совпадают с исходными данными
    ok( eq_hash( \%users, \%users_result ), "task_11_change_password for name = Andrey and password = L1234^5678n" );
    ok( !eq_hash( \%users, \%users_init ), "task_11_change_password for name = Andrey and password = L1234^5678n" );

    # Возврат тестовых данных в исходное состояние
    tools::task_8_rewrite_config( $file_name, %users_init );
};

# Удаление используваемого файла для тестов
unlink $conf_path . $file_name or print "can't remove $file_name: $!";

done_testing();
