import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

class MaticTransfer {
  final String privateKey;
  final String rpcUrl;

  MaticTransfer({
    required this.privateKey,
    required this.rpcUrl,
  });

  // ارسال MATIC
  Future<void> sendMATIC(String recipient, double amount) async {
    final client = Web3Client(rpcUrl, Client());
    final credentials = EthPrivateKey.fromHex(privateKey);
    final recipientAddress = EthereumAddress.fromHex(recipient);

    try {
      final transaction = Transaction(
        to: recipientAddress,
        value: EtherAmount.fromUnitAndValue(EtherUnit.wei, (amount * 1e18).toInt()),
      );

      await client.sendTransaction(
        credentials,
        transaction,
        chainId: 137, // Polygon Mainnet
      );
      print('MATIC با موفقیت ارسال شد');
    } catch (e) {
      print('خطا در ارسال MATIC: $e');
    } finally {
      client.dispose();
    }
  }
}
