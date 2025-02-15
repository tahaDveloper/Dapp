import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // اضافه کردن Dio
import 'package:web3dart/web3dart.dart';
import 'friends.dart';


class TransferPage extends StatefulWidget {
  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final Dio _dio = Dio(); // ایجاد شی Dio
  late String _privateKey;
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _privateKey = "0x11361371ba99160bf9e52647e8b847b924b3187cb7972c06f99eacaf3f88f5cd"; // کلید خصوصی اکانت شما
  }

  Future<void> sendTransaction() async {
    try {
      // آدرس فرستنده و گیرنده
      final fromAddress = EthereumAddress.fromHex(_fromController.text);
      final toAddress = EthereumAddress.fromHex(_toController.text);

      // مقدار تراکنش
      final amount = double.parse(_amountController.text);
      final amountInWei = EtherAmount.fromUnitAndValue(EtherUnit.wei, amount * 1e18); // MATIC دارای 18 رقم اعشار است

      // دریافت کلید خصوصی و حذف پیشوند 0x
      String privateKeyWithoutPrefix = _privateKey.trim().replaceFirst('0x', '');

      final credentials = EthPrivateKey.fromHex(privateKeyWithoutPrefix);

      // ایجاد تراکنش
      final txHash = await _sendTransaction(fromAddress, toAddress, amountInWei);

      // نمایش پیام موفقیت
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Transaction successful: $txHash'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // نمایش پیام خطا
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<String> _sendTransaction(
      EthereumAddress from, EthereumAddress to, EtherAmount value) async {
    // تعریف اطلاعات تراکنش
    final transaction = {
      "from": from.hex,
      "to": to.hex,
      "value": value.getInWei.toString(),
      "gas": "21000",
      "gasPrice": "1000000000", // قیمت گاز
    };

    // ارسال درخواست به شبکه
    final response = await _dio.post(
      'https://eth-mainnet.g.alchemy.com/v2/oV51GPoQ4DgCwJTrTFJPuTMwZvWWN77b',
      data: {
        "jsonrpc": "2.0",
        "method": "eth_sendTransaction",
        "params": [transaction],
        "id": 1,
      },
    );

    if (response.statusCode == 200) {
      return response.data['result']; // برگرداندن هشتگ تراکنش
    } else {
      throw Exception('Failed to send transaction: ${response.data}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/6689579_3415051.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Semi-transparent overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.5), // رنگ مشکی با شفافیت
                  Colors.indigo.withOpacity(0.7), // رنگ آبی تیره با شفافیت
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 40),

                  // Title
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Friends(),
                        ),
                      );
                    },
                    child: Text(
                      'Transfer Matic',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Colors.purpleAccent, // تغییر رنگ متن به سفید
                        shadows:[
                          Shadow(
                            color: Colors.cyanAccent, // رنگ سایه
                            offset: Offset(4.0, 4.0), // موقعیت سایه
                            blurRadius: 4.0, // شعاع تار شدن سایه
                          ),
                        ]
                      ),
                    ),
                  ),
                  SizedBox(height: 200),

                  // Fancy input fields
                  _buildFancyTextField(_fromController, 'From Address'),
                  SizedBox(height: 15),
                  _buildFancyTextField(_toController, 'To Address'),
                  SizedBox(height: 15),
                  _buildFancyTextField(
                      _amountController, 'Amount', TextInputType.number),
                  SizedBox(height: 30),

                  // Fancy button
                  ElevatedButton(
                    onPressed: sendTransaction,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.cyan,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 10,
                    ),
                    child: const Text(
                      'Send Transaction',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  // A helper method for fancy text fields
  Widget _buildFancyTextField(TextEditingController controller, String label,
      [TextInputType keyboardType = TextInputType.text]) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
            color: Colors.purpleAccent, fontSize: 15, fontWeight: FontWeight.w600),
        filled: true,
        fillColor: Colors.black.withOpacity(0.2),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.cyanAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.amber),
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}
