-module(geometry).
-compile(export_all).

start() ->
    spawn(fun loop/0).

rpc(Pid, Request) ->
    Pid ! {self(), Request},
    receive
	Response ->
	    Response
    end.

loop() ->
    receive
	{From, {rectangle, W, H}} ->
	    From ! W * H,
	    loop();
	{From, {circle, R}} ->
	    From ! 3.14159 * R * R,
	    loop();
	{From, Other} ->
	    From ! {error, Other},
	    loop()
    end.
