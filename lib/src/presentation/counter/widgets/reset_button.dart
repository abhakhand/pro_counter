import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_counter/app/l10n/l10n.dart';
import 'package:pro_counter/src/application/counter/counter_bloc.dart';
import 'package:pro_counter/src/presentation/core/helpers/widget_keys.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return TextButton(
      key: WidgetKeys.counterResetButtonKey,
      onPressed: () => context.read<CounterBloc>().add(
            const CounterEvent.reset(),
          ),
      child: Text(
        l10n.counterResetButtonLabel,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
