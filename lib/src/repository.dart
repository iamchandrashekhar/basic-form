import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class NetworkRepository {
  final _create = "create";
  final baseUrl = "${const String.fromEnvironment("base_url")}/";

  Future<int> submitDetails(Map<String, dynamic> data) async {
    final url = "$baseUrl$_create";
    var response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    log(response.body, name: "submitDetails");
    return response.statusCode;
  }
}
