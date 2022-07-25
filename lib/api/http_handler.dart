import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpHandler {
  Future<Map<String, dynamic>> getData(Uri url) async {
    try {
      var resp = await http.get(url);

      if (resp.statusCode == 200) {
        return {
          'status': 'SUCCESS',
          'data': jsonDecode(resp.body),
        };
      } else {
        return {
          'status': 'ERROR',
          'data': 'Error: ${resp.statusCode}',
        };
      }
    } catch (e) {
      return {
        'status': 'ERROR',
        'data': e.toString(),
      };
    }
  }
}
