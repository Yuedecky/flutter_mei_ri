import 'package:dio/dio.dart';
import 'dart:io';
import 'error.dart';
import '../utils/system.dart';
import '../config/http_config.dart' as config;
import '../config/token_config.dart' as tokenConfig;

/// missfresh 在用户登陆之前 请求头 携带access_token='' deviceId='' source_device_id=''
/// 但是携带
/// platform
/// version
/// screen_width
/// screen_height
/// android_channel_value
/// android_id
/// ignore_fragment_event
/// session
/// 手机启动需要获取用户权限
/// 1.定位信息 下次请求可以携带 userLat userLng currentLat currentLng 匹配最近的仓库bigWarehouse
/// 2.存储空间
/// 3.设备信息 比如网络类型
/// ---- 请求头queryString 示例 -----
///      "userLng": "121.63499",
///      "addressCode": "310115",
///      "stationCode": "MRYX|mryx_zjzpx",
///      "screenWidth": "1080",
///      "session": "android0.100670670282450141564787825728",
///      "screenHeight": "1920",
///      "deliveryType": "1",
///      --- access_token看起来是经过 base64 编码过的
///      "accessToken":
///          "a1FIYXlTY3NCSEVPMDI4ekJlNHlYM2sxdkF4dUVHcTZwcWxBdFU0d3B5Qnl2TGdkVUlFZ0Y0akEyQ0FJeUVSaA==",
///      "version": "9.4.0",
///      "platform": "android",
///      "userLat": "31.18506",
///      "currentLat": "31.18506",
///      "smDeviceId":
///          "20190803071708c436092d1e05862d33e0341b2a66955901b6d4a3b6c45d45",
///      "androidChannelValue": "xiaomi",
///      "imei": "c536040143b8e1ebfbcdc37b903f6fbd",
///      "tdk":
///          "eyJvcyI6ImFuZHJvaWQiLCJ2ZXJzaW9uIjoiMy4xLjkiLCJwYWNrYWdlcyI6ImNuLm1pc3NmcmVzaC5hcHBsaWNhdGlvbiomOS40LjAiLCJwcm9maWxlX3RpbWUiOjIxOTgsImludGVydmFsX3RpbWUiOjc4MTQ4LCJ0b2tlbl9pZCI6InVYUnZEeExcLytOMFJ5MnR4QVRzRjFtdTE0TDNCRXVFeHk1ZjVqNzZheVFiZ2pEK0dpQ0MyMXJOeXcwbGJib25hZnFLUm4xZEJ3WE1jeWhVb3RzQmpoUT09In0=",
///      "currentLng": "121.63499",
///      "sourceDeviceId": "865441035038124",
///      "android_id": "87be3c54dfc6d9f1",
///      "devtk": "",
///      "bigWarehouse": "MRYXSHW"
///
///
class HttpGo {
  static final debug = false;
  static final token = '';



  static final Dio _dio = Dio(BaseOptions(
      headers: {},
      baseUrl: config.HttpConfig.MeiRiBaseUrl,
      connectTimeout: 5000,
      receiveTimeout: 100000,
      followRedirects: true));

  static final LogicError _unknownError = LogicError(errorCode: -1, msg: "未知异常");

