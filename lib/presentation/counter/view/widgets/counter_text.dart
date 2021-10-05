import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_counter/presentation/counter/bloc/counter_bloc.dart';

class CounterText extends StatelessWidget {
  const CounterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final count = context.select(
      (CounterBloc bloc) => bloc.state.count,
    );

    return AnimatedFlipCounter(
      value: count.toDouble(),
      textStyle: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: counterColor(count),
      ),
    );
  }

  Color counterColor(int value) {
    if (value < 0) {
      return Colors.red;
    } else if (value > 0) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }
}
