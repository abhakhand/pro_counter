import 'package:flutter_test/flutter_test.dart';
import 'package:pro_counter/app/app.dart';
import 'package:pro_counter/src/presentation/counter/views/counter_view.dart';

import 'helpers/helpers.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterView', (tester) async {
      await mockHydratedStorage(
        () async {
          await tester.pumpWidget(const App());
        },
      );

      expect(find.byType(CounterView), findsOneWidget);
    });
  });
}
