import 'dart:async';
import 'dart:convert' show utf8,jsonDecode,jsonEncode;
import 'dart:io';
import 'package:http/http.dart' as http;

typedef RequestCallBack = void Function(Map data);

class HttpRequest {

  static requestGET (
      String authority, String unEncodedPath, RequestCallBack callBack,
      [Map<String, String> queryParameters]) async {
    try {
      var httpClient = new HttpClient();
      var uri = new Uri.http(authority, unEncodedPath, queryParameters);
      var request = await httpClient.getUrl(uri);
      var responseBody = await request.close().then((response) {
        response.cast<List<int>>().transform(utf8.decoder).listen((content) {
          return content;
        });
      });
      Map data = jsonDecode(responseBody);
      callBack(data);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  final baseUrl;

  HttpRequest(this.baseUrl);

  Future<dynamic> get(String uri, {Map<String, String> headers}) async {
    try {
      http.Response response = await http.get(baseUrl + uri, headers: headers);
      final statusCode = response.statusCode;
      final body = response.body;
      print('[uri=$uri][statusCode=$statusCode][response=$body]');
      var result = jsonDecode(body);
      return result;
    } on Exception catch (e) {
      print('[uri=$uri]exception e=${e.toString()}');
      return '';
    }
  }

  Future<dynamic> getResponseBody(String uri, {Map<String, String> headers}) async {
    try {
      http.Response response = await http.get(baseUrl + uri, headers: headers);
      final statusCode = response.statusCode;
      final body = response.body;
      print('[uri=$uri][statusCode=$statusCode][response=$body]');
      return body;
    } on Exception catch (e) {
      print('[uri=$uri]exception e=${e.toString()}');
      return null;
    }
  }

  Future<dynamic> post(String uri, dynamic body, {Map<String, String> headers}) async {
    try {
      http.Response response = await http.post(baseUrl + uri, body: jsonEncode(body), headers: headers);
      final statusCode = response.statusCode;
      final responseBody = response.body;
      var result = jsonDecode(responseBody);
      print('[uri=$uri][statusCode=$statusCode][response=$responseBody]');
      return result;
    } on Exception catch (e) {
      print('[uri=$uri]exception e=${e.toString()}');
      return '';
    }
  }
}
