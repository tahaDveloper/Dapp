// import 'dart:convert';
//
// import 'package:get/get.dart';
// import 'package:web3dart/web3dart.dart';
//
// import '../../../../netWork/nftModel.dart';
// import '../../../model/walletScreen/WalletScreenModel.dart';
// import 'package:http/http.dart' as http;
//
// class WalletScreen_ViweModel extends GetxController {
//   var balance = 0.0.obs;
//   var nfts = <NFT>[].obs;
//   var hasNFT = false.obs;
//   var nftError = ''.obs;
//   var bottomNavIndex = 1.obs; // شاخص ناوبری
//   late final WalletScreen_model walletScreen_model;
//   late Web3Client ethClient;
//
//   // سازنده با مقداردهی کلید خصوصی
//   WalletScreen_ViweModel(String privateKey) {
//     ethClient = Web3Client(
//       "https://polygon-rpc.com",
//       http.Client(),
//     );
//
//     walletScreen_model = WalletScreen_model(
//       privateKey: privateKey,
//       credentials: EthPrivateKey.fromHex(privateKey), // ایجاد credentials از کلید خصوصی
//       ethereumAddress: EthereumAddress.fromHex(""), // اینجا مقداردهی اولیه را تغییر می‌دهیم
//       balance: 0,
//       apiResponse: '',
//       addressString: '',
//       web3Client: ethClient,
//       hasNFTs: false,
//     );
//
//     // استخراج آدرس اتریوم و کلید عمومی بعد از مقداردهی اولیه
//     walletScreen_model.ethereumAddress = walletScreen_model.credentials?.extractAddress() as EthereumAddress;
//     walletScreen_model.publicKey = walletScreen_model.ethereumAddress?.hexNo0x;
//   }
//
//   // مقداردهی کیف پول
//   @override
//   void onInit() {
//     super.onInit();
//     _initializeWallet();
//   }
//
//   Future<void> _initializeWallet() async {
//     try {
//       walletScreen_model.credentials = EthPrivateKey.fromHex(walletScreen_model.privateKeyController.text);
//       walletScreen_model.ethereumAddress = await walletScreen_model.credentials.extractAddress();
//       walletScreen_model.publicKey = walletScreen_model.ethereumAddress.hexNo0x;
//
//       await _getBalance();
//       await _checkForNFT();
//     } catch (e) {
//       print('خطا در مقداردهی کیف پول: $e');
//     }
//   }
//
//   // دریافت موجودی در اتریوم
//   Future<void> _getBalance() async {
//     try {
//       EtherAmount? balanceAmount = await ethClient.getBalance(WalletScreenModel.ethereumAddress);
//       walletScreen_model.balance = balanceAmount!.getValueInUnit(EtherUnit.ether).toDouble();
//       balance.value = walletScreen_model.balance;
//       walletScreen_model.balance = double.parse(walletScreen_model.balance.toStringAsFixed(3));
//       print('موجودی در اتریوم: ${walletScreen_model.balance}');
//     } catch (e) {
//       print('خطا در دریافت موجودی: $e');
//     }
//   }
//
//   // دریافت اطلاعات NFT ها
//   Future<void> _checkForNFT() async {
//     try {
//       final url = 'https://api.polygonscan.com/api?module=account&action=tokennfttx&address=${walletScreen_model.ethereumAddress.hex}&apikey=${walletScreen_model.apiKey}';
//       final response = await http.get(Uri.parse(url));
//
//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);
//         print('پاسخ API NFT: ${jsonResponse}');
//         if (jsonResponse['status'] == '1' && jsonResponse['result'].isNotEmpty) {
//           hasNFT.value = true;
//           nftError.value = '';
//           nfts.value = (jsonResponse['result'] as List)
//               .map((e) => NFT.fromJson(e))
//               .toList();
//         } else {
//           hasNFT.value = false;
//           nftError.value = 'هیچ NFT برای این آدرس یافت نشد.';
//         }
//       } else {
//         throw Exception('خطا در بارگذاری داده‌های NFT');
//       }
//     } catch (e) {
//       nftError.value = 'خطا در بررسی NFT: $e';
//       print('خطا در بررسی NFT: $e');
//     }
//   }
// }
