import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hr_banking_app/UI/register_page.dart';
import 'package:hr_banking_app/UI/start_page.dart';
import 'package:hr_banking_app/models/databaseUsers.dart';
import 'package:hr_banking_app/provider/auth_notifier.dart';
import 'package:hr_banking_app/services/authentication.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}
bool showPassword = true;

class _LoginPageState extends State<LoginPage> {
  Users _users = Users();
  Authentication _authentication = Authentication();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


/////////////////////////////////////////////////////////////////////////////
  toast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.blue,
      gravity: ToastGravity.BOTTOM,
    );
  }
///////////////////////////////////////////////////////////////////////////
  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    AuthNotifier authNotifier =
    Provider.of<AuthNotifier>(context, listen: false);
    RegExp regExp =
    RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$');
    if (!regExp.hasMatch(_users.email)) {
      //toast
      toast('Enter a valid email ID');
    } else if (_users.password.length < 8) {
      toast('Password must be longer than 8');
    } else {
      //login function from authentication
      _authentication.login(_users, authNotifier, context);
    }
  }
  //////////////////////////////////////////////////////////////////////////////
  @override
  void initState() {
    AuthNotifier authNotifier =
    Provider.of<AuthNotifier>(context, listen: false);
    //initialize current _users
    _authentication.initializeCurrentUser(authNotifier);    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildLoginForm() {
      return Column(
        children: [
          // email formfield
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: TextFormField(
              validator: (value) {
                return null;
              },
              onSaved: (newValue) {
                _users.email = newValue;
              },
              cursorColor: Colors.lightBlueAccent,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.email,
                  size: 17,
                  color: Colors.lightBlueAccent,
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Enter Email',
                hintStyle: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          // password formfield
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            padding:const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: TextFormField(
              obscureText: showPassword,
              validator: (value) {
                return null;
              },
              onSaved: (newValue) {
                _users.password = newValue;
              },
              cursorColor: Colors.lightBlueAccent,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: Icon(
                      (showPassword)
                          ? Icons.visibility_off
                          : Icons.visibility,
                      size: 17,
                      color: Colors.lightBlueAccent,
                    ),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    }),
                icon: const Icon(
                  Icons.lock,
                  size: 17,
                  color: Colors.lightBlueAccent,
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Enter Password',
                hintStyle: const TextStyle(
                    fontFamily: 'Nunito',
                    fontStyle: FontStyle.italic,
                    fontSize: 12,
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
              ),
              Text(
                'Forgot Password?',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => StartPage()));
            },
            child: GestureDetector(
              onTap: () {
                _submitForm();
              },
              child: Container(
                width: 100,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      );
    }


    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.white,
                  Colors.white,
                  Colors.blue,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const Text(
                  'HrQuick Bank',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                _buildLoginForm(),
               const SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   const Text('Not registered yet? ',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.blue,
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => RegisterPage()));
                      },
                      child:const Text('Sign Up',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
