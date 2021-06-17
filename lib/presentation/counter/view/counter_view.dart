import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_counter/app/l10n/l10n.dart';
import 'package:pro_counter/presentation/core/widget_keys/widget_keys.dart';
import 'package:pro_counter/presentation/counter/bloc/counter_bloc.dart';
import 'package:pro_counter/presentation/counter/view/widgets/counter_text.dart';

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (_) => CounterBloc(),
      child: const CounterPage(),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.counterAppBarTitle),
        actions: [
          BlocBuilder<CounterBloc, CounterState>(
            builder: (context, state) {
              final bloc = context.read<CounterBloc>();
              return IconButton(
                key: WidgetKeys.counterUndoButtonKey,
                icon: const Icon(Icons.undo),
                onPressed: bloc.canUndo ? bloc.undo : null,
              );
            },
          ),
          BlocBuilder<CounterBloc, CounterState>(
            builder: (context, state) {
              final bloc = context.read<CounterBloc>();
              return IconButton(
                key: WidgetKeys.counterRedoButtonKey,
                icon: const Icon(Icons.redo),
                onPressed: bloc.canRedo ? bloc.redo : null,
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CounterText(),
            TextButton(
              key: WidgetKeys.counterResetButtonKey,
              onPressed: () => context.read<CounterBloc>().add(
                    const CounterEvent.reset(),
                  ),
              child: Text(
                l10n.counterResetButtonLabel,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            key: WidgetKeys.counterIncrementButtonKey,
            onPressed: () => context.read<CounterBloc>().add(
                  const CounterEvent.increment(),
                ),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            key: WidgetKeys.counterDecrementButtonKey,
            onPressed: () => context.read<CounterBloc>().add(
                  const CounterEvent.decrement(),
                ),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
