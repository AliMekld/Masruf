class RequestMethod {
  final String method;

  final Map<String, dynamic>? body;

  final Map<String, String>? headers;

  /// http methods [CRUD]
  RequestMethod.get()
      : method = "GET",
        body = null,
        headers = {};

  RequestMethod.post({required this.body})
      : headers = {},
        method = "POST";

  RequestMethod.put({required this.body})
      : headers = {},
        method = "PUT";

  RequestMethod.delete({this.body})
      : headers = {},
        method = "DELTET";

  RequestMethod.patch({this.body})
      : headers = {},
        method = "PATCH";
  Future doRequest() async {
    // final response = MultiPartRequesr;
  }
}
