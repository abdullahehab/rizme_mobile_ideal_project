import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:laravel_exception/laravel_exception.dart';

String getErrorMessage(Object e) {
  late String message;
  if (e is Exception) {
    final parser = ApiErrorParser(exception: e);
    message = parser.error.message;
  } else {
    message = e.toString();
  }
  if (message.length > 500) return message.substring(0, 500);
  return message;
}

enum ErrorType {
  internetConnection,
  serverConnection,
  internalServerError,
  notFoundError,
  validationError,
  generalError,
  platformError,
}

class ErrorResponse {
  final String message;
  final ErrorType type;
  const ErrorResponse({required this.message, required this.type});
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ErrorResponse &&
        other.message == message &&
        other.type == type;
  }

  @override
  int get hashCode => message.hashCode ^ type.hashCode;
}

class ApiErrorParser {
  late ErrorResponse _error;
  final Exception _exception;
  final List<int>? skipCodes;

  ErrorResponse get error => _error;

  ApiErrorParser({
    required Exception exception,
    this.skipCodes,
  }) : _exception = exception {
    final err = _parseError();
    if (err != null) {
      _error = err;
    } else {
      _error = const ErrorResponse(
        message: "GENERAL_GENERIC_ERROR",
        type: ErrorType.generalError,
      );
    }
  }

  ErrorResponse? _parseError() {
    if (_exception is PlatformException) {
      return _parsePlatformException();
    } else if (_exception is DioException) {
      switch (_exception.type) {
        case DioExceptionType.badResponse:
          return _parseApiResponseError();
        case DioExceptionType.connectionTimeout:
          return _parseInternetConnectionError();
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return _parseServerConnectionError();
        case DioExceptionType.unknown:
          return _parseOtherDioException();
        default:
          return _parseGeneralError();
      }
    } else {
      return _parseGeneralError();
    }
  }

  bool checkSkipCodes(int code) {
    return skipCodes != null &&
        skipCodes!.isNotEmpty &&
        skipCodes!.contains(code);
  }

  ErrorResponse? _parseApiResponseError() {
    final e = _exception as DioException;
    final resp = e.response;
    if (resp == null) {
      return _parseGeneralError();
    }
    switch (resp.statusCode) {
      case HttpStatus.notFound:
        if (checkSkipCodes(HttpStatus.notFound)) {
          return null;
        }
        return _parseNotFoundError();
      case HttpStatus.internalServerError:
        if (checkSkipCodes(HttpStatus.internalServerError)) {
          return null;
        }
        return _parseInternalServerError(e);
      case HttpStatus.unprocessableEntity:
      case HttpStatus.badRequest:
      case HttpStatus.unauthorized:
      case HttpStatus.requestEntityTooLarge:
        if (checkSkipCodes(HttpStatus.unprocessableEntity) ||
            checkSkipCodes(HttpStatus.badRequest) ||
            checkSkipCodes(HttpStatus.requestEntityTooLarge) ||
            checkSkipCodes(HttpStatus.unauthorized)) {
          return null;
        }
        return _parseValidationError(e);
      default:
        return _parseGeneralError();
    }
  }

  ErrorResponse _parseNotFoundError() {
    String msg = "";
    if (_exception is DioException) {
      final data = _exception.response?.data as Map<String, dynamic>?;
      final err = LNotFoundException.parse(data ?? {});
      msg = err.message;
    } else {
      msg = _exception.toString();
    }
    final err = ErrorResponse(
      message: msg,
      type: ErrorType.notFoundError,
    );
    return err;
  }

  ErrorResponse _parsePlatformException() {
    final pError = _exception as PlatformException;
    final err = ErrorResponse(
      message: pError.message ?? pError.code,
      type: ErrorType.platformError,
    );
    return err;
  }

  ErrorResponse _parseInternalServerError(DioException error) {
    final data = error.response?.data as Map<String, dynamic>?;
    final e = LServerException(response: data ?? {});
    final err = ErrorResponse(
      message: e.message,
      type: ErrorType.internalServerError,
    );
    return err;
  }

  ErrorResponse _parseValidationError(DioException error) {
    final data = error.response?.data as Map<String, dynamic>?;
    final e = LValidationException(data ?? {});
    final List<String> errors = _laravelValidationErrors(e);
    final err = ErrorResponse(
      message: errors.isEmpty ? e.message : errors.join("\n"),
      type: ErrorType.validationError,
    );
    return err;
  }

  List<String> _laravelValidationErrors(LValidationException exp) {
    final errorsList = List.generate(
      exp.keys.length,
      (index) => exp.errorsByKey(exp.keys[index]) ?? [],
    );
    errorsList.removeWhere((element) => element.isEmpty);
    final List<String> errors = [];
    for (final List<String> element in errorsList) {
      final String errorStr =
          element.length == 1 ? element.first : element.join("\n");
      errors.add(errorStr);
    }
    return errors;
  }

  ErrorResponse _parseOtherDioException() {
    final err = _exception as DioException;
    if (err.error is SocketException) {
      if ((_exception.error! as SocketException).osError!.errorCode == 104) {
        return _parseServerConnectionError();
      }
      return _parseInternetConnectionError();
    }
    return ErrorResponse(
      message: err.error.toString(),
      type: ErrorType.generalError,
    );
  }

  ErrorResponse _parseInternetConnectionError() {
    return const ErrorResponse(
      message: "INTERNET_CONNECTION_ERROR",
      type: ErrorType.internetConnection,
    );
  }

  ErrorResponse _parseServerConnectionError() {
    return const ErrorResponse(
      message: "SERVER_CONNECTION_ERROR",
      type: ErrorType.serverConnection,
    );
  }

  ErrorResponse _parseGeneralError() {
    final msg = _exception.toString();
    final err = ErrorResponse(
      message: "GENERAL_GENERIC_ERROR: $msg",
      type: ErrorType.generalError,
    );
    return err;
  }
}
