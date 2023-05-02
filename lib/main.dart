import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:mini_store/data/wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/themes.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  final prefs = await SharedPreferences.getInstance();
  Themes.defaultIndex = prefs.getInt('defaultIndex') ?? 0;
  bool presentation = prefs.getBool('presentation') ?? false;

  Wallet.money;

  runApp(
    Main(
      savedThemeMode: savedThemeMode,
      presentation: presentation,
    ),
  );
}

class Main extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final bool presentation;

  const Main({
    super.key,
    this.savedThemeMode,
    required this.presentation,
  });

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
          colorSchemeSeed: Themes.colors[Themes.defaultIndex],
          brightness: Brightness.light,
          useMaterial3: true,
        ),
        dark: ThemeData(
          colorSchemeSeed: Themes.colors[Themes.defaultIndex],
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
            home: widget.presentation ? null : const Home(),
          );
        });
  }
}
