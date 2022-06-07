import 'package:ecomerce/constants.dart';
import 'package:ecomerce/screens/register_page.dart';
import 'package:ecomerce/widgets/custom_btn.dart';
import 'package:ecomerce/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // ignore: unused_element
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            // ignore: avoid_unnecessary_containers
            content: Container(
              child: Text(error),
            ),
            actions: [
              // ignore: deprecated_member_use
              FlatButton(
                child: const Text("Close Dialog"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
    );
  }

  // Create a new user account
  // ignore: unused_element
  Future<String?> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);
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
      _loginFormLoading = true;
    });

    // Run the create account method
    String? _loginFeedback = await _loginAccount();

    // If the string is not null, we got error while create account.
    if(_loginFeedback != null) {
      _alertDialogBuilder(_loginFeedback);

      // Set the form to regular state [not loading].
      setState(() {
        _loginFormLoading = false;
      });
    }
  }

   // Default Form Loading State
  // ignore: unused_field
  bool _loginFormLoading = false;

  // Form Input Field Values
  late String _loginEmail = "";
  late String _loginPassword = "";

  // Focus Node for input fields
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
              "Welcome User,\n Login to Your Account",
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
                      _loginEmail = value;
                    },
                    onSubmit: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next, 
                    focusNode: _passwordFocusNode, 
                    isPasswordField: false,
              ),
              // ignore: prefer_const_constructors
              CustomInput(
                text: "Password...", 
                focusNode: _passwordFocusNode, 
                onChanged: (value) { 
                   _loginPassword = value;
                 }, 
                onSubmit: (value) {
                  _submitForm();
                  }, 
                isPasswordField: true, 
                textInputAction: TextInputAction.next,
              ),
              CustomBtn(
            text: "Login",
            onPressed: (){
                _submitForm();
            },
            outlineBtn: true, 
            isLoading: _loginFormLoading,
          ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 16.0,
            ),
            child: CustomBtn(
              text: "Create New Account",
              onPressed: (){
               Navigator.push(
                 context, 
               MaterialPageRoute(
                 builder: (context) => const RegisterPage()
                 ),
                 );
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