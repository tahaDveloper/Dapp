import 'package:get/get.dart';

class PublicKeyController extends GetxController {
  var publicKey = ''.obs;

  void setPublicKey(String key) {
    publicKey.value = key;
  }
}
