import 'package:flutter/material.dart';

class FancySnackbar extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;
  final Duration duration;

  const FancySnackbar({
    super.key,
    required this.message,
    this.backgroundColor = Colors.blueAccent,
    this.textColor = Colors.white,
    this.icon,
    this.duration = const Duration(seconds: 3),
  });

  // تابعی برای نمایش Snackbar
  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        backgroundColor: Colors.transparent, // پس‌زمینه شفاف
        content: _buildSnackbarContent(),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
      ),
    );
  }

  Widget _buildSnackbarContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: textColor,
            ),
          if (icon != null) const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: textColor,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // این ویجت فقط برای نمایش Snackbar است
  }
}
