%%% Snippets from slides
-module(snippets).
-compile(export_all).

%% Minimum memory for a process
% Fun = fun() -> receive after infinity -> ok end end.
% {_,Bytes} = process_info(spawn(Fun), memory).
% {memory,1232}

%% Parse a buffer with pattern matching on binary data
parse_buffer(BufferAll, 0, Bytes) ->
        case BufferAll of
            <<Data:Bytes/binary, Buffer/binary>> -> {Data, Buffer, Bytes};
            <<Data/binary>> -> {Data, <<>>, erlang:size(Data)}
        end;

parse_buffer(BufferAll, SeekPos, Bytes) ->
        case BufferAll of
            <<_:SeekPos/binary, Data:Bytes/binary, Buffer/binary>> -> {Data, Buffer, Bytes};
            <<_:SeekPos/binary, Data/binary>> -> {Data, <<>>, erlang:size(Data)}
        end.

%% Sum all the ints from 1 to N
sum(0) -> 0;
sum(N) when N > 0 ->
    N + sum(N - 1).

%% Rewritten as a case expression
sum_case(N) when N >= 0 ->
    case N of
        0 -> 0;
        N -> N + sum_case(N - 1)
    end.

%% Sum all the numbers from A to B
sum_range(A, A) -> A;

sum_range(A, B) when B > A,
                     A > 0,
                     B > 0 ->
                B + sum_range(A, B - 1).

%% Normal recursion
fac(0) -> 1;
fac(N) when N > 0  -> N*fac(N-1).

%% Tail recursion
%% public arity 1
fac_tail(N) -> tail_fac(N,1).

%% private arity 2
tail_fac(0,Acc) -> Acc;
tail_fac(N,Acc) when N > 0 -> tail_fac(N-1,N*Acc).

%% Messaging
loop() ->
    receive
        {Pid, Msg} -> Pid ! Msg,
                      loop();
        die -> ok;
        _ -> exit
    end.

% Pid = spawn(snippets, loop, []).
% Pid ! {self(), hi}
% Pid ! die

% Pull a reply from your mailbox
% receive Msg1 -> io:format("I got: ~p", [Msg1]) after 1000 -> erlang:error(timeout) end.