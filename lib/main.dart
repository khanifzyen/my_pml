import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'utils/router.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Adamina", "Philosopher");
    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'My Flutter App',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      routerConfig: router,
    );
  }
}
