import 'package:food/core/constants/app_images.dart';

class OnboardingModel {
  final String title;
  final String description;
  final String imagepath;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.imagepath,
  });
}

List<OnboardingModel> onboardingPages = [
  OnboardingModel(
    title: "All your favorites",
    description:
        "Get all your loved foods in one once place\n you just place the order we do the rest",
    imagepath: AppImages.onboarding1,
  ),
  OnboardingModel(
    title: "Best Offers",
    description: "We offer the best prices\n and discounts for you",
    imagepath: AppImages.onboarding2,
  ),
];
