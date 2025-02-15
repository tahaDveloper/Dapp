// Separate TransferForm widget
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TransferForm extends StatelessWidget {
  final TextEditingController recipientController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final Function(String, double) onSendTransaction;

  TransferForm({required this.onSendTransaction});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: recipientController,
          decoration: InputDecoration(
            hintText: "To Address",
            hintStyle:
            TextStyle(color: Colors.white54, fontWeight: FontWeight.bold),
            filled: true,
            fillColor: Colors.grey[850],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Color(0xffE2E2B6), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
              BorderSide(color:  Color(0xffE2E2B6), width: 2.5),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            suffixIcon:
            Icon(Icons.account_balance_wallet, color: Colors.white54),
          ),
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(height: 10),
        TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Amount",
            hintStyle:
            TextStyle(color: Colors.white54, fontWeight: FontWeight.bold),
            filled: true,
            fillColor: Colors.grey[850],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Color(0xff6EACDA), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
              BorderSide(color: Color(0xffE2E2B6), width: 2.5),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            suffixIcon: Icon(Icons.attach_money, color: Colors.white54),
          ),
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffE2E2B6),
              minimumSize: Size(200, 50),
            ),
            onPressed: () {
              final recipient = recipientController.text;
              final amount = double.tryParse(amountController.text) ?? 0.0;
              if (recipient.isNotEmpty && amount > 0.0) {
                onSendTransaction(recipient, amount);
              } else {
                Get.snackbar(
                  "Complete filed",
                  "Please Complete filed",
                  colorText: Color(0xffE2E2B6),
                  backgroundColor: Color(0xff03346E).withOpacity(0.7),
                  snackPosition: SnackPosition.BOTTOM,
                  duration: Duration(seconds: 2),
                );
              }
            },
            child: Text(
              "Send Transaction",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xff03346E)),
            ),
          ),
        ),
      ],
    );
  }
}