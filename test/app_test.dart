import 'package:flutter_test/flutter_test.dart';
import 'package:pro_counter/app/app.dart';
import 'package:pro_counter/presentation/counter/view/counter_view.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(CounterView), findsOneWidget);
    });
  });
}
