import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:utils/utils.dart';
import 'package:weather_app/app/features/onboarding/view/onboarding_footer.dart';
import 'package:weather_app/app/features/onboarding/view/onboarding_header.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Scaffold(
      backgroundColor: Palette.backgroundOnboarding,
      body: responsive.isPortrait
          ? const OnboadingViewPortrait()
          : const OnboadingViewLandscape(),
    );
  }
}

class OnboadingViewPortrait extends StatelessWidget {
  const OnboadingViewPortrait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          SizedBox(height: responsive.hp(4)),
          const OnboardingHeader(),
          SizedBox(height: responsive.hp(4)),
          LottieBuilder.asset(
            'assets/animations/weather.json',
            package: PackageName.uiKit,
          ),
          const OnboardingFooter(),
        ],
      ),
    );
  }
}

class OnboadingViewLandscape extends StatelessWidget {
  const OnboadingViewLandscape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return SafeArea(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: responsive.wp(2)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const OnboardingHeader(),
                  SizedBox(height: responsive.hp(4)),
                  LottieBuilder.asset(
                    'assets/animations/weather.json',
                    package: PackageName.uiKit,
                  ),
                ],
              ),
            ),
          ),
          const OnboardingFooter(),
        ],
      ),
    );
  }
}
