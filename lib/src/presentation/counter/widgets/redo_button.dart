import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_counter/src/application/counter/counter_bloc.dart';
import 'package:pro_counter/src/presentation/core/helpers/widget_keys.dart';

class RedoButton extends StatelessWidget {
  const RedoButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, CounterState>(
      builder: (context, state) {
        final bloc = context.read<CounterBloc>();
        return IconButton(
          key: WidgetKeys.counterRedoButtonKey,
          icon: const Icon(Icons.redo),
          onPressed: bloc.canRedo ? bloc.redo : null,
        );
      },
    );
  }
}
