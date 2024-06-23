import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_ideal_project/components/default_button.dart';
import 'package:mobile_ideal_project/config/helpers/assets.dart';
import 'package:mobile_ideal_project/config/helpers/constants.dart';
import 'package:mobile_ideal_project/config/helpers/context_extensions.dart';
import 'package:mobile_ideal_project/config/helpers/theme.dart';
import 'package:mobile_ideal_project/generated/localization.dart';

@RoutePage()
class SuccessfullyCreateAccountPage extends ConsumerStatefulWidget {
  const SuccessfullyCreateAccountPage({super.key});

  @override
  ConsumerState<SuccessfullyCreateAccountPage> createState() =>
      _CreateAccountState();
}

class _CreateAccountState extends ConsumerState<SuccessfullyCreateAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: Constants.appPadding,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Lottie.asset(AppAssets.successIcon),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.successfullyCreatedAnAccount.tr(),
                        textAlign: TextAlign.center,
                        style: context.theme.headlineLarge!.copyWith(
                          color: AppColors.primaryTextColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        LocaleKeys.afterThisYouCanExploreAnyPlaceYouWantEnjoy
                            .tr(),
                        textAlign: TextAlign.center,
                        style: context.theme.bodyMedium!.copyWith(
                          color: AppColors.primaryTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                DefaultButton(
                  onPressed: () {
                    // router.replaceAll([const MainRoute()]);
                  },
                  title: LocaleKeys.letsExplore.tr(),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
