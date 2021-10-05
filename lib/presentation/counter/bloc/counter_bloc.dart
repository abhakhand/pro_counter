import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:replay_bloc/replay_bloc.dart';

part 'counter_event.dart';
part 'counter_state.dart';
part 'counter_bloc.freezed.dart';

class CounterBloc extends HydratedBloc<CounterEvent, CounterState>
    with ReplayBlocMixin {
  CounterBloc() : super(const CounterState.initial());

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    yield event.when(
      increment: () => CounterState.current(state.count + 1),
      decrement: () => CounterState.current(state.count - 1),
      reset: () => const CounterState.current(0),
    );
  }

  @override
  CounterState fromJson(Map<String, dynamic> json) =>
      CounterState.initial(json['counter'] as int);

  @override
  Map<String, dynamic> toJson(CounterState state) =>
      <String, dynamic>{'counter': state.count};
}
