import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reticle_trainer_app/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'package:reticle_trainer_app/commonWidgets.dart';

class ScreenshotGalleryPage extends StatefulWidget {
  @override
  _ScreenshotGalleryPageState createState() => _ScreenshotGalleryPageState();
}

class _ScreenshotGalleryPageState extends State<ScreenshotGalleryPage> {
  List<Map<String, dynamic>> screenshots = [];

  @override
  void initState() {
    super.initState();
    loadScreenshots();
  }

  Future<void> loadScreenshots() async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList('screenshot_metadata') ?? [];

    final loaded =
        savedList
            .map((entry) {
              final decoded = jsonDecode(entry);
              return {'path': decoded['path'], 'date': decoded['date']};
            })
            .where((item) => File(item['path']!).existsSync())
            .toList();

    setState(() {
      screenshots = loaded.reversed.toList();
      // Show newest first
    });
  }

  Future<void> deleteScreenshot(int index) async {
    final file = File(screenshots[index]['path']!);
    if (file.existsSync()) {
      await file.delete();
    }

    final prefs = await SharedPreferences.getInstance();
    final existingList = prefs.getStringList('screenshot_metadata') ?? [];

    existingList.removeWhere((entry) {
      final decoded = jsonDecode(entry);
      return decoded['path'] == screenshots[index]['path'];
    });

    await prefs.setStringList('screenshot_metadata', existingList);

    setState(() {
      screenshots.removeAt(index);
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: commonText("Screenshot deleted")));
  }

  void shareScreenshot(String path) {
    Share.shareXFiles([XFile(path)], text: "Check out my screenshot!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: commonText("Share Your Shot", isBold: true, size: 20),
        centerTitle: true,
        leading: SizedBox(),
      ),
      body:
          screenshots.isEmpty
              ? Center(
                child: commonText(
                  "No screenshots found.",
                  size: 18,
                  isBold: true,
                ),
              )
              : GridView.builder(
                padding: EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 per row for better spacing
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemCount: screenshots.length,
                itemBuilder: (context, index) {
                  final item = screenshots[index];
                  final file = File(item['path']!);
                  final date = item['date']!;

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Image.file(
                                  file,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: AppColors.black,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6.0,
                                horizontal: 8,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: commonText(
                                      date,
                                      size: 14,
                                      maxLine: 1,
                                      color: AppColors.white,
                                      isBold: true,
                                    ),
                                  ),
                                  InkWell(
                                    child: Image.asset(
                                      "assets/share.png",
                                      width: 20,
                                    ),
                                    onTap: () => shareScreenshot(item['path']!),
                                  ),
                                  SizedBox(width: 8),
                                  InkWell(
                                    child: Image.asset(
                                      "assets/delete.png",
                                      width: 20,
                                    ),
                                    onTap: () => deleteScreenshot(index),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
