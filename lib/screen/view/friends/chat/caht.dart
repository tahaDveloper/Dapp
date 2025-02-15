import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../widget/customeNavigation/widget_navigation.dart';

class ChatScreen extends StatelessWidget {
  final String friendName;

  ChatScreen({required this.friendName});

  final List<Map<String, dynamic>> messages = [
    {'text': 'Hi', 'isSentByMe': true},
    {'text': 'Hey, How Are You?', 'isSentByMe': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff17191D),
        title: Text(friendName,style: TextStyle(color: Colors.white54),),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios, // آیکن دلخواه خود را انتخاب کنید
            color: Color(0xffE2E2B6), // رنگ آیکن
          ),
          onPressed: () {
            Get.toNamed("FriendsListScreen");
            // تابعی برای عملکرد آیکن می‌توانید اضافه کنید
            print("Menu button pressed");
          },
        ),
      ),
      backgroundColor: Color(0xff17191D),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isSentByMe = messages[index]['isSentByMe']!;
                return Align(
                  alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: isSentByMe ? Colors.purple : Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      messages[index]['text']!,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      filled: true,
                      fillColor: Colors.grey[700],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    // Implement send message functionality
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    //  bottomNavigationBar: Navigation(),

    );
  }
}