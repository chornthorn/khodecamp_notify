import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/app_version_res.dart';

const baseUrl = 'http://localhost:3000';

Future<AppVersionResponse> checkAppVersion(
  String version,
  String platform,
) async {
  try {
    final uri = Uri.parse('$baseUrl/app-versions/latest/$platform/$version');

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final jsonObject = json.decode(response.body) as Map<String, dynamic>;
      final newMap = Map<String, dynamic>.from(jsonObject['info']);
      newMap['upToDate'] = jsonObject['upToDate'];
      return AppVersionResponse.fromJson(newMap);
    } else {
      throw Exception('Failed to load app version');
    }
  } catch (e) {
    print(e);
    rethrow; // Rethrow the exception
  }
}
