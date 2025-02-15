import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class BalanceControllerMATIC extends GetxController {
  RxString maticBalance = "0".obs;
  RxString bitanaBalance = "0".obs; // مقدار BITANA

  void setBalance(String balance) {
    maticBalance.value = balance;
  }

  void setBitanaBalance(String balance) {
    bitanaBalance.value = balance;
  }
}
