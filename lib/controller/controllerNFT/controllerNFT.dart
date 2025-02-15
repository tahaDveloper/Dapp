import 'package:get/get.dart';

class NftController extends GetxController {
  var amountNFT = 0.obs;

  void setNftCount(int count) {
    amountNFT.value = count;
  }
}
