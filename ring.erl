-module(ring).
-compile(export_all).

ring(N, M) ->
    Self = self(),
    [Pid0|_] = Pids = chain(M, N, [Self]),
    io:format("~p~n", [Pids]),
    whisper(Pid0, N).

chain(0, _, Acc) -> Acc;
chain(X, N, [H|_] = Acc) ->
    chain(X - 1, N, [spawn(fun() -> whisper(H, N) end) | Acc]).
    
whisper(Pid, N) ->
    case N of
	0 ->
	    io:format("~p did enough trips~n", [self()]),
	    void;
	_ -> receive
		 Any ->
		     %% io:format("~p whispers to ~p for the ~p th time~n", [self(), Pid, N]),
		     Pid ! Any,
		     whisper(Pid, N - 1)
	     end
    end.

