import 'package:ecomerce/widgets/custom_btn.dart';
import 'package:ecomerce/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {


//Build an alert dialog to display some error
  // ignore: unused_element
  Future<void> _alertDialogBuilder(String error) async{
    return showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title:const Text("Error"),
          // ignore: avoid_unnecessary_containers
          content: Container(
            child: Text(error),
          ),
          actions: [
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              child: const Text("Close Dialog"))
          ],
        );
      }
      );
  }

//create a new user account
// Create a new user account
  // ignore: unused_element
  Future<String?> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
      return null;
    } on FirebaseAuthException catch(e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

// ignore: unused_element
 void _submitForm() async {
    // Set the form to loading state
    setState(() {
      _registerFormLoading = true;
    });

    // Run the create account method
    String? _createAccountFeedback = await _createAccount();

    // If the string is not null, we got error while create account.
    if(_createAccountFeedback != null) {
      _alertDialogBuilder(_createAccountFeedback);

      // Set the form to regular state [not loading].
      setState(() {
        _registerFormLoading = false;
      });
    } else {
      // The String was null, user is logged in.
      Navigator.pop(context);
    }
  }

//Default Form Loading Stage
late bool _registerFormLoading = false;

//Form Input Fields Values
// ignore: unused_field
late String _registerEmail= "";
// ignore: unused_field
late String _registerPassword= "";
//Focus node for the input field
 // ignore: unused_field
 late FocusNode _passwordFocusNode;

 @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
      child: Container(
        width: double.infinity,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          // ignore: avoid_unnecessary_containers
          Container(
            padding: const EdgeInsets.only(
              top:24.0,
            ),
            child: const Text(
              "Create A New Account",
              textAlign: TextAlign.center,
              style: Constants.boldHeading,
              ),
          ),
          Column(
            children:   [
              // ignore: prefer_const_constructors
              CustomInput(
                text: "Email....", 
                onChanged: (value) {
                  _registerEmail = value;
                  }, onSubmit: (value) {
                    _passwordFocusNode.requestFocus();
                    }, focusNode: _passwordFocusNode, 
                    textInputAction: TextInputAction.next, 
                    isPasswordField: false,
              ),
              // ignore: prefer_const_constructors
              CustomInput(
                text: "Password...", 
                focusNode: _passwordFocusNode, 
                onChanged: (value) {
                  _registerPassword = value;
                  }, onSubmit: (value) { 
                    _submitForm();
                   },
                    isPasswordField: true, 
                    textInputAction: TextInputAction.next,
              ),
              CustomBtn(
            text: "Create New Account",
            onPressed: (){
             _submitForm();
            },
            outlineBtn: true, 
            isLoading: _registerFormLoading,
          ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 16.0,
            ),
            child: CustomBtn(
              text: "Back To Login",
              onPressed: (){
                Navigator.pop(context);
              },
              outlineBtn: true, 
              isLoading: false,
            ),
          ),
        ],
      ),
     ),
      ),
    );
    
  }
}