import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moviedetails/screens/movie_details_page.dart';
import 'package:moviedetails/screens/movies_list_page.dart';
import 'package:moviedetails/screens/profile_page.dart';
import 'package:moviedetails/screens/signin_page.dart';
import 'package:moviedetails/screens/signup_page.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system, // 👈 follows system theme
      theme: _lightTheme,
      darkTheme: _darkTheme,
      initialRoute: MoviesListPage.routeName, // start from auth (local)
      routes: {
        SignInPage.routeName: (_) => const SignInPage(),
        SignUpPage.routeName: (_) => const SignUpPage(),
        MoviesListPage.routeName: (_) => const MoviesListPage(),
        ProfilePage.routeName: (_) => const ProfilePage(),
      },
      // for passing movie data to details screen
      onGenerateRoute: (settings) {
        if (settings.name == MovieDetailsPage.routeName) {
          final movie =
              settings.arguments; // you’ll type this later (e.g. Movie)
          return MaterialPageRoute(
            builder: (_) => MovieDetailsPage(movie: movie),
          );
        }
        return null;
      },
    );
  }
}

/// ----------------- THEME -----------------

final ThemeData _lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorSchemeSeed: Colors.deepPurple,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),
  cardTheme: const CardThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
);

final ThemeData _darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorSchemeSeed: Colors.deepPurple,
  scaffoldBackgroundColor: const Color(0xFF0D0D0D),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Color(0xFF0D0D0D),
    foregroundColor: Colors.white,
  ),
  cardColor: const Color(0xFF1A1A1A),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),
  cardTheme: const CardThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
);
