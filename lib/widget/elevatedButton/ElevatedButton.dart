import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomElevatedButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double padding;
  final IconData? icon;
  final dynamic copyText; // آیکون به صورت اختیاری
  final double width; // عرض دکمه
  final double height; // ارتفاع دکمه

  const CustomElevatedButton( {
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor, // رنگ پیش‌فرض
    this.textColor = Colors.white,
    this.borderRadius = 10.0,
    this.padding = 16.0,
    this.icon,
    this.copyText, // مقدار اختیاری برای متن کپی‌شونده
    required this.width, // اجباری برای تعیین عرض دکمه
    required this.height, required ButtonStyle? style,
    required int size, required foregroundColor, required shape, // اجباری برای تعیین ارتفاع دکمه
  });

  @override
  _CustomElevatedButtonState createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  double _scale = 1.0; // مقدار پیش‌فرض برای مقیاس

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _scale = 1.05;
        });
      },
      onExit: (_) {
        setState(() {
          _scale = 1.0;
        });
      },
      child: Transform.scale(
        scale: _scale,
        child: SizedBox(
          width: widget.width, // عرض دکمه به صورت دستی
          height: widget.height, // ارتفاع دکمه به صورت دستی
          child: ElevatedButton(
            onPressed: () {
              if (widget.copyText != null) {
                Clipboard.setData(ClipboardData(text: widget.copyText!));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Text Copied',
                      style: TextStyle(color: Color(0xffCBCBCB), fontSize: 20),
                    ),
                  ),
                );
              }
              widget.onPressed();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.backgroundColor,
              padding: EdgeInsets.all(widget.padding),
              shape: const StadiumBorder(),
              elevation: 10.0,
              shadowColor: Colors.black.withOpacity(0.3),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max, // محتوا نیز در عرض کامل کشیده می‌شود
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null)
                  Icon(
                    widget.icon,
                    color: widget.textColor,
                    size: 15,
                  ),
                if (widget.icon != null) SizedBox(width: 8),
                Text(
                  widget.text,
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
