part of 'counter_bloc.dart';

@freezed
class CounterState with _$CounterState {
  const factory CounterState.value(int count) = _Initial;
}
