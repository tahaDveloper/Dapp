import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../main.dart';
import '../../../../netWork/nftModel.dart';
import '../../../viweModel/nft/detail/NftDetailPage.dart';



class Car_StorePage extends StatefulWidget {
  @override
  _CarState createState() => _CarState();
}

class _CarState extends State<Car_StorePage> {
  List<NFT> nfts = [];
  String _nftError = '';
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchNFTs(); // بارگذاری NFTها در هنگام شروع
  }

  Future<void> _fetchNFTs() async {
    final String apiKey = "YOUR_API_KEY"; // کلید API خود را جایگزین کنید
    final String address = "YOUR_WALLET_ADDRESS"; // آدرس کیف پول خود را جایگزین کنید

    try {
      final response = await http.get(Uri.parse(
          'https://api.polygonscan.com/api?module=account&action=tokennfttx&address=$address&apikey=$apiKey'));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == '1' && jsonResponse['result'].isNotEmpty) {
          setState(() {
            nfts = (jsonResponse['result'] as List)
                .map((nft) => NFT.fromJson(nft))
                .toList();
            _nftError = ''; // پاک کردن خطا
          });
        } else {
          setState(() {
            _nftError = 'هیچ NFT‌ای برای این آدرس یافت نشد.';
          });
        }
      } else {
        throw Exception('خطا در بارگذاری داده‌های NFT. کد وضعیت: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _nftError = 'خطا در دریافت NFTها: $e';
      });
    }
  }

  void _viewNFTDetail(BuildContext context, NFT nft) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NFTDetailPage(nft: nft, public_key: '',),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // فیلتر کردن NFT ها بر اساس جستجوی کاربر
    final filteredNfts = nfts.where((nft) {
      return nft.Name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/image/images.jpg',
                fit: BoxFit.cover,
              ),
            ),
            // جستجو
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value; // بروزرسانی جستجو
                  });
                },
                decoration: InputDecoration(
                  hintText: 'جستجوی NFT...',
                  filled: true,
                  fillColor: Colors.white38,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            // نمایش پیام خطا
            if (_nftError.isNotEmpty)
              Center(
                child: Text(
                  _nftError,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            // نمایش NFTها
            if (filteredNfts.isNotEmpty)
              Container(
                height: 100,
                color: Colors.white38,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: filteredNfts.length,
                    itemBuilder: (context, index) {
                      final nft = filteredNfts[index];
                      return Card(
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
                  ),
                ),
              ),
            Column(
              children: [
                SizedBox(height: 8),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 250.0,
                    autoPlay: true, // فعال کردن پخش خودکار
                    autoPlayInterval: Duration(seconds: 3), // مدت زمان تغییر خودکار بین اسلایدها
                  ),
                  items: filteredNfts.map((nft) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () => _viewNFTDetail(context, nft),
                                child: Image.network(
                                  nft.url,
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.error);
                                  },
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                nft.Name,
                                style: TextStyle(fontSize: 17, color: Colors.black),
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
