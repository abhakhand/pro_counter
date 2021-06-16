import 'package:flutter/material.dart';
import 'package:pro_counter/app/l10n/l10n.dart';

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.counterAppBarTitle),
      ),
    );
  }
}
