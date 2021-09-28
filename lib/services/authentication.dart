import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hr_banking_app/UI/start_page.dart';
import 'package:hr_banking_app/UI/homepage.dart';
import 'package:hr_banking_app/provider/auth_notifier.dart';
import 'package:hr_banking_app/models/databaseUsers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class Authentication {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool userDataUploaded = false;

  toast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.blue,
      gravity: ToastGravity.BOTTOM,
    );
  }

  // get user details
  Future getUserDetails(AuthNotifier authNotifier) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(authNotifier.user.uid)
        .get()
        .catchError((e) => print(e))
        .then((value) => (value != null)
        ? authNotifier.setUserDetails(Users.fromMap(value.data()))
        : print(value));
  }

  // to upload userData
  Future uploadUserData(Users users, bool userDataUploaded) async {
    var userDataUploadBool = userDataUploaded;

    User currentUser = auth.currentUser;
    users.uuid = currentUser.uid;
    CollectionReference userReference =
    FirebaseFirestore.instance.collection('users');

    // check if data is uploaded
    if (userDataUploadBool != true) {
      await userReference
          .doc(currentUser.uid)
          .set(users.toMap())
          .catchError((e) => print(e))
          .then((value) => userDataUploadBool = true);
    }
  }

  // To Login
  Future login(
      Users users, AuthNotifier authNotifier, BuildContext context) async {
    UserCredential result;

    try {
      result = await auth.signInWithEmailAndPassword(
          email: users.email, password: users.password);
    } catch (e) {
      toast(e.message.toString());
    }

    // To verify
    try {
      if (result != null) {
        User user = auth.currentUser;
        if (!user.emailVerified) {
          auth.signOut();
          toast('Email ID not verified');
        } else if (user != null) {
          print('Logged in : #user');
          authNotifier.setUser(user);
          await getUserDetails(authNotifier);
          print('done');

          Navigator.push(
              context, MaterialPageRoute(builder: (_) => HomePage()));

        }
      }
    } catch (e) {
      toast(e.message.toString());
    }
  }

  // to SignUp
  Future signUp(
      Users users, AuthNotifier authNotifier, BuildContext context) async {
    UserCredential result;

    try {
      result = await auth.createUserWithEmailAndPassword(
          email: users.email, password: users.password);
    } catch (e) {
      toast(e.message.toString());
    }

    // to verify
    try {
      if (result != null) {
        auth.currentUser.updateDisplayName(users.displayName);
        User user = result.user;
        await user.sendEmailVerification();

        if (user != null) {
          await user.reload();
          print('Sign up: $user');
          uploadUserData(users, userDataUploaded);
          await auth.signOut();
          authNotifier.setUser(null);

          toast('Verification link is sent to ${user.email}');
          Navigator.pop(context);
        }
      }
    } catch (e) {
      toast(e.message.toString());
    }
  }


  // initialize current user
  Future initializeCurrentUser(AuthNotifier authNotifier)async{
    User user = auth.currentUser;

    if(user !=null){
      authNotifier.setUser(user);
      await getUserDetails(authNotifier);
    }
  }

  // sign out
  Future signOut(AuthNotifier authNotifier, BuildContext context) async{
    await auth.signOut();
    authNotifier.setUser(null);
    Navigator.push(context, MaterialPageRoute(builder: (_)=> StartPage()));
  }
}
