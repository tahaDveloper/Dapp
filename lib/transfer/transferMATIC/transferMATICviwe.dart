import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

import '../../screen/view/transferFrom/transferFrom.dart';
import '../../screen/view/walletScreen/WalletScreenViwe.dart'; // برای استفاده از Web3Client

class AnotherScreen extends StatefulWidget {
  @override
  _AnotherScreenState createState() => _AnotherScreenState();
}

class _AnotherScreenState extends State<AnotherScreen> {
  // کلید خصوصی و URL ریموت RPC
  final String privateKey = 'YOUR_PRIVATE_KEY';
  final String rpcUrl = 'https://polygon-mainnet.infura.io/v3/YOUR_INFURA_PROJECT_ID';

  // ارسال MATIC
  Future<void> sendMATIC(String recipient, double amount) async {
    if (recipient.isNotEmpty && amount > 0.0) {
      final client = Web3Client(rpcUrl, Client());
      final credentials = EthPrivateKey.fromHex(privateKey);
      final recipientAddress = EthereumAddress.fromHex(recipient);

      try {
        final transaction = Transaction(
          to: recipientAddress,
          value: EtherAmount.fromUnitAndValue(EtherUnit.wei, (amount * 1e18).toInt()), // تبدیل مقدار MATIC به Wei
        );

        await client.sendTransaction(
          credentials,
          transaction,
          chainId: 137, // Polygon Mainnet
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successes sending MATIC')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('error sending MATIC $e')),
        );
      } finally {
        client.dispose();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send MATIC'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TransferForm(
          onSendTransaction: sendMATIC, // ارسال تراکنش به متد sendMATIC
        ),
      ),
    );
  }
}
