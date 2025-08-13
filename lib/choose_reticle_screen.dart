import 'package:flutter/material.dart';
import 'package:reticle_trainer_app/PracticeScreen.dart';
import 'package:reticle_trainer_app/colors.dart';
import 'package:reticle_trainer_app/commonWidgets.dart';

class ChooseReticleScreen extends StatefulWidget {
  final String targetImage;
  final bool is12Inch;

  const ChooseReticleScreen({
    super.key,
    required this.targetImage,
    required this.is12Inch,
  });

  @override
  State<ChooseReticleScreen> createState() => _ChooseReticleScreenState();
}

class _ChooseReticleScreenState extends State<ChooseReticleScreen> {
  final List<String> reticles = [
    "PR2-MIL FFP",
    "CMR-MIL",
    "MiL-XT",
    "Mil-CF2",
    "MPCT-1X",
    "MPCT-2X",
    "SKMR4+",
    "SKMR4+ (2)",
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        leading: const BackButton(),
        title: commonText('Choose a Reticle', size: 20, isBold: true),

        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: reticles.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final isSelected = selectedIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Card(
                      color: AppColors.lightWhite,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: isSelected ? Colors.black : Colors.transparent,
                          width: isSelected ? 2 : 0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/${reticles[index]}.png",
                            height: 100,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image, size: 60);
                            },
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: commonText(
                              reticles[index],
                              size: 14,
                              isBold: true,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            commonButton(
              "Next",
              onTap: () {
                if (selectedIndex == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please select a reticle first"),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => PracticeScreen(
                            reticleAsset:
                                "assets/${reticles[selectedIndex!]}.png",
                            targetAsset: widget.targetImage,
                            is12Inch: widget.is12Inch,
                          ),
                    ),
                  );
                }
              },
              color: Colors.black,
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
