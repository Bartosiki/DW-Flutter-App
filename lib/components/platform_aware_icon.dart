import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlatformAwareIcon extends StatelessWidget {
  final String iconPath;
  final double width;
  final double height;
  final Color color;

  const PlatformAwareIcon({
    required this.iconPath,
    required this.color,
    this.width = 24,
    this.height = 24,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      // For web, especially Safari, use a safer approach
      return Icon(
        _getIconDataForPath(iconPath),
        color: color,
        size: width,
      );
    }

    // For mobile platforms, use SVG as before
    return SvgPicture.asset(
      iconPath,
      width: width,
      height: height,
      colorFilter: ColorFilter.mode(
        color,
        BlendMode.srcIn,
      ),
    );
  }

  // Map your SVG paths to Material icons
  IconData _getIconDataForPath(String path) {
    switch (path) {
      case 'assets/icons/home.svg':
        return Icons.home_rounded;
      case 'assets/icons/trophy.svg':
        return Icons.emoji_events_rounded;
      case 'assets/icons/qr_code.svg':
        return Icons.qr_code_scanner_rounded;
      case 'assets/icons/map.svg':
        return Icons.map_rounded;
      default:
        return Icons.circle;
    }
  }
}
