import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

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
  })  : headers = {},
        body = null,
        files = const [],
        uri = Uri.parse(url),
        _method = "POST";

  RequestMethod.postJsonUri({
    required this.bodyJson,
    required this.uri,
  })  : headers = {},
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
  })  : headers = {},
        body = null,
        files = const [],
        uri = Uri.parse(url),
        _method = "PUT";

  RequestMethod.putJsonUri({
    required this.bodyJson,
    required this.uri,
  })  : headers = {},
        body = null,
        files = const [],
        _method = "PUT";

  RequestMethod.delete({
    this.body,
    required String url,
  })  : headers = {},
        bodyJson = null,
        files = const [],
        uri = Uri.parse(url),
        _method = "DELTET";

  RequestMethod.deleteUri({
    this.body,
    required this.uri,
  })  : headers = {},
        files = const [],
        bodyJson = null,
        _method = "DELTET";

  RequestMethod.patch({
    required this.bodyJson,
    required String url,
  })  : headers = {},
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
    if (bodyJson != null && requst.body.isNotEmpty) {
      requst.body = json.encode(body);
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
    return _ApiResponseHelper.getHandledResponse(request: requst, method: this);
  }
}

sealed class _ApiResponseHelper {
  static Future<BaseResponseModel> getHandledResponse(
      {required BaseRequest request, required RequestMethod method}) async {
    /// this [do]
    /// send request
    /// handle errors
    /// logging
    /// handle response
    ///
    try {
      final StreamedResponse response = await request.send();

      final resStream = response.stream;
      final decodedString = json.decode(await resStream.bytesToString());
      return BaseResponseModel.fromJson(decodedString);
    } on HttpException catch (e) {
      throw Exception('HTTP Error: ${e.message}');
    } on SocketException catch (e) {
      throw Exception('Network Error: ${e.message}');
    } catch (e) {
      throw Exception('Error: $e');
    }
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
