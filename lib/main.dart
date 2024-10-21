import 'dart:async';
import 'package:civic_watch/cubits/auth/auth_cubit.dart';
import 'package:civic_watch/cubits/theme/theme_cubit.dart';
import 'package:civic_watch/helpers/env_helper.dart';
import 'package:civic_watch/services/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleFonts.pendingFonts(
    [GoogleFonts.afacad(),]
  );
  await Firebase.initializeApp();

  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
  );
  await setupLocator();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final themeMode = state.when(
            system: () => ThemeMode.system,
            light: () => ThemeMode.light,
            dark: () => ThemeMode.dark,
          );
          return ShadApp.router(
            routerConfig: getIt<GoRouter>(),
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
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
          );
        },
      ),
    );
  }
}
