import 'package:flutter/material.dart';
import 'package:oasis/transfer/transferNFT/transferNFmodel.dart';

import '../../widget/customeTextFild/Text_Fild.dart';

class GiftNFTForm extends StatefulWidget {
  final ScrollController scrollController;

  GiftNFTForm({required this.scrollController});

  @override
  _GiftNFTFormState createState() => _GiftNFTFormState();
}

class _GiftNFTFormState extends State<GiftNFTForm> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String? errorMessage;

  // ایجاد نمونه از NFTTransfer با مقادیر مورد نیاز
  final NFTTransfer nftTransfer = NFTTransfer(
    privateKey: 'YOUR_PRIVATE_KEY',
    contractAddress: 'YOUR_CONTRACT_ADDRESS',
    rpcUrl: 'https://polygon-rpc.com',
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Gift NFT",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 20),
        CustomTextField(
          hintText: 'Enter your friend\'s address',
          labelText: 'To Address',
          focusedLabelColor: Colors.white,
          controller: _addressController,
          obscureText: false,
          validator: (value) {},
          backgroundColor: Color(0xff42454D),
          keyboardType: TextInputType.text,
        ),
        SizedBox(height: 10),
        CustomTextField(
          hintText: 'Enter amount POL',
          labelText: 'Amount',
          focusedLabelColor: Colors.white,
          controller: _amountController,
          obscureText: false,
          validator: (value) {},
          backgroundColor: Color(0xff42454D),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 20),
        if (errorMessage != null)
          Text(
            errorMessage!,
            style: TextStyle(color: Colors.red, fontSize: 14),
          ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            String address = _addressController.text;
            String amountText = _amountController.text;

            // اعتبارسنجی آدرس و مقدار
            if (address.isEmpty) {
              setState(() {
                errorMessage = 'Please enter a valid address';
              });
            } else if (!_isValidAddress(address)) {
              setState(() {
                errorMessage = 'Invalid address format';
              });
            } else if (amountText.isEmpty) {
              setState(() {
                errorMessage = 'Please enter an amount';
              });
            } else {
              BigInt amount = BigInt.from(int.tryParse(amountText) ?? 0);
              if (amount <= BigInt.zero) {
                setState(() {
                  errorMessage = 'Amount must be greater than zero';
                });
              } else {
                try {
                  // فراخوانی تابع ارسال NFT
                  await nftTransfer.sendNFT(
                    address,
                    BigInt.from(1), // شناسه توکن
                    amount,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('NFT sent successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context); // بستن BottomSheet
                } catch (e) {
                  setState(() {
                    errorMessage = 'Error sending NFT: $e';
                  });
                }
              }
            }
          },
          child: Text(
            'Send Transaction',
            style: TextStyle(color: Colors.white,fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
          ),
        ),
      ],
    );
  }

  bool _isValidAddress(String address) {
    return RegExp(r"^0x[a-fA-F0-9]{40}$").hasMatch(address);
  }
}