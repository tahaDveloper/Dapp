import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart'as http;
import 'package:web3dart/web3dart.dart';

import '../../../controller/controllerBITANA/controllerBITANA.dart';
import '../../../controller/controllerBalance/controllerBalance.dart';
import '../../../controller/controllerNFT/controllerNFT.dart';
import '../../../controller/controllerPublickKey/controllerPublickKey.dart';


class WalletScreen_model {
  late final EthPrivateKey? credentials;
  late final EthereumAddress? ethereumAddress;
  late final double balance;
  final String apiResponse;
  final String addressString;
  final String privateKey;
  final Web3Client? web3Client;
  late final bool hasNFTs;
  late final dynamic nfts;

  // سازنده کلاس
  WalletScreen_model(
      {
    required this.credentials,
    required this.ethereumAddress,
    required this.balance,
    required this.apiResponse,
    required this.addressString,
    required this.privateKey,
    required this.web3Client,
        required this.hasNFTs,
        this.nfts,
      });
  String? publicKey= "0x";
  String? maticBalance = "0";
  int? amountNFT;
  List<String> nftImages = [];
  String? errorMessage;


  final PublicKeyController publicKeyController = Get.find<PublicKeyController>();
  final BalanceControllerMATIC balanceControllerMATIC = Get.find<BalanceControllerMATIC>();
  final BalanceControllerBITANA balanceControllerBITANA = Get.find<BalanceControllerBITANA>();
  final NftController nftController = Get.find<NftController>();
// متغیرهای isTransferClicked و showTransferForm را تعریف کنید
  bool isTransferClicked = false;
  bool showTransferForm = false;

}





