import 'package:civic_watch/wrappers/animated_tap.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/images.dart';
import '../cubits/auth/auth_cubit.dart';

class AnonSignInButton extends StatelessWidget {
  const AnonSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedTap(
        onTap: () {
          context.read<AuthCubit>().signIn();
          context.go('/');
        },
        child: SvgPicture.asset(
          Images.anonSignIn,
          width: MediaQuery.of(context).size.width * 0.9,
        ),
      ),
    );
  }
}