  static void setProxy() {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      //设置代理主机
      client.findProxy = (uri) {
        return "PROXY localhost:8888";
      };
      //认证失败
      client.badCertificateCallback =
          (X509Certificate certificate, String host, int port) {
        return true;
      };
    };
  }



  _addStartHttpInterceptor(Dio dio) {
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      // 在请求被发送之前做一些事情   比如加密的一些操作 或者添加token等参数 对head 或者请求参数进行加工处理
      Map<String, dynamic> headers = options.headers;
      Map<String, dynamic> body = options.data;
      headers['accessToken'] = '';
      headers['content-type'] = 'application/json;charset=UTF-8';
      headers['accept-encoding'] = 'gzip';
      return options;
    }, onResponse: (Response response) {
      // 在返回响应数据之前做一些预处理
      return response; // continue
    }, onError: (DioError e) {
      // 当请求失败时做一些预处理
      return e; //continue
    }));
  }

  ///获取授权token
  static getToken() async {
    return await SystemUtils.getCacheItem(tokenConfig.TokenConfig.AccessTokenKey);
  }

  /// 对请求返回的数据进行统一的处理
  /// 如果成功则将我们需要的数据返回出去，否则进异常处理方法，返回异常信息
  static Future<T> logicalErrorTransform<T>(Response<Map<String, dynamic>> resp) {
    if (resp.data != null) {
      if (resp.data["code"] == 0) {
        T realData = resp.data["data"];
        return Future.value(realData);
      }
    }

    if (debug) {
      print('resp--------$resp');
      print('resp.data--------${resp.data}');
    }

    LogicError error;
    if (resp.data != null && resp.data["code"] != 0) {
      if (resp.data['data'] != null) {
        /// 失败时  错误提示在 data中时
        /// 收到token过期时  直接进入登录页面
        Map<String, dynamic> realData = resp.data["data"];
        error = LogicError(errorCode:resp.data["code"],msg: realData['msg']);
      } else {
        /// 失败时  错误提示在 message中时
        error = LogicError(errorCode:resp.data["code"], msg:resp.data["msg"]);
      }
    } else {
      error = _unknownError;
    }
    return Future.error(error);
  }


  static Future<Map<String, dynamic>> getJson<T>(
      String uri, Map<String, dynamic> paras) =>
      _httpJson("get", uri, data: paras).then(logicalErrorTransform);

  static Future<Map<String, dynamic>> getForm<T>(
      String uri, Map<String, dynamic> paras) =>
      _httpJson("get", uri, data: paras, dataIsJson: false)
          .then(logicalErrorTransform);

  /// 表单方式的post
  static Future<Map<String, dynamic>> postForm<T>(
      String uri, Map<String, dynamic> paras) =>
      _httpJson("post", uri, data: paras, dataIsJson: false)
          .then(logicalErrorTransform);

  /// requestBody (json格式参数) 方式的 post
  static Future<Map<String, dynamic>> postJson(
      String uri, Map<String, dynamic> body) =>
      _httpJson("post", uri, data: body).then(logicalErrorTransform);

  static Future<Map<String, dynamic>> deleteJson<T>(
      String uri, Map<String, dynamic> body) =>
      _httpJson("delete", uri, data: body).then(logicalErrorTransform);

  /// requestBody (json格式参数) 方式的 put
  static Future<Map<String, dynamic>> putJson<T>(
      String uri, Map<String, dynamic> body) =>
      _httpJson("put", uri, data: body).then(logicalErrorTransform);

  /// 表单方式的 put
  static Future<Map<String, dynamic>> putForm<T>(
      String uri, Map<String, dynamic> body) =>
      _httpJson("put", uri, data: body, dataIsJson: false)
          .then(logicalErrorTransform);

  /// 文件上传  返回json数据为字符串
  static Future<T> putFile<T>(String uri, String filePath) {
    var name =
    filePath.substring(filePath.lastIndexOf("/") + 1, filePath.length);
    var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
    FormData formData = new FormData.from({
      "multipartFile": new UploadFileInfo(new File(filePath), name,
          contentType: ContentType.parse("image/$suffix"))
    });

    var enToken = token == null ? "" : Uri.encodeFull(token);
    return _dio
        .put<Map<String, dynamic>>("$uri?token=$enToken", data: formData)
        .then(logicalErrorTransform);
  }

  static Future<Response<Map<String, dynamic>>> _httpJson(
      String method, String uri,
      {Map<String, dynamic> data, bool dataIsJson = true}) {
    var enToken = token == null ? "" : Uri.encodeFull(token);

    /// 如果为 get方法，则进行参数拼接
    if (method == "get") {
      dataIsJson = false;
      if (data == null) {
        data = new Map<String, dynamic>();
      }
      data["token"] = token;
    }

    if (debug) {
      print('<net url>------$uri');
      print('<net params>------$data');
    }

    /// 根据当前 请求的类型来设置 如果是请求体形式则使用json格式
    /// 否则则是表单形式的（拼接在url上）
    Options op;
    if (dataIsJson) {
      op = new Options(contentType: ContentType.parse("application/json"));
    } else {
      op = new Options(
          contentType: ContentType.parse("application/x-www-form-urlencoded"));
    }

    op.method = method;

    /// 统一带上token
    return _dio.request<Map<String, dynamic>>(
        method == "get" ? uri : "$uri?access_token=$enToken",
        data: data,
        options: op);

  }
}
