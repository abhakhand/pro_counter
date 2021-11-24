import 'package:flutter/widgets.dart';
import 'package:pro_counter/app/app.dart';
import 'package:pro_counter/app/bootstrap.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  bootstrap(() => const App());
}
