import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
          final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Center(
        child: LoadingAnimationWidget.fourRotatingDots(
      color: isDarkMode? Colors.white :  Colors.black,
      size: 60,
    ));
  }
}