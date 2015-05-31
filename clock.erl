-module(clock).
-compile(export_all).

start(Time, Fun) ->
    register(clock, spawn(fun() -> tick(Time, Fun) end)).

stop() ->
    clock ! stop.

tick(N, Fun) ->
    receive
	stop ->
	    void
    after N ->
	    Fun(),
	    tick(N, Fun)
    end.
