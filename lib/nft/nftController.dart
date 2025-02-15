import 'package:get/get.dart';

import '../netWork/netWork.dart';
import '../netWork/nftModel.dart';



class NFTController extends GetxController {
  var nfts = <NFT>[].obs;
  var errorMessage = ''.obs;

  final RestClient apiService;

  NFTController(this.apiService);

  Future<void> fetchNFTs() async {
    try {
      nfts.value = await apiService.fetchNFTs();
    } catch (e) {
      errorMessage.value = 'Error fetching NFTs: $e';
    }
  }
}
