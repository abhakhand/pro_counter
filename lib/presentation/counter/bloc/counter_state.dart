part of 'counter_bloc.dart';

@freezed
class CounterState with _$CounterState {
  const factory CounterState.initial([@Default(0) int count]) = _Initial;
  const factory CounterState.current(int count) = _Current;
}
