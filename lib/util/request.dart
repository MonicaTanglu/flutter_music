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

    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (client) {
    //   client.findProxy = (url) {
    //     return "PROXY 192.168.4.115:8888";
    //   };
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    // }; // fiddle抓包设置

    // getTemporaryDirectory 获取应用缓存目录
    getTemporaryDirectory().then((tempDir) {
      CookieJar cj = new PersistCookieJar(dir: tempDir.path);
      dio.interceptors.add(CookieManager(cj));
      // 一般项目中登录接口调用成功后，后端会在cookie中写入token，所以登录请求前
      // 建立CookieManager自动管理cookie
      // 假如使用CookieManager(await Api.cookieJar)在程序退出时，会清除所有的cookie，于是使用PersistCookieJar
      // PersistCookieJar将cookie保存在文件中，如果应用程序退出，则cookie始终存在，除非显式调用delete
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
