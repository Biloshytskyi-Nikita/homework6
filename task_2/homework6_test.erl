-module(homework6_test).
-include_lib("common_test/include/ct.hrl").

-export([all/0, create_cache_test/0, insert_lookup_test/0, ttl_test/0]).

all() ->
    [create_cache_test, insert_lookup_test, ttl_test].
create_cache_test() ->
    homework6_server:create("test_table"),
    ?assertMatch(true, ets:info("test_table") =/= undefined).
insert_lookup_test() ->
    homework6_server:create("test_table"),
    homework6_server:insert("test_table", key, value),
    ?assertEqual(value, homework6_server:lookup("test_table", key)).
ttl_test() ->
    homework6_server:create("test_table"),
    homework6_server:insert("test_table", key, value, 2),
    timer:sleep(3000),  % Чекаємо 3 секунди
    ?assertEqual(undefined, homework6_server:lookup("test_table", key)).
