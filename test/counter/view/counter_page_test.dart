import 'package:flutter_test/flutter_test.dart';
import 'package:pro_counter/presentation/counter/counter.dart';

import '../../helpers/helpers.dart';

void main() {
  group('CounterView', () {
    testWidgets('renders AppBar title', (tester) async {
      await tester.pumpApp(const CounterView());
      expect(find.text('Counter'), findsOneWidget);
    });
  });
}
