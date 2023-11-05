import 'dart:developer';

import 'package:myadmin/cubits/my_app_cubit/my_app_datasource.dart';
import 'package:myadmin/cubits/my_app_cubit/my_app_model.dart';

class MyAppRepository {
  final myAppDataSource = MyAppDataSource();

  Future<TestServerData?> testServer({
    required String referrer,
  }) async {
    try {
      final response = await myAppDataSource.testServer(
        referrer: referrer
      );
      return TestServerData.fromJson(response);
    } catch (e) {
      log("Failed to load test server");
      return null;
    }
  }
}