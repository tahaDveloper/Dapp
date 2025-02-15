import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../netWork/nftModel.dart';



class Phone_StorePage extends StatefulWidget {
  const Phone_StorePage({super.key});

  @override
  State<Phone_StorePage> createState() => _PhoneState();
}

class _PhoneState extends State<Phone_StorePage> {
  // اینجا لیست NFT ها را تعریف کنید
  final List<NFT> nfts = [

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone NFTs'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/fba7e90aae11ba301fe88f9da2a35875.jpg'), // تصویر پس‌زمینه
            fit: BoxFit.cover,
          ),
        ),
        child: nfts.isNotEmpty
            ? ListView.builder(
          itemCount: nfts.length,
          itemBuilder: (context, index) {
            final nft = nfts[index];
            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: Image.network(
                  nft.url,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(nft.Name),
                ),
              );
          },
        )
            : const Center(
          child: Text(
            'No Phone NFTs found.',
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      ),
    );
  }
}