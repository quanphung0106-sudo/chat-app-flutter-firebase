
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Authenticate/Authenticate.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDn-85tuPQHKkz_cZ52Bxdq5YUbDzm38Qw",
      appId: "1:878803114707:android:c14d63120e3eee54659226",
      messagingSenderId: "878803114707",
      projectId: "emailpasswordauth-9bea0",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Authenticate(),
    );
  }
}