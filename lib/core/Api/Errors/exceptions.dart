import 'dart:async';
import 'dart:io';

import 'package:masrof/core/Api/Errors/error_model.dart';

sealed class NetworkFailure implements Exception {
  final ErrorModel model;
  const NetworkFailure(this.model);
}

class ApiException extends NetworkFailure {
  ApiException(super.model);
}

class NetworkException extends NetworkFailure {
  NetworkException(super.model);
}

class UnauthorizedException extends NetworkFailure {
  UnauthorizedException(super.model);
}

class ForbiddenException extends NetworkFailure {
  ForbiddenException(super.model);
}

class NotFoundException extends NetworkFailure {
  NotFoundException(super.model);
}

class ConflictException extends NetworkFailure {
  ConflictException(super.model);
}

class TooManyRequestsException extends NetworkFailure {
  TooManyRequestsException(super.model);
}

class ServiceUnavailableException extends NetworkFailure {
  ServiceUnavailableException(super.model);
}

class RequestTimeoutException extends NetworkFailure {
  RequestTimeoutException(super.model);
}

class BadRequestException extends NetworkFailure {
  BadRequestException(super.model);
}

class ServerException extends NetworkFailure {
  ServerException(super.model);
}

Exception throwError(
  Exception type,
  ErrorModel model,
) {
  if (type is SocketException) return NetworkException(model);
  if (type is TimeoutException) return RequestTimeoutException(model);
  if (type is FormatException) return BadRequestException(model);
  if (type is HttpException) return ServerException(model);

  switch (model.statusCode) {
    case 400:
      return BadRequestException(model);
    case 401:
      return UnauthorizedException(model);
    case 403:
      return ForbiddenException(model);
    case 404:
      return NotFoundException(model);

    case 409:
      return ConflictException(model);
    case 429:
      return TooManyRequestsException(model);
    case 500:
    case 502:
      return ServerException(model);
    case 503:
      return ServiceUnavailableException(model);
    case 504:
      return RequestTimeoutException(model);
    default:
      return ApiException(model);
  }
}
