import 'package:flutter/material.dart';
import 'package:reticle_trainer_app/colors.dart';
import 'package:reticle_trainer_app/commonWidgets.dart';
import 'package:reticle_trainer_app/how_it_works_view.dart';
import 'package:reticle_trainer_app/rootpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Spacer(flex: 1),
          Image.asset("assets/logo.png", height: 200),
          SizedBox(height: 16),
          commonButton(
            "Start Training Session",
            borderRadious: 16,
            onTap: () {
              RootPage.selectedIndex = 1;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RootPage(), // pass data if needed
                ),
              );
            },
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HowItWorksView(), // pass data if needed
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.black,
                  width: 2,
                ), // border color
                borderRadius: BorderRadius.circular(8), // rounded corners
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  commonText("How it works", size: 16, isBold: true),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, color: AppColors.black),
                ],
              ),
            ),
          ),

          Spacer(flex: 3),
        ],
      ),
    );
  }
}
