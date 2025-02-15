import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final Color? focusedLabelColor;
  final Color? backgroundColor;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.focusedLabelColor,
    this.backgroundColor , required  Function(dynamic value)? validator, required obscureText, required TextInputType? keyboardType,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword,
      focusNode: _focusNode,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 20,
          foreground: Paint()..shader = LinearGradient(
            colors: [
              Color(0xff0000),
              widget.focusedLabelColor ?? Colors.white.withOpacity(0.1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(Rect.fromLTWH(1, 10, 100, 0)), // Apply gradient shader
        ),
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: Colors.deepPurpleAccent)
            : null,
        filled: true,
        fillColor: widget.backgroundColor, // رنگ پس‌زمینه
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(
            color: Color(0xff),
            width: 3.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(
            color: Color(0xff6EACDA),
            width: 3.0,
          ),
        ),
      ),
      keyboardType: widget.isPassword ? TextInputType.visiblePassword : TextInputType.text,
    );
  }
}
