import 'package:flutter/material.dart';
import 'package:reticle_trainer_app/colors.dart';
import 'package:reticle_trainer_app/commonWidgets.dart';

class HowItWorksView extends StatelessWidget {
  const HowItWorksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black),
        title: commonText(
          'How it Works',
          size: 18,
          isBold: true,
          color: Colors.black,
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: const [
              StepCard(
                stepNumber: 1,
                title: 'Choose Your Target',
                description:
                    'Select from different target shapes and sizes that match your real-world shooting scenarios. The app includes circles, squares, diamonds, and animal silhouettes.',
              ),
              SizedBox(height: 16),
              StepCard(
                stepNumber: 2,
                title: 'Select a Reticle',
                description:
                    'Choose from various scope reticle designs including crosshair, duplex, mil-dot, and others. Each reticle represents different real-world optics.',
              ),
              SizedBox(height: 16),
              StepCard(
                stepNumber: 3,
                title: 'Practice Holdover',
                description:
                    'Drag and position the reticle to practice holdover techniques. The target remains fixed while you move the reticle to simulate different shooting scenarios.',
              ),
              SizedBox(height: 16),
              StepCard(
                stepNumber: 4,
                title: 'Save & Share',
                description:
                    'Take screenshots of your training sessions and share them with friends or instructors. All screenshots are saved in the app for future reference.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StepCard extends StatelessWidget {
  final int stepNumber;
  final String title;
  final String description;

  const StepCard({
    super.key,
    required this.stepNumber,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonText(
            '$stepNumber. $title',
            size: 16,
            isBold: true,
            color: Colors.black,
          ),
          const SizedBox(height: 6),
          commonText(description, size: 14),
        ],
      ),
    );
  }
}
