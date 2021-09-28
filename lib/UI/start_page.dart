import 'package:flutter/material.dart';
import 'package:hr_banking_app/UI/login_page.dart';
import 'package:hr_banking_app/UI/register_page.dart';
import 'package:hr_banking_app/provider/auth_notifier.dart';
import 'package:hr_banking_app/services/authentication.dart';
import 'package:provider/provider.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key key}) : super(key: key);


  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  Authentication _authentication= Authentication();
  @override
  void initState() {
    AuthNotifier authNotifier =
    Provider.of<AuthNotifier>(context, listen: false);
    _authentication.initializeCurrentUser(authNotifier);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.white,
              Colors.white,
              Colors.blue,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'HrQuick Bank',
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                (authNotifier.user == null)
                    ? Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginPage()))
                    : (authNotifier.userDetails == null)
                    ? print('wait')
                    : Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => RegisterPage()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Dive in',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
