import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jamaah_time/Admin%20Panel/Category.dart';
import 'package:jamaah_time/Admin%20Panel/ProductAdd.dart';
import 'package:jamaah_time/Admin%20Panel/info.dart';
import 'package:jamaah_time/Admin%20Panel/mosque_info_input.dart';
import 'package:jamaah_time/Admin%20Panel/productlist.dart';

import '../Constants/constant.dart';


class AdminNavbar extends StatefulWidget {

  @override
  State<AdminNavbar> createState() => _AdminNavbarState();
}

class _AdminNavbarState extends State<AdminNavbar> {
  int _selectedTab = 0;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        MosqueInfoInput(),
        AdminInformation(),
        AddProductPage(),
        ProductListPage(),
        Category(),
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
            icon: Icons.edit_note,
            text: 'Add Mosque',
          ),
          GButton(
            icon: Icons.list_alt_outlined,
            text: 'Mosque Info.',
          ),
          GButton(
            icon: Icons.add_shopping_cart,
            text: 'Products',
          ),
          GButton(
            icon: Icons.remove_red_eye_outlined,
            text: 'View Products',
          ),
          GButton(
            icon: Icons.add_box_outlined,
            text: 'Category',
          ),

        ],
      ),
    );
  }
}