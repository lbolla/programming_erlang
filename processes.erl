-module(processes).
-compile(export_all).

max(N) ->
    Max = erlang:system_info(process_limit),
    io:format("Max num procs ~p~n", [Max]),
    statistics(runtime),
    statistics(wall_clock),
    Procs = [spawn(fun wait/0) || _ <- lists:seq(1, N)],
    lists:foreach(fun(Pid) -> Pid ! die end, Procs),
    {_, Time1} = statistics(runtime),
    {_, Time2} = statistics(wall_clock),
    U1 = Time1 * 1000 / N,
    U2 = Time2 * 1000 / N,
    io:format("Spawn us/proc ~p / ~p~n", [U1, U2]).

wait() ->
    receive
	die ->
	    void
    end.
    
