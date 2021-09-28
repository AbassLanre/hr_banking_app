import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hr_banking_app/models/databaseUsers.dart';
import 'package:hr_banking_app/provider/auth_notifier.dart';
import 'package:hr_banking_app/services/authentication.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Users _users = Users();
  Authentication _authentication = Authentication();
  bool displayPassword = true;
  bool displayConfirmPassword = true;
  final TextEditingController _passwordControllerr = TextEditingController();
  bool showPassword = true;
  bool showConfirmPassword = true;
  final TextEditingController _passwordController = new TextEditingController();
// initstate
  @override
  void initState() {
    AuthNotifier authNotifier =
    Provider.of<AuthNotifier>(context, listen: false);
    // initialize current user
    _authentication.initializeCurrentUser(authNotifier);
    super.initState();
  }

  void toast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.grey,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    RegExp regExp = new RegExp(
        r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$');
    AuthNotifier authNotifier =
    Provider.of<AuthNotifier>(context, listen: false);
    if (_users.displayName.length < 3) {
      toast("Name must have atleast 3 characters");
    } else if (!regExp.hasMatch(_users.email)) {
      toast("Enter a valid Email ID");
    } else if (_users.phone.length != 13) {
      toast("Contact number length must be 13");
    } else if (int.tryParse(_users.phone) == null) {
      toast("Contact number must be a number");
    } else if (_users.password.length < 8) {
      toast("Password must have atleast 8 characters");
    } else if (_passwordController.text.toString() != _users.password) {
      toast("Confirm password does'nt match your password");
    } else {
      print("Success");
      _authentication.signUp(_users, authNotifier, context);
    }
  }

  Widget _buildSignUpForm() {
    return Column(
      children: [
        SizedBox(
          height: 60,
        ),
        // User Name Field
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: TextFormField(
            validator: (value) {
              return null;
            },
            onSaved: (newValue) {
              _users.displayName = newValue;
            },
            keyboardType: TextInputType.name,
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              hintText: 'User Name',
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              icon: Icon(
                Icons.account_circle,
                color: Colors.blue,
              ),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        // Email Field
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
            keyboardType: TextInputType.emailAddress,
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              icon: Icon(
                Icons.email,
                color:Colors.blue,
              ),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        // Phone Field
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: TextFormField(
            validator: (value) {
              return null;
            },
            onSaved: (newValue) {
              _users.phone = newValue;
            },
            keyboardType: TextInputType.phone,
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              hintText: 'Contact Number',
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              icon: Icon(
                Icons.phone,
                color: Colors.blue,
              ),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        // password field
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: TextFormField(
            obscureText: showPassword,
            validator: (value) {
              return null;
            },
            onSaved: (newvalue) {
              return _users.password = newvalue;
            },
            cursorColor: Colors.blue,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(
                    (showPassword) ? Icons.visibility_off : Icons.visibility,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  }),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: 'Password',
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              // prefix icon
              //icon: Icon(Icons.email),
              icon: Icon(
                Icons.lock,
                color: Colors.blue,
              ),
            ),
          ),
        ),
        // confirm password field
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: TextFormField(
            obscureText: showConfirmPassword,
            validator: (value) {
              return null;
            },
            controller: _passwordController,
            // controller
            cursorColor: Colors.blue,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(
                    (showConfirmPassword)
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    setState(() {
                      showConfirmPassword = !showConfirmPassword;
                    });
                  }),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: 'Confirm Password',
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              // prefix icon
              //icon: Icon(Icons.email),
              icon: Icon(
                Icons.lock,
                color: Colors.blue,
              ),
            ),
          ),
        ),

        // sign up button
        SizedBox(
          height: 50,
        ),
        GestureDetector(
          onTap: () {
            // submit function
            _submitForm();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 60,
        ),
        // Login Line
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already a registered user?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                child: Text(
                  'Log In here',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white,
              Colors.blue,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40,),
                Text(
                  'HrQuick Bank',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                _buildSignUpForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
