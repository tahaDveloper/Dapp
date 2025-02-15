import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../../../netWork/nftModel.dart';



class ConfirmSellPage extends StatelessWidget {
  final Dio http = Dio(); // Create an instance of Dio for HTTP requests
  final NFT nft; // NFT object to hold the data
  final String publicKey; // Public key for display
  final double price; // Price of the NFT

  // Constructor to receive parameters
  ConfirmSellPage({required this.nft, required this.publicKey, required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/5908835613371647683.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              'Are you sure you want to sell?',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.amber),
            ),
            SizedBox(height: 16),
            Text(
              'Public Key: $publicKey',
              style: TextStyle(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.w600),
            ),
            Text(
              'Name: ${nft.Name}',
              style: TextStyle(fontSize: 20, color: Colors.deepOrange, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            Text(
              'Description: ${nft.Description}',
              style: TextStyle(fontSize: 20, color: Colors.deepOrange, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text(
              'Price: \$${price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, color: Colors.deepOrange, fontWeight: FontWeight.w600),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Go back to the previous page
                  },
                  child: Text('Cancel'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.red,
                    textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    fixedSize: Size(150, 60),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                    } catch (e) {
                      print('Error during NFT sell process: $e');
                      _showErrorDialog(context); // Show error dialog
                    }
                  },
                  child: Text('Sell'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.green,
                    textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    fixedSize: Size(150, 60),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('An error occurred during the selling process. Please try again.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> sendSellDataToServer(NFT nft, double price, String transactionHash) async {
    final url = 'https://your-server.com/api/sell'; // Your server URL
    final headers = {'Content-Type': 'application/json'};
    final body = {
      'price': price,
      'transactionHash': transactionHash,
      'description': nft.Description,
      'public_key': nft.PublicKey,
      // Add other necessary data
    };

    try {
      final response = await http.post(
        url,
        options: Options(headers: headers),
        data: json.encode(body),
      );

      if (response.statusCode != 200) {
        throw 'Failed to send sell data to server';
      }
      print('Sell data successfully sent to server');
    } catch (e) {
      print('Error sending sell data to server: $e');
      throw e; // Propagate error for higher-level handling
    }
  }
}
