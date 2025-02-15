import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;
import 'package:web3dart/contracts.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

class WalletScreen extends StatefulWidget {
  final String privateKey;

  WalletScreen({required this.privateKey});

  @override
  _PrivateKeyViewState createState() => _PrivateKeyViewState();
}

class _PrivateKeyViewState extends State<WalletScreen> {
  String? publicKey;
  String? maticBalance;
  List<String> nftImages = [];
  String? errorMessage;

  final String _rpcUrl = 'https://polygon-rpc.com';
  final http.Client _httpClient = http.Client();
  late Web3Client _web3Client;

  @override
  void initState() {
    super.initState();
    _web3Client = Web3Client(_rpcUrl, _httpClient);
    _getPublicKeyAndBalance(widget.privateKey);
  }

  // دریافت موجودی MATIC
  _getBalance(EthPrivateKey credentials) async {
    var address = credentials.address;
    try {
      var balance = await _web3Client.getBalance(address);
      setState(() {
        maticBalance = balance.getInEther.toString();
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching MATIC balance';
      });
    }
  }

  // دریافت تعداد NFTها و تصاویر آنها
  _getNFTCount(EthPrivateKey credentials) async {
    var address = credentials.address;
    String nftContractAddress = '0xYourNFTContractAddress'; // آدرس قرارداد NFT شما
    final contract = DeployedContract(
      ContractAbi.fromJson(
          '[{"constant":true,"inputs":[{"name":"owner","type":"address"}],"name":"balanceOf","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"tokenId","type":"uint256"}],"name":"tokenURI","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"}]',
          'NFT'),
      EthereumAddress.fromHex(nftContractAddress),
    );

    final balanceOfFunction = contract.function('balanceOf');
    try {
      final result = await _web3Client.call(
        contract: contract,
        function: balanceOfFunction,
        params: [EthereumAddress.fromHex(address.hex)],
      );

      int nftCount = result[0].toInt();
      List<String> images = [];
      for (int i = 0; i < nftCount; i++) {
        final tokenURI = await _getTokenURI(contract, i);
        if (tokenURI != null) {
          images.add(tokenURI);
        } else {
          setState(() {
            errorMessage = 'No image found for NFT ID $i';
          });
        }
      }

      setState(() {
        nftImages = images;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching NFT count or images';
      });
    }
  }

  // دریافت URL متادیتای NFT با استفاده از tokenId
  _getTokenURI(DeployedContract contract, int tokenId) async {
    final tokenURIFunction = contract.function('tokenURI');
    final result = await _web3Client.call(
      contract: contract,
      function: tokenURIFunction,
      params: [BigInt.from(tokenId)],
    );

    String tokenURI = result[0]; // URL متادیتا
    if (tokenURI.isEmpty) {
      return null;
    }

    try {
      // دریافت محتوای متادیتا (مثلاً JSON)
      final response = await http.get(Uri.parse(tokenURI));
      if (response.statusCode == 200) {
        // بررسی برای وجود تصویر
        var metadata = response.body;
        // فرض کنید که در JSON یک فیلد image داریم
        // شما باید برای پردازش دقیق‌تر آن را به یک Map تبدیل کنید
        if (metadata.contains('image')) {
          // استخراج URL تصویر از JSON
          var imageURL = 'Image URL here'; // از metadata استخراج کنید
          return imageURL;
        } else {
          return null; // اگر تصویری در متادیتا نباشد
        }
      } else {
        return null; // خطا در دریافت متادیتا
      }
    } catch (e) {
      return null; // در صورت خطا در درخواست HTTP
    }
  }

  _getPublicKeyAndBalance(String privateKey) async {
    try {
      var credentials = EthPrivateKey.fromHex(privateKey);
      var address = credentials.address;
      setState(() {
        publicKey = address.hex;
      });
      _getBalance(credentials);
      _getNFTCount(credentials);
    } catch (e) {
      setState(() {
        errorMessage = 'Invalid Private Key or Error fetching data';
      });
    }
  }

  @override
  void dispose() {
    _web3Client.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (publicKey != null) ...[
              Text('Public Key: $publicKey'),
              IconButton(
                icon: Icon(Icons.copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: publicKey!));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Public Key Copied!')));
                },
              ),
            ],
            if (maticBalance != null) ...[
              Text('MATIC Balance: $maticBalance'),
            ],
            if (nftImages.isNotEmpty) ...[
              Text('NFT Images:'),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: nftImages.map((imageURL) {
                  return Image.network(imageURL, width: 100, height: 100);
                }).toList(),
              ),
            ],
            if (errorMessage != null) ...[
              Text(errorMessage!, style: TextStyle(color: Colors.red)),
            ],
          ],
        ),
      ),
    );
  }
}