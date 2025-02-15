import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oasis/screen/view/broadcast/broadcast.dart';

import '../../screen/view/friends/friends.dart';
import '../../screen/view/store/store.dart';
import '../../screen/view/voting/voting.dart';
import '../../screen/view/walletScreen/WalletScreenViwe.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  List<bool> selectedIndex = [true, false, false, false, false]; // وضعیت اولیه انتخاب

  @override
  Widget build(BuildContext context) {
    String currentRoute = Get.currentRoute; // مسیر فعلی

    return Container(
      height: 70,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff03346E),
            blurRadius: 10,
            offset: Offset(4, 4),
            spreadRadius: BorderSide.strokeAlignOutside,
          ),
        ],
        color: Color(0xff6EACDA),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButtonWidget(
            icon: Icons.home,
            label: 'Home',
            isSelected: currentRoute == "/WalletScreen",
            onPressed: () {
              setState(() {
                selectedIndex = [true, false, false, false, false];
              });
              Get.to(
                WalletScreenView(privateKey: '',), // صفحه مورد نظر را وارد کنید
                transition: Transition.leftToRightWithFade, // انیمیشن انتقال
                duration: Duration(milliseconds: 500), // مدت زمان انیمیشن
              );
            },
          ),
          IconButtonWidget(
            icon: Icons.person,
            label: 'Friends',
            isSelected: currentRoute == "/FriendsListScreen",
            onPressed: () {
              setState(() {
                selectedIndex = [false, true, false, false, false];
              });
              Get.to(
                FriendsListScreen(), // صفحه مورد نظر را وارد کنید
                transition: Transition.leftToRightWithFade,
                duration: Duration(milliseconds: 500),
              );
            },
          ),
          IconButtonWidget(
            icon: Icons.account_balance,
            label: 'Store',
            isSelected: currentRoute == "/StorePage",
            onPressed: () {
              setState(() {
                selectedIndex = [false, false, true, false, false];
              });
              Get.to(
                StorePage(), // صفحه مورد نظر را وارد کنید
                transition: Transition.leftToRightWithFade,
                duration: Duration(milliseconds: 500),
              );
            },
          ),
          IconButtonWidget(
            icon: Icons.how_to_vote,
            label: 'Voting',
            isSelected: currentRoute == "/VotingPage",
            onPressed: () {
              setState(() {
                selectedIndex = [false, false, false, true, false];
              });
              Get.to(
                Voting_Page(), // صفحه مورد نظر را وارد کنید
                transition: Transition.leftToRightWithFade,
                duration: Duration(milliseconds: 500),
              );
            },
          ),
          IconButtonWidget(
            icon: Icons.video_library,
            label: 'Live',
            isSelected: currentRoute == "/broadcast",
            onPressed: () {
              setState(() {
                selectedIndex = [false, false, false, false, true];
              });
              Get.to(
                Broadcast(), // صفحه مورد نظر را وارد کنید
                transition: Transition.leftToRightWithFade,
                duration: Duration(milliseconds: 500),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ویجت دکمه آیکون
class IconButtonWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const IconButtonWidget({
    Key? key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff03346E) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Color(0xffE2E2B6) : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Color(0xffE2E2B6) : Color(0xff021526),
              size: 30,
            ),
            SizedBox(width: 8),
            if (isSelected)
              Text(
                label,
                style: TextStyle(
                  color: Color(0xffE2E2B6),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
//bottomNavigationBar: Navigation(),
