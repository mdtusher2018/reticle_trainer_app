import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:reticle_trainer_app/colors.dart';
import 'package:reticle_trainer_app/commonWidgets.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PracticeScreen extends StatefulWidget {
  final String targetAsset;
  final String reticleAsset;

  PracticeScreen({required this.targetAsset, required this.reticleAsset});

  @override
  _PracticeScreenState createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  double targetScale = 1.0;

  final PhotoViewController _reticleController = PhotoViewController();
  final PhotoViewScaleStateController _reticleScaleController =
      PhotoViewScaleStateController();

  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  void dispose() {
    _reticleController.dispose();
    _reticleScaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhite,
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: AppColors.lightWhite,
        elevation: 0,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Screenshot(
            controller: _screenshotController,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Transform.scale(
                  scale: targetScale,
                  child: Image.asset(widget.targetAsset, color: Colors.white),
                ),

                /// Reticle with zoom/pan via PhotoView
                PhotoView.customChild(
                  controller: _reticleController,

                  scaleStateController: _reticleScaleController,
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  minScale: 0.2,
                  maxScale: 3.0,
                  initialScale: 1.0,
                  enablePanAlways: true,
                  basePosition: Alignment.center,

                  child: Image.asset(
                    widget.reticleAsset,
                    width: 200,
                    height: 200,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            right: 0,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 300, // height of vertical slider
                  child: RotatedBox(
                    quarterTurns:
                        -1, // rotate slider 90 degrees counter-clockwise
                    child: Slider(
                      value: targetScale,
                      min: 0.5,
                      max: 2.5,
                      divisions: 20,
                      label: "${(targetScale * 100).round()}%",
                      onChanged: (value) {
                        setState(() {
                          targetScale = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(width: 20),
                commonText(
                  "Target\nScale",
                  isBold: true,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          /// Screenshot Button
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.camera_alt_outlined, size: 30),
                onPressed: () async {
                  final directory = await getApplicationDocumentsDirectory();
                  final timestamp = DateTime.now();
                  final formattedDate = DateFormat(
                    "dd/MM/yyyy",
                  ).format(timestamp);
                  final filePath =
                      "${directory.path}/screenshot_${timestamp.millisecondsSinceEpoch}.png";

                  final image = await _screenshotController.capture();
                  if (image != null) {
                    final imageFile = File(filePath);
                    await imageFile.writeAsBytes(image);

                    // Store metadata
                    final prefs = await SharedPreferences.getInstance();
                    final existingList =
                        prefs.getStringList('screenshot_metadata') ?? [];

                    final newEntry = jsonEncode({
                      'path': filePath,
                      'date': formattedDate,
                    });

                    existingList.add(newEntry);
                    await prefs.setStringList(
                      'screenshot_metadata',
                      existingList,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: commonText(
                          "Screenshot saved",
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
