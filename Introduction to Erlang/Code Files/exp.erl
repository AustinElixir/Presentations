-module(exp).
-compile([export_all]).

eval({int, I}) -> I;
eval({neg, Exp}) -> -Exp;
eval({add, A,B}) -> A + B.

toString({int, I}) -> integer_to_list(I);
toString({neg, Exp}) -> "-" ++ toString({int, Exp});
toString({add, A, B}) -> toString({int, A}) ++ " + " ++ toString({int, B}).

hasZero({int, I}) -> I == 0;
hasZero({neg, Exp}) -> hasZero(Exp);
hasZero({add, A, B}) -> hasZero(A) or hasZero(B);
hasZero(I) -> I == 0.

tests() ->
    true = 1 =:= eval({int, 1}),
    true = -1 == eval({neg, 1}),
    true = 4 =:= eval({add, 2, 2}),
    true = "2" == toString({int, 2}),
    true = "-2" == toString({neg, 2}),
    true = "2 + 2" == toString({add, 2, 2}),
    true = true == hasZero({int, 0}),
    true = false == hasZero({int, 2}),
    true = false == hasZero({neg, 2}),
    true = true == hasZero({add, 0, 0}),
    true = true == hasZero({add, 0, 1}),
    true = false == hasZero({add, 1, 1}),
    ok.