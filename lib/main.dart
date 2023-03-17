import 'package:agoratestapp/pages/User/screen/LoginPage.dart';
import 'package:agoratestapp/pages/User/screen/agora_uikit.dart';
import 'package:flutter/material.dart';

import 'pages/User/screen/contact_list_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:
          LoginPage(), //change the class (page) if you want to try different page
    );
  }
}
