import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../netWork/netWork.dart';
import '../../../../netWork/nftModel.dart';

class ProductController extends GetxController {
  final RestClient productService = RestClient(Dio());
  var products = <NFT>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchNFTs();
    super.onInit();
  }

  Future<void> fetchNFTs() async {
    isLoading.value = true;
    try {
      products.value = await productService.fetchNFTs();
    } catch (e) {
      errorMessage.value = 'Error fetching NFTs: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
