import 'dart:async';
import 'package:civic_watch/cubits/auth/auth_cubit.dart';
import 'package:civic_watch/helpers/env_helper.dart';
import 'package:civic_watch/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleFonts.pendingFonts();
  await Firebase.initializeApp();

  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  Widget _flavorBanner({
    required Widget child,
    bool show = true,
  }) =>
      show
          ? Banner(
              location: BannerLocation.topStart,
              message: 'Dev',
              color: Colors.green.withOpacity(0.6),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.0,
                  letterSpacing: 1.0),
              child: child,
            )
          : Container(
              child: child,
            );
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: ShadApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        darkTheme: ShadThemeData(
          textTheme: ShadTextTheme.fromGoogleFont(
            GoogleFonts.afacad,
          ),
          brightness: Brightness.dark,
          colorScheme: const ShadSlateColorScheme.dark(),
        ),
        theme: ShadThemeData(
            textTheme: ShadTextTheme.fromGoogleFont(
              GoogleFonts.afacad,
            ),
            brightness: Brightness.light,
            colorScheme: const ShadSlateColorScheme.light()),
        home: _flavorBanner(
          child: const LandingScreen(),
          show: kDebugMode && Env.type == 'dev',
        ),
      ),
    );
  }
}
