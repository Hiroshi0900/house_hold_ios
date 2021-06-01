import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';

List parseUsers(String responseBody) {
  var list = json.decode(responseBody)['results'] as List;
  List users = list.map((model) => User.fromJson(model)).toList();
  return users;
}

Future fetchUsers() async {
  final response = await http.get("https://randomuser.me/api/?results=20");
  if (response.statusCode == 200) {
    print(response.body);
    return compute(parseUsers, response.body);
  } else {
    throw Exception('Can\'t get users');
  }
}
