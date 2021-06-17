import 'package:flutter_test/flutter_test.dart';
import 'package:pro_counter/app/app.dart';
import 'package:pro_counter/presentation/counter/view/counter_view.dart';

import 'helpers/helpers.dart';

void main() {
  setUpAll(initHydratedBloc);
  group('App', () {
    testWidgets('renders CounterView', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(CounterView), findsOneWidget);
    });
  });
}
