import 'package:dw_flutter_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onPressed;

  const LoginButton({
    super.key,
    required this.text,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: AppColors.loginButtonColor,
        foregroundColor: AppColors.loginButtonTextColor,
        textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
      ),
      onPressed: onPressed,
      child: SizedBox(
        height: 44.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: AssetImage(imagePath),
                width: 24.0,
                height: 24.0,
              ),
              Text(
                text,
              ),
              const SizedBox(width: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}
