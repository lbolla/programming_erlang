-module(lib_misc).
-compile(export_all).

sleep(N) ->
    receive
    after N ->
	    true
    end.

on_exit(Pid, Fun) ->
    spawn(fun() ->
		  process_flag(trap_exit, true),
		  link(Pid),
		  receive
		      {'EXIT', Pid, Why} ->
			  Fun(Why)
		  end
	  end).
