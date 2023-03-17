import 'dart:convert';
import 'package:agoratestapp/pages/User/model/usermodel.dart';
import 'package:http/http.dart' as http;

String domainName = "https://arsl-3e3a5-default-rtdb.firebaseio.com/";

Future<void> fetchData(List model) async {
  http.Response response = await http.get(Uri.parse("$domainName/user.json"));
  Map data = json.decode(response.body);
  if (response.statusCode == 200) {
    data.forEach((key, value) {
      model.add(UserModel.fromMap(value));
    });
  }
}

Future<void> sendUserData(
    String email, String password, String name, String phone) async {
  http.Response response = await http.post(Uri.parse("$domainName/user.json"),
      body: json.encode({
        "email": email,
        "password": password,
        "name": name,
        "phone": phone
      }));
}
