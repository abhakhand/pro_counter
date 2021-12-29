import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_counter/app/l10n/l10n.dart';
import 'package:pro_counter/src/application/counter/counter_bloc.dart';
import 'package:pro_counter/src/presentation/core/helpers/widget_keys.dart';
import 'package:pro_counter/src/presentation/counter/widgets/widgets.dart';

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

    return AnimatedTheme(
      data: Theme.of(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.counterAppBarTitle),
          actions: const [
            ThemeSwitcherButton(),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    UndoButton(),
                    CounterText(),
                    RedoButton(),
                  ],
                ),
              ),
              const ResetButton(),
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
      ),
    );
  }
}
