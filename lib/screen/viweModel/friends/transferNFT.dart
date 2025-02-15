import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'friends.dart';


class NFTManagementApp extends StatefulWidget {
  @override
  _NFTManagementAppState createState() => _NFTManagementAppState();
}
class _NFTManagementAppState extends State<NFTManagementApp> {
  late Web3Client _client;
  final String _rpcUrl =
      "https://polygon-mainnet.g.alchemy.com/v2/oV51GPoQ4DgCwJTrTFJPuTMwZvWWN77b"; // آدرس RPC شبکه
  final String _privateKey = "11361371ba99160bf9e52647e8b847b924b3187cb7972c06f99eacaf3f88f5cd"; // کلید خصوصی شما
  final String _contractAddress = "0x11dDe867C6a225C49523b540BF854C6ECEa6C489"; // آدرس اسمارت کانترکت NFT

  late DeployedContract _contract;
  late ContractFunction transferNFT;
  late ContractFunction changeOwnership;
  late EthereumAddress isContract;
  late Credentials _credentials;

  TextEditingController _addressController = TextEditingController();
  TextEditingController _tokenIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initWeb3();
  }

  Future<void> _initWeb3() async {
    _client = Web3Client(_rpcUrl, Client());
    _credentials = EthPrivateKey.fromHex(_privateKey);
    isContract = EthereumAddress.fromHex(_contractAddress);

    // ABI اسمارت کانترکت NFT را اینجا وارد کنید
    String abi = '''[
      {
        "inputs": [
          {
            "internalType": "address",
            "name": "nftContract",
            "type": "address"
          },
          {
            "internalType": "address",
            "name": "to",
            "type": "address"
          },
          {
            "internalType": "uint256[]",
            "name": "tokenIds",
            "type": "uint256[]"
          }
        ],
        "name": "batchTransferNFT",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
      },
      {
        "inputs": [
          {
            "internalType": "address",
            "name": "newOwner",
            "type": "address"
          }
        ],
        "name": "changeOwnership",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
      },
      {
        "inputs": [
          {
            "internalType": "address",
            "name": "nftContract",
            "type": "address"
          },
          {
            "internalType": "address",
            "name": "to",
            "type": "address"
          },
          {
            "internalType": "uint256",
            "name": "tokenId",
            "type": "uint256"
          }
        ],
        "name": "transferNFT",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
      }
    ]''';

    _contract = DeployedContract(
      ContractAbi.fromJson(abi, 'MyNFT'),
      isContract,
    );

    transferNFT = _contract.function("transferNFT");
    changeOwnership = _contract.function("changeOwnership");
  }

  Future<void> _transferNFT() async {
    final fromAddress = EthereumAddress.fromHex("FROM_ADDRESS"); // آدرس فرستنده
    final toAddress = EthereumAddress.fromHex(_addressController.text);
    final tokenId = BigInt.parse(_tokenIdController.text);

    try {
      await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
          contract: _contract,
          function: transferNFT,
          parameters: [fromAddress, toAddress, tokenId],
        ),
      );
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(
          content: Text('NFT transferred successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(
          content: Text('Error transferring NFT: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _changeOwnership() async {
    final newOwnerAddress = EthereumAddress.fromHex(_addressController.text);
    try {
      await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
          contract: _contract,
          function: changeOwnership,
          parameters: [newOwnerAddress],
        ),
      );
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(
          content: Text('Ownership changed successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(
          content: Text('Error changing ownership: $e'),
          backgroundColor: Colors.red,
        ),
      );
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
                image: AssetImage('assets/image/13839352_5362535.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Semi-transparent overlay
          Padding(
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
                  child: const Text(
                    'Transfer NFT',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Colors.cyanAccent,
                      shadows: [
                        Shadow(
                          color: Colors.purpleAccent, // رنگ سایه
                          offset: Offset(4.0, 4.0), // موقعیت سایه
                          blurRadius: 4.0, // شعاع تار شدن سایه
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 150),

                // Center container for input fields
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Fancy input fields
                          _buildFancyTextField(_addressController, 'Recipient Address'),
                          SizedBox(height: 20),
                          _buildFancyTextField(_tokenIdController, 'Token ID', TextInputType.number),
                          SizedBox(height: 30),

                          // Fancy buttons with custom styling
                          _buildFancyButton('Transfer NFT', _transferNFT),
                          SizedBox(height: 15),
                          _buildFancyButton('Change Ownership', _changeOwnership),
                        ],
                      ),
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



  // Helper method to create fancy text fields
  Widget _buildFancyTextField(TextEditingController controller, String label,
      [TextInputType keyboardType = TextInputType.text]) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.purpleAccent.withOpacity(0.2),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.purpleAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.cyanAccent),
        ),
      ),
      style: TextStyle(color: Colors.cyanAccent),
    );
  }

  // Helper method to create fancy buttons
  Widget _buildFancyButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.cyanAccent,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        elevation: 10,
        shadowColor: Colors.black54,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
          color: Colors.black,
        ),
      ),
    );
  }
}