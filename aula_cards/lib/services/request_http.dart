import 'dart:convert';

import 'package:http/http.dart' as http;

getProducts() async {
  var url = Uri.parse('https://dummyjson.com/products');
  var response = await http.get(url);
  return (jsonDecode(response.body))['products'];
}
