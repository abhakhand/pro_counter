import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:replay_bloc/replay_bloc.dart';

part 'counter_event.dart';
part 'counter_state.dart';
part 'counter_bloc.freezed.dart';

class CounterBloc extends HydratedBloc<CounterEvent, CounterState>
    with ReplayBlocMixin {
  CounterBloc() : super(const CounterState.value(0)) {
    on<CounterEvent>(_onEvent);
  }

  void _onEvent(
    CounterEvent event,
    Emitter<CounterState> emit,
  ) {
    emit(
      event.map(
        increment: (_) => CounterState.value(state.count + 1),
        decrement: (_) => CounterState.value(state.count - 1),
        reset: (_) => const CounterState.value(0),
      ),
    );
  }

  @override
  CounterState fromJson(Map<String, dynamic> json) =>
      CounterState.value(json['counter'] as int);

  @override
  Map<String, dynamic> toJson(CounterState state) =>
      <String, dynamic>{'counter': state.count};
}
