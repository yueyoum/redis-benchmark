-module(server).
-export([start/1]).
-export([worker/1]).

-vsn(1.0).

start(Port) ->
    {ok, Sock} = gen_tcp:listen(Port, [
                binary,
                inet,
                {reuseaddr, true},
                {active, once},
                {nodelay, true},
                {ip, {127,0,0,1}},
                {packet, line}
                ]),

    io:format("start on port ~p~n", [Port]),
    loop(Sock).


loop(Sock) ->
    {ok, Client} = gen_tcp:accept(Sock),
    Pid = spawn(?MODULE, worker, [Client]),
    gen_tcp:controlling_process(Client, Pid),
    loop(Sock).


worker(Client) ->
    receive
        {tcp, Client, <<"PING\r\n">>} ->
            gen_tcp:send(Client, <<"+PING\r\n">>),
            inet:setopts(Client, [{active, once}]),
            worker(Client);
        {tcp, _, _Data} ->
            inet:setopts(Client, [{active, once}]),
            worker(Client);
        {tcp_closed, _} ->
            ok;
        {tcp_error, _, _Reason} ->
            ok
    end.


