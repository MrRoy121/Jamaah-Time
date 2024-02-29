import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jamaah_time/Admin%20Panel/Category.dart';
import 'package:jamaah_time/Admin%20Panel/ProductAdd.dart';
import 'package:jamaah_time/Admin%20Panel/info.dart';
import 'package:jamaah_time/Admin%20Panel/mosque_info_input.dart';
import 'package:jamaah_time/User%20panel/Screen/homescreen.dart';
import 'package:jamaah_time/User%20panel/Screen/mosqueInfo.dart';
import 'package:jamaah_time/User%20panel/Screen/Duas.dart';
import 'package:jamaah_time/User%20panel/Screen/qiblaScreen_direction.dart';
import 'package:jamaah_time/User%20panel/e-shoping/uShoping.dart';

import '../../Constants/constant.dart';



class Navbar extends StatefulWidget {

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedTab = 0;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        HomeScreen(),
        MosqueInfo(),
        QiblaDirection(),
        NotificationScreen(),
        UserShopping(),
      ].elementAt(_selectedTab),
      bottomNavigationBar: GNav(
        backgroundColor: AppColor,
        color: Colors.white,
        tabBackgroundColor: Colors.white70,
        gap: 8,
        padding: EdgeInsets.all(16),
        onTabChange: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.list_alt_outlined,
            text: 'Mosque Info.',
          ),
          GButton(
            icon: Icons.directions,
            text: 'Qibla',
          ),
          GButton(
            icon: Icons.menu_book,
            text: "Duaa",
          ),
          GButton(
            icon: Icons.add_shopping_cart,
            text: 'e-Shoping',
          ),

        ],
      ),
    );
  }
}