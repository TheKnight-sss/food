import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food/components/buttons/main_button.dart';
import 'package:food/core/routes/navigation.dart';
import 'package:food/core/routes/routes.dart';
import 'package:food/core/utils/colors.dart';
import 'package:food/core/utils/text_style.dart';
import 'package:food/features/onboarding/onboarding_model.dart';
import 'package:food/services/local/local_helper.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboadringScreen extends StatefulWidget {
  const OnboadringScreen({super.key});

  @override
  State<OnboadringScreen> createState() => _OnboadringScreenState();
}

class _OnboadringScreenState extends State<OnboadringScreen> {
  var pagecontroller = PageController();
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Gap(118),
              Expanded(
                child: PageView.builder(
                  controller: pagecontroller,
                  onPageChanged: (index) {
                    setState(() {
                      currentindex = index;
                    });
                  },
                  itemCount: onboardingPages.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            onboardingPages[index].imagepath,
                            width: 240,
                            height: 292,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Gap(63),
                        Text(
                          onboardingPages[index].title,
                          style: Style.heading,
                        ),
                        Gap(18),
                        Text(
                          onboardingPages[index].description,
                          textAlign: TextAlign.center,
                          style: Style.regular.copyWith(
                            color: AppColors.txtcolor,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Gap(32),
              SmoothPageIndicator(
                controller: pagecontroller,
                count: onboardingPages.length,
                effect: WormEffect(
                  activeDotColor: AppColors.primcolor,
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),
              Gap(69),
              if (currentindex == onboardingPages.length-1)
                CustomButton(txt: 'Get Started', onpressed: () {
                  SharedPref.setOnboardingsSeen();
                  pushwithReplacement(context, Routes.welcome);
                }),
            ],
          ),
        ),
      ),
    );
  }
}
