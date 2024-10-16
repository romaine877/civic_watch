import 'package:civic_watch/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../cubits/auth/auth_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return state.maybeWhen(
          authenticated: (userModel) {
            return  Scaffold(
                body: SafeArea(
                  child: Column(
                    children: [
                      const Expanded(child: Center(child: Text('Main Screen'))),
                      ShadButton(
                        onPressed: () {
                          context.read<AuthCubit>().signOut();
                        },
                        child: const Text('Sign Out'),
                      ),
                    ],
                  ),
                ),
              );
          },
          loading: () {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
          orElse: () {
            return const LoginScreen();
          },
        );
      },
    );
  }
}
