import 'package:flutter/material.dart';

class FancyContainer extends StatelessWidget {
  final Color backgroundColor;
  final double borderRadius;
  final double elevation;
  final Widget child;

  const FancyContainer({
    super.key,
    this.backgroundColor = Colors.blueAccent,
    this.borderRadius = 16.0,
    this.elevation = 8.0,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: elevation,
            offset: Offset(0, 4), // موقعیت سایه
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0), // فاصله داخلی
      child: child, // محتویات داخلی
    );
  }
}
