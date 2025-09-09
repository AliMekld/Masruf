import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:masrof/core/Api/Errors/error_model.dart';
import 'package:masrof/core/Api/Errors/exceptions.dart';

class RequestMethod {
  final String _method;
  final Uri uri;
  final Map<String, String>? body, headers;
  final Map<String, dynamic>? bodyJson;
  final List<MultipartFile> files;

  /// http methods [CRUD]
  RequestMethod.get({
    required String url,
  })  : _method = "GET",
        body = null,
        bodyJson = null,
        files = const [],
        uri = Uri.parse(url),
        headers = {};
  RequestMethod.getUri({
    required this.uri,
  })  : _method = "GET",
        body = null,
        bodyJson = null,
        files = const [],
        headers = {};

  RequestMethod.post({
    required String url,
    required this.body,
    this.files = const [],
  })  : headers = {},
        bodyJson = null,
        uri = Uri.parse(url),
        _method = "POST";
  RequestMethod.postUri({
    required this.body,
    this.files = const [],
    required this.uri,
  })  : headers = {},
        bodyJson = null,
        _method = "POST";

  RequestMethod.postJson({
    required this.bodyJson,
    required String url,
  })  : headers = {'Content-Type': 'application/json'},
        body = null,
        files = const [],
        uri = Uri.parse(url),
        _method = "POST";

  RequestMethod.postJsonUri({
    required this.bodyJson,
    required this.uri,
  })  : headers = {'Content-Type': 'application/json'},
        body = null,
        files = const [],
        _method = "POST";

  RequestMethod.put({
    required this.body,
    this.files = const [],
    required String url,
  })  : headers = {},
        bodyJson = null,
        uri = Uri.parse(url),
        _method = "PUT";

  RequestMethod.putUri({
    required this.body,
    this.files = const [],
    required this.uri,
  })  : headers = {},
        bodyJson = null,
        _method = "PUT";

  RequestMethod.putJson({
    required this.bodyJson,
    required String url,
  })  : headers = {'Content-Type': 'application/json'},
        body = null,
        files = const [],
        uri = Uri.parse(url),
        _method = "PUT";

  RequestMethod.putJsonUri({
    required this.bodyJson,
    required this.uri,
  })  : headers = {'Content-Type': 'application/json'},
        body = null,
        files = const [],
        _method = "PUT";

  RequestMethod.delete({
    this.body,
    required String url,
  })  : headers = {'Content-Type': 'application/json'},
        bodyJson = null,
        files = const [],
        uri = Uri.parse(url),
        _method = "DELETE";

  RequestMethod.deleteUri({
    this.body,
    required this.uri,
  })  : headers = {'Content-Type': 'application/json'},
        files = const [],
        bodyJson = null,
        _method = "DELETE";

  RequestMethod.patch({
    required this.bodyJson,
    required String url,
  })  : headers = {'Content-Type': 'application/json'},
        files = const [],
        body = null,
        uri = Uri.parse(url),
        _method = "PATCH";

  Future<dynamic> request() async {
    final requst = MultipartRequest(_method, uri);
    if (body != null && (body?.isNotEmpty ?? false)) {
      requst.fields.addAll(body!);
    }
    if (files.isNotEmpty) {
      requst.files.addAll(files);
    }
    if (headers != null) {
      requst.headers.addAll(headers!);
    }

    return _ApiResponseHelper.getHandledResponse(
      request: requst,
      method: this,
    );
  }

  Future<dynamic> requestJson() async {
    final requst = Request(_method, uri);
    if (bodyJson != null) {
      requst.body = json.encode(bodyJson);
    }
    if (headers != null) {
      requst.headers.addAll(headers!);
    }
    return _ApiResponseHelper.getHandledResponse(
      request: requst,
      method: this,
    );
  }

  Future<dynamic> requestFileStream() async {
    final requst = MultipartRequest(_method, uri);
    if (body != null) {
      requst.fields.addAll(body!);
    }
    if (headers != null) {
      requst.headers.addAll(headers!);
    }
    if (files.isNotEmpty) {
      requst.files.addAll(files);
    }
    return _ApiResponseHelper.getHandledResponse(
        request: requst, method: this, isFile: true);
  }
}

sealed class _ApiResponseHelper {
  static Future<BaseResponseModel> getHandledResponse(
      {bool isFile = false,
      required BaseRequest request,
      required RequestMethod method}) async {
    final StreamedResponse response;
    ErrorModel errorModel = ErrorModel.init(method: method, statusCode: -1);
    try {
      response = await request.send().timeout(const Duration(seconds: 15));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return isFile
            ? _handleFilesRespose(response)
            : _handleRespose(response);
      } else {
        errorModel = ErrorModel.init(
          method: method,
          statusCode: response.statusCode,
          message: response.reasonPhrase,
        );
        throw throwError(ServerException(errorModel), errorModel);
      }
    } on Exception catch (e) {
      throw throwError(e, errorModel);
    }
  }
}

Future<BaseResponseModel> _handleRespose(StreamedResponse response) async {
  if (response.statusCode == 204) {
    return BaseResponseModel(
        message: 'No Content', statusCode: 204, body: null);
  }

  final resStream = response.stream;
  final responseBody = await resStream.bytesToString();

  if (responseBody.isEmpty) {
    return BaseResponseModel(
        message: 'Empty response', statusCode: response.statusCode, body: null);
  }

  try {
    final decodedString = json.decode(responseBody);
    return BaseResponseModel.fromJson(decodedString);
  } catch (e) {
    // Handle malformed JSON
    throw Exception('Failed to decode response: $responseBody');
  }
}

Future<BaseResponseModel> _handleFilesRespose(StreamedResponse response) async {
  if (response.statusCode == 204) {
    return BaseResponseModel(
        message: 'No Content', statusCode: 204, body: null);
  }

  final resStream = response.stream;
  final responseBody = await resStream.bytesToString();

  if (responseBody.isEmpty) {
    return BaseResponseModel(
        message: 'Empty response', statusCode: response.statusCode, body: null);
  }

  try {
    final decodedString = json.decode(responseBody);
    return BaseResponseModel.fromJson(decodedString);
  } catch (e) {
    // Handle malformed JSON
    throw Exception('Failed to decode response: $responseBody');
  }
}

class BaseResponseModel {
  final String message;
  final int statusCode;
  final dynamic body;

  BaseResponseModel({
    required this.message,
    required this.statusCode,
    required this.body,
  });

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) {
    return BaseResponseModel(
      message: json['message'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'statusCode': statusCode,
      'body': body,
    };
  }
}
