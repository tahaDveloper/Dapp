import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import '../transferMATIC/transferMATIC_model.dart';
import '../transferNFT/transferNFmodel.dart';

class TransferScreen extends StatefulWidget {
  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _recipientController = TextEditingController();
  final _tokenIdController = TextEditingController();
  final _amountController = TextEditingController();
  final _maticAmountController = TextEditingController();

  final String privateKey = 'YOUR_PRIVATE_KEY'; // کلید خصوصی
  final String contractAddress = 'YOUR_CONTRACT_ADDRESS'; // آدرس اسمارت کانترکت ERC-1155
  final String rpcUrl = 'https://polygon-mainnet.infura.io/v3/YOUR_INFURA_PROJECT_ID'; // URL ریموت RPC

  // ارسال NFT
  Future<void> sendNFT() async {
    final recipient = _recipientController.text;
    final tokenId = BigInt.tryParse(_tokenIdController.text) ?? BigInt.zero;
    final amount = BigInt.tryParse(_amountController.text) ?? BigInt.zero;

    if (recipient.isNotEmpty && tokenId != BigInt.zero && amount > BigInt.zero) {
      NFTTransfer nftTransfer = NFTTransfer(
        privateKey: privateKey,
        contractAddress: contractAddress,
        rpcUrl: rpcUrl,
      );
      await nftTransfer.sendNFT(recipient, tokenId, amount);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('لطفاً تمام فیلدها را پر کنید')),
      );
    }
  }

  // ارسال MATIC
  Future<void> sendMATIC() async {
    final recipient = _recipientController.text;
    final amount = double.tryParse(_maticAmountController.text) ?? 0.0;

    if (recipient.isNotEmpty && amount > 0.0) {
      MaticTransfer maticTransfer = MaticTransfer(
        privateKey: privateKey,
        rpcUrl: rpcUrl,
      );
      await maticTransfer.sendMATIC(recipient, amount);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('لطفاً تمام فیلدها را پر کنید')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ارسال MATIC و NFT'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ورودی آدرس گیرنده
            TextField(
              controller: _recipientController,
              decoration: InputDecoration(labelText: 'آدرس گیرنده'),
            ),
            // ورودی شناسه توکن (برای NFT)
            TextField(
              controller: _tokenIdController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'شناسه توکن (Token ID)'),
            ),
            // ورودی مقدار توکن (برای NFT)
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'مقدار توکن (NFT)'),
            ),
            SizedBox(height: 20),
            // ورودی مقدار MATIC
            TextField(
              controller: _maticAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'مقدار MATIC'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: sendNFT,
              child: Text('ارسال NFT'),
            ),
            ElevatedButton(
              onPressed: sendMATIC,
              child: Text('ارسال MATIC'),
            ),
          ],
        ),
      ),
    );
  }
}
