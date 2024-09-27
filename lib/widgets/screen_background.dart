import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../assets_path.dart';


@override
class ScreenBackground extends StatelessWidget {
  const ScreenBackground({super.key, required this.child});
  final Widget child;

  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        SvgPicture.asset(
          AssetPath.backgroundImage,
          fit: BoxFit.fill,
          height: screenSize.height,
          width: screenSize.width,
        ),
        SafeArea(child: child)
      ],
    );
  }
}