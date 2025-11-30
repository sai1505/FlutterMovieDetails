import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moviedetails/blocs/bloc/movies_bloc.dart';
import 'package:moviedetails/repos/movie_repository.dart';
import 'package:moviedetails/screens/movie_details_page.dart';
import 'package:moviedetails/screens/movies_list_page.dart';
import 'package:moviedetails/screens/profile_page.dart';
import 'package:moviedetails/screens/signin_page.dart';
import 'package:moviedetails/screens/signup_page.dart';
import 'package:moviedetails/service/movie_api_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MovieApiService>(
          create: (_) => MovieApiService(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MoviesBloc(
              MovieRepository(
                api: context.read<MovieApiService>(),
              ),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Movie App',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: _lightTheme,
          darkTheme: _darkTheme,
          initialRoute: MoviesListPage.routeName,
          routes: {
            SignInPage.routeName: (_) => const SignInPage(),
            SignUpPage.routeName: (_) => const SignUpPage(),
            MoviesListPage.routeName: (_) => const MoviesListPage(),
            ProfilePage.routeName: (_) => const ProfilePage(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == MovieDetailsPage.routeName) {
              final movieid = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailsPage(movieId: movieid),
              );
            }
            return null;
          },
        ),
      ),
    );
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
}
