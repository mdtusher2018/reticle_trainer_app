import 'package:flutter/material.dart';
import 'package:reticle_trainer_app/colors.dart';
import 'package:reticle_trainer_app/commonWidgets.dart';
import 'package:reticle_trainer_app/rootpage.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Train Your Aim.\nVisually",
      "subtitle":
          "Practice reticle holdover techniques with real-world target references — no calculations, just clean visuals",
    },
    {
      "title": "Select. Align. Learn",
      "subtitle":
          "Pick a target shape and reticle.  Drag and zoom the reticle over the target to simulate aiming with a holdover technique allowing for elevation and windage adjustments.",
    },
    {
      "title": "Save & Share With\nOne Tap",
      "subtitle":
          "Capture your reticle holdover and send it to a coach, friends, or post it online.  Get better together by sharing and learning!",
    },
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _finishOnboarding() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => RootPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          if (_currentPage < onboardingData.length - 1)
            TextButton(
              onPressed: _finishOnboarding,
              child: commonText("Skip", size: 14),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (_, index) {
                final data = onboardingData[index];
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: commonText(
                            data["title"]!,
                            size: 36,

                            fontWeight: FontWeight.w900,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        child: commonText(
                          data["subtitle"]!,
                          textAlign: TextAlign.center,
                          color: Color(0xFF707070),
                          isBold: true,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(onboardingData.length, (index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 6),
                width: _currentPage == index ? 30 : 8,
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: _currentPage == index ? AppColors.black : Colors.grey,
                ),
              );
            }),
          ),
          SizedBox(height: 20),
          commonButton(
            _currentPage == 0 ? "Get Started" : "Next",
            onTap: _nextPage,
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
