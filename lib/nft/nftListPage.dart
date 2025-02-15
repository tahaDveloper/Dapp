import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../netWork/netWork.dart';
import '../screen/viweModel/nft/detail/NftDetailPage.dart';
import 'nftController.dart';


class NFTListPage extends StatelessWidget {
  final NFTController controller = Get.put(NFTController(RestClient(Dio())));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('NFT List')),
      body: Obx(() {
        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value, style: TextStyle(color: Colors.red)));
        }

        if (controller.nfts.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.nfts.length,
          itemBuilder: (context, index) {
            final nft = controller.nfts[index];
            return ListTile(
              title: Text(nft.Name),
              onTap: () => Get.to(() => NFTDetailPage(nft: nft, public_key: '',)),
            );
          },
        );
      }),
    );
  }
}
