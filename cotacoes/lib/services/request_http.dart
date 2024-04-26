import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getCurrencyData() async {
  var url = Uri.parse(
      'https://economia.awesomeapi.com.br/json/last/USD-BRL,EUR-BRL,BTC-BRL');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load currency data');
  }
}
