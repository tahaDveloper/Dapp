import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import '../../../abi/abi.dart';
import '../../../widget/customeNavigation/widget_navigation.dart';
import '../../model/walletScreen/WalletScreenModel.dart';
import '../transferFrom/transferFrom.dart';

class WalletScreenView  extends StatefulWidget {
  final String privateKey;

  WalletScreenView ({required this.privateKey});

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreenView> {

  final String _rpcUrl = 'https://polygon-rpc.com';
  final http.Client _httpClient = http.Client();
  late Web3Client _web3Client;

  final bool isTransferClicked = false;
  final bool showTransferForm = false;

  final WalletScreenModel = WalletScreen_model(
      credentials: null,
      ethereumAddress: null,
      balance: 0,
      apiResponse: '',
      addressString: '',
      privateKey: '',
      web3Client: null,
      hasNFTs: false);

  @override
  void initState() {
    super.initState();
    _web3Client = Web3Client(_rpcUrl, _httpClient);
    _getPublicKeyAndBalance(widget.privateKey);
    _fetchNftCount(); // Fetch NFT count
  }

  _getBalanceMATIC(EthPrivateKey credentials) async {
    var address = credentials.address;

    // بررسی آدرس کاربر
    if (address.hex.isEmpty || address.hex.length == 42) {
      setState(() {
        WalletScreenModel.errorMessage = 'Invalid MATIC address';
      });
    }

    // دریافت موجودی MATIC
    var balance = await _web3Client.getBalance(address);
    if (balance != null) {
      WalletScreenModel.balanceControllerMATIC
          .setBalance(balance.getInEther.toString());
    } else {
      setState(() {
        WalletScreenModel.errorMessage = 'Error fetching MATIC balance';
      });
    }
  }

  _getBalanceBITANA(EthPrivateKey credentials) async {
    var address = credentials.address;

    // بررسی آدرس کاربر
    if (address.hex.isEmpty || address.hex.length != 42) {
      setState(() {
        WalletScreenModel.errorMessage = 'Invalid BITANA address';
      });
      return;
    }

    // قرارداد BITANA
    final contract = DeployedContract(
      ContractAbi.fromJson(abiState().abi, 'BITANA'),
      EthereumAddress.fromHex('0x5ba91566572c9ff884144621dd60b64d6615972a'),
    );

    final balanceFunction = contract.function('balanceOf');
    final balanceData = await _web3Client.call(
      contract: contract,
      function: balanceFunction,
      params: [address],
    );

    if (balanceData != null && balanceData.isNotEmpty) {
      BigInt balance = balanceData[0];
      WalletScreenModel.balanceControllerBITANA.setBalance(balance.toString());
    } else {
      setState(() {
        WalletScreenModel.errorMessage = 'Error fetching BITANA balance';
      });
    }
  }

  _getPublicKeyAndBalance(String privateKey) async {
    // بررسی کلید خصوصی
    if (privateKey.isEmpty || privateKey.length != 64) {
      setState(() {
        WalletScreenModel.errorMessage = 'Invalid Private Key';
      });
      return;
    }

    var credentials = EthPrivateKey.fromHex(privateKey);
    var address = credentials.address;

    if (address.hex.isNotEmpty && address.hex.length == 42) {
      WalletScreenModel.publicKeyController.setPublicKey(address.hex);
      await _getBalanceMATIC(credentials);
      await _getBalanceBITANA(credentials);
    } else {
      setState(() {
        WalletScreenModel.errorMessage = 'Error fetching data';
      });
    }
  }

  void _fetchNftCount() async {
    // بررسی مقدار NFT
    int? nftCount = 0; // Replace with real fetch logic
    if (nftCount != null && nftCount >= 0) {
      WalletScreenModel.nftController.setNftCount(nftCount);
    } else {
      setState(() {
        WalletScreenModel.errorMessage = 'Error fetching NFT count';
      });
    }
  }

  void sendMATIC(String recipient, double amount) async {
    // بررسی مقدار کلید خصوصی
    if (widget.privateKey.isEmpty || widget.privateKey.length == 64) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid Private Key')),
      );
    }

