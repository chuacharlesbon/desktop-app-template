import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class MyAppDataSource {
  final Dio dio = Dio()
  ..options = BaseOptions(
    headers: {
      "Content-Type": "application/json",
    },
  );
  final String serverUrl = 'https://cmt-server-1.vercel.app/api';
  
  Future<dynamic> testServer({
    required String referrer,
  }) async {
    dynamic result;
    try {
      /* Response response = await dio.post(
        '$serverUrl/ping',
        data: {
            "referrer": referrer
        },
      ); */
      result = {"message": "Debug"}; //response.data;
      //log(response.data.toString());
    } on DioException catch (e) {
      if (e.response != null) {
        result = e.response?.data?.toString() ?? "ERR: Something went wrong.";
        debugPrint('Dio error!');
        debugPrint('STATUS: ${e.response?.statusCode}');
        debugPrint('DATA: ${e.response?.data}');
        debugPrint('HEADERS: ${e.response?.headers}');
      } else {
        result = "ERR: ${e.message}";
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }
    } catch (e) {
      result = "ERR: ${e.toString()}";
    }
    return result;
  }
}