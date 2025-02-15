import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../netWork/nftModel.dart';
import '../screen/model/storeModel/StoreViweModel.dart';
import '../screen/viweModel/nft/detail/NftDetailPage.dart';



class YourWidget extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('My NFTs (${productController.products.length})')), // نمایش تعداد NFT‌ها
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return Center(child: CircularProgressIndicator()); // بارگذاری
        } else if (productController.products.isEmpty) {
          return Center(child: Text('No NFTs found.')); // پیام در صورت عدم وجود NFT
        } else {
          return buildNFTGrid(productController.products);
        }
      }),
    );
  }

  Widget buildNFTGrid(List<NFT> nftAssets) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // تعداد ستون‌ها در grid
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: nftAssets.length,
      itemBuilder: (context, index) {
        final nft = nftAssets[index];
        return GestureDetector(
          onTap: () {
            Get.to(() => NFTDetailPage(nft: nft, public_key: '')); // ناوبری به صفحه جزئیات NFT
          },
          child: Card(
            child: Column(
              children: [
                SizedBox(height: 8),
                Expanded(
                  child: Image.asset(
                    "assets/image/IMAGE_CyberpunkHouse.jpg", // توجه به حذف ".jpg.jpg"
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  nft.Name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('\$${nft.Price}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