    // بررسی آدرس مقصد
    if (!recipient.startsWith("0x") || recipient.length != 42) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid Recipient Address')),
      );
      return;
    }

    // بررسی مقدار ارسال
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Amount must be greater than zero')),
      );
      return;
    }

    // اگر همه بررسی‌ها درست بود، تراکنش را اجرا کن
    var credentials = EthPrivateKey.fromHex(widget.privateKey);
    var recipientAddress = EthereumAddress.fromHex(recipient);
    var transaction = Transaction(
      to: recipientAddress,
      value: EtherAmount.fromUnitAndValue(
          EtherUnit.wei, (amount * 1e18).toInt()), // Convert MATIC to Wei
    );

    // ارسال تراکنش
    final transactionResult = await _web3Client.sendTransaction(
      credentials,
      transaction,
      chainId: 137, // Polygon Mainnet
    );

    // بررسی نتیجه تراکنش
    if (transactionResult != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('MATIC sent successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Transaction failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Home",
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffE2E2B6)),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xffE2E2B6),
          ),
          onPressed: () {
            Get.toNamed("PrivateKeyScreen");
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              _buildUserInfo(),
              SizedBox(height: 90),
              _buildPublicKeyButton(),
              SizedBox(height: 20),
              _buildBalanceSection(),
              SizedBox(height: 20),
              _buildNFTSection(),
              SizedBox(height: 70),
              _buildMostExpensiveItemsSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Navigation(),
    );
  }

  Widget _buildUserInfo() {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/image/5872854524849407807.jpg'),
          radius: 30,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hi, DV", style: TextStyle(color: Colors.white, fontSize: 20)),
            Text("You're Welcome!", style: TextStyle(color: Colors.white54)),
          ],
        ),
      ],
    );
  }

  Widget _buildPublicKeyButton() {
    return Obx(() => ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff6EACDA),
        minimumSize: Size(double.infinity, 60),
      ),
      onPressed: () {
        Clipboard.setData(ClipboardData(text: WalletScreenModel.publicKeyController.publicKey.value));
        Get.snackbar(
          "Copied",
          "Copied Public Key",
          colorText: Color(0xffE2E2B6),
          backgroundColor: Color(0xff03346E).withOpacity(0.7),
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
      },
      child: Text(
        WalletScreenModel.publicKeyController.publicKey.value,
        style: TextStyle(
            color: Color(0xff021526), fontSize: 16, fontWeight: FontWeight.w800),
        textAlign: TextAlign.center,
      ),
    ));
  }

  Widget _buildBalanceRow() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Balance",
              style: TextStyle(
                  color: Color(0xffE2E2B6),
                  fontSize: 25,
                  fontWeight: FontWeight.w800)),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${WalletScreenModel.balanceControllerMATIC.maticBalance.value} POL",
                style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  WalletScreenModel.isTransferClicked
                      ? Color(0xff77CDFF)
                      : Color(0xffE2E2B6),
                ),
                onPressed: () {
                  setState(() {
                    WalletScreenModel.isTransferClicked =
                    !WalletScreenModel.isTransferClicked;
                    WalletScreenModel.showTransferForm =
                    !WalletScreenModel.showTransferForm;
                  });
                },
                child: Text("Transfer",
                    style: TextStyle(
                        color: Color(0xff03346E), fontSize: 18)),
              ),
            ],
          )
        ]);}

  Widget _buildBalanceSection() {
    return Obx(() {
      return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xff03346E), Color(0xff6EACDA)]),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Color(0xffE2E2B6).withOpacity(0.9),
              offset: Offset(0.4, 0.8),
              blurRadius: 15,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            _buildBalanceRow(),
            SizedBox(height: 20),
            Text(
              "${WalletScreenModel.balanceControllerBITANA.bitanaBalance.value} BITANA",
              style: TextStyle(color: Colors.amber, fontSize: 24, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 30),
            if (WalletScreenModel.showTransferForm) TransferForm(onSendTransaction: sendMATIC),
          ],
        ),
      );
    });
  }

  Widget _buildNFTSection() {
    return Obx(() => ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff6EACDA),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        padding: EdgeInsets.all(16),
        minimumSize: Size(200, 50),
      ),
      onPressed: () {
        Get.toNamed("/ExpensiveItemsView");
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${WalletScreenModel.nftController.amountNFT.value} NFTs",
            style: TextStyle(color: Color(0xff021526), fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ));
  }

  Widget _buildMostExpensiveItemsSection() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 20,
      padding: const EdgeInsets.all(20),
      children: [
        // Add your dynamic "Most Expensive" items here
      ],
    );
  }
}
