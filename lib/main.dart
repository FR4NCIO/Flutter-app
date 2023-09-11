import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nsa_app_giuseppe/pages/atleti_page.dart';
import 'package:nsa_app_giuseppe/pages/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color rosso = Color.fromARGB(255, 192, 65, 53);
    const Color bianco = Color.fromARGB(255, 247, 247, 247);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          foregroundColor: bianco,
        )),
        textTheme: GoogleFonts.bebasNeueTextTheme(
          Theme.of(context)
              .textTheme
              .apply(bodyColor: bianco, displayColor: bianco),
        ),
        appBarTheme: const AppBarTheme(color: rosso),
        colorScheme: const ColorScheme.dark().copyWith(
          primary: rosso,
          secondary: bianco,
          tertiary: bianco,
        ),
      ),
      routes: {
        "/HomePage": (context) => const HomePage(),
        "/AtletiPage": (context) => const AtletiPage(),
      },
      initialRoute: "/HomePage",
    );
  }
}
