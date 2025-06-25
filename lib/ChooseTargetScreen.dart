import 'package:flutter/material.dart';
import 'package:reticle_trainer_app/choose_reticle_screen.dart';
import 'package:reticle_trainer_app/colors.dart';
import 'package:reticle_trainer_app/commonWidgets.dart';

class ChooseTargetScreen extends StatefulWidget {
  @override
  State<ChooseTargetScreen> createState() => _ChooseTargetScreenState();
}

class _ChooseTargetScreenState extends State<ChooseTargetScreen> {
  Map<String, String>? selectedTarget;

  final List<Map<String, String>> target6 = [
    {
      "label": "Circle",
      "size": "6\"",
      "range": "167 Yards / 1\nMil Wide",
      "asset": "assets/circle.png",
    },
    {
      "label": "Square",
      "size": "6\"",
      "range": "167 Yards / 1\nMil Wide",
      "asset": "assets/square.png",
    },
    {
      "label": "Diamond",
      "size": "6\"",
      "range": "167 Yards / 1\nMil Wide",
      "asset": "assets/diamond.png",
    },
    {
      "label": "IPSC",
      "size": "6\"",
      "range": "167 Yards / 1\nMil Wide",
      "asset": "assets/ipsc.png",
    },
  ];

  final List<Map<String, String>> target12 = [
    {
      "label": "Circle",
      "size": "12\"",
      "range": "167 Yards / 2\nMil Wide",
      "asset": "assets/circle.png",
    },
    {
      "label": "Square",
      "size": "12\"",
      "range": "167 Yards / 2\nMil Wide",
      "asset": "assets/square.png",
    },
    {
      "label": "Diamond",
      "size": "12\"",
      "range": "167 Yards / 2\nMil Wide",
      "asset": "assets/diamond.png",
    },
    {
      "label": "IPSC",
      "size": "12\"",
      "range": "167 Yards / 2\nMil Wide",
      "asset": "assets/ipsc.png",
    },
  ];

  Widget buildTargetCard(Map<String, String> target) {
    final isSelected = selectedTarget == target;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTarget = target;
        });
      },
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,

              child: Card(
                elevation: isSelected ? 0 : 1,
                color: AppColors.lightWhite,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: isSelected ? Colors.black : Colors.transparent,
                    width: isSelected ? 3 : 0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(target['asset']!, height: 80),
                    const SizedBox(height: 8),
                    commonText("${target['label']}", size: 16, isBold: true),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          commonText(
            target['range']!,
            textAlign: TextAlign.center,
            isBold: true,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: commonText('Choose Your Target', size: 20, isBold: true),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: SizedBox(),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonText("6\" Targets", size: 18, isBold: true),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: target6.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  return buildTargetCard(target6[index]);
                },
              ),
              const SizedBox(height: 16),
              commonText("12\" Targets", size: 18, isBold: true),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: target12.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  return buildTargetCard(target12[index]);
                },
              ),
              const SizedBox(height: 20),
              commonButton(
                "Next",
                onTap: () {
                  if (selectedTarget == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please select a target first"),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => ChooseReticleScreen(
                              targetImage: selectedTarget!['asset']!,
                            ),
                      ),
                    );
                  }
                },
                color: Colors.black,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
