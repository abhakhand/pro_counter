part of 'counter_bloc.dart';

@freezed
class CounterEvent extends ReplayEvent with _$CounterEvent {
  const factory CounterEvent.increment() = _Increment;
  const factory CounterEvent.decrement() = _Decrement;
  const factory CounterEvent.reset() = _Reset;
}
