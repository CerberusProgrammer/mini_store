import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(
    Main(
      savedThemeMode: savedThemeMode,
    ),
  );
}

class Main extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const Main({super.key, this.savedThemeMode});

  @override
  State<StatefulWidget> createState() => _Main();
}

class _Main extends State<Main> {
  AdaptiveThemeMode? savedThemeMode;

  @override
  void initState() {
    super.initState();
    savedThemeMode = widget.savedThemeMode;
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: ThemeData(
          colorSchemeSeed: Colors.purple,
          brightness: Brightness.light,
          useMaterial3: true,
        ),
        dark: ThemeData(
          colorSchemeSeed: Colors.amber,
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        initial: savedThemeMode ?? AdaptiveThemeMode.light,
        builder: (theme, darkTheme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Mini Store',
            theme: theme,
            darkTheme: darkTheme,
            home: const Home(),
          );
        });
  }
}
