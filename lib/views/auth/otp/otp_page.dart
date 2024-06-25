import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../components/auth_app_bar.dart';
import '../../../components/default_button.dart';
import '../../../components/pin_code_field.dart';
import '../../../config/helpers/constants.dart';
import '../../../config/helpers/context_extensions.dart';
import '../../../config/helpers/snackbars.dart';
import '../../../config/helpers/theme.dart';
import '../../../config/routers/router.dart';
import '../../../generated/localization.dart';

@RoutePage()
class OTPPage extends ConsumerStatefulWidget {
  final String phone;
  final ValueChanged<bool>? onResult;
  const OTPPage({
    required this.phone,
    this.onResult,
    super.key,
  });

  @override
  ConsumerState<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends ConsumerState<OTPPage> {
  late final TextEditingController _otpController;
  final _formKey = GlobalKey<FormState>();
  late Timer? _timer;
  int _start = 60;
  bool isLoading = false;

  @override
  void initState() {
    _otpController = TextEditingController();

    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _otpController.dispose();
    _timer!.cancel();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (!timer.isActive) return;
        if (_start == 0) {
          setState(() => timer.cancel());
          return;
        }
        setState(() => _start--);
      },
    );
  }

  Future<void> verifyPhone() async {
    if (!_formKey.currentState!.validate()) return;
    router.pushAndPopUntil(const HomeRoute(), predicate: (_) => false);
  }

  Future<void> resend() async {
    _otpController.clear();
    try {
      changeLoading(true);
      _start = 60;
      // final phone = widget.phone;
      // final message = await ref.read(authServiceProvider).sendOTP(phone: phone);
      if (!mounted) return;
      unawaited(showSuccessSnackBar(context, 'success'));
    } on Exception catch (e) {
      if (mounted) {
        unawaited(handleErrorSnackBar(context, e));
      }
    } finally {
      changeLoading(false);
    }
  }

  void changeLoading(bool loading) {
    if (loading == isLoading) return;
    isLoading = loading;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: const AuthAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: Constants.appPadding.copyWith(top: 40),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  WelcomeText(
                    phone: widget.phone,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    LocaleKeys.oTPCode.tr(),
                    style: textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  PinCodeField(
                    otpController: _otpController,
                    onCompleted: (__) => verifyPhone(),
                    validator: FormBuilderValidators.required(),
                  ),
                  const SizedBox(height: 35),
                  DefaultButton(
                    isLoading: isLoading,
                    onPressed: verifyPhone,
                    title: LocaleKeys.verify.tr(),
                  ),
                  const SizedBox(height: 20),
                  if (_start == 0)
                    const SizedBox()
                  else
                    Text(
                      "00:$_start",
                      style: textTheme.bodyMedium!.copyWith(
                        color: AppColors.greyTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: 30),
                  Opacity(
                    opacity: _start != 0 ? 0.25 : 1,
                    child: ResendCodeWidget(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          if (_start == 0) {
                            await resend();
                            startTimer();
                          }
                        },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WelcomeText extends StatelessWidget {
  final String phone;
  const WelcomeText({
    required this.phone,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.oTPVerification.tr(),
          style: context.theme.titleLarge!.copyWith(
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          LocaleKeys.pleaseCheckCode.tr(),
          style: context.theme.titleMedium!.copyWith(
            color: AppColors.titleMediumColor,
          ),
        ),
        Text(
          LocaleKeys.theCodeSentTo.tr(namedArgs: {"mobile": phone}),
          style: context.theme.titleMedium!.copyWith(
            color: AppColors.titleMediumColor,
          ),
        ),
      ],
    );
  }
}

class ResendCodeWidget extends StatelessWidget {
  final GestureRecognizer? recognizer;
  final bool isResend;
  const ResendCodeWidget({
    super.key,
    this.recognizer,
    this.isResend = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Text.rich(
        TextSpan(
          text: LocaleKeys.didNotReceiveOtp.tr(),
          style: textTheme.labelMedium!.copyWith(
            fontSize: 13,
            color: AppColors.titleMediumColor,
          ),
          children: [
            const TextSpan(text: "\t"),
            TextSpan(
              text: LocaleKeys.resend.tr(),
              style: textTheme.titleMedium!.copyWith(
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.w800,
                height: 0,
              ),
              recognizer: recognizer,
            ),
          ],
        ),
      ),
    );
  }
}
