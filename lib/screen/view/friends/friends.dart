import 'package:flutter/material.dart';
import '../../../widget/customeNavigation/widget_navigation.dart';
import 'chat/caht.dart';

class FriendsListScreen extends StatelessWidget {
  final List<Map<String, String>> friends = [
    {'name': 'Taha', 'image': 'assets/taha.jpg'},
    {'name': 'Javid', 'image': 'assets/javid.jpg'},
    {'name': 'Arian', 'image': 'assets/arian.jpg'},
    {'name': 'Arman', 'image': 'assets/arman.jpg'},
    {'name': 'Shahram', 'image': 'assets/shahram.jpg'},
    {'name': 'Sina', 'image': 'assets/sina.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff17191D),  // پس‌زمینه تیره
      appBar: AppBar(
        title: Text('Friends', style: TextStyle(color: Color(0xffE2E2B6), fontFamily: 'Fantasy')),
        backgroundColor: Color(0xff17191D),
        elevation: 0,
        centerTitle: true,

      ),
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            color: Color(0xff03346E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16), // گرد کردن گوشه‌ها
              side: BorderSide(color: Color(0xff6EACDA), width: 1.5),
            ),
            elevation: 5,
            shadowColor: Color(0xffE2E2B6), // افکت سایه
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(friends[index]['image']!),
                radius: 30,
              ),
              title: Text(
                friends[index]['name']!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xffE2E2B6),
                ),
              ),
              subtitle: Text(
                'Tap to chat!',
                style: TextStyle(color: Color(0xff6EACDA), fontSize: 14),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(friendName: friends[index]['name']!),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar:Navigation(),
    );
  }
}
