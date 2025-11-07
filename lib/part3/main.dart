import 'package:first_app/part3/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.deepPurpleAccent,
);
var kColorSchemeDark = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Colors.blueGrey,
);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //   ],
  // ).then(
  //   (fn) =>
        runApp(
      MaterialApp(
        darkTheme: ThemeData().copyWith(
          colorScheme: kColorSchemeDark,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorSchemeDark.onPrimaryContainer,
            foregroundColor: kColorSchemeDark.primaryContainer,
          ),
          scaffoldBackgroundColor: kColorSchemeDark.primaryContainer,
          cardTheme: const CardThemeData().copyWith(
            color: kColorSchemeDark.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorSchemeDark.onSecondaryContainer,
              foregroundColor: kColorSchemeDark.secondaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: kColorSchemeDark.onSecondaryContainer,
              fontSize: 16,
            ),
          ),
        ),
        theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          ),
          cardTheme: const CardThemeData().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.onSecondaryContainer,
              foregroundColor: kColorScheme.secondaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: kColorScheme.onSecondaryContainer,
              fontSize: 16,
            ),
          ),
        ),
        // themeMode: ThemeMode.system, par défaut système sinon ThemeMode.dark ou ThemeMode.light.
        home: Expenses(),
      ),
    // ),
  );
}
