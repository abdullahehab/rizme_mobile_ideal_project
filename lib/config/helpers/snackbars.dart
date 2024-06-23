import 'package:flutter/material.dart';
import 'package:mobile_ideal_project/config/helpers/api_error_parser.dart';

const _snackbarTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.white,
  fontSize: 16,
);

/// Displays a error snackbar with the error message.
///
/// Use `unawaited()` to ignore the Future returned by this function
///
Future<void> handleErrorSnackBar(
  BuildContext context,
  Exception e, {
  List<int>? skipCodes,
}) async {
  assert(context.mounted, "Context is not mounted");
  final parser = ApiErrorParser(exception: e, skipCodes: skipCodes);
  final error = parser.error;
  await showErrorSnackBar(context, error.message);
}

/// Use `unawaited()` to ignore the Future returned by this function
///
Future<void> showSuccessSnackBar(BuildContext context, String msg) async {
  assert(context.mounted, "Context is not mounted");
  final sm = ScaffoldMessenger.of(context);
  sm.hideCurrentSnackBar();
  final c = sm.showSnackBar(
    SnackBar(
      backgroundColor: Colors.green.shade400,
      content: Text(msg, style: _snackbarTextStyle),
    ),
  );
  await c.closed;
}

Future<void> showErrorSnackBar(BuildContext context, String msg) async {
  assert(context.mounted, "Context is not mounted");
  final sm = ScaffoldMessenger.of(context);
  sm.hideCurrentSnackBar();
  final c = sm.showSnackBar(
    SnackBar(
      backgroundColor: Colors.red.shade400,
      content: Text(msg, style: _snackbarTextStyle),
    ),
  );
  await c.closed;
}
