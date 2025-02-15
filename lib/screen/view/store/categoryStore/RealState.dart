import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../netWork/nftModel.dart';





class RealState_StorePage extends StatefulWidget {
  const RealState_StorePage({super.key});

  @override
  State<RealState_StorePage> createState() => _RealStateState();
}

class _RealStateState extends State<RealState_StorePage> {
  // اینجا لیست NFT ها را تعریف کنید
  final List<NFT> nfts = [


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Real State NFTs'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/colorful-cartoon-illustration-city-skyline-dawn-with-soft-pink-sky_36682-228143.jpg'),
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
            : Center(
          child: Text(
            'No Real State NFTs found.',
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      ),
    );
  }
}