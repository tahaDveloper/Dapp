import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../netWork/netWork.dart';
import '../../../netWork/nftModel.dart';

class ExpensiveController extends GetxController {
  var expensiveItems = <NFT>[].obs;
  var isLoading = false.obs;

  late RestClient apiService;

  @override
  void onInit() {
    super.onInit();
    final dio = Dio();
    apiService = RestClient(dio);
    fetchExpensiveItems();
  }

  void fetchExpensiveItems() async {
    try {
      isLoading(true);
      final items = await apiService.fetchNFTs();
      expensiveItems.assignAll(items);
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
