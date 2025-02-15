import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart'; // وارد کردن kIsWeb

// واردات dart:ffi فقط در پلتفرم‌های بومی
import 'dart:io' show Platform; // برای پلتفرم‌های بومی
// سایر واردات دیگر

class NFTTransfer {
  final String privateKey;
  final String contractAddress;
  final String rpcUrl;

  NFTTransfer({
    required this.privateKey,
    required this.contractAddress,
    required this.rpcUrl,
  });

  // ارسال NFT
  Future<void> sendNFT(String recipient, BigInt tokenId, BigInt amount) async {
    final client = Web3Client(rpcUrl, Client());
    final credentials = EthPrivateKey.fromHex(privateKey);
    final contractAbi = [
      // ABI اسمارت کانترکت ERC-1155
    ];

    final contract = DeployedContract(
      ContractAbi.fromJson("contractAbi", 'ERC1155'),
      EthereumAddress.fromHex(contractAddress),
    );

    final transferFunction = contract.function('safeTransferFrom');
    final recipientAddress = EthereumAddress.fromHex(recipient);

    try {
      await client.sendTransaction(
        credentials,
        Transaction.callContract(
          contract: contract,
          function: transferFunction,
          parameters: [recipientAddress, EthereumAddress.fromHex(privateKey), tokenId, amount, '0x'],
          maxGas: 100000,
        ),
        chainId: 137, // Polygon Mainnet
      );
      print('Success to sending NFT');
    } catch (e) {
      print('error in sending NFT:$e');
    } finally {
      client.dispose();
    }
  }
}
