import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../netWork/nftModel.dart';





class NFTDetailPage extends StatelessWidget {
  final NFT nft;

  NFTDetailPage({required this.nft, required String public_key});

  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _priceController.text = nft.Price;

    return Scaffold(
      appBar: AppBar(title: Text(nft.Name)),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/image/5908835613371647683.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.amber),
                  onPressed: () => Get.back(),
                ),
                SizedBox(height: 16),
                Center(
                  child: Image.network(
                    nft.url,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16),
                Text('Name: ${nft.Name}', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                SizedBox(height: 8),
                Text('Description: ${nft.Description}', style: TextStyle(fontSize: 20, color: Colors.cyanAccent)),
                SizedBox(height: 16),
                Text('Public Key: ${nft.PublicKey}', style: TextStyle(fontSize: 20, color: Colors.lightBlueAccent)),
                SizedBox(height: 8),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Enter price MATIC',
                    labelStyle: TextStyle(color: Colors.amber),
                    border: OutlineInputBorder(),
                  ),
                ),
                Spacer(),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      final double enteredPrice = double.tryParse(_priceController.text) ?? 0.0;
                      // اجرای منطق فروش NFT
                      // اینجا کد مربوط به ارسال داده‌ها به سرور را قرار دهید
                    },
                    child: Text('Sell NFT'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.red,
                      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                      fixedSize: Size(150, 60),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
