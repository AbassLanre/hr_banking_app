
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hr_banking_app/provider/auth_notifier.dart';
import 'UI/start_page.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> AuthNotifier()),
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: StartPage(),
    );
  }
}

