import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/images.dart';
import '../wrappers/animated_tap.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedTap(
        onTap: () {},
        child: SvgPicture.asset(
          Images.googleSignIn,
          width: MediaQuery.of(context).size.width * 0.9,
        ),
      ),
    );
  }
}
