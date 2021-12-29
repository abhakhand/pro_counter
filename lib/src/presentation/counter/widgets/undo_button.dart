import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_counter/src/application/counter/counter_bloc.dart';
import 'package:pro_counter/src/presentation/core/helpers/widget_keys.dart';

class UndoButton extends StatelessWidget {
  const UndoButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, CounterState>(
      builder: (context, state) {
        final bloc = context.read<CounterBloc>();
        return IconButton(
          key: WidgetKeys.counterUndoButtonKey,
          icon: const Icon(Icons.undo),
          onPressed: bloc.canUndo ? bloc.undo : null,
        );
      },
    );
  }
}
