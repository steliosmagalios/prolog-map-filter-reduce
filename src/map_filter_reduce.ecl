% :- module(map_filter_reduce).





filter([], _Predicate, _Arguments, []) :- !.

filter([Item | RestItems], Predicate, Arguments, [Item | RestResult]) :-
  C =.. [Predicate, Item | Arguments],
  call(C), !,

  filter(RestItems, Predicate, Arguments, RestResult).

filter([Item | RestItems], Predicate, Arguments, Result) :-
  C =.. [Predicate, Item | Arguments],
  not(call(C)), !,

  filter(RestItems, Predicate, Arguments, Result).





map([], _Predicate, _Arguments, []) :- !.

map([Item | RestItems], Predicate, Arguments, [MappedItem | RestMapped]) :-
  C =.. [Predicate, Item, MappedItem | Arguments],
  call(C), !,

  map(RestItems, Predicate, Arguments, RestMapped).





% If the list is empty, the predicate fails
reduce([], _Predicate, _Arguments, _Result) :- fail.

reduce([Item], _Predicate, _Arguments, Item) :- !.

reduce([Item1, Item2 | RestItems], Predicate, Arguments, Result) :-
  C =.. [Predicate, Item1, Item2, Accumulator | Arguments],
  call(C), !,

  reduce([Accumulator | RestItems], Predicate, Arguments, Result).
