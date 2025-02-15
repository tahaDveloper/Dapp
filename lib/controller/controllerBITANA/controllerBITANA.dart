import 'package:get/get.dart';

class BalanceControllerBITANA extends GetxController {
  var bitanaBalance = "0".obs; // مقدار اولیه "0"
  void setBalance(String balance) {
    bitanaBalance.value = balance;
  }
}
