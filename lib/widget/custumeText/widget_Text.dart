import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class Custume_Text extends StatelessWidget {
  final String text;
  final Color color;
  final double Size;

    Custume_Text({super.key,
    required this.text,
    required this.color,
    required this.Size, required FontWeight? fontWeight,});
  
  @override
  Widget build(BuildContext context) {
    return Text('${text}',
      style: TextStyle(
        color: color,
      fontSize: Size,
        fontWeight: FontWeight.bold
    ),);
  }
}
