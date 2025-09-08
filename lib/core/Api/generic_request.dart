import 'request_Methods.dart';

class GenericRequest<T> {
  final T Function(Map<String, dynamic>) fromMap;
  final RequestMethod method;
  const GenericRequest({
    required this.fromMap,
    required this.method,
  });
  Future<T> getObject() async {
    final BaseResponseModel response = method.body == null
        ? await method.requestJson()
        : await method.request();

    /// todo handle formating and serialization errors
    T object = fromMap(response.body);
    return object;
  }

  Future<List<T>> getList() async {
    List<T> tList = [];
    final BaseResponseModel response = method.body == null
        ? await method.requestJson()
        : await method.request();
    final responseBody = response.body;
    List dList = responseBody;
    tList = List<T>.from(dList.map((e) => fromMap(e)));

    /// todo handle formating and serialization errors
    return tList;
  }

  Future<dynamic> getResponse() async {
    final BaseResponseModel response = method.body == null
        ? await method.requestJson()
        : await method.request();

    return response.body;
  }
}
