import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cookie_jar/cookie_jar.dart';

class DioUtil {
  static DioUtil _instance;
  static DioUtil getInstance() {
    if (_instance == null) {
      _instance = DioUtil();
    }
    return _instance;
  }

  Dio dio = new Dio();
  DioUtil() {
    dio.options.baseUrl = 'http://192.168.4.115:3000';
    dio.options.connectTimeout = 20000;
    dio.options.receiveTimeout = 20000;
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.findProxy = (url) {
        return "PROXY 192.168.4.115:8888";
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    }; // fiddle抓包设置
    getTemporaryDirectory().then((tempDir) {
      CookieJar cj = new PersistCookieJar(dir: tempDir.path);
      dio.interceptors.add(CookieManager(cj));
    });
  }
  get(String url, params, Function successCallBack,
      Function errorCallBack) async {
    try {
      Response response =
          await dio.get(url, queryParameters: params).catchError(errorCallBack);
      final data = response.data;
      if (data['code'] == 200) {
        successCallBack(data);
      } else {
        errorCallBack(data);
      }
    } catch (e) {
      // errorCallBack(e);
      throw e;
    }
  }

  getNoQuery(
      String url, Function successCallBack, Function errorCallBack) async {
    try {
      Response response = await dio.get(url).catchError(errorCallBack);
      final data = response.data;
      if (data['code'] == 200) {
        successCallBack(data);
      } else {
        errorCallBack(data);
      }
    } catch (e) {
      // errorCallBack(e);
      throw e;
    }
  }

  post(String url, params) async {
    return await dio.post(url, data: params);
  }
}
