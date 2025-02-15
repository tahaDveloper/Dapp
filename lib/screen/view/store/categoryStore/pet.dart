import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../netWork/nftModel.dart';



class Pet_StorePage extends StatefulWidget {
  const Pet_StorePage({super.key});

  @override
  State<Pet_StorePage> createState() => _PetState();
}

class _PetState extends State<Pet_StorePage> {
  // اینجا لیست NFT ها را تعریف کنید
  final List<NFT> nfts = [

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet NFTs'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/download.jpg'), // تصویر پس‌زمینه
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
            'No Pet NFTs found.',
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      ),
    );
  }
}