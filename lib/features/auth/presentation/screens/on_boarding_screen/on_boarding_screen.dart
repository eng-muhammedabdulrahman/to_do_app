import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:to_do_app/core/database/cache_helper.dart';
import 'package:to_do_app/core/services/service_locator.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_strings.dart';
import 'package:to_do_app/features/auth/data/model/on_boarding_model.dart';
import 'package:to_do_app/features/task/presentation/screens/home_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: PageView.builder(
            controller: controller,
            itemCount: OnBoardingModel.onBoardingScreens.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  // skip text
                  index != 2
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            child: Text(AppStrings.skip,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color:
                                            AppColors.white.withOpacity(.44))),
                            onPressed: () {
                              controller.jumpToPage(2);
                            },
                          ),
                        )
                      : const SizedBox(
                          height: 54,
                        ),
                  const SizedBox(
                    height: 16,
                  ),
                  // image
                  Image.asset(OnBoardingModel.onBoardingScreens[index].imgPath),
                  const SizedBox(
                    height: 16,
                  ),
                  // dots
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                        activeDotColor: AppColors.primary,
                        dotHeight: 8,
                        spacing: 10),
                  ),
                  const SizedBox(
                    height: 52,
                  ),
                  // title
                  Text(OnBoardingModel.onBoardingScreens[index].title,
                      style: Theme.of(context).textTheme.displayLarge),
                  const SizedBox(
                    height: 42,
                  ),
                  // subTitle
                  Text(OnBoardingModel.onBoardingScreens[index].subTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(
                    height: 100,
                  ),
                  Row(
                    children: [
                      // back button
                      index != 0
                          ? TextButton(
                              child: Text(AppStrings.back,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          color: AppColors.white
                                              .withOpacity(.44))),
                              onPressed: () {
                                controller.previousPage(
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    curve: Curves.fastLinearToSlowEaseIn);
                              },
                            )
                          : Container(),
                      // spacer
                      const Spacer(),
                      // next button
                      index != 2
                          ? ElevatedButton(
                              onPressed: () {
                                controller.nextPage(
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    curve: Curves.fastLinearToSlowEaseIn);
                              },
                              style:
                                  Theme.of(context).elevatedButtonTheme.style,
                              child: const Text(
                                AppStrings.next,
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () async {
                                // navigate to home screen
                                await sl<CacheHelper>()
                                    .saveData(
                                        key: AppStrings.onBoardingKey,
                                        value: true)
                                    .then((value) {
                                  print('onBoardingKey');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const HomeScreen()),
                                  );
                                }).catchError((e) {
                                  print(e.toString());
                                });
                              },
                              style:
                                  Theme.of(context).elevatedButtonTheme.style,
                              child: const Text(
                                AppStrings.getStarted,
                              ),
                            ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
