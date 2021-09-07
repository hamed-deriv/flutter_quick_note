import 'package:http/http.dart';

class HttpService {
  static final baseUrl = 'https://api.dictionaryapi.dev/api/v2/entries/';

  static Future<Response> getResponse(String endpoint) async {
    try {
      return get(Uri.parse('$baseUrl$endpoint'));
    } on Exception catch (e) {
      throw e;
    }
  }
}
