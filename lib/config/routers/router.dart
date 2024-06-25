import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ideal_project/views/auth/create_account/create_account_page.dart';
import 'package:mobile_ideal_project/views/auth/login/login_page.dart';
import 'package:mobile_ideal_project/views/auth/otp/otp_page.dart';
import 'package:mobile_ideal_project/views/auth/successfully_create_account/successfully_create_account_page.dart';
import 'package:mobile_ideal_project/views/create_post/create_post_page.dart';

part 'router.gr.dart';

final router = AppRouter();

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  AppRouter() : super();
  @override
  List<AutoRoute> get routes => [
        /// * Auth
        AutoRoute(page: CreateAccountRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: OTPRoute.page),
        AutoRoute(page: SuccessfullyCreateAccountRoute.page),
        AutoRoute(page: CreatePostRoute.page, initial: true),
      ];
}
