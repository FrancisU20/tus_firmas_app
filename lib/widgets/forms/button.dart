import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tus_firmas_app/themes/app_theme.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final bool enabled;
  final bool loading;

  const AppButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = AppTheme.primaryColor,
    this.enabled = true,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled && !loading ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: buildButtonChild(),
    );
  }

  Widget buildButtonChild() {
    if (loading) {
      return LoadingAnimationWidget.staggeredDotsWave(color: color, size: 26);
    } else {
      return Text(
        text,
        style: AppTheme.fontFamily.copyWith(
          color: AppTheme.primaryButtonTextColor,
          fontSize: 14,
          letterSpacing: 1.25,
          fontWeight: FontWeight.bold,
        )
      );
    }
  }
}
