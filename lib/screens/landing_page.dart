import 'package:ecomerce/constants.dart';
// ignore: unused_import
import 'package:ecomerce/screens/home_page.dart';
import 'package:ecomerce/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Landingpage extends StatelessWidget {
  Landingpage({ Key? key }) : super(key: key);

  // ignore: unused_field
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot){
        //if snapshot has error
        if(snapshot.hasError){
          return const Scaffold(
            body: Center(
              child: Text("Error: &(snapshot.error)"),
              ),
          );
        }

//connection initialized firebase app is running
        if(snapshot.connectionState == ConnectionState.done){
          //StreamBuilder can check the login state level
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamsnapshot){
              //if streamsnapshot has error
        if(snapshot.hasError){
          return const Scaffold(
            body: Center(
              child: Text("Error: &(streamsnapshot.error)"),
              ),
          );
        }

        //connection state active to the user login check inside the if statement
        if(streamsnapshot.connectionState == ConnectionState.active){

          //get user 
          // ignore: unused_local_variable
          User? _user = streamsnapshot.data as User?;

          //if the user is null, we're not logged in
          if(_user == null){
            //user not logged in, head to homepage
            return const LoginPage();
          }else{
            //if user is logged in, head to home page
            return const HomePage();
          }
        }
         //checking to auth state
        return const Scaffold(
          body: Center(
            child: Text(
              "Checking Authentication ....",
              style: Constants.regularheading,
              ),
          ),
        );
            }
            );
        }

        //connecting to the firebase loading
        return const Scaffold(
          body: Center(
            child: Text(
              "Initializing app ....",
              style: Constants.regularheading,
              ),
          ),
        );
// return Container();

      },
      );
  }
}