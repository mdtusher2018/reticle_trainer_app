import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as image;
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
  final bool is12Inch;

  PracticeScreen({required this.targetAsset, required this.reticleAsset,required this.is12Inch});

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
double reticleScale=0.2;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.is12Inch) {
      targetScale = 1; // Adjust scale for 12-inch targets
    } else {
      targetScale = 0.5; // Default scale for 6-inch targets
    }
    // reticleScale = widget.is12Inch ? 0.4 : 0.2;

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
                  child: Image.asset(widget.targetAsset, color: Color(0xFFC0C0C0)),
                ),

                /// Reticle with zoom/pan via PhotoView
                PhotoView.customChild(
                  controller: _reticleController,
                  scaleStateController: _reticleScaleController,
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  minScale: reticleScale,
                  maxScale: reticleScale,
                  initialScale: reticleScale,
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
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.camera_alt_outlined, size: 30),
                onPressed: () async {
                  // final directory = await getApplicationDocumentsDirectory();
                  // final timestamp = DateTime.now();
                  // final formattedDate = DateFormat(
                  //   "dd/MM/yyyy",
                  // ).format(timestamp);
                  // final filePath =
                  //     "${directory.path}/screenshot_${timestamp.millisecondsSinceEpoch}.png";
                  // final image = await _screenshotController.capture();
                  // if (image != null) {
                  //   final imageFile = File(filePath);
                  //   await imageFile.writeAsBytes(image);
                  //   // Store metadata
                  //   final prefs = await SharedPreferences.getInstance();
                  //   final existingList =
                  //       prefs.getStringList('screenshot_metadata') ?? [];
                  //   final newEntry = jsonEncode({
                  //     'path': filePath,
                  //     'date': formattedDate,
                  //   });
                  //   existingList.add(newEntry);
                  //   await prefs.setStringList(
                  //     'screenshot_metadata',
                  //     existingList,
                  //   );
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: commonText(
                  //         "Screenshot saved",
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   );
                  // }
                   final directory = await getApplicationDocumentsDirectory();
  final timestamp = DateTime.now();
  final formattedDate = DateFormat("dd/MM/yyyy").format(timestamp);
  final filePath =
      "${directory.path}/screenshot_${timestamp.millisecondsSinceEpoch}.png";

  final rawImage = await _screenshotController.capture();
  if (rawImage != null) {
    // Decode image to edit
    final originalImage = image.decodeImage(rawImage);
    if (originalImage != null) {
      // Define size of the cropped area (e.g. center 300x300)
      const cropWidth = 600;
      const cropHeight = 600;
      final centerX = (originalImage.width / 2).round();
      final centerY = (originalImage.height / 2).round();

      final cropped = image.copyCrop(
        originalImage,
        x: centerX - cropWidth ~/ 2,
        y: centerY - cropHeight ~/ 2,
        width: cropWidth,
        height: cropHeight,
      );

      // Save cropped image
      final croppedBytes = image.encodePng(cropped);
      final imageFile = File(filePath);
      await imageFile.writeAsBytes(croppedBytes);

      // Store metadata
      final prefs = await SharedPreferences.getInstance();
      final existingList = prefs.getStringList('screenshot_metadata') ?? [];

      final newEntry = jsonEncode({
        'path': filePath,
        'date': formattedDate,
      });

      existingList.add(newEntry);
      await prefs.setStringList('screenshot_metadata', existingList);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: commonText("Screenshot saved (cropped)", color: Colors.white),
        ),
      );
    }
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
