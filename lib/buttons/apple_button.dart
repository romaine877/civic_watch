import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/images.dart';
import '../wrappers/animated_tap.dart';

class AppleSignInButton extends StatelessWidget {
  const AppleSignInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedTap(
        onTap: () {},
        child: SvgPicture.asset(
          Images.appleSignIn,
          width: MediaQuery.of(context).size.width * .9,
        ),
      ),
    );
  }
}
