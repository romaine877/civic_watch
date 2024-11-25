import 'dart:io';

import 'package:civic_watch/cubits/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../buttons/anon_button.dart';
import '../buttons/apple_button.dart';
import '../buttons/google_button.dart';
import '../constants/images.dart';
import '../widgets/loading_indicator.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () {
            return const Scaffold(
              body: Center(
                child: LoadingIndicator(),
              ),
            );
          },
          orElse: () {
            return const LoginView();
          },
        );
      },
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images.loginCover),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Image.asset(
                      //   Images.appIcon,
                      //   height: MediaQuery.of(context).size.height * 0.5,
                      // ),
                      Text(
                        'Civic Watch',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                      ),
                      Text(
                        'Report issues in your community',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const AnonSignInButton(),
              if (Platform.isIOS) const AppleSignInButton(),
              const GoogleSignInButton(),
              const SizedBox(height: 16),
              Text('Version 1.0.0',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}
