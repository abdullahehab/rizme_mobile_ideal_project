import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/localization/l10n.dart';

import 'boot.dart';
import 'config/helpers/theme.dart';
import 'config/routers/router.dart';
import 'generated/localization.dart';

void main() async {
  final overrides = await getOverrides();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  EasyLocalization.logger.enableLevels = [
    LevelMessages.error,
    LevelMessages.warning,
  ];

  runApp(
    EasyLocalization(
      supportedLocales: const [arabicLocale, englishLocale],
      path: 'assets/translations',
      fallbackLocale: arabicLocale,
      startLocale: arabicLocale,
      assetLoader: const CodegenLoader(),
      child: ProviderScope(
        overrides: overrides,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Ideal Project',
      theme: appTheme(context.locale),
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates
        ..add(
          FormBuilderLocalizations.delegate,
        ),
      routerConfig: router.config(),
    );
  }
}
