import 'package:flutter/material.dart';
import 'package:reticle_trainer_app/ChooseTargetScreen.dart';
import 'package:reticle_trainer_app/ScreenshotGalleryPage.dart';
import 'package:reticle_trainer_app/colors.dart';
import 'package:reticle_trainer_app/home_page.dart';

class RootPage extends StatefulWidget {
  static int selectedIndex = 0;
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final List<Widget> _pages = [
    HomePage(),
    ChooseTargetScreen(),
    ScreenshotGalleryPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      RootPage.selectedIndex = index;
    });
  }

  // Use a custom icon builder with active/inactive state
  Widget _buildIcon(String assetPath, bool isActive) {
    return Image.asset(
      assetPath,
      height: 24,
      color: isActive ? Color(0xFF707070) : AppColors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[RootPage.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: RootPage.selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color(0xFF707070),
        unselectedItemColor: AppColors.black,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
            icon: _buildIcon("assets/home.png", RootPage.selectedIndex == 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon("assets/train.png", RootPage.selectedIndex == 1),
            label: 'Train',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon("assets/share.png", RootPage.selectedIndex == 2),
            label: 'Gallery',
          ),
        ],
      ),
    );
  }
}
